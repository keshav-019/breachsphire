import type { LucideIcon } from "lucide-react";
import {
  Activity,
  Bug,
  Cloud,
  Crosshair,
  Fingerprint,
  KeyRound,
  Network,
  Search,
  ShieldAlert,
  Skull,
  Terminal,
  Brain,
} from "lucide-react";

export type SkillTrack = { name: string; level: number; max: number; pct: number };

export const SKILL_TRACKS: SkillTrack[] = [
  { name: "Network Recon", level: 4, max: 5, pct: 78 },
  { name: "Malware Analysis", level: 3, max: 5, pct: 52 },
  { name: "Digital Forensics", level: 3, max: 5, pct: 44 },
  { name: "Cryptography", level: 2, max: 5, pct: 30 },
  { name: "Blue Team Defense", level: 4, max: 5, pct: 84 },
  { name: "Hardware & OT", level: 1, max: 5, pct: 16 },
  { name: "Web Exploitation", level: 3, max: 5, pct: 58 },
  { name: "Linux Ops", level: 4, max: 5, pct: 81 },
  { name: "Windows Ops", level: 3, max: 5, pct: 49 },
  { name: "Scripting", level: 3, max: 5, pct: 62 },
  { name: "OSINT", level: 2, max: 5, pct: 37 },
  { name: "Cloud Security", level: 1, max: 5, pct: 12 },
  { name: "Threat Intel", level: 2, max: 5, pct: 41 },
  { name: "Social Engineering", level: 2, max: 5, pct: 26 },
];

export type Rarity = "common" | "rare" | "epic" | "legendary";

export type Achievement = {
  id: string;
  name: string;
  description: string;
  icon: LucideIcon;
  rarity: Rarity;
  unlocked: boolean;
  progress?: number;
  holders: string;
};

export const ACHIEVEMENTS: Achievement[] = [
  { id: "first-blood", name: "First Blood", description: "Clear your first operation", icon: Crosshair, rarity: "common", unlocked: true, holders: "94%" },
  { id: "night-owl", name: "Night Owl", description: "Complete 10 missions after 02:00", icon: Activity, rarity: "rare", unlocked: true, holders: "22%" },
  { id: "packet-whisperer", name: "Packet Whisperer", description: "Identify 50 malicious flows", icon: Network, rarity: "rare", unlocked: true, holders: "18%" },
  { id: "citadel", name: "Citadel Breaker", description: "Clear Linux Citadel with no hints", icon: Terminal, rarity: "epic", unlocked: true, holders: "6%" },
  { id: "streak-30", name: "Unbroken", description: "Hold a 30 day duty streak", icon: Fingerprint, rarity: "epic", unlocked: false, progress: 57, holders: "9%" },
  { id: "zero-day", name: "Zero Day", description: "Solve an apex target in under 10 min", icon: Bug, rarity: "legendary", unlocked: false, progress: 20, holders: "0.4%" },
  { id: "ghostwalk", name: "Ghostwalk", description: "Finish a red team op undetected", icon: Skull, rarity: "legendary", unlocked: false, progress: 0, holders: "0.9%" },
  { id: "keymaster", name: "Keymaster", description: "Break 25 ciphers", icon: KeyRound, rarity: "rare", unlocked: false, progress: 44, holders: "15%" },
  { id: "sentinel", name: "Sentinel", description: "Contain 100 incidents", icon: ShieldAlert, rarity: "epic", unlocked: false, progress: 31, holders: "5%" },
  { id: "archivist", name: "Archivist", description: "Collect 40 pieces of evidence", icon: Search, rarity: "common", unlocked: true, holders: "61%" },
  { id: "oracle", name: "Oracle Slayer", description: "Defeat ORACLE-9", icon: Brain, rarity: "legendary", unlocked: false, progress: 0, holders: "0.1%" },
  { id: "cloudwalker", name: "Cloudwalker", description: "Harden 15 cloud accounts", icon: Cloud, rarity: "rare", unlocked: false, progress: 8, holders: "12%" },
];

export type Agent = {
  rank: number;
  tag: string;
  clearance: string;
  xp: string;
  streak: number;
  title: string;
  you?: boolean;
};

export const GLOBAL_BOARD: Agent[] = [
  { rank: 1, tag: "V3CTOR", clearance: "V", xp: "148,120", streak: 96, title: "Grid Sentinel" },
  { rank: 2, tag: "HALCYON", clearance: "V", xp: "144,905", streak: 71, title: "Ghost Analyst" },
  { rank: 3, tag: "MERIDIAN", clearance: "V", xp: "132,410", streak: 64, title: "Packet Reaper" },
  { rank: 4, tag: "SABLE", clearance: "IV", xp: "98,220", streak: 40, title: "Red Hand" },
  { rank: 5, tag: "IONWOLF", clearance: "IV", xp: "87,004", streak: 33, title: "Trace Runner" },
  { rank: 6, tag: "KESTREL", clearance: "IV", xp: "72,860", streak: 28, title: "Signal Cutter" },
  { rank: 7, tag: "NOVA", clearance: "III", xp: "12,480", streak: 17, title: "Nightfall Operative", you: true },
  { rank: 8, tag: "DRIFTWOOD", clearance: "III", xp: "11,204", streak: 12, title: "Log Diver" },
  { rank: 9, tag: "PYRE", clearance: "II", xp: "9,860", streak: 8, title: "Recruit" },
  { rank: 10, tag: "ASHLINE", clearance: "II", xp: "8,120", streak: 5, title: "Recruit" },
];

export const RANKS = [
  { name: "Recruit", clearance: "I", xp: "0", state: "done" as const },
  { name: "Field Analyst", clearance: "II", xp: "2,500", state: "done" as const },
  { name: "Nightfall Operative", clearance: "III", xp: "10,000", state: "current" as const },
  { name: "Senior Guardian", clearance: "IV", xp: "35,000", state: "locked" as const },
  { name: "Grid Sentinel", clearance: "V", xp: "120,000", state: "locked" as const },
];
