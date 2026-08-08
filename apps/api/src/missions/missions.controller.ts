import { Controller, Get, Param, Post, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { SupabaseAuthGuard } from "../auth/supabase-auth.guard";
import { MissionsService } from "./missions.service";

@Controller("missions")
export class MissionsController {
  constructor(private readonly missionsService: MissionsService) {}

  @UseGuards(SupabaseAuthGuard)
  @Get(":id")
  getDetail(@Param("id") id: string, @Req() request: Request) {
    return this.missionsService.getDetail(id, request.user!.sub);
  }

  @UseGuards(SupabaseAuthGuard)
  @Post(":id/start")
  start(@Param("id") id: string, @Req() request: Request) {
    return this.missionsService.startMission(id, request.user!.sub);
  }
}
