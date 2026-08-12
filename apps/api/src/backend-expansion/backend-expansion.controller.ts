import { Body, Controller, Get, Param, Post, Query, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import type { ArenaSubmissionInput } from "@cyber-guardians/types";
import { SupabaseAuthGuard } from "../auth/supabase-auth.guard";
import { BackendExpansionService } from "./backend-expansion.service";

@UseGuards(SupabaseAuthGuard)
@Controller("backend")
export class BackendExpansionController {
  constructor(private readonly service: BackendExpansionService) {}

  @Get("overview")
  overview(@Query("pathwayId") pathwayId = "pathway-backend", @Req() request: Request) {
    return this.service.overview(request.user!.sub, pathwayId);
  }

  @Get("arena")
  arena(@Query("pathwayId") pathwayId = "pathway-backend", @Req() request: Request) {
    return this.service.listArena(request.user!.sub, pathwayId);
  }

  @Get("arena/:slug")
  arenaChallenge(@Param("slug") slug: string, @Query("pathwayId") pathwayId = "pathway-backend", @Req() request: Request) {
    return this.service.getArenaChallenge(slug, request.user!.sub, pathwayId);
  }

  @Post("arena/:slug/submissions")
  submitArena(
    @Param("slug") slug: string,
    @Query("pathwayId") pathwayId = "pathway-backend",
    @Body() body: Partial<ArenaSubmissionInput>,
    @Req() request: Request,
  ) {
    return this.service.submitArenaChallenge(slug, request.user!.sub, pathwayId, body);
  }

  @Get("portfolio")
  portfolio(@Query("pathwayId") pathwayId = "pathway-backend", @Req() request: Request) {
    return this.service.listPortfolio(request.user!.sub, pathwayId);
  }

  @Get("portfolio/:slug")
  portfolioCampaign(@Param("slug") slug: string, @Query("pathwayId") pathwayId = "pathway-backend", @Req() request: Request) {
    return this.service.getPortfolioCampaign(slug, request.user!.sub, pathwayId);
  }

  @Post("portfolio/:slug/evidence")
  saveEvidence(
    @Param("slug") slug: string,
    @Query("pathwayId") pathwayId = "pathway-backend",
    @Body() body: { repoUrl?: string; liveUrl?: string; reflection?: string },
    @Req() request: Request,
  ) {
    return this.service.savePortfolioEvidence(slug, request.user!.sub, pathwayId, body);
  }

  @Post("portfolio/milestones/:milestoneId")
  setMilestone(
    @Param("milestoneId") milestoneId: string,
    @Body() body: { completed?: boolean },
    @Req() request: Request,
  ) {
    return this.service.setPortfolioMilestone(milestoneId, body.completed === true, request.user!.sub);
  }

  @Get("tracks")
  tracks(@Query("pathwayId") pathwayId = "pathway-backend", @Req() request: Request) {
    return this.service.listLanguageTracks(request.user!.sub, pathwayId);
  }

  @Get("tracks/:slug")
  track(@Param("slug") slug: string, @Query("pathwayId") pathwayId = "pathway-backend", @Req() request: Request) {
    return this.service.getLanguageTrack(slug, request.user!.sub, pathwayId);
  }

  @Post("tracks/:slug/enroll")
  enroll(@Param("slug") slug: string, @Query("pathwayId") pathwayId = "pathway-backend", @Req() request: Request) {
    return this.service.enrollLanguageTrack(slug, request.user!.sub, pathwayId);
  }

  @Post("tracks/modules/:moduleId")
  setModule(
    @Param("moduleId") moduleId: string,
    @Body() body: { completed?: boolean; reflection?: string },
    @Req() request: Request,
  ) {
    return this.service.setLanguageModule(
      moduleId,
      request.user!.sub,
      body.completed === true,
      body.reflection ?? "",
    );
  }
}
