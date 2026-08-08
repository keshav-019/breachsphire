import { Module } from "@nestjs/common";
import { HealthModule } from "./health/health.module";
import { PlayersModule } from "./players/players.module";
import { WorldsModule } from "./worlds/worlds.module";
import { MissionsModule } from "./missions/missions.module";

/**
 * Modular monolith (section 25). Domain modules are added here as they're
 * implemented: Auth, Users, Players, Worlds, Campaigns, Missions, Progress,
 * Skills, Achievements, Inventory, Leaderboards, Challenges, Labs,
 * Notifications, Admin, Analytics.
 */
@Module({
  imports: [HealthModule, PlayersModule, WorldsModule, MissionsModule],
})
export class AppModule {}
