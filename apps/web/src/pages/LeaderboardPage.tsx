import { useState } from "react";
import { Globe, Users, Shield } from "lucide-react";
import { GLOBAL_BOARD, type Agent } from "@/lib/game-data";
import { LeaderboardRow } from "@/components/guardians/LeaderboardRow";
import { StatTile } from "@/components/guardians/StatTile";
import { cn } from "@/lib/utils";

const SCOPES = [
  { id: "global", label: "Global", icon: Globe },
  { id: "friends", label: "Friends", icon: Users },
  { id: "guild", label: "Guild", icon: Shield },
] as const;

const boards: Record<string, Agent[]> = {
  global: GLOBAL_BOARD,
  friends: GLOBAL_BOARD.slice(5).map((a, i) => ({ ...a, rank: i + 1 })),
  guild: GLOBAL_BOARD.slice(3, 9).map((a, i) => ({ ...a, rank: i + 1 })),
};

export default function LeaderboardPage() {
  const [scope, setScope] = useState<string>("global");
  const rows = boards[scope]!;

  return (
    <div className="px-5 py-8">
      <span className="label-mono text-primary">Season 2 · resets in 3d 04h</span>
      <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">Division standings</h1>

      <div className="mt-6 grid gap-4 sm:grid-cols-3">
        <StatTile icon={Globe} label="Your global rank" value="#7" sub="up 4 this week" tone="signal" />
        <StatTile icon={Users} label="Agents ranked" value="41,209" />
        <StatTile icon={Shield} label="Guild" value="Cell 07" sub="rank #12 of 840" />
      </div>

      <div className="mt-8 flex gap-2">
        {SCOPES.map((s) => (
          <button
            key={s.id}
            type="button"
            onClick={() => setScope(s.id)}
            className={cn(
              "corner-cut inline-flex items-center gap-2 border px-4 py-2.5 font-display text-xs tracking-[0.14em] uppercase transition-colors",
              scope === s.id
                ? "border-primary/60 bg-primary/15 text-primary glow-signal"
                : "border-border bg-surface/60 text-muted-foreground hover:text-foreground",
            )}
          >
            <s.icon className="h-3.5 w-3.5" />
            {s.label}
          </button>
        ))}
      </div>

      <div className="hud-panel corner-cut mt-4 p-3">
        <div className="flex items-center gap-4 border-b border-border px-3 pb-3">
          <span className="label-mono w-8">#</span>
          <span className="label-mono">Agent</span>
          <span className="label-mono ml-auto">XP</span>
        </div>
        <ul>
          {rows.map((a) => (
            <LeaderboardRow key={a.tag} agent={a} />
          ))}
        </ul>
      </div>
    </div>
  );
}
