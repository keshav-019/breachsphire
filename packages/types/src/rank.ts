export const PLAYER_RANKS = [
  "recruit",
  "trainee",
  "cyber_cadet",
  "cyber_defender",
  "security_analyst",
  "incident_responder",
  "pentester",
  "threat_hunter",
  "red_team_specialist",
  "blue_team_commander",
  "cyber_guardian",
  "elite_guardian",
] as const;

export type PlayerRank = (typeof PLAYER_RANKS)[number];

export const SKILL_TRACKS = [
  "networking",
  "linux",
  "windows",
  "web_security",
  "programming",
  "pentesting",
  "soc",
  "incident_response",
  "forensics",
  "malware_analysis",
  "cloud_security",
  "cryptography",
  "threat_hunting",
  "ai_security",
] as const;

export type SkillTrack = (typeof SKILL_TRACKS)[number];

export interface PlayerSkill {
  track: SkillTrack;
  level: number;
  xp: number;
  xpToNextLevel: number;
}
