import { Module } from "@nestjs/common";
import { HealthModule } from "./health/health.module";
import { PlayersModule } from "./players/players.module";
import { PathwaysModule } from "./pathways/pathways.module";
import { WorldsModule } from "./worlds/worlds.module";
import { MissionsModule } from "./missions/missions.module";
import { BackendExpansionModule } from "./backend-expansion/backend-expansion.module";
import { AiExpansionModule } from "./ai-expansion/ai-expansion.module";

/**
 * Modular monolith (section 25). Domain modules are added here as they're
 * implemented: Auth, Users, Players, Pathways, Worlds, Campaigns, Missions,
 * Progress, Skills, Achievements, Inventory, Leaderboards, Challenges, Labs,
 * Notifications, Admin, Analytics.
 */
@Module({
  imports: [HealthModule, PlayersModule, PathwaysModule, WorldsModule, MissionsModule, BackendExpansionModule, AiExpansionModule],
})
export class AppModule {}
