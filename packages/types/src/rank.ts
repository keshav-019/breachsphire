/**
 * The clearance progression from the World Story & Campaign Bible
 * (docs/12-world-story-bible.md §2.1). Clearance is a story wrapper around
 * prerequisite mastery: a player can revisit any unlocked World, but new
 * operational privileges (real Docker labs, advanced AD ranges, exploit
 * research, command simulations) unlock only after the required skills and
 * safety briefings are complete.
 */
export const PLAYER_RANKS = [
  "civilian",
  "recruit",
  "cadet",
  "analyst",
  "operator",
  "pentester",
  "hunter",
  "specialist",
  "commander",
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
