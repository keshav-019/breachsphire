import { Module } from "@nestjs/common";
import { MissionsController } from "./missions.controller";
import { ChallengesController } from "./challenges.controller";
import { MissionsService } from "./missions.service";

@Module({
  controllers: [MissionsController, ChallengesController],
  providers: [MissionsService],
})
export class MissionsModule {}
