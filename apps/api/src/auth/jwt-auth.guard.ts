import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from "@nestjs/common";
import type { Request } from "express";
import { verifyAccessToken } from "./tokens";

export interface AuthUser {
  sub: string;
  email?: string;
}

declare module "express" {
  interface Request {
    user?: AuthUser;
  }
}

/**
 * Verifies the bearer access token the API issued at sign-in (HS256,
 * JWT_SECRET). No database round-trip: it only proves the session is a
 * genuine, unexpired one.
 */
@Injectable()
export class JwtAuthGuard implements CanActivate {
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<Request>();
    const token = request.headers.authorization?.replace(/^Bearer\s+/i, "");

    if (!token) {
      throw new UnauthorizedException("Missing bearer token");
    }

    try {
      request.user = await verifyAccessToken(token);
      return true;
    } catch {
      throw new UnauthorizedException("Invalid or expired session");
    }
  }
}
