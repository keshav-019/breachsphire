import type { PlayerRank, PlayerSkill } from "./rank";

export interface PlayerProfile {
  id: string;
  userId: string;
  displayName: string;
  avatarUrl?: string;
  rank: PlayerRank;
  xp: number;
  credits: number;
  loginStreak: number;
  createdAt: string;
}

export type MissionProgressStatus =
  | "locked"
  | "available"
  | "in_progress"
  | "completed";

export interface MissionProgress {
  missionId: string;
  playerId: string;
  status: MissionProgressStatus;
  objectivesCompleted: string[];
  startedAt?: string;
  completedAt?: string;
}

export interface PlayerState {
  profile: PlayerProfile;
  skills: PlayerSkill[];
  missionProgress: MissionProgress[];
  achievementIds: string[];
}
