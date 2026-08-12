import { Module } from "@nestjs/common";
import { AiExpansionController } from "./ai-expansion.controller";
import { AiExpansionService } from "./ai-expansion.service";

@Module({ controllers: [AiExpansionController], providers: [AiExpansionService] })
export class AiExpansionModule {}
