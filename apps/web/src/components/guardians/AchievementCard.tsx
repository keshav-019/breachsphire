import { Lock } from "lucide-react";
import type { Achievement, Rarity } from "@/lib/game-data";
import { cn } from "@/lib/utils";

export type AchievementCardProps = {
  achievement: Achievement;
  className?: string;
};

const rarityStyle: Record<Rarity, { ring: string; label: string; text: string }> = {
  common: { ring: "border-border", label: "Common", text: "text-muted-foreground" },
  rare: { ring: "border-telemetry/50", label: "Rare", text: "text-telemetry" },
  epic: { ring: "border-clearance/60", label: "Epic", text: "text-clearance" },
  legendary: { ring: "border-primary/70", label: "Legendary", text: "text-primary" },
};

export function AchievementCard({ achievement: a, className }: AchievementCardProps) {
  const r = rarityStyle[a.rarity];
  const Icon = a.icon;

  return (
    <article
      className={cn(
        "hud-panel corner-cut relative p-5 transition-transform hover:-translate-y-1",
        r.ring,
        a.unlocked ? (a.rarity === "legendary" ? "glow-signal" : "") : "opacity-60 grayscale",
        className,
      )}
    >
      <div className="flex items-start gap-4">
        <span
          className={cn(
            "grid h-12 w-12 shrink-0 place-items-center rounded-full border-2",
            r.ring,
            a.unlocked ? r.text : "text-muted-foreground",
          )}
        >
          {a.unlocked ? <Icon className="h-5 w-5" /> : <Lock className="h-4 w-4" />}
        </span>
        <div className="min-w-0">
          <h3 className="font-display text-base text-foreground">{a.name}</h3>
          <p className="mt-1 text-xs leading-relaxed text-muted-foreground">{a.description}</p>
        </div>
      </div>

      {!a.unlocked && typeof a.progress === "number" && (
        <div className="mt-4">
          <div className="h-1 w-full overflow-hidden bg-muted">
            <div
              className="h-full"
              style={{ width: `${a.progress}%`, background: "var(--gradient-signal)" }}
            />
          </div>
          <div className="label-mono mt-2">{a.progress}% complete</div>
        </div>
      )}

      <div className="mt-4 flex items-center justify-between border-t border-border/60 pt-3">
        <span className={cn("label-mono", r.text)}>{r.label}</span>
        <span className="label-mono">{a.holders} of agents</span>
      </div>
    </article>
  );
}
