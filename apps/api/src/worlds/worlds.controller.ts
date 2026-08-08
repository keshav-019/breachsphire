import { Controller, Get, Param, Req, UseGuards } from "@nestjs/common";
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

  @UseGuards(SupabaseAuthGuard)
  @Get(":worldId/missions")
  missions(@Param("worldId") worldId: string, @Req() request: Request) {
    return this.worldsService.getMissionTree(worldId, request.user!.sub);
  }
}
