import { createHash, randomBytes } from "node:crypto";
import { SignJWT, jwtVerify } from "jose";

const ISSUER = "breachsphire-api";
const AUDIENCE = "breachsphire";

export const ACCESS_TOKEN_TTL_SECONDS = 15 * 60;
export const REFRESH_TOKEN_TTL_SECONDS = 30 * 24 * 60 * 60;

let secret: Uint8Array | null = null;

function getSecret() {
  if (!secret) {
    const value = process.env.JWT_SECRET;
    if (!value || value.length < 32) {
      throw new Error("JWT_SECRET is not set or shorter than 32 characters — see apps/api/.env.example");
    }
    secret = new TextEncoder().encode(value);
  }
  return secret;
}

export interface AccessTokenClaims {
  sub: string;
  email?: string;
}

export async function signAccessToken(claims: AccessTokenClaims) {
  const expiresAt = Math.floor(Date.now() / 1000) + ACCESS_TOKEN_TTL_SECONDS;
  const token = await new SignJWT({ email: claims.email })
    .setProtectedHeader({ alg: "HS256", typ: "JWT" })
    .setSubject(claims.sub)
    .setIssuer(ISSUER)
    .setAudience(AUDIENCE)
    .setIssuedAt()
    .setExpirationTime(expiresAt)
    .sign(getSecret());
  return { token, expiresAt };
}

export async function verifyAccessToken(token: string): Promise<AccessTokenClaims> {
  const { payload } = await jwtVerify(token, getSecret(), {
    issuer: ISSUER,
    audience: AUDIENCE,
    algorithms: ["HS256"],
  });
  if (typeof payload.sub !== "string") {
    throw new Error("Token has no subject");
  }
  return { sub: payload.sub, email: typeof payload.email === "string" ? payload.email : undefined };
}

/** Opaque refresh token; only its SHA-256 hash is stored. */
export function newRefreshToken() {
  return randomBytes(32).toString("base64url");
}

export function hashRefreshToken(token: string) {
  return createHash("sha256").update(token).digest("hex");
}

/** Fails fast at boot instead of on the first login. */
export function assertAuthConfigured() {
  getSecret();
}
