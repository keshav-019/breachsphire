import { Controller, Get, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { SupabaseAuthGuard } from "../auth/supabase-auth.guard";
import { WorldsService } from "./worlds.service";

@Controller("worlds")
export class WorldsController {
  constructor(private readonly worldsService: WorldsService) {}

  @UseGuards(SupabaseAuthGuard)
  @Get()
  list(@Req() request: Request) {
    return this.worldsService.listForPlayer(request.user!.sub);
  }
}
