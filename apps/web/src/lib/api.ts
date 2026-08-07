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
