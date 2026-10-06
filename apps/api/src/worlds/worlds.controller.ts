import { Controller, Get, Param, Query, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { JwtAuthGuard } from "../auth/jwt-auth.guard";
import { WorldsService } from "./worlds.service";

@Controller("worlds")
export class WorldsController {
  constructor(private readonly worldsService: WorldsService) {}

  @UseGuards(JwtAuthGuard)
  @Get()
  list(@Req() request: Request, @Query("pathwayId") pathwayId?: string) {
    return this.worldsService.listForPlayer(request.user!.sub, pathwayId ?? "pathway-cyber");
  }

  @UseGuards(JwtAuthGuard)
  @Get(":worldId/missions")
  missions(@Param("worldId") worldId: string, @Req() request: Request) {
    return this.worldsService.getMissionTree(worldId, request.user!.sub);
  }
}
