import { Body, Controller, Param, Post, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { SupabaseAuthGuard } from "../auth/supabase-auth.guard";
import { MissionsService } from "./missions.service";

@Controller("challenges")
export class ChallengesController {
  constructor(private readonly missionsService: MissionsService) {}

  @UseGuards(SupabaseAuthGuard)
  @Post(":id/hints/:tier")
  revealHint(@Param("id") id: string, @Param("tier") tier: string, @Req() request: Request) {
    return this.missionsService.revealHint(id, tier, request.user!.sub);
  }

  @UseGuards(SupabaseAuthGuard)
  @Post(":id/attempts")
  submitAttempt(
    @Param("id") id: string,
    @Body() body: { answer?: Record<string, unknown> },
    @Req() request: Request,
  ) {
    return this.missionsService.submitAttempt(id, request.user!.sub, body.answer ?? {});
  }
}
