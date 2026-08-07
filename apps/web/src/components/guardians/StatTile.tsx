import type { LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

export type StatTileProps = {
  icon: LucideIcon;
  label: string;
  value: string;
  sub?: string;
  tone?: "signal" | "telemetry" | "threat";
  className?: string;
};

const tones = {
  signal: "text-primary",
  telemetry: "text-telemetry",
  threat: "text-threat",
} as const;

export function StatTile({
  icon: Icon,
  label,
  value,
  sub,
  tone = "telemetry",
  className,
}: StatTileProps) {
  return (
    <div className={cn("hud-panel corner-cut p-4", className)}>
      <div className="flex items-center gap-2">
        <Icon className={cn("h-4 w-4", tones[tone])} />
        <span className="label-mono">{label}</span>
      </div>
      <div className="mt-3 font-display text-2xl text-foreground">{value}</div>
      {sub && <div className="label-mono mt-1">{sub}</div>}
    </div>
  );
}
