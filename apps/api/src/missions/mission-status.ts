/**
 * Shared by WorldsService (mission-list summaries) and MissionsService
 * (mission detail / start) so both compute status identically. Plain
 * function, not a NestJS provider — no DI wiring needed, and it keeps
 * WorldsModule and MissionsModule from having to depend on each other.
 *
 * Status is computed, not eagerly stored (see the Phase 2.5 plan):
 * `player_mission_progress` rows only exist once a player has actually
 * started or completed a mission. Before that, "available" vs "locked"
 * is derived from the World's unlock state plus whether prerequisite
 * missions are complete.
 */

export type ComputedMissionStatus = "locked" | "available" | "in_progress" | "completed";

const WORLD_STATES_COUNTING_AS_UNLOCKED = new Set(["unlocked", "active", "cleared"]);

export function computeMissionStatus(params: {
  worldState: string | undefined;
  prerequisiteMissionIds: readonly string[];
  completedMissionIds: ReadonlySet<string>;
  storedStatus: string | undefined;
}): ComputedMissionStatus {
  if (params.storedStatus === "in_progress" || params.storedStatus === "completed") {
    return params.storedStatus;
  }

  if (!params.worldState || !WORLD_STATES_COUNTING_AS_UNLOCKED.has(params.worldState)) {
    return "locked";
  }

  const prerequisitesMet = params.prerequisiteMissionIds.every((id) => params.completedMissionIds.has(id));
  return prerequisitesMet ? "available" : "locked";
}

/** `Mission.prerequisites` is `{ requiredMissionIds?: string[] }` (packages/types/src/mission.ts) stored as jsonb. */
export function extractRequiredMissionIds(prerequisites: unknown): string[] {
  if (
    typeof prerequisites === "object" &&
    prerequisites !== null &&
    "requiredMissionIds" in prerequisites &&
    Array.isArray((prerequisites as { requiredMissionIds: unknown }).requiredMissionIds)
  ) {
    return (prerequisites as { requiredMissionIds: string[] }).requiredMissionIds.filter(
      (id): id is string => typeof id === "string",
    );
  }
  return [];
}
