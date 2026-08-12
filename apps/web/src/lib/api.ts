import type { LucideIcon } from "lucide-react";
import type {
  ArenaSubmission,
  ArenaSubmissionInput,
  AiIncidentAttempt,
  AiIncidentDetail,
  AiIncidentSummary,
  AiInterviewAttempt,
  AiInterviewQuestion,
  AiPracticeOverview,
  BackendExpansionOverview,
  LanguageTrackDetail,
  LanguageTrackSummary,
  PortfolioCampaignDetail,
  PortfolioCampaignSummary,
  PortfolioEvidence,
  SystemDesignChallengeDetail,
  SystemDesignChallengeSummary,
} from "@cyber-guardians/types";
import { supabase } from "./supabase";
import { ICON_MAP } from "./icon-map";

const apiBase = (
  import.meta.env.VITE_API_BASE_URL ||
  (window.location.protocol === "file:" ? "https://breachsphire-api.onrender.com" : "/api")
).replace(/\/$/, "");

function apiUrl(path: string) {
  return `${apiBase}${path.startsWith("/") ? path : `/${path}`}`;
}

export interface HealthStatus {
  status: "online" | "degraded" | "offline";
  service: string;
  version: string;
  timestamp: string;
}

export async function fetchHealth(): Promise<HealthStatus> {
  const res = await fetch(apiUrl("/health"));
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

async function responseError(res: Response): Promise<Error> {
  try {
    const body = (await res.json()) as { message?: string | string[] };
    const message = Array.isArray(body.message) ? body.message.join(" ") : body.message;
    return new Error(message || `API responded with ${res.status}`);
  } catch {
    return new Error(`API responded with ${res.status}`);
  }
}

export interface Pathway {
  id: string;
  slug: string;
  title: string;
  tagline: string;
  description: string;
  icon: LucideIcon;
  actsTotal: number;
  actsCleared: number;
  started: boolean;
}

interface PathwayDto {
  id: string;
  slug: string;
  title: string;
  tagline: string;
  description: string;
  icon: string;
  actsTotal: number;
  actsCleared: number;
  started: boolean;
}

export async function fetchPathways(): Promise<Pathway[]> {
  const res = await fetch(apiUrl("/pathways"), { headers: await authHeaders() });
  if (!res.ok) {
    throw await responseError(res);
  }
  const rows: PathwayDto[] = await res.json();
  return rows.map((row) => ({
    ...row,
    icon: ICON_MAP[row.icon] ?? ICON_MAP.GraduationCap,
  }));
}

export async function fetchWorlds(pathwayId: string): Promise<World[]> {
  const res = await fetch(apiUrl(`/worlds?pathwayId=${encodeURIComponent(pathwayId)}`), {
    headers: await authHeaders(),
  });
  if (!res.ok) {
    throw await responseError(res);
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
  const res = await fetch(apiUrl(path), { headers: await authHeaders() });
  if (!res.ok) {
    throw await responseError(res);
  }
  return res.json();
}

async function postJson<T>(path: string, body?: unknown): Promise<T> {
  const res = await fetch(apiUrl(path), {
    method: "POST",
    headers: { ...(await authHeaders()), "Content-Type": "application/json" },
    body: JSON.stringify(body ?? {}),
  });
  if (!res.ok) {
    throw await responseError(res);
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

function pathwayQuery(pathwayId: string) {
  return `?pathwayId=${encodeURIComponent(pathwayId)}`;
}

export function fetchBackendOverview(pathwayId: string): Promise<BackendExpansionOverview> {
  return getJson(`/backend/overview${pathwayQuery(pathwayId)}`);
}

export function fetchArenaChallenges(pathwayId: string): Promise<SystemDesignChallengeSummary[]> {
  return getJson(`/backend/arena${pathwayQuery(pathwayId)}`);
}

export function fetchArenaChallenge(slug: string, pathwayId: string): Promise<SystemDesignChallengeDetail> {
  return getJson(`/backend/arena/${encodeURIComponent(slug)}${pathwayQuery(pathwayId)}`);
}

export function submitArenaDesign(slug: string, pathwayId: string, input: ArenaSubmissionInput): Promise<ArenaSubmission> {
  return postJson(`/backend/arena/${encodeURIComponent(slug)}/submissions${pathwayQuery(pathwayId)}`, input);
}

export function fetchPortfolioCampaigns(pathwayId: string): Promise<PortfolioCampaignSummary[]> {
  return getJson(`/backend/portfolio${pathwayQuery(pathwayId)}`);
}

export function fetchPortfolioCampaign(slug: string, pathwayId: string): Promise<PortfolioCampaignDetail> {
  return getJson(`/backend/portfolio/${encodeURIComponent(slug)}${pathwayQuery(pathwayId)}`);
}

export function setPortfolioMilestone(milestoneId: string, completed: boolean) {
  return postJson(`/backend/portfolio/milestones/${encodeURIComponent(milestoneId)}`, { completed });
}

export function savePortfolioEvidence(slug: string, pathwayId: string, evidence: PortfolioEvidence): Promise<PortfolioEvidence> {
  return postJson(`/backend/portfolio/${encodeURIComponent(slug)}/evidence${pathwayQuery(pathwayId)}`, evidence);
}

export function fetchLanguageTracks(pathwayId: string): Promise<LanguageTrackSummary[]> {
  return getJson(`/backend/tracks${pathwayQuery(pathwayId)}`);
}

export function fetchLanguageTrack(slug: string, pathwayId: string): Promise<LanguageTrackDetail> {
  return getJson(`/backend/tracks/${encodeURIComponent(slug)}${pathwayQuery(pathwayId)}`);
}

export function enrollLanguageTrack(slug: string, pathwayId: string): Promise<{ status: "in_progress" }> {
  return postJson(`/backend/tracks/${encodeURIComponent(slug)}/enroll${pathwayQuery(pathwayId)}`);
}

export function setLanguageModule(moduleId: string, completed: boolean, reflection: string) {
  return postJson(`/backend/tracks/modules/${encodeURIComponent(moduleId)}`, { completed, reflection });
}

export function fetchAiPracticeOverview(): Promise<AiPracticeOverview> {
  return getJson("/ai/overview");
}

export function fetchAiIncidents(): Promise<AiIncidentSummary[]> {
  return getJson("/ai/incidents");
}

export function fetchAiIncident(slug: string): Promise<AiIncidentDetail> {
  return getJson(`/ai/incidents/${encodeURIComponent(slug)}`);
}

export function submitAiIncident(slug: string, diagnosis: string, mitigation: string): Promise<AiIncidentAttempt> {
  return postJson(`/ai/incidents/${encodeURIComponent(slug)}/attempts`, { diagnosis, mitigation });
}

export function fetchAiInterviews(): Promise<AiInterviewQuestion[]> {
  return getJson("/ai/interviews");
}

export function submitAiInterview(questionId: string, answer: string): Promise<AiInterviewAttempt> {
  return postJson(`/ai/interviews/${encodeURIComponent(questionId)}/attempts`, { answer });
}
