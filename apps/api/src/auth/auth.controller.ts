import { Body, Controller, Get, HttpCode, Post, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { AuthService } from "./auth.service";
import { JwtAuthGuard } from "./jwt-auth.guard";

interface Credentials {
  email?: unknown;
  password?: unknown;
  displayName?: unknown;
}

@Controller("auth")
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post("signup")
  signUp(@Body() body: Credentials) {
    return this.authService.signUp(body?.email, body?.password, body?.displayName);
  }

  @HttpCode(200)
  @Post("login")
  login(@Body() body: Credentials, @Req() request: Request) {
    return this.authService.signIn(body?.email, body?.password, request.ip ?? "unknown");
  }

  @HttpCode(200)
  @Post("refresh")
  refresh(@Body() body: { refreshToken?: unknown }) {
    return this.authService.refresh(body?.refreshToken);
  }

  @HttpCode(204)
  @Post("logout")
  async logout(@Body() body: { refreshToken?: unknown }) {
    await this.authService.signOut(body?.refreshToken);
  }

  @UseGuards(JwtAuthGuard)
  @Get("me")
  me(@Req() request: Request) {
    return { id: request.user!.sub, email: request.user!.email };
  }
}
