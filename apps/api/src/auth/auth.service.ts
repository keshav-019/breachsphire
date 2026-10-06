import { randomUUID } from "node:crypto";
import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
  UnauthorizedException,
} from "@nestjs/common";
import bcrypt from "bcryptjs";
import { and, eq, isNull, sql } from "drizzle-orm";
import { db } from "../db/client";
import { apiRefreshTokens, authUsers, profiles } from "../db/schema";
import { LoginThrottle } from "./login-throttle";
import {
  REFRESH_TOKEN_TTL_SECONDS,
  hashRefreshToken,
  newRefreshToken,
  signAccessToken,
} from "./tokens";

const BCRYPT_COST = 10;
const MIN_PASSWORD_LENGTH = 6;
const MAX_PASSWORD_BYTES = 72; // bcrypt ignores anything past 72 bytes
const MAX_DISPLAY_NAME_LENGTH = 40;
const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

// Compared against when the email is unknown, so a missing account takes as
// long to reject as a wrong password.
const DUMMY_HASH = bcrypt.hashSync("breachsphire-timing-equalizer", BCRYPT_COST);

export interface SessionUser {
  id: string;
  email: string;
  displayName: string;
}

export interface Session {
  accessToken: string;
  refreshToken: string;
  /** Access token expiry, Unix seconds. */
  expiresAt: number;
  user: SessionUser;
}

function normalizeEmail(value: unknown) {
  const email = typeof value === "string" ? value.trim().toLowerCase() : "";
  if (!EMAIL_PATTERN.test(email) || email.length > 254) {
    throw new BadRequestException("Enter a valid email address");
  }
  return email;
}

function validatePassword(value: unknown) {
  if (typeof value !== "string" || value.length < MIN_PASSWORD_LENGTH) {
    throw new BadRequestException(`Password must be at least ${MIN_PASSWORD_LENGTH} characters`);
  }
  if (Buffer.byteLength(value) > MAX_PASSWORD_BYTES) {
    throw new BadRequestException(`Password must be at most ${MAX_PASSWORD_BYTES} bytes`);
  }
  return value;
}

function isUniqueViolation(error: unknown) {
  return typeof error === "object" && error !== null && (error as { code?: string }).code === "23505";
}

@Injectable()
export class AuthService {
  private readonly throttle = new LoginThrottle();

  async signUp(rawEmail: unknown, rawPassword: unknown, rawDisplayName: unknown): Promise<Session> {
    const email = normalizeEmail(rawEmail);
    const password = validatePassword(rawPassword);
    const displayName = typeof rawDisplayName === "string" ? rawDisplayName.trim() : "";
    if (!displayName || displayName.length > MAX_DISPLAY_NAME_LENGTH) {
      throw new BadRequestException(`Callsign must be 1-${MAX_DISPLAY_NAME_LENGTH} characters`);
    }

    const [existing] = await db
      .select({ id: authUsers.id })
      .from(authUsers)
      .where(sql`lower(${authUsers.email}) = ${email}`);
    if (existing) {
      throw new ConflictException("An account with this email already exists");
    }

    const now = new Date();
    const id = randomUUID();
    try {
      // The on_auth_user_created trigger creates the matching profiles row.
      await db.insert(authUsers).values({
        id,
        aud: "authenticated",
        role: "authenticated",
        email,
        encryptedPassword: await bcrypt.hash(password, BCRYPT_COST),
        emailConfirmedAt: now,
        lastSignInAt: now,
        rawAppMetaData: { provider: "email", providers: ["email"] },
        rawUserMetaData: { display_name: displayName },
        createdAt: now,
        updatedAt: now,
      });
    } catch (error) {
      if (isUniqueViolation(error)) {
        throw new ConflictException("An account with this email already exists");
      }
      throw error;
    }

    return this.issueSession({ id, email, displayName });
  }

  async signIn(rawEmail: unknown, rawPassword: unknown, ip: string): Promise<Session> {
    const email = normalizeEmail(rawEmail);
    const password = typeof rawPassword === "string" ? rawPassword : "";
    const throttleKey = `${ip}|${email}`;

    const retryAfter = this.throttle.retryAfter(throttleKey);
    if (retryAfter > 0) {
      throw new HttpException(
        `Too many failed sign-in attempts. Try again in ${Math.ceil(retryAfter / 60)} minutes.`,
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }

    const [user] = await db
      .select()
      .from(authUsers)
      .where(and(sql`lower(${authUsers.email}) = ${email}`, isNull(authUsers.deletedAt)));

    const passwordOk = await bcrypt.compare(password, user?.encryptedPassword ?? DUMMY_HASH);
    if (!user || !user.encryptedPassword || !passwordOk) {
      this.throttle.fail(throttleKey);
      throw new UnauthorizedException("Invalid email or password");
    }
    this.throttle.succeed(throttleKey);

    if (user.bannedUntil && user.bannedUntil > new Date()) {
      throw new ForbiddenException("This account is suspended");
    }

    await db.update(authUsers).set({ lastSignInAt: new Date() }).where(eq(authUsers.id, user.id));
    const displayName = await this.ensureProfile(user.id, user.email!, user.rawUserMetaData);
    return this.issueSession({ id: user.id, email: user.email!, displayName });
  }

  async refresh(rawToken: unknown): Promise<Session> {
    if (typeof rawToken !== "string" || !rawToken) {
      throw new UnauthorizedException("Missing refresh token");
    }
    const [current] = await db
      .select()
      .from(apiRefreshTokens)
      .where(eq(apiRefreshTokens.tokenHash, hashRefreshToken(rawToken)));

    if (!current || current.expiresAt <= new Date()) {
      throw new UnauthorizedException("Session expired, sign in again");
    }
    if (current.revokedAt) {
      // A rotated-out token came back: assume it leaked and end every session.
      await db
        .update(apiRefreshTokens)
        .set({ revokedAt: new Date() })
        .where(and(eq(apiRefreshTokens.userId, current.userId), isNull(apiRefreshTokens.revokedAt)));
      throw new UnauthorizedException("Session expired, sign in again");
    }

    const [user] = await db
      .select()
      .from(authUsers)
      .where(and(eq(authUsers.id, current.userId), isNull(authUsers.deletedAt)));
    if (!user?.email || (user.bannedUntil && user.bannedUntil > new Date())) {
      throw new UnauthorizedException("Session expired, sign in again");
    }

    const displayName = await this.ensureProfile(user.id, user.email, user.rawUserMetaData);
    return this.issueSession({ id: user.id, email: user.email, displayName }, current.id);
  }

  async signOut(rawToken: unknown) {
    if (typeof rawToken !== "string" || !rawToken) return;
    await db
      .update(apiRefreshTokens)
      .set({ revokedAt: new Date() })
      .where(and(eq(apiRefreshTokens.tokenHash, hashRefreshToken(rawToken)), isNull(apiRefreshTokens.revokedAt)));
  }

  /** Returns the display name, creating the profile if an account lacks one. */
  private async ensureProfile(userId: string, email: string, metadata: unknown) {
    const fallback =
      (metadata as { display_name?: string } | null)?.display_name || email.split("@")[0];
    await db.insert(profiles).values({ id: userId, displayName: fallback }).onConflictDoNothing();
    const [profile] = await db
      .select({ displayName: profiles.displayName })
      .from(profiles)
      .where(eq(profiles.id, userId));
    return profile?.displayName ?? fallback;
  }

  /**
   * Issues an access token plus a new refresh token. When rotating, the
   * previous refresh token is revoked in the same transaction, and only if it
   * is still live, so two concurrent refreshes cannot both succeed.
   */
  private async issueSession(user: SessionUser, rotateFromId?: string): Promise<Session> {
    const refreshToken = newRefreshToken();
    const expiresAt = new Date(Date.now() + REFRESH_TOKEN_TTL_SECONDS * 1000);

    await db.transaction(async (tx) => {
      const [created] = await tx
        .insert(apiRefreshTokens)
        .values({ userId: user.id, tokenHash: hashRefreshToken(refreshToken), expiresAt })
        .returning({ id: apiRefreshTokens.id });

      if (rotateFromId) {
        const revoked = await tx
          .update(apiRefreshTokens)
          .set({ revokedAt: new Date(), replacedBy: created.id })
          .where(and(eq(apiRefreshTokens.id, rotateFromId), isNull(apiRefreshTokens.revokedAt)))
          .returning({ id: apiRefreshTokens.id });
        if (revoked.length === 0) {
          throw new UnauthorizedException("Session expired, sign in again");
        }
      }
    });

    const access = await signAccessToken({ sub: user.id, email: user.email });
    return { accessToken: access.token, refreshToken, expiresAt: access.expiresAt, user };
  }
}
