import { Module } from "@nestjs/common";
import { PathwaysController } from "./pathways.controller";
import { PathwaysService } from "./pathways.service";

@Module({
  controllers: [PathwaysController],
  providers: [PathwaysService],
})
export class PathwaysModule {}
