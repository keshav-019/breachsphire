import { BadRequestException, ForbiddenException, Injectable, NotFoundException } from "@nestjs/common";
import { and, eq, inArray, sql } from "drizzle-orm";
import { db } from "../db/client";
import {
  worlds,
  playerWorldProgress,
  missions,
  objectives,
  challenges,
  dialogueLines,
  hints,
  playerMissionProgress,
  playerObjectiveProgress,
  playerChallengeAttempts,
  playerHintReveals,
  profiles,
} from "../db/schema";
import { computeMissionStatus, extractRequiredMissionIds, type ComputedMissionStatus } from "./mission-status";
import { evaluateCompletion, UnrecognizedCompletionConditionsError } from "./completion-evaluator";
import { redactChallengeContent } from "./content-redaction";

export interface HintDto {
  tier: string;
  text: string;
  xpCost: number;
}

/**
 * Unlike `HintDto` (always real text -- returned right after a reveal),
 * this describes the full ladder for a challenge: every tier's cost is
 * visible so the client can render "reveal next hint (-N XP)", but
 * `text` stays `null` until `revealed` -- never leaking unpaid hint text.
 */
export interface MissionHintDto {
  tier: string;
  xpCost: number;
  revealed: boolean;
  text: string | null;
}

export interface ChallengeDetailDto {
  id: string;
  type: string;
  prompt: string;
  content: unknown;
  hints: MissionHintDto[];
}

export interface ObjectiveDetailDto {
  id: string;
  title: string;
  description: string;
  completed: boolean;
  challenges: ChallengeDetailDto[];
}

export interface DialogueLineDto {
  characterId: string;
  text: string;
}

export interface MissionDetailDto {
  id: string;
  worldId: string;
  campaignId: string;
  operationId: string;
  slug: string;
  title: string;
  description: string;
  difficulty: string;
  characterIds: string[];
  isBoss: boolean;
  rewards: unknown;
  status: ComputedMissionStatus;
  storyDialogue: DialogueLineDto[];
  objectives: ObjectiveDetailDto[];
}

export interface AttemptResultDto {
  correct: boolean;
  objectiveCompleted: boolean;
  missionCompleted: boolean;
  rewardsApplied?: { xp: number; credits: number };
  worldCleared?: boolean;
}

const HINT_TIER_ORDER = ["orientation", "concept", "tool_direction", "near_solution", "solution"] as const;

@Injectable()
export class MissionsService {
  /** Every mission the player has ever completed, across all worlds. */
  private async getCompletedMissionIds(playerId: string): Promise<Set<string>> {
    const rows = await db
      .select({ missionId: playerMissionProgress.missionId })
      .from(playerMissionProgress)
      .where(and(eq(playerMissionProgress.playerId, playerId), eq(playerMissionProgress.status, "completed")));
    return new Set(rows.map((r) => r.missionId));
  }

  private async computeStatusFor(mission: { id: string; worldId: string; prerequisites: unknown }, playerId: string) {
    const [worldProgress, [storedProgress], completedMissionIds] = await Promise.all([
      db
        .select({ state: playerWorldProgress.state })
        .from(playerWorldProgress)
        .where(and(eq(playerWorldProgress.worldId, mission.worldId), eq(playerWorldProgress.playerId, playerId)))
        .then((rows) => rows[0]),
      db
        .select({ status: playerMissionProgress.status })
        .from(playerMissionProgress)
        .where(and(eq(playerMissionProgress.playerId, playerId), eq(playerMissionProgress.missionId, mission.id))),
      this.getCompletedMissionIds(playerId),
    ]);

    return computeMissionStatus({
      worldState: worldProgress?.state,
      prerequisiteMissionIds: extractRequiredMissionIds(mission.prerequisites),
      completedMissionIds,
      storedStatus: storedProgress?.status,
    });
  }

  async getDetail(missionId: string, playerId: string): Promise<MissionDetailDto> {
    const [mission] = await db.select().from(missions).where(eq(missions.id, missionId));
    if (!mission) {
      throw new NotFoundException(`Mission ${missionId} not found`);
    }

    const status = await this.computeStatusFor(mission, playerId);

    const [objectiveRows, dialogueRows] = await Promise.all([
      db.select().from(objectives).where(eq(objectives.missionId, missionId)).orderBy(objectives.order),
      db
        .select({ characterId: dialogueLines.characterId, text: dialogueLines.text })
        .from(dialogueLines)
        .where(eq(dialogueLines.missionId, missionId))
        .orderBy(dialogueLines.order),
    ]);
    const objectiveIds = objectiveRows.map((o) => o.id);

    const [challengeRows, objectiveProgressRows] = await Promise.all([
      objectiveIds.length
        ? db.select().from(challenges).where(inArray(challenges.objectiveId, objectiveIds)).orderBy(challenges.order)
        : Promise.resolve([]),
      objectiveIds.length
        ? db
            .select({ objectiveId: playerObjectiveProgress.objectiveId, status: playerObjectiveProgress.status })
            .from(playerObjectiveProgress)
            .where(
              and(eq(playerObjectiveProgress.playerId, playerId), inArray(playerObjectiveProgress.objectiveId, objectiveIds)),
            )
        : Promise.resolve([]),
    ]);
    const completedObjectiveIds = new Set(
      objectiveProgressRows.filter((r) => r.status === "completed").map((r) => r.objectiveId),
    );

    const challengeIds = challengeRows.map((c) => c.id);
    const [hintRows, revealedRows] = await Promise.all([
      challengeIds.length
        ? db.select().from(hints).where(inArray(hints.challengeId, challengeIds)).orderBy(hints.order)
        : Promise.resolve([]),
      challengeIds.length
        ? db
            .select({ challengeId: playerHintReveals.challengeId, tier: playerHintReveals.tier })
            .from(playerHintReveals)
            .where(and(eq(playerHintReveals.playerId, playerId), inArray(playerHintReveals.challengeId, challengeIds)))
        : Promise.resolve([]),
    ]);
    const revealedTiersByChallenge = new Map<string, Set<string>>();
    for (const r of revealedRows) {
      const set = revealedTiersByChallenge.get(r.challengeId) ?? new Set<string>();
      set.add(r.tier);
      revealedTiersByChallenge.set(r.challengeId, set);
    }

    const challengeDtosByObjectiveId = new Map<string, ChallengeDetailDto[]>();
    for (const c of challengeRows) {
      const revealedTiers = revealedTiersByChallenge.get(c.id) ?? new Set<string>();
      const dto: ChallengeDetailDto = {
        id: c.id,
        type: c.type,
        prompt: c.prompt,
        content: redactChallengeContent(c.type, c.content),
        hints: hintRows
          .filter((h) => h.challengeId === c.id)
          .map((h) => {
            const revealed = revealedTiers.has(h.tier);
            return { tier: h.tier, xpCost: h.xpCost, revealed, text: revealed ? h.text : null };
          }),
      };
      const list = challengeDtosByObjectiveId.get(c.objectiveId) ?? [];
      list.push(dto);
      challengeDtosByObjectiveId.set(c.objectiveId, list);
    }

    return {
      id: mission.id,
      worldId: mission.worldId,
      campaignId: mission.campaignId,
      operationId: mission.operationId,
      slug: mission.slug,
      title: mission.title,
      description: mission.description,
      difficulty: mission.difficulty,
      characterIds: mission.characterIds,
      isBoss: mission.isBoss,
      rewards: mission.rewards,
      status,
      storyDialogue: dialogueRows,
      objectives: objectiveRows.map((o) => ({
        id: o.id,
        title: o.title,
        description: o.description,
        completed: completedObjectiveIds.has(o.id),
        challenges: challengeDtosByObjectiveId.get(o.id) ?? [],
      })),
    };
  }

  async startMission(missionId: string, playerId: string): Promise<{ status: ComputedMissionStatus }> {
    const [mission] = await db.select().from(missions).where(eq(missions.id, missionId));
    if (!mission) {
      throw new NotFoundException(`Mission ${missionId} not found`);
    }

    const status = await this.computeStatusFor(mission, playerId);
    if (status === "locked") {
      throw new ForbiddenException("This mission's prerequisites aren't complete yet");
    }
    if (status === "completed") {
      return { status };
    }

    const [existing] = await db
      .select()
      .from(playerMissionProgress)
      .where(and(eq(playerMissionProgress.playerId, playerId), eq(playerMissionProgress.missionId, missionId)));

    if (existing) {
      await db
        .update(playerMissionProgress)
        .set({ status: "in_progress", updatedAt: new Date() })
        .where(and(eq(playerMissionProgress.playerId, playerId), eq(playerMissionProgress.missionId, missionId)));
    } else {
      await db.insert(playerMissionProgress).values({
        playerId,
        missionId,
        status: "in_progress",
        startedAt: new Date(),
      });
    }

    return { status: "in_progress" };
  }

  async revealHint(challengeId: string, tier: string, playerId: string): Promise<HintDto> {
    if (!HINT_TIER_ORDER.includes(tier as (typeof HINT_TIER_ORDER)[number])) {
      throw new BadRequestException(`Unknown hint tier: ${tier}`);
    }

    const challengeHints = await db.select().from(hints).where(eq(hints.challengeId, challengeId)).orderBy(hints.order);
    const target = challengeHints.find((h) => h.tier === tier);
    if (!target) {
      throw new NotFoundException(`Challenge ${challengeId} has no ${tier} hint`);
    }

    const priorHints = challengeHints.filter((h) => h.order < target.order);
    const revealed = await db
      .select({ tier: playerHintReveals.tier })
      .from(playerHintReveals)
      .where(and(eq(playerHintReveals.playerId, playerId), eq(playerHintReveals.challengeId, challengeId)));
    const revealedTiers = new Set(revealed.map((r) => r.tier));

    const missingPrior = priorHints.find((h) => !revealedTiers.has(h.tier));
    if (missingPrior) {
      throw new BadRequestException(`Reveal the ${missingPrior.tier} hint before ${tier}`);
    }

    if (!revealedTiers.has(tier)) {
      await db
        .insert(playerHintReveals)
        .values({ playerId, challengeId, tier, xpCost: target.xpCost })
        .onConflictDoNothing();
    }

    return { tier: target.tier, text: target.text, xpCost: target.xpCost };
  }

  async submitAttempt(challengeId: string, playerId: string, answer: Record<string, unknown>): Promise<AttemptResultDto> {
    const [challenge] = await db.select().from(challenges).where(eq(challenges.id, challengeId));
    if (!challenge) {
      throw new NotFoundException(`Challenge ${challengeId} not found`);
    }
    const [objective] = await db.select().from(objectives).where(eq(objectives.id, challenge.objectiveId));
    if (!objective) {
      throw new NotFoundException(`Objective ${challenge.objectiveId} not found`);
    }
    const [mission] = await db.select().from(missions).where(eq(missions.id, objective.missionId));
    if (!mission) {
      throw new NotFoundException(`Mission ${objective.missionId} not found`);
    }

    const [missionProgress] = await db
      .select()
      .from(playerMissionProgress)
      .where(and(eq(playerMissionProgress.playerId, playerId), eq(playerMissionProgress.missionId, mission.id)));
    if (missionProgress?.status !== "in_progress" && missionProgress?.status !== "completed") {
      throw new ForbiddenException("Start the mission before attempting its challenges");
    }

    // Sibling objectives already completed -- only used by boss_encounter's
    // `requiredObjectiveIds` shape, harmless to compute otherwise.
    const missionObjectiveRows = await db.select().from(objectives).where(eq(objectives.missionId, mission.id));
    const missionObjectiveIds = missionObjectiveRows.map((o) => o.id);
    const completedObjectiveRows = await db
      .select({ objectiveId: playerObjectiveProgress.objectiveId })
      .from(playerObjectiveProgress)
      .where(
        and(
          eq(playerObjectiveProgress.playerId, playerId),
          eq(playerObjectiveProgress.status, "completed"),
          inArray(playerObjectiveProgress.objectiveId, missionObjectiveIds),
        ),
      );
    const completedObjectiveIds = new Set(completedObjectiveRows.map((r) => r.objectiveId));

    let correct: boolean;
    try {
      correct = evaluateCompletion(challenge.completionConditions as Record<string, unknown>, answer, {
        completedObjectiveIds,
      });
    } catch (err) {
      if (err instanceof UnrecognizedCompletionConditionsError) {
        throw new BadRequestException(err.message);
      }
      throw err;
    }

    const hintsRevealedRows = await db
      .select({ tier: playerHintReveals.tier })
      .from(playerHintReveals)
      .where(and(eq(playerHintReveals.playerId, playerId), eq(playerHintReveals.challengeId, challengeId)));

    let result: AttemptResultDto = { correct, objectiveCompleted: false, missionCompleted: false };

    await db.transaction(async (tx) => {
      await tx.insert(playerChallengeAttempts).values({
        playerId,
        challengeId,
        isCorrect: correct,
        hintsRevealed: hintsRevealedRows.map((r) => r.tier),
      });

      if (!correct) return;

      // -- objective completion: every challenge under it must have a
      // correct attempt on record.
      const objectiveChallenges = await tx.select({ id: challenges.id }).from(challenges).where(eq(challenges.objectiveId, objective.id));
      const objectiveChallengeIds = objectiveChallenges.map((c) => c.id);
      const correctAttempts = await tx
        .select({ challengeId: playerChallengeAttempts.challengeId })
        .from(playerChallengeAttempts)
        .where(
          and(
            eq(playerChallengeAttempts.playerId, playerId),
            eq(playerChallengeAttempts.isCorrect, true),
            inArray(playerChallengeAttempts.challengeId, objectiveChallengeIds),
          ),
        );
      const correctChallengeIds = new Set(correctAttempts.map((a) => a.challengeId));
      const objectiveComplete = objectiveChallengeIds.every((id) => correctChallengeIds.has(id));

      if (!objectiveComplete) return;

      await tx
        .insert(playerObjectiveProgress)
        .values({ playerId, objectiveId: objective.id, status: "completed", completedAt: new Date() })
        .onConflictDoUpdate({
          target: [playerObjectiveProgress.playerId, playerObjectiveProgress.objectiveId],
          set: { status: "completed", completedAt: new Date(), updatedAt: new Date() },
        });
      result.objectiveCompleted = true;

      // -- mission completion: every objective in it must now be complete.
      const objectiveProgressForMission = await tx
        .select({ objectiveId: playerObjectiveProgress.objectiveId })
        .from(playerObjectiveProgress)
        .where(
          and(
            eq(playerObjectiveProgress.playerId, playerId),
            eq(playerObjectiveProgress.status, "completed"),
            inArray(playerObjectiveProgress.objectiveId, missionObjectiveIds),
          ),
        );
      const completedNow = new Set(objectiveProgressForMission.map((r) => r.objectiveId));
      completedNow.add(objective.id); // this transaction's own update, read-your-writes
      const missionComplete = missionObjectiveIds.every((id) => completedNow.has(id));

      if (!missionComplete) return;
      if (missionProgress?.status === "completed") {
        // Already recorded (replay) -- don't re-apply rewards.
        result.missionCompleted = true;
        return;
      }

      // All challenges across this mission's objectives, to total the hint penalty.
      const allMissionChallenges = await tx
        .select({ id: challenges.id })
        .from(challenges)
        .where(inArray(challenges.objectiveId, missionObjectiveIds));
      const allMissionChallengeIds = allMissionChallenges.map((c) => c.id);
      const hintCostRows = allMissionChallengeIds.length
        ? await tx
            .select({ xpCost: playerHintReveals.xpCost })
            .from(playerHintReveals)
            .where(
              and(eq(playerHintReveals.playerId, playerId), inArray(playerHintReveals.challengeId, allMissionChallengeIds)),
            )
        : [];
      const totalHintCost = hintCostRows.reduce((sum, r) => sum + r.xpCost, 0);

      const rewards = mission.rewards as { xp: number; credits: number };
      const awardedXp = Math.max(0, rewards.xp - totalHintCost);

      await tx
        .insert(playerMissionProgress)
        .values({ playerId, missionId: mission.id, status: "completed", startedAt: new Date(), completedAt: new Date() })
        .onConflictDoUpdate({
          target: [playerMissionProgress.playerId, playerMissionProgress.missionId],
          set: { status: "completed", completedAt: new Date(), updatedAt: new Date() },
        });

      await tx
        .update(profiles)
        .set({ xp: sql`${profiles.xp} + ${awardedXp}`, credits: sql`${profiles.credits} + ${rewards.credits}` })
        .where(eq(profiles.id, playerId));

      result.missionCompleted = true;
      result.rewardsApplied = { xp: awardedXp, credits: rewards.credits };

      if (!mission.isBoss) return;

      const [world] = await tx.select().from(worlds).where(eq(worlds.id, mission.worldId));
      if (!world) return;

      await tx
        .insert(playerWorldProgress)
        .values({ playerId, worldId: world.id, state: "cleared", completion: 100 })
        .onConflictDoUpdate({
          target: [playerWorldProgress.playerId, playerWorldProgress.worldId],
          set: { state: "cleared", completion: 100, updatedAt: new Date() },
        });

      const [nextWorld] = await tx.select().from(worlds).where(eq(worlds.index, world.index + 1));
      if (nextWorld) {
        const [existingNext] = await tx
          .select()
          .from(playerWorldProgress)
          .where(and(eq(playerWorldProgress.playerId, playerId), eq(playerWorldProgress.worldId, nextWorld.id)));
        if (!existingNext) {
          await tx.insert(playerWorldProgress).values({ playerId, worldId: nextWorld.id, state: "unlocked", completion: 0 });
        }
      }

      result.worldCleared = true;
    });

    return result;
  }
}
