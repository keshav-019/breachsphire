import {
  pgTable,
  text,
  integer,
  real,
  uuid,
  timestamp,
  primaryKey,
  boolean,
  jsonb,
} from "drizzle-orm/pg-core";

/**
 * Mirrors infra/supabase/migrations/*.sql by hand — Drizzle is a typed
 * query layer here, not the migration source of truth.
 */

export const profiles = pgTable("profiles", {
  id: uuid("id").primaryKey(),
  displayName: text("display_name").notNull(),
  rank: text("rank").notNull().default("recruit"),
  xp: integer("xp").notNull().default(0),
  credits: integer("credits").notNull().default(0),
  createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
});

export const pathways = pgTable("pathways", {
  id: text("id").primaryKey(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  tagline: text("tagline").notNull(),
  description: text("description").notNull(),
  icon: text("icon").notNull(),
  sortOrder: integer("sort_order").notNull(),
});

export const acts = pgTable("acts", {
  id: text("id").primaryKey(),
  pathwayId: text("pathway_id").notNull(),
  index: integer("index").notNull(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  purpose: text("purpose").notNull(),
  playerTransformation: text("player_transformation").notNull(),
});

export const worlds = pgTable("worlds", {
  id: text("id").primaryKey(),
  actId: text("act_id").notNull(),
  pathwayId: text("pathway_id").notNull(),
  index: integer("index").notNull(),
  slug: text("slug").notNull(),
  name: text("name").notNull(),
  short: text("short").notNull(),
  description: text("description").notNull(),
  entryIncident: text("entry_incident").notNull(),
  capstoneTitle: text("capstone_title").notNull(),
  storyReveal: text("story_reveal").notNull(),
  transitionHook: text("transition_hook").notNull(),
  boss: text("boss"),
  icon: text("icon").notNull(),
  threat: text("threat").notNull(),
  x: real("x").notNull(),
  y: real("y").notNull(),
});

export const playerWorldProgress = pgTable(
  "player_world_progress",
  {
    playerId: uuid("player_id").notNull(),
    worldId: text("world_id").notNull(),
    state: text("state").notNull().default("locked"),
    completion: integer("completion").notNull().default(0),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.worldId] })],
);

export const campaigns = pgTable("campaigns", {
  id: text("id").primaryKey(),
  worldId: text("world_id").notNull(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  description: text("description").notNull(),
  order: integer("sort_order").notNull(),
});

export const operations = pgTable("operations", {
  id: text("id").primaryKey(),
  campaignId: text("campaign_id").notNull(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  description: text("description").notNull(),
  order: integer("sort_order").notNull(),
});

export const missions = pgTable("missions", {
  id: text("id").primaryKey(),
  worldId: text("world_id").notNull(),
  campaignId: text("campaign_id").notNull(),
  operationId: text("operation_id").notNull(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  description: text("description").notNull(),
  difficulty: text("difficulty").notNull(),
  characterIds: text("character_ids").array().notNull().default([]),
  prerequisites: jsonb("prerequisites"),
  requiredSkills: jsonb("required_skills"),
  lab: jsonb("lab").notNull(),
  rewards: jsonb("rewards").notNull(),
  isBoss: boolean("is_boss").notNull().default(false),
  order: integer("sort_order").notNull(),
});

export const dialogueLines = pgTable("dialogue_lines", {
  id: uuid("id").primaryKey().defaultRandom(),
  missionId: text("mission_id").notNull(),
  order: integer("sort_order").notNull(),
  characterId: text("character_id").notNull(),
  text: text("text").notNull(),
});

export const objectives = pgTable("objectives", {
  id: text("id").primaryKey(),
  missionId: text("mission_id").notNull(),
  order: integer("sort_order").notNull(),
  title: text("title").notNull(),
  description: text("description").notNull(),
});

export const challenges = pgTable("challenges", {
  id: text("id").primaryKey(),
  objectiveId: text("objective_id").notNull(),
  order: integer("sort_order").notNull(),
  type: text("type").notNull(),
  prompt: text("prompt").notNull(),
  content: jsonb("content").notNull(),
  completionConditions: jsonb("completion_conditions").notNull(),
});

export const hints = pgTable("hints", {
  id: uuid("id").primaryKey().defaultRandom(),
  challengeId: text("challenge_id").notNull(),
  tier: text("tier").notNull(),
  text: text("text").notNull(),
  xpCost: integer("xp_cost").notNull().default(0),
  order: integer("sort_order").notNull(),
});

export const playerMissionProgress = pgTable(
  "player_mission_progress",
  {
    playerId: uuid("player_id").notNull(),
    missionId: text("mission_id").notNull(),
    status: text("status").notNull().default("locked"),
    startedAt: timestamp("started_at", { withTimezone: true }),
    completedAt: timestamp("completed_at", { withTimezone: true }),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.missionId] })],
);

export const playerObjectiveProgress = pgTable(
  "player_objective_progress",
  {
    playerId: uuid("player_id").notNull(),
    objectiveId: text("objective_id").notNull(),
    status: text("status").notNull().default("locked"),
    completedAt: timestamp("completed_at", { withTimezone: true }),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.objectiveId] })],
);

export const playerChallengeAttempts = pgTable("player_challenge_attempts", {
  id: uuid("id").primaryKey().defaultRandom(),
  playerId: uuid("player_id").notNull(),
  challengeId: text("challenge_id").notNull(),
  isCorrect: boolean("is_correct").notNull(),
  hintsRevealed: text("hints_revealed").array().notNull().default([]),
  submittedAt: timestamp("submitted_at", { withTimezone: true }).notNull().defaultNow(),
});

export const playerHintReveals = pgTable(
  "player_hint_reveals",
  {
    playerId: uuid("player_id").notNull(),
    challengeId: text("challenge_id").notNull(),
    tier: text("tier").notNull(),
    xpCost: integer("xp_cost").notNull(),
    revealedAt: timestamp("revealed_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.challengeId, t.tier] })],
);

// Backend Engineering post-game systems. These intentionally do not reuse
// the mission-engine hierarchy: each domain has its own interaction and
// progress model.
export const systemDesignChallenges = pgTable("system_design_challenges", {
  id: text("id").primaryKey(),
  pathwayId: text("pathway_id").notNull(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  domain: text("domain").notNull(),
  summary: text("summary").notNull(),
  prompt: text("prompt").notNull(),
  context: text("context").notNull(),
  functionalRequirements: jsonb("functional_requirements").notNull(),
  nonfunctionalRequirements: jsonb("nonfunctional_requirements").notNull(),
  modes: jsonb("modes").notNull(),
  rubric: jsonb("rubric").notNull(),
  estimatedMinutes: integer("estimated_minutes").notNull(),
  order: integer("sort_order").notNull(),
});

export const systemDesignSubmissions = pgTable("system_design_submissions", {
  id: uuid("id").primaryKey().defaultRandom(),
  playerId: uuid("player_id").notNull(),
  challengeId: text("challenge_id").notNull(),
  mode: text("mode").notNull(),
  architecture: text("architecture").notNull(),
  assumptions: text("assumptions").notNull(),
  tradeoffs: text("tradeoffs").notNull(),
  score: integer("score").notNull(),
  criterionScores: jsonb("criterion_scores").notNull(),
  feedback: jsonb("feedback").notNull(),
  createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
});

export const portfolioCampaigns = pgTable("portfolio_campaigns", {
  id: text("id").primaryKey(),
  pathwayId: text("pathway_id").notNull(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  tagline: text("tagline").notNull(),
  summary: text("summary").notNull(),
  stackOptions: text("stack_options").array().notNull().default([]),
  outcomes: jsonb("outcomes").notNull(),
  order: integer("sort_order").notNull(),
});

export const portfolioMilestones = pgTable("portfolio_milestones", {
  id: text("id").primaryKey(),
  campaignId: text("campaign_id").notNull(),
  title: text("title").notNull(),
  description: text("description").notNull(),
  deliverable: text("deliverable").notNull(),
  order: integer("sort_order").notNull(),
});

export const playerPortfolioProgress = pgTable(
  "player_portfolio_progress",
  {
    playerId: uuid("player_id").notNull(),
    campaignId: text("campaign_id").notNull(),
    status: text("status").notNull().default("not_started"),
    repoUrl: text("repo_url").notNull().default(""),
    liveUrl: text("live_url").notNull().default(""),
    reflection: text("reflection").notNull().default(""),
    startedAt: timestamp("started_at", { withTimezone: true }),
    completedAt: timestamp("completed_at", { withTimezone: true }),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.campaignId] })],
);

export const playerPortfolioMilestones = pgTable(
  "player_portfolio_milestones",
  {
    playerId: uuid("player_id").notNull(),
    milestoneId: text("milestone_id").notNull(),
    completed: boolean("completed").notNull().default(false),
    completedAt: timestamp("completed_at", { withTimezone: true }),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.milestoneId] })],
);

export const languageTracks = pgTable("language_tracks", {
  id: text("id").primaryKey(),
  pathwayId: text("pathway_id").notNull(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  language: text("language").notNull(),
  framework: text("framework").notNull(),
  description: text("description").notNull(),
  icon: text("icon").notNull(),
  estimatedHours: integer("estimated_hours").notNull(),
  capstone: text("capstone").notNull(),
  order: integer("sort_order").notNull(),
});

export const languageTrackModules = pgTable("language_track_modules", {
  id: text("id").primaryKey(),
  trackId: text("track_id").notNull(),
  title: text("title").notNull(),
  description: text("description").notNull(),
  focus: jsonb("focus").notNull(),
  projectStep: text("project_step").notNull(),
  order: integer("sort_order").notNull(),
});

export const playerLanguageTracks = pgTable(
  "player_language_tracks",
  {
    playerId: uuid("player_id").notNull(),
    trackId: text("track_id").notNull(),
    status: text("status").notNull().default("in_progress"),
    startedAt: timestamp("started_at", { withTimezone: true }).notNull().defaultNow(),
    completedAt: timestamp("completed_at", { withTimezone: true }),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.trackId] })],
);

export const playerLanguageModules = pgTable(
  "player_language_modules",
  {
    playerId: uuid("player_id").notNull(),
    moduleId: text("module_id").notNull(),
    completed: boolean("completed").notNull().default(false),
    reflection: text("reflection").notNull().default(""),
    completedAt: timestamp("completed_at", { withTimezone: true }),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.moduleId] })],
);

export const aiOnCallIncidents = pgTable("ai_on_call_incidents", {
  id: text("id").primaryKey(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  symptom: text("symptom").notNull(),
  evidence: jsonb("evidence").notNull(),
  expectedSignals: jsonb("expected_signals").notNull(),
  resolution: text("resolution").notNull(),
  difficulty: text("difficulty").notNull(),
  order: integer("sort_order").notNull(),
});

export const playerAiIncidentAttempts = pgTable("player_ai_incident_attempts", {
  id: uuid("id").primaryKey().defaultRandom(),
  playerId: uuid("player_id").notNull(),
  incidentId: text("incident_id").notNull(),
  diagnosis: text("diagnosis").notNull(),
  mitigation: text("mitigation").notNull(),
  score: integer("score").notNull(),
  feedback: jsonb("feedback").notNull(),
  createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
});

export const aiInterviewQuestions = pgTable("ai_interview_questions", {
  id: text("id").primaryKey(),
  question: text("question").notNull(),
  focus: text("focus").notNull(),
  expectedSignals: jsonb("expected_signals").notNull(),
  order: integer("sort_order").notNull(),
});

export const playerAiInterviewAttempts = pgTable("player_ai_interview_attempts", {
  id: uuid("id").primaryKey().defaultRandom(),
  playerId: uuid("player_id").notNull(),
  questionId: text("question_id").notNull(),
  answer: text("answer").notNull(),
  score: integer("score").notNull(),
  matchedSignals: jsonb("matched_signals").notNull(),
  feedback: jsonb("feedback").notNull(),
  createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
});
