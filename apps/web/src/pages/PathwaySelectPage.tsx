import { useNavigate } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { ChevronRight, Lock } from "lucide-react";
import { fetchPathways } from "@/lib/api";
import { usePathwayStore } from "@/store/pathway";
import { XPBar } from "@/components/guardians/XPBar";

export default function PathwaySelectPage() {
  const navigate = useNavigate();
  const setPathway = usePathwayStore((s) => s.setPathway);
  const { data: pathways, isLoading, error } = useQuery({ queryKey: ["pathways"], queryFn: fetchPathways });

  function enter(pathway: { id: string; slug: string; title: string }) {
    setPathway(pathway);
    navigate("/");
  }

  if (isLoading) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono flicker">Loading campaign tracks…</span>
      </div>
    );
  }

  if (error || !pathways) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono text-threat">Failed to reach the pathway registry.</span>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-4xl px-5 py-10">
      <span className="label-mono text-primary">Nexus // Pathway Selection</span>
      <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">Choose your pathway.</h1>
      <p className="mt-2 max-w-xl text-sm text-muted-foreground">
        Every pathway is a complete, independent campaign with its own Acts, missions and progress. Clear Acts in
        either one whenever you like — nothing here is exclusive.
      </p>

      <div className="mt-8 grid gap-6 sm:grid-cols-2">
        {pathways.map((p) => {
          const Icon = p.icon;
          const pct = p.actsTotal > 0 ? Math.round((p.actsCleared / p.actsTotal) * 100) : 0;
          return (
            <button
              key={p.id}
              type="button"
              onClick={() => enter(p)}
              className="hud-panel corner-cut scanline group flex flex-col items-start p-6 text-left transition-transform hover:scale-[1.01]"
            >
              <span className="grid h-14 w-14 place-items-center rounded-full border-2 border-primary/60 bg-primary/10 text-primary">
                <Icon className="h-7 w-7" />
              </span>

              <h2 className="mt-4 font-display text-xl text-foreground">{p.title}</h2>
              <p className="label-mono mt-1 text-telemetry">{p.tagline}</p>
              <p className="mt-3 text-sm text-muted-foreground">{p.description}</p>

              <div className="mt-5 w-full">
                {p.actsTotal > 0 ? (
                  <XPBar value={p.actsCleared} max={p.actsTotal} label="Acts secured" showNumbers />
                ) : (
                  <div className="flex items-center gap-2 text-xs text-muted-foreground">
                    <Lock className="h-3.5 w-3.5" />
                    More Acts coming soon
                  </div>
                )}
              </div>

              <span className="corner-cut mt-6 flex w-full items-center justify-center gap-2 bg-primary py-3 font-display text-sm tracking-[0.12em] text-primary-foreground uppercase glow-signal transition-transform group-hover:scale-[1.02]">
                {p.started ? "Continue" : "Begin"}
                <ChevronRight className="h-4 w-4" />
              </span>
              <span className="label-mono mt-2">{pct}% complete</span>
            </button>
          );
        })}
      </div>
    </div>
  );
}
