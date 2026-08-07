import type { ThreatLevel } from "@/lib/game-data";
import { cn } from "@/lib/utils";

export type ThreatLevelPillProps = {
  level: ThreatLevel;
  className?: string;
};

const config: Record<ThreatLevel, { label: string; className: string }> = {
  low: { label: "Low", className: "border-telemetry/40 bg-telemetry/10 text-telemetry" },
  guarded: { label: "Guarded", className: "border-telemetry/40 bg-telemetry/10 text-telemetry" },
  elevated: { label: "Elevated", className: "border-primary/40 bg-primary/10 text-primary" },
  severe: { label: "Severe", className: "border-primary/50 bg-primary/15 text-primary" },
  critical: { label: "Critical", className: "border-threat/50 bg-threat/10 text-threat" },
};

export function ThreatLevelPill({ level, className }: ThreatLevelPillProps) {
  const c = config[level];
  return (
    <span
      className={cn(
        "inline-flex items-center gap-1.5 border px-2 py-0.5 font-mono text-[0.6rem] tracking-[0.16em] uppercase",
        c.className,
        className,
      )}
    >
      <span className="h-1.5 w-1.5 rounded-full bg-current" />
      {c.label}
    </span>
  );
}
