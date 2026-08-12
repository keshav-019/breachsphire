import { BadRequestException, Injectable, NotFoundException } from "@nestjs/common";
import { and, desc, eq } from "drizzle-orm";
import type {
  ArenaCriterionScore,
  ArenaMode,
  ArenaModeDefinition,
  ArenaRubricCriterion,
  ArenaSubmission,
  ArenaSubmissionInput,
  BackendExpansionOverview,
  LanguageTrackDetail,
  LanguageTrackSummary,
  PortfolioCampaignDetail,
  PortfolioCampaignSummary,
  PortfolioStatus,
  SystemDesignChallengeDetail,
  SystemDesignChallengeSummary,
} from "@cyber-guardians/types";
import { db } from "../db/client";
import {
  languageTrackModules,
  languageTracks,
  playerLanguageModules,
  playerLanguageTracks,
  playerPortfolioMilestones,
  playerPortfolioProgress,
  portfolioCampaigns,
  portfolioMilestones,
  systemDesignChallenges,
  systemDesignSubmissions,
} from "../db/schema";

const ARENA_MODES = new Set<ArenaMode>(["foundation", "scale", "incident", "interview"]);

function strings(value: unknown): string[] {
  return Array.isArray(value) ? value.filter((item): item is string => typeof item === "string") : [];
}

function asModes(value: unknown): ArenaModeDefinition[] {
  return Array.isArray(value) ? (value as ArenaModeDefinition[]) : [];
}

function asRubric(value: unknown): ArenaRubricCriterion[] {
  return Array.isArray(value) ? (value as ArenaRubricCriterion[]) : [];
}

function submissionDto(row: typeof systemDesignSubmissions.$inferSelect): ArenaSubmission {
  return {
    id: row.id,
    mode: row.mode as ArenaMode,
    architecture: row.architecture,
    assumptions: row.assumptions,
    tradeoffs: row.tradeoffs,
    score: row.score,
    criterionScores: Array.isArray(row.criterionScores)
      ? (row.criterionScores as ArenaCriterionScore[])
      : [],
    feedback: strings(row.feedback),
    createdAt: row.createdAt.toISOString(),
  };
}

function validateHttpUrl(value: string, label: string) {
  if (!value) return;
  try {
    const url = new URL(value);
    if (url.protocol !== "http:" && url.protocol !== "https:") throw new Error();
  } catch {
    throw new BadRequestException(`${label} must be a valid http(s) URL`);
  }
}

@Injectable()
export class BackendExpansionService {
  async overview(playerId: string, pathwayId: string): Promise<BackendExpansionOverview> {
    const [arena, portfolio, tracks] = await Promise.all([
      this.listArena(playerId, pathwayId),
      this.listPortfolio(playerId, pathwayId),
      this.listLanguageTracks(playerId, pathwayId),
    ]);
    const arenaBest = arena.flatMap((item) => (item.bestScore === null ? [] : [item.bestScore]));

    return {
      arena: {
        completed: arena.filter((item) => item.submissionCount > 0).length,
        total: arena.length,
        bestScore: arenaBest.length ? Math.max(...arenaBest) : null,
      },
      portfolio: {
        completed: portfolio.filter((item) => item.status === "completed").length,
        total: portfolio.length,
        milestonesCompleted: portfolio.reduce((sum, item) => sum + item.milestonesCompleted, 0),
        milestonesTotal: portfolio.reduce((sum, item) => sum + item.milestonesTotal, 0),
      },
      tracks: {
        completed: tracks.filter((item) => item.status === "completed").length,
        enrolled: tracks.filter((item) => item.status !== "not_started").length,
        total: tracks.length,
        modulesCompleted: tracks.reduce((sum, item) => sum + item.modulesCompleted, 0),
        modulesTotal: tracks.reduce((sum, item) => sum + item.modulesTotal, 0),
      },
    };
  }

  async listArena(playerId: string, pathwayId: string): Promise<SystemDesignChallengeSummary[]> {
    const [challengeRows, submissionRows] = await Promise.all([
      db.select().from(systemDesignChallenges).where(eq(systemDesignChallenges.pathwayId, pathwayId)).orderBy(systemDesignChallenges.order),
      db
        .select({ challengeId: systemDesignSubmissions.challengeId, score: systemDesignSubmissions.score })
        .from(systemDesignSubmissions)
        .where(eq(systemDesignSubmissions.playerId, playerId)),
    ]);

    return challengeRows.map((challenge) => {
      const attempts = submissionRows.filter((row) => row.challengeId === challenge.id);
      return {
        id: challenge.id,
        slug: challenge.slug,
        title: challenge.title,
        domain: challenge.domain,
        summary: challenge.summary,
        estimatedMinutes: challenge.estimatedMinutes,
        submissionCount: attempts.length,
        bestScore: attempts.length ? Math.max(...attempts.map((attempt) => attempt.score)) : null,
      };
    });
  }

  async getArenaChallenge(slug: string, playerId: string, pathwayId: string): Promise<SystemDesignChallengeDetail> {
    const [challenge] = await db
      .select()
      .from(systemDesignChallenges)
      .where(and(eq(systemDesignChallenges.slug, slug), eq(systemDesignChallenges.pathwayId, pathwayId)))
      .limit(1);
    if (!challenge) throw new NotFoundException("System design challenge not found");

    const submissions = await db
      .select()
      .from(systemDesignSubmissions)
      .where(
        and(
          eq(systemDesignSubmissions.playerId, playerId),
          eq(systemDesignSubmissions.challengeId, challenge.id),
        ),
      )
      .orderBy(desc(systemDesignSubmissions.createdAt));

    return {
      id: challenge.id,
      slug: challenge.slug,
      title: challenge.title,
      domain: challenge.domain,
      summary: challenge.summary,
      estimatedMinutes: challenge.estimatedMinutes,
      submissionCount: submissions.length,
      bestScore: submissions.length ? Math.max(...submissions.map((row) => row.score)) : null,
      prompt: challenge.prompt,
      context: challenge.context,
      functionalRequirements: strings(challenge.functionalRequirements),
      nonfunctionalRequirements: strings(challenge.nonfunctionalRequirements),
      modes: asModes(challenge.modes),
      rubric: asRubric(challenge.rubric),
      latestSubmission: submissions[0] ? submissionDto(submissions[0]) : null,
    };
  }

  async submitArenaChallenge(
    slug: string,
    playerId: string,
    pathwayId: string,
    input: Partial<ArenaSubmissionInput>,
  ): Promise<ArenaSubmission> {
    const [challenge] = await db
      .select()
      .from(systemDesignChallenges)
      .where(and(eq(systemDesignChallenges.slug, slug), eq(systemDesignChallenges.pathwayId, pathwayId)))
      .limit(1);
    if (!challenge) throw new NotFoundException("System design challenge not found");

    const mode = input.mode;
    const architecture = input.architecture?.trim() ?? "";
    const assumptions = input.assumptions?.trim() ?? "";
    const tradeoffs = input.tradeoffs?.trim() ?? "";
    if (!mode || !ARENA_MODES.has(mode)) throw new BadRequestException("Choose a valid Arena mode");
    if (architecture.length < 120) {
      throw new BadRequestException("Architecture must contain at least 120 characters");
    }
    if (assumptions.length < 40) {
      throw new BadRequestException("Assumptions must contain at least 40 characters");
    }
    if (tradeoffs.length < 40) {
      throw new BadRequestException("Tradeoffs must contain at least 40 characters");
    }

    const rubric = asRubric(challenge.rubric);
    const response = `${assumptions}\n${architecture}\n${tradeoffs}`.toLocaleLowerCase();
    const responseWords = response.split(/\s+/).filter(Boolean).length;
    const criterionScores: ArenaCriterionScore[] = rubric.map((criterion) => {
      const matchedSignals = criterion.keywords.filter((keyword) => response.includes(keyword.toLocaleLowerCase()));
      const signalTarget = Math.min(4, Math.max(1, criterion.keywords.length));
      const coverage = Math.min(1, matchedSignals.length / signalTarget);
      // A little depth credit prevents a good explanation from scoring zero
      // simply because it used accurate synonyms. Keywords remain visible in
      // the rubric and are only a deterministic first-pass signal.
      const depthCredit = Math.min(0.2, responseWords / 1000);
      const score = Math.round(criterion.weight * Math.min(1, coverage * 0.85 + depthCredit));
      return {
        key: criterion.key,
        label: criterion.label,
        score,
        maxScore: criterion.weight,
        matchedSignals,
      };
    });
    const score = Math.min(100, criterionScores.reduce((sum, item) => sum + item.score, 0));
    const weakCriteria = criterionScores
      .filter((item) => item.score < item.maxScore * 0.65)
      .sort((a, b) => a.score / a.maxScore - b.score / b.maxScore)
      .slice(0, 2);
    const feedback = weakCriteria.length
      ? weakCriteria.map((item) => `Strengthen ${item.label.toLocaleLowerCase()}: connect the decision to a requirement, failure mode, and alternative.`)
      : ["The response covers every rubric dimension. Tighten estimates and rehearse defending the most consequential tradeoff aloud."];

    const [saved] = await db
      .insert(systemDesignSubmissions)
      .values({
        playerId,
        challengeId: challenge.id,
        mode,
        architecture,
        assumptions,
        tradeoffs,
        score,
        criterionScores,
        feedback,
      })
      .returning();
    return submissionDto(saved!);
  }

  async listPortfolio(playerId: string, pathwayId: string): Promise<PortfolioCampaignSummary[]> {
    const [campaignRows, milestoneRows, progressRows, completedRows] = await Promise.all([
      db.select().from(portfolioCampaigns).where(eq(portfolioCampaigns.pathwayId, pathwayId)).orderBy(portfolioCampaigns.order),
      db.select().from(portfolioMilestones),
      db.select().from(playerPortfolioProgress).where(eq(playerPortfolioProgress.playerId, playerId)),
      db
        .select()
        .from(playerPortfolioMilestones)
        .where(
          and(
            eq(playerPortfolioMilestones.playerId, playerId),
            eq(playerPortfolioMilestones.completed, true),
          ),
        ),
    ]);

    return campaignRows.map((campaign) => {
      const milestones = milestoneRows.filter((row) => row.campaignId === campaign.id);
      const milestoneIds = new Set(milestones.map((row) => row.id));
      const progress = progressRows.find((row) => row.campaignId === campaign.id);
      return {
        id: campaign.id,
        slug: campaign.slug,
        title: campaign.title,
        tagline: campaign.tagline,
        summary: campaign.summary,
        stackOptions: campaign.stackOptions,
        status: (progress?.status ?? "not_started") as PortfolioStatus,
        milestonesCompleted: completedRows.filter((row) => milestoneIds.has(row.milestoneId)).length,
        milestonesTotal: milestones.length,
      };
    });
  }

  async getPortfolioCampaign(slug: string, playerId: string, pathwayId: string): Promise<PortfolioCampaignDetail> {
    const [campaign] = await db
      .select()
      .from(portfolioCampaigns)
      .where(and(eq(portfolioCampaigns.slug, slug), eq(portfolioCampaigns.pathwayId, pathwayId)))
      .limit(1);
    if (!campaign) throw new NotFoundException("Portfolio campaign not found");

    const [milestoneRows, completedRows, progressRows] = await Promise.all([
      db
        .select()
        .from(portfolioMilestones)
        .where(eq(portfolioMilestones.campaignId, campaign.id))
        .orderBy(portfolioMilestones.order),
      db
        .select()
        .from(playerPortfolioMilestones)
        .where(eq(playerPortfolioMilestones.playerId, playerId)),
      db
        .select()
        .from(playerPortfolioProgress)
        .where(
          and(
            eq(playerPortfolioProgress.playerId, playerId),
            eq(playerPortfolioProgress.campaignId, campaign.id),
          ),
        )
        .limit(1),
    ]);
    const progress = progressRows[0];
    const completedById = new Map(completedRows.map((row) => [row.milestoneId, row.completed]));
    const completed = milestoneRows.filter((row) => completedById.get(row.id)).length;

    return {
      id: campaign.id,
      slug: campaign.slug,
      title: campaign.title,
      tagline: campaign.tagline,
      summary: campaign.summary,
      stackOptions: campaign.stackOptions,
      outcomes: strings(campaign.outcomes),
      status: (progress?.status ?? "not_started") as PortfolioStatus,
      milestonesCompleted: completed,
      milestonesTotal: milestoneRows.length,
      milestones: milestoneRows.map((row) => ({
        id: row.id,
        title: row.title,
        description: row.description,
        deliverable: row.deliverable,
        order: row.order,
        completed: completedById.get(row.id) ?? false,
      })),
      evidence: {
        repoUrl: progress?.repoUrl ?? "",
        liveUrl: progress?.liveUrl ?? "",
        reflection: progress?.reflection ?? "",
      },
    };
  }

  async setPortfolioMilestone(milestoneId: string, completed: boolean, playerId: string) {
    const [milestone] = await db
      .select()
      .from(portfolioMilestones)
      .where(eq(portfolioMilestones.id, milestoneId))
      .limit(1);
    if (!milestone) throw new NotFoundException("Portfolio milestone not found");

    const now = new Date();
    await db
      .insert(playerPortfolioMilestones)
      .values({ playerId, milestoneId, completed, completedAt: completed ? now : null, updatedAt: now })
      .onConflictDoUpdate({
        target: [playerPortfolioMilestones.playerId, playerPortfolioMilestones.milestoneId],
        set: { completed, completedAt: completed ? now : null, updatedAt: now },
      });

    const campaignMilestones = await db
      .select({ id: portfolioMilestones.id })
      .from(portfolioMilestones)
      .where(eq(portfolioMilestones.campaignId, milestone.campaignId));
    const completedMilestones = await db
      .select({ milestoneId: playerPortfolioMilestones.milestoneId })
      .from(playerPortfolioMilestones)
      .where(
        and(
          eq(playerPortfolioMilestones.playerId, playerId),
          eq(playerPortfolioMilestones.completed, true),
        ),
      );
    const campaignIds = new Set(campaignMilestones.map((row) => row.id));
    const completedCount = completedMilestones.filter((row) => campaignIds.has(row.milestoneId)).length;
    const status: PortfolioStatus =
      completedCount === campaignMilestones.length ? "completed" : "in_progress";

    await db
      .insert(playerPortfolioProgress)
      .values({
        playerId,
        campaignId: milestone.campaignId,
        status,
        startedAt: now,
        completedAt: status === "completed" ? now : null,
        updatedAt: now,
      })
      .onConflictDoUpdate({
        target: [playerPortfolioProgress.playerId, playerPortfolioProgress.campaignId],
        set: { status, completedAt: status === "completed" ? now : null, updatedAt: now },
      });

    return { completed, status, milestonesCompleted: completedCount, milestonesTotal: campaignMilestones.length };
  }

  async savePortfolioEvidence(
    slug: string,
    playerId: string,
    pathwayId: string,
    body: { repoUrl?: string; liveUrl?: string; reflection?: string },
  ) {
    const [campaign] = await db
      .select()
      .from(portfolioCampaigns)
      .where(and(eq(portfolioCampaigns.slug, slug), eq(portfolioCampaigns.pathwayId, pathwayId)))
      .limit(1);
    if (!campaign) throw new NotFoundException("Portfolio campaign not found");
    const repoUrl = body.repoUrl?.trim() ?? "";
    const liveUrl = body.liveUrl?.trim() ?? "";
    const reflection = body.reflection?.trim() ?? "";
    validateHttpUrl(repoUrl, "Repository URL");
    validateHttpUrl(liveUrl, "Live URL");
    if (reflection.length > 5000) throw new BadRequestException("Reflection is limited to 5,000 characters");

    const now = new Date();
    await db
      .insert(playerPortfolioProgress)
      .values({
        playerId,
        campaignId: campaign.id,
        status: "in_progress",
        repoUrl,
        liveUrl,
        reflection,
        startedAt: now,
        updatedAt: now,
      })
      .onConflictDoUpdate({
        target: [playerPortfolioProgress.playerId, playerPortfolioProgress.campaignId],
        set: { repoUrl, liveUrl, reflection, updatedAt: now },
      });
    return { repoUrl, liveUrl, reflection };
  }

  async listLanguageTracks(playerId: string, pathwayId: string): Promise<LanguageTrackSummary[]> {
    const [trackRows, moduleRows, enrollmentRows, progressRows] = await Promise.all([
      db.select().from(languageTracks).where(eq(languageTracks.pathwayId, pathwayId)).orderBy(languageTracks.order),
      db.select().from(languageTrackModules),
      db.select().from(playerLanguageTracks).where(eq(playerLanguageTracks.playerId, playerId)),
      db
        .select()
        .from(playerLanguageModules)
        .where(
          and(eq(playerLanguageModules.playerId, playerId), eq(playerLanguageModules.completed, true)),
        ),
    ]);

    return trackRows.map((track) => {
      const modules = moduleRows.filter((row) => row.trackId === track.id);
      const moduleIds = new Set(modules.map((row) => row.id));
      const enrollment = enrollmentRows.find((row) => row.trackId === track.id);
      return {
        id: track.id,
        slug: track.slug,
        title: track.title,
        language: track.language,
        framework: track.framework,
        description: track.description,
        icon: track.icon,
        estimatedHours: track.estimatedHours,
        status: enrollment?.status === "completed" ? "completed" : enrollment ? "in_progress" : "not_started",
        modulesCompleted: progressRows.filter((row) => moduleIds.has(row.moduleId)).length,
        modulesTotal: modules.length,
      };
    });
  }

  async getLanguageTrack(slug: string, playerId: string, pathwayId: string): Promise<LanguageTrackDetail> {
    const [track] = await db.select().from(languageTracks).where(and(eq(languageTracks.slug, slug), eq(languageTracks.pathwayId, pathwayId))).limit(1);
    if (!track) throw new NotFoundException("Language track not found");
    const [modules, enrollments, progress] = await Promise.all([
      db
        .select()
        .from(languageTrackModules)
        .where(eq(languageTrackModules.trackId, track.id))
        .orderBy(languageTrackModules.order),
      db
        .select()
        .from(playerLanguageTracks)
        .where(
          and(eq(playerLanguageTracks.playerId, playerId), eq(playerLanguageTracks.trackId, track.id)),
        )
        .limit(1),
      db.select().from(playerLanguageModules).where(eq(playerLanguageModules.playerId, playerId)),
    ]);
    const byModule = new Map(progress.map((row) => [row.moduleId, row]));
    const completed = modules.filter((row) => byModule.get(row.id)?.completed).length;
    const enrollment = enrollments[0];

    return {
      id: track.id,
      slug: track.slug,
      title: track.title,
      language: track.language,
      framework: track.framework,
      description: track.description,
      icon: track.icon,
      estimatedHours: track.estimatedHours,
      capstone: track.capstone,
      status: enrollment?.status === "completed" ? "completed" : enrollment ? "in_progress" : "not_started",
      modulesCompleted: completed,
      modulesTotal: modules.length,
      modules: modules.map((row) => ({
        id: row.id,
        title: row.title,
        description: row.description,
        focus: strings(row.focus),
        projectStep: row.projectStep,
        order: row.order,
        completed: byModule.get(row.id)?.completed ?? false,
        reflection: byModule.get(row.id)?.reflection ?? "",
      })),
    };
  }

  async enrollLanguageTrack(slug: string, playerId: string, pathwayId: string) {
    const [track] = await db.select().from(languageTracks).where(and(eq(languageTracks.slug, slug), eq(languageTracks.pathwayId, pathwayId))).limit(1);
    if (!track) throw new NotFoundException("Language track not found");
    await db
      .insert(playerLanguageTracks)
      .values({ playerId, trackId: track.id })
      .onConflictDoNothing();
    return { status: "in_progress" as const };
  }

  async setLanguageModule(
    moduleId: string,
    playerId: string,
    completed: boolean,
    reflection: string,
  ) {
    const [module] = await db
      .select()
      .from(languageTrackModules)
      .where(eq(languageTrackModules.id, moduleId))
      .limit(1);
    if (!module) throw new NotFoundException("Language module not found");
    const cleanReflection = reflection.trim();
    if (cleanReflection.length > 2000) throw new BadRequestException("Reflection is limited to 2,000 characters");
    const now = new Date();

    await db
      .insert(playerLanguageTracks)
      .values({ playerId, trackId: module.trackId, status: "in_progress", startedAt: now, updatedAt: now })
      .onConflictDoNothing();
    await db
      .insert(playerLanguageModules)
      .values({
        playerId,
        moduleId,
        completed,
        reflection: cleanReflection,
        completedAt: completed ? now : null,
        updatedAt: now,
      })
      .onConflictDoUpdate({
        target: [playerLanguageModules.playerId, playerLanguageModules.moduleId],
        set: {
          completed,
          reflection: cleanReflection,
          completedAt: completed ? now : null,
          updatedAt: now,
        },
      });

    const trackModules = await db
      .select({ id: languageTrackModules.id })
      .from(languageTrackModules)
      .where(eq(languageTrackModules.trackId, module.trackId));
    const completedModules = await db
      .select({ moduleId: playerLanguageModules.moduleId })
      .from(playerLanguageModules)
      .where(
        and(eq(playerLanguageModules.playerId, playerId), eq(playerLanguageModules.completed, true)),
      );
    const ids = new Set(trackModules.map((row) => row.id));
    const completedCount = completedModules.filter((row) => ids.has(row.moduleId)).length;
    const status = completedCount === trackModules.length ? "completed" : "in_progress";
    await db
      .update(playerLanguageTracks)
      .set({ status, completedAt: status === "completed" ? now : null, updatedAt: now })
      .where(
        and(eq(playerLanguageTracks.playerId, playerId), eq(playerLanguageTracks.trackId, module.trackId)),
      );

    return { completed, reflection: cleanReflection, status, modulesCompleted: completedCount, modulesTotal: trackModules.length };
  }
}
