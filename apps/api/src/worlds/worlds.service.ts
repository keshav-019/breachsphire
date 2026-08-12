import { Injectable, NotFoundException } from "@nestjs/common";
import { and, eq } from "drizzle-orm";
import { db } from "../db/client";
import { worlds, playerWorldProgress, campaigns, operations, missions, playerMissionProgress } from "../db/schema";
import { computeMissionStatus, extractRequiredMissionIds, type ComputedMissionStatus } from "../missions/mission-status";

export interface WorldDto {
  id: string;
  index: number;
  name: string;
  short: string;
  icon: string;
  boss: string | null;
  threat: string;
  x: number;
  y: number;
  state: string;
  completion: number;
}

export interface MissionSummaryDto {
  id: string;
  slug: string;
  title: string;
  description: string;
  difficulty: string;
  isBoss: boolean;
  rewards: unknown;
  order: number;
  status: ComputedMissionStatus;
}

export interface OperationWithMissionsDto {
  id: string;
  slug: string;
  title: string;
  description: string;
  order: number;
  missions: MissionSummaryDto[];
}

export interface CampaignWithOperationsDto {
  id: string;
  slug: string;
  title: string;
  description: string;
  order: number;
  operations: OperationWithMissionsDto[];
}

@Injectable()
export class WorldsService {
  async listForPlayer(playerId: string, pathwayId: string): Promise<WorldDto[]> {
    const rows = await db
      .select({
        id: worlds.id,
        index: worlds.index,
        name: worlds.name,
        short: worlds.short,
        icon: worlds.icon,
        boss: worlds.boss,
        threat: worlds.threat,
        x: worlds.x,
        y: worlds.y,
        state: playerWorldProgress.state,
        completion: playerWorldProgress.completion,
      })
      .from(worlds)
      .leftJoin(
        playerWorldProgress,
        and(eq(playerWorldProgress.worldId, worlds.id), eq(playerWorldProgress.playerId, playerId)),
      )
      .where(eq(worlds.pathwayId, pathwayId))
      .orderBy(worlds.index);

    return rows.map((row) => ({
      ...row,
      state: row.state ?? "locked",
      completion: row.completion ?? 0,
    }));
  }

  /**
   * A world's campaign -> operation -> mission tree, missions summarized
   * (no objectives/challenges — that's `MissionsService.getDetail`). Each
   * mission's `status` is computed per `computeMissionStatus`, not read
   * from a possibly-nonexistent `player_mission_progress` row.
   */
  async getMissionTree(worldId: string, playerId: string): Promise<CampaignWithOperationsDto[]> {
    const [world] = await db.select({ id: worlds.id }).from(worlds).where(eq(worlds.id, worldId));
    if (!world) {
      throw new NotFoundException(`World ${worldId} not found`);
    }

    const [worldProgress] = await db
      .select({ state: playerWorldProgress.state })
      .from(playerWorldProgress)
      .where(and(eq(playerWorldProgress.worldId, worldId), eq(playerWorldProgress.playerId, playerId)));

    const [campaignRows, operationRows, missionRows, allMissionProgress] = await Promise.all([
      db.select().from(campaigns).where(eq(campaigns.worldId, worldId)).orderBy(campaigns.order),
      db
        .select({
          id: operations.id,
          campaignId: operations.campaignId,
          slug: operations.slug,
          title: operations.title,
          description: operations.description,
          order: operations.order,
        })
        .from(operations)
        .innerJoin(campaigns, eq(operations.campaignId, campaigns.id))
        .where(eq(campaigns.worldId, worldId))
        .orderBy(operations.order),
      db.select().from(missions).where(eq(missions.worldId, worldId)).orderBy(missions.order),
      // Deliberately not scoped to this world's missions: prerequisites
      // could in principle point outside it, and this table is tiny.
      db
        .select({ missionId: playerMissionProgress.missionId, status: playerMissionProgress.status })
        .from(playerMissionProgress)
        .where(eq(playerMissionProgress.playerId, playerId)),
    ]);

    const storedStatusByMissionId = new Map(allMissionProgress.map((r) => [r.missionId, r.status]));
    const completedMissionIds = new Set(
      allMissionProgress.filter((r) => r.status === "completed").map((r) => r.missionId),
    );

    const missionDtosByOperationId = new Map<string, MissionSummaryDto[]>();
    for (const m of missionRows) {
      const status = computeMissionStatus({
        worldState: worldProgress?.state,
        prerequisiteMissionIds: extractRequiredMissionIds(m.prerequisites),
        completedMissionIds,
        storedStatus: storedStatusByMissionId.get(m.id),
      });
      const dto: MissionSummaryDto = {
        id: m.id,
        slug: m.slug,
        title: m.title,
        description: m.description,
        difficulty: m.difficulty,
        isBoss: m.isBoss,
        rewards: m.rewards,
        order: m.order,
        status,
      };
      const list = missionDtosByOperationId.get(m.operationId) ?? [];
      list.push(dto);
      missionDtosByOperationId.set(m.operationId, list);
    }

    const operationDtosByCampaignId = new Map<string, OperationWithMissionsDto[]>();
    for (const o of operationRows) {
      const dto: OperationWithMissionsDto = {
        id: o.id,
        slug: o.slug,
        title: o.title,
        description: o.description,
        order: o.order,
        missions: missionDtosByOperationId.get(o.id) ?? [],
      };
      const list = operationDtosByCampaignId.get(o.campaignId) ?? [];
      list.push(dto);
      operationDtosByCampaignId.set(o.campaignId, list);
    }

    return campaignRows.map((c) => ({
      id: c.id,
      slug: c.slug,
      title: c.title,
      description: c.description,
      order: c.order,
      operations: operationDtosByCampaignId.get(c.id) ?? [],
    }));
  }
}
