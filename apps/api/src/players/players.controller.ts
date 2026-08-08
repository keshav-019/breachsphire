import { Controller, Get, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { SupabaseAuthGuard } from "../auth/supabase-auth.guard";
import { PlayersService } from "./players.service";

@Controller("players")
export class PlayersController {
  constructor(private readonly playersService: PlayersService) {}

  @UseGuards(SupabaseAuthGuard)
  @Get("me")
  me(@Req() request: Request) {
    return this.playersService.getMe(request.user!.sub, request.user!.email);
  }
}
