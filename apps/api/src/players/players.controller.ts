import { Controller, Get, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { SupabaseAuthGuard } from "../auth/supabase-auth.guard";

@Controller("players")
export class PlayersController {
  @UseGuards(SupabaseAuthGuard)
  @Get("me")
  me(@Req() request: Request) {
    return { id: request.user!.sub, email: request.user!.email };
  }
}
