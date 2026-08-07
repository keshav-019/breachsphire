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
