import { Controller, Get, Req, UseGuards } from "@nestjs/common";
import type { Request } from "express";
import { JwtAuthGuard } from "../auth/jwt-auth.guard";
import { PathwaysService } from "./pathways.service";

@Controller("pathways")
export class PathwaysController {
  constructor(private readonly pathwaysService: PathwaysService) {}

  @UseGuards(JwtAuthGuard)
  @Get()
  list(@Req() request: Request) {
    return this.pathwaysService.listForPlayer(request.user!.sub);
  }
}
