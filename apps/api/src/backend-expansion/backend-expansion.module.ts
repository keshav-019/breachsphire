import { Module } from "@nestjs/common";
import { BackendExpansionController } from "./backend-expansion.controller";
import { BackendExpansionService } from "./backend-expansion.service";

@Module({
  controllers: [BackendExpansionController],
  providers: [BackendExpansionService],
})
export class BackendExpansionModule {}
