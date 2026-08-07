import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from "@nestjs/common";
import type { Request } from "express";
import { createRemoteJWKSet, jwtVerify } from "jose";

export interface SupabaseUser {
  sub: string;
  email?: string;
}

declare module "express" {
  interface Request {
    user?: SupabaseUser;
  }
}

let jwks: ReturnType<typeof createRemoteJWKSet> | null = null;

function getJwks() {
  if (!jwks) {
    const supabaseUrl = process.env.SUPABASE_URL;
    if (!supabaseUrl) {
      throw new Error("SUPABASE_URL is not set — copy apps/api/.env.example to .env");
    }
    jwks = createRemoteJWKSet(new URL(`${supabaseUrl}/auth/v1/.well-known/jwks.json`));
  }
  return jwks;
}

/**
 * Verifies the bearer token against Supabase's JWKS endpoint (asymmetric
 * ECC/RSA signing keys — Supabase's current default, replacing the legacy
 * shared HS256 secret). No database round-trip, no secret to hold — this
 * only proves the session is a genuine, unexpired Supabase session.
 */
@Injectable()
export class SupabaseAuthGuard implements CanActivate {
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<Request>();
    const token = request.headers.authorization?.replace(/^Bearer\s+/i, "");

    if (!token) {
      throw new UnauthorizedException("Missing bearer token");
    }

    try {
      const supabaseUrl = process.env.SUPABASE_URL;
      const { payload } = await jwtVerify(token, getJwks(), {
        issuer: `${supabaseUrl}/auth/v1`,
      });
      request.user = { sub: payload.sub as string, email: payload.email as string | undefined };
      return true;
    } catch {
      throw new UnauthorizedException("Invalid or expired session");
    }
  }
}
