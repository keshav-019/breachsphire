import type { LucideIcon } from "lucide-react";
import { supabase } from "./supabase";
import { ICON_MAP } from "./icon-map";

export interface HealthStatus {
  status: "online" | "degraded" | "offline";
  service: string;
  version: string;
  timestamp: string;
}

export async function fetchHealth(): Promise<HealthStatus> {
  const res = await fetch("/api/health");
  if (!res.ok) {
    throw new Error(`API responded with ${res.status}`);
  }
  return res.json();
}

export type WorldState = "cleared" | "active" | "unlocked" | "locked";
export type ThreatLevel = "low" | "guarded" | "elevated" | "severe" | "critical";

export type World = {
  id: string;
  name: string;
  short: string;
  icon: LucideIcon;
  state: WorldState;
  completion: number;
  boss?: string | null;
  threat: ThreatLevel;
  x: number;
  y: number;
};

interface WorldDto {
  id: string;
  index: number;
  name: string;
  short: string;
  icon: string;
  boss: string | null;
  threat: ThreatLevel;
  x: number;
  y: number;
  state: WorldState;
  completion: number;
}

async function authHeaders(): Promise<HeadersInit> {
  const { data } = await supabase.auth.getSession();
  const token = data.session?.access_token;
  return token ? { Authorization: `Bearer ${token}` } : {};
}

export async function fetchWorlds(): Promise<World[]> {
  const res = await fetch("/api/worlds", { headers: await authHeaders() });
  if (!res.ok) {
    throw new Error(`API responded with ${res.status}`);
  }
  const rows: WorldDto[] = await res.json();
  return rows
    .sort((a, b) => a.index - b.index)
    .map((row) => ({
      id: row.id,
      name: row.name,
      short: row.short,
      icon: ICON_MAP[row.icon] ?? ICON_MAP.GraduationCap,
      state: row.state,
      completion: row.completion,
      boss: row.boss,
      threat: row.threat,
      x: row.x,
      y: row.y,
    }));
}

async function getJson<T>(path: string): Promise<T> {
  const res = await fetch(`/api${path}`, { headers: await authHeaders() });
  if (!res.ok) {
    throw new Error(`API responded with ${res.status}`);
  }
  return res.json();
}

async function postJson<T>(path: string, body?: unknown): Promise<T> {
  const res = await fetch(`/api${path}`, {
    method: "POST",
    headers: { ...(await authHeaders()), "Content-Type": "application/json" },
    body: JSON.stringify(body ?? {}),
  });
  if (!res.ok) {
    throw new Error(`API responded with ${res.status}`);
  }
  return res.json();
}

export interface PlayerMe {
  id: string;
  email?: string;
  displayName: string;
  rank: string;
  xp: number;
  credits: number;
}

export function fetchMe(): Promise<PlayerMe> {
  return getJson("/players/me");
}

export type MissionStatus = "locked" | "available" | "in_progress" | "completed";

export interface MissionRewards {
  xp: number;
  credits: number;
  badgeIds?: string[];
  skillXp?: Record<string, number>;
  itemIds?: string[];
}

export interface MissionSummary {
  id: string;
  slug: string;
  title: string;
  description: string;
  difficulty: string;
  isBoss: boolean;
  rewards: MissionRewards;
  order: number;
  status: MissionStatus;
}

export interface OperationWithMissions {
  id: string;
  slug: string;
  title: string;
  description: string;
  order: number;
  missions: MissionSummary[];
}

export interface CampaignWithOperations {
  id: string;
  slug: string;
  title: string;
  description: string;
  order: number;
  operations: OperationWithMissions[];
}

export function fetchWorldMissions(worldId: string): Promise<CampaignWithOperations[]> {
  return getJson(`/worlds/${worldId}/missions`);
}

export interface MissionHint {
  tier: string;
  xpCost: number;
  revealed: boolean;
  text: string | null;
}

export interface MissionChallenge {
  id: string;
  type: string;
  prompt: string;
  content: Record<string, unknown>;
  hints: MissionHint[];
}

export interface MissionObjective {
  id: string;
  title: string;
  description: string;
  completed: boolean;
  challenges: MissionChallenge[];
}

export interface DialogueLine {
  characterId: string;
  text: string;
}

export interface MissionDetail {
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
  rewards: MissionRewards;
  status: MissionStatus;
  storyDialogue: DialogueLine[];
  objectives: MissionObjective[];
}

export function fetchMissionDetail(missionId: string): Promise<MissionDetail> {
  return getJson(`/missions/${missionId}`);
}

export function startMission(missionId: string): Promise<{ status: MissionStatus }> {
  return postJson(`/missions/${missionId}/start`);
}

export interface RevealedHint {
  tier: string;
  text: string;
  xpCost: number;
}

export function revealHint(challengeId: string, tier: string): Promise<RevealedHint> {
  return postJson(`/challenges/${challengeId}/hints/${tier}`);
}

export interface AttemptResult {
  correct: boolean;
  objectiveCompleted: boolean;
  missionCompleted: boolean;
  rewardsApplied?: { xp: number; credits: number };
  worldCleared?: boolean;
}

export function submitAttempt(challengeId: string, answer: Record<string, unknown>): Promise<AttemptResult> {
  return postJson(`/challenges/${challengeId}/attempts`, { answer });
}
