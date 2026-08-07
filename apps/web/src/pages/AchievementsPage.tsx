import { useState } from "react";
import { Medal } from "lucide-react";
import { ACHIEVEMENTS, type Rarity } from "@/lib/game-data";
import { AchievementCard } from "@/components/guardians/AchievementCard";
import { XPBar } from "@/components/guardians/XPBar";
import { cn } from "@/lib/utils";

const FILTERS = ["all", "unlocked", "locked", "legendary"] as const;

export default function AchievementsPage() {
  const [filter, setFilter] = useState<(typeof FILTERS)[number]>("all");

  const list = ACHIEVEMENTS.filter((a) =>
    filter === "all"
      ? true
      : filter === "unlocked"
        ? a.unlocked
        : filter === "locked"
          ? !a.unlocked
          : a.rarity === ("legendary" as Rarity),
  );

  const unlocked = ACHIEVEMENTS.filter((a) => a.unlocked).length;

  return (
    <div className="px-5 py-8">
      <div className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <span className="label-mono text-primary">Honours record</span>
          <h1 className="mt-2 flex items-center gap-3 text-3xl font-bold text-foreground sm:text-4xl">
            <Medal className="h-7 w-7 text-primary" />
            Commendations
          </h1>
        </div>
        <div className="hud-panel corner-cut w-64 p-4">
          <XPBar value={unlocked} max={ACHIEVEMENTS.length} label="Earned" />
        </div>
      </div>

      <div className="mt-6 flex flex-wrap gap-2">
        {FILTERS.map((f) => (
          <button
            key={f}
            type="button"
            onClick={() => setFilter(f)}
            className={cn(
              "corner-cut border px-4 py-2 font-display text-xs tracking-[0.14em] uppercase transition-colors",
              filter === f
                ? "border-primary/60 bg-primary/15 text-primary"
                : "border-border bg-surface/60 text-muted-foreground hover:text-foreground",
            )}
          >
            {f}
          </button>
        ))}
      </div>

      <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        {list.map((a) => (
          <AchievementCard key={a.id} achievement={a} />
        ))}
      </div>
    </div>
  );
}
