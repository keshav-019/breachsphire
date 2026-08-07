import type { LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

export type SkillProgressBarProps = {
  name: string;
  level: number;
  max: number;
  pct: number;
  icon?: LucideIcon;
  tone?: "signal" | "telemetry";
  className?: string;
};

export function SkillProgressBar({
  name,
  level,
  max,
  pct,
  icon: Icon,
  tone = "telemetry",
  className,
}: SkillProgressBarProps) {
  return (
    <div className={cn("w-full", className)}>
      <div className="flex items-center gap-2">
        {Icon && (
          <Icon className={cn("h-4 w-4", tone === "signal" ? "text-primary" : "text-telemetry")} />
        )}
        <span className="font-display text-sm text-foreground">{name}</span>
        <span className="label-mono ml-auto">
          LV {level}/{max}
        </span>
      </div>
      <div className="mt-2 h-1.5 w-full overflow-hidden bg-muted">
        <div
          className="h-full"
          style={{
            width: `${pct}%`,
            background: tone === "signal" ? "var(--gradient-signal)" : "var(--gradient-telemetry)",
          }}
        />
      </div>
      <div className="mt-2 flex gap-1">
        {Array.from({ length: max }).map((_, i) => (
          <span
            key={i}
            className={cn("h-1 flex-1", i < level ? "bg-foreground/50" : "bg-border")}
          />
        ))}
      </div>
    </div>
  );
}
