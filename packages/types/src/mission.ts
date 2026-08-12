import type { SkillTrack } from "./rank";

/**
 * Content-engine schema (section 18): World -> Campaign -> Operation -> Mission -> Objective -> Challenge.
 * Missions are pure data. New content ships as JSON/DB rows, never as new React components.
 */

export type Difficulty =
  | "intro"
  | "beginner"
  | "intermediate"
  | "advanced"
  | "expert"
  | "boss";

export type LabType = "simulation" | "shared_lab" | "isolated_lab" | "none";

/**
 * A top-level campaign track (Cyber Guardians, The Fracture, ...). Each
 * pathway owns its own Acts/Worlds, scoped by `pathwayId`.
 */
export interface Pathway {
  id: string;
  slug: string;
  title: string;
  tagline: string;
  description: string;
  icon: string;
}

/**
 * The Acts (0-indexed within their pathway) from that pathway's story
 * bible. Each Act groups several Worlds.
 */
export interface Act {
  id: string;
  pathwayId: string;
  index: number;
  slug: string;
  title: string;
  purpose: string;
  playerTransformation: string;
}

export interface World {
  id: string;
  actId: string;
  pathwayId: string;
  index: number;
  slug: string;
  title: string;
  description: string;
  /** In-fiction hook that opens the World — see bible §3, "entry incident". */
  entryIncident: string;
  /** Name of the World's closing mission, boss or otherwise. */
  capstoneTitle: string;
  /** What the capstone reveals about the larger Sentinel-X mystery. */
  storyReveal: string;
  /** The narrative hook that justifies moving into the next World. */
  transitionHook: string;
  bossId?: string;
  unlockRequirement?: PrerequisiteRule;
}

export interface Campaign {
  id: string;
  worldId: string;
  slug: string;
  title: string;
  description: string;
  order: number;
}

export interface Operation {
  id: string;
  campaignId: string;
  slug: string;
  title: string;
  description: string;
  order: number;
}

export interface PrerequisiteRule {
  requiredMissionIds?: string[];
  requiredRank?: string;
  requiredSkill?: { track: SkillTrack; minLevel: number };
}

export type CharacterId =
  | "ava"
  | "zayn"
  | "luna"
  | "byte"
  | "cipher"
  | "sentinel_x"
  | "mira"
  | "forge"
  | "fracture"
  | "maya"
  | "arjun"
  | "elena"
  | "noah"
  | "echo";

export interface DialogueLine {
  characterId: CharacterId | "system";
  text: string;
}

export type ChallengeType =
  | "story_dialogue"
  | "investigation"
  | "multiple_choice"
  | "interactive_diagram"
  | "drag_and_drop"
  | "packet_routing"
  | "phishing_identification"
  | "log_analysis"
  | "terminal_simulation"
  | "browser_simulation"
  | "code_debugging"
  | "sandbox_lab"
  | "boss_encounter"
  | "timed_incident"
  | "ctf";

/**
 * The 5-tier hint ladder every World uses (bible §2.3): each tier gives
 * away more than the last, ending in a full explained solution so a
 * learner can never become permanently blocked.
 */
export type HintTier =
  | "orientation"
  | "concept"
  | "tool_direction"
  | "near_solution"
  | "solution";

export interface Hint {
  tier: HintTier;
  text: string;
  xpCost: number;
}

export interface Challenge {
  id: string;
  type: ChallengeType;
  prompt: string;
  content: Record<string, unknown>;
  hints: Hint[];
  completionConditions: Record<string, unknown>;
}

export interface Objective {
  id: string;
  order: number;
  title: string;
  description: string;
  challenges: Challenge[];
}

export interface MissionRewards {
  xp: number;
  credits: number;
  badgeIds?: string[];
  skillXp?: Partial<Record<SkillTrack, number>>;
  itemIds?: string[];
}

export interface LabConfig {
  type: LabType;
  simulationId?: string;
  sharedLabId?: string;
  dockerImage?: string;
  cpuLimit?: string;
  memoryLimit?: string;
  networkPolicy?: "isolated" | "target-only";
  ttlMinutes?: number;
}

export interface Mission {
  id: string;
  worldId: string;
  campaignId: string;
  operationId: string;
  slug: string;
  title: string;
  description: string;
  difficulty: Difficulty;
  storyDialogue: DialogueLine[];
  characterIds: CharacterId[];
  objectives: Objective[];
  prerequisites?: PrerequisiteRule;
  requiredSkills?: Partial<Record<SkillTrack, number>>;
  lab: LabConfig;
  rewards: MissionRewards;
  isBoss?: boolean;
}
