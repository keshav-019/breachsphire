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

export interface World {
  id: string;
  index: number;
  slug: string;
  title: string;
  description: string;
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

export type CharacterId = "ava" | "zayn" | "luna" | "byte" | "cipher" | "sentinel_x";

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

export interface Challenge {
  id: string;
  type: ChallengeType;
  prompt: string;
  content: Record<string, unknown>;
  hints: string[];
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
