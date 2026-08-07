import { Flame } from "lucide-react";
import type { Agent } from "@/lib/game-data";
import { CharacterAvatar } from "./CharacterAvatar";
import { cn } from "@/lib/utils";

export type LeaderboardRowProps = {
  agent: Agent;
  className?: string;
};

export function LeaderboardRow({ agent, className }: LeaderboardRowProps) {
  const podium = agent.rank <= 3;
  return (
    <li
      className={cn(
        "flex items-center gap-4 border-b border-border/60 px-3 py-3 last:border-0",
        agent.you && "border-primary/40 bg-primary/8",
        className,
      )}
    >
      <span
        className={cn(
          "w-8 shrink-0 font-mono text-sm",
          podium ? "text-primary" : "text-muted-foreground",
        )}
      >
        {String(agent.rank).padStart(2, "0")}
      </span>
      <CharacterAvatar tag={agent.tag} tone={agent.you ? "signal" : "telemetry"} />
      <div className="min-w-0">
        <div className="font-display text-sm text-foreground">
          {agent.tag}
          {agent.you && <span className="label-mono ml-2 text-primary">you</span>}
        </div>
        <div className="label-mono mt-0.5 truncate">
          {agent.title} · Clearance {agent.clearance}
        </div>
      </div>
      <div className="ml-auto flex items-center gap-5">
        <span className="hidden items-center gap-1 font-mono text-xs text-primary sm:flex">
          <Flame className="h-3.5 w-3.5" />
          {agent.streak}
        </span>
        <span className="font-mono text-sm text-telemetry">{agent.xp}</span>
      </div>
    </li>
  );
}
