import { Link, useParams } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { Check, Lock, Play, Skull } from "lucide-react";
import { fetchWorldMissions, type MissionStatus } from "@/lib/api";
import { cn } from "@/lib/utils";

const STATUS_CONFIG: Record<MissionStatus, { label: string; className: string; Icon: typeof Lock }> = {
  locked: { label: "Locked", className: "text-muted-foreground", Icon: Lock },
  available: { label: "Available", className: "text-primary", Icon: Play },
  in_progress: { label: "In progress", className: "text-primary", Icon: Play },
  completed: { label: "Completed", className: "text-telemetry", Icon: Check },
};

export default function WorldMissionsPage() {
  const { worldId } = useParams<{ worldId: string }>();
  const {
    data: campaigns,
    isLoading,
    error,
  } = useQuery({
    queryKey: ["worldMissions", worldId],
    queryFn: () => fetchWorldMissions(worldId!),
    enabled: Boolean(worldId),
  });

  if (isLoading) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono flicker">Pulling campaign records…</span>
      </div>
    );
  }

  if (error || !campaigns) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono text-threat">Failed to load this world's missions.</span>
      </div>
    );
  }

  return (
    <div className="px-5 py-8">
      <Link to="/map" className="label-mono text-primary">
        &larr; Back to the grid
      </Link>
      <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">Campaigns</h1>

      <div className="mt-8 space-y-10">
        {campaigns.map((campaign) => (
          <section key={campaign.id}>
            <h2 className="font-display text-xl text-foreground">{campaign.title}</h2>
            <p className="mt-1 max-w-2xl text-sm text-muted-foreground">{campaign.description}</p>

            <div className="mt-4 space-y-6">
              {campaign.operations.map((operation) => (
                <div key={operation.id}>
                  <span className="label-mono text-telemetry">{operation.title}</span>
                  <ol className="mt-2 space-y-2">
                    {operation.missions.map((mission) => {
                      const status = STATUS_CONFIG[mission.status];
                      const locked = mission.status === "locked";
                      const content = (
                        <div
                          className={cn(
                            "hud-panel corner-cut flex items-center gap-4 p-4 transition-colors",
                            !locked && "hover:border-primary/50",
                            locked && "opacity-60",
                          )}
                        >
                          <span className={cn("grid h-9 w-9 shrink-0 place-items-center border border-current", status.className)}>
                            <status.Icon className="h-4 w-4" />
                          </span>
                          <div className="min-w-0 flex-1">
                            <div className="flex items-center gap-2">
                              <span className="font-display text-sm text-foreground">{mission.title}</span>
                              {mission.isBoss && <Skull className="h-3.5 w-3.5 text-threat" />}
                            </div>
                            <p className="mt-0.5 truncate text-xs text-muted-foreground">{mission.description}</p>
                          </div>
                          <div className="shrink-0 text-right">
                            <div className={cn("label-mono", status.className)}>{status.label}</div>
                            <div className="font-mono text-[0.65rem] text-muted-foreground">{mission.rewards.xp} XP</div>
                          </div>
                        </div>
                      );
                      return (
                        <li key={mission.id}>
                          {locked ? content : <Link to={`/mission/${mission.id}`}>{content}</Link>}
                        </li>
                      );
                    })}
                  </ol>
                </div>
              ))}
            </div>
          </section>
        ))}
      </div>
    </div>
  );
}
