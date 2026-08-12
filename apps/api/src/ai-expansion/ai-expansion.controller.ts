import { Body, Controller, Get, Param, Post, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { SupabaseAuthGuard } from "../auth/supabase-auth.guard";
import { AiExpansionService } from "./ai-expansion.service";

@UseGuards(SupabaseAuthGuard)
@Controller("ai")
export class AiExpansionController {
  constructor(private readonly service: AiExpansionService) {}

  @Get("overview")
  overview(@Req() request: Request) {
    return this.service.overview(request.user!.sub);
  }

  @Get("incidents")
  incidents(@Req() request: Request) {
    return this.service.listIncidents(request.user!.sub);
  }

  @Get("incidents/:slug")
  incident(@Param("slug") slug: string, @Req() request: Request) {
    return this.service.getIncident(slug, request.user!.sub);
  }

  @Post("incidents/:slug/attempts")
  submitIncident(
    @Param("slug") slug: string,
    @Body() body: { diagnosis?: string; mitigation?: string },
    @Req() request: Request,
  ) {
    return this.service.submitIncident(slug, request.user!.sub, body);
  }

  @Get("interviews")
  interviews(@Req() request: Request) {
    return this.service.listInterviewQuestions(request.user!.sub);
  }

  @Post("interviews/:questionId/attempts")
  submitInterview(
    @Param("questionId") questionId: string,
    @Body() body: { answer?: string },
    @Req() request: Request,
  ) {
    return this.service.submitInterview(questionId, request.user!.sub, body);
  }
}
