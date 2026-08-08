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

export const acts = pgTable("acts", {
  id: text("id").primaryKey(),
  index: integer("index").notNull(),
  slug: text("slug").notNull(),
  title: text("title").notNull(),
  purpose: text("purpose").notNull(),
  playerTransformation: text("player_transformation").notNull(),
});

export const worlds = pgTable("worlds", {
  id: text("id").primaryKey(),
  actId: text("act_id").notNull(),
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
