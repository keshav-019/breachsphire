import { Link } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { ArrowRight, CheckCircle2, Siren } from "lucide-react";
import { fetchAiIncidents } from "@/lib/api";
import { ForgeHeader } from "@/components/backend/ForgeNav";

export default function AiIncidentsPage() {
  const { data, isLoading, error } = useQuery({ queryKey: ["ai-incidents"], queryFn: fetchAiIncidents });
  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Loading incident rotation…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Incident registry unavailable.</span></div>;

  const attempted = data.filter((incident) => incident.attemptCount > 0).length;
  return (
    <div className="mx-auto max-w-6xl px-5 py-8">
      <ForgeHeader
        eyebrow="Cipher On-Call"
        title="Thirty failures. Evidence before action."
        description="Each drill starts with symptoms, not a diagnosis. Read the trace, explain the likely failure, contain impact, and define a recovery that keeps rollback available."
      />

      <div className="mt-7 flex flex-wrap gap-3">
        <span className="label-mono border border-primary/40 bg-primary/10 px-3 py-2 text-primary">{attempted} / {data.length} attempted</span>
        <span className="label-mono border border-border px-3 py-2">Repeatable · score improves with evidence</span>
      </div>

      <section className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
        {data.map((incident, index) => (
          <Link key={incident.id} to={`/forge/incidents/${incident.slug}`} className="hud-panel corner-cut group flex min-h-[235px] flex-col p-5 transition-colors hover:border-primary/60">
            <div className="flex items-center justify-between gap-3">
              <span className="label-mono text-telemetry">Incident {String(index + 1).padStart(2, "0")}</span>
              {incident.bestScore == null
                ? <Siren className="h-4 w-4 text-threat" />
                : <span className="flex items-center gap-1 text-xs text-telemetry"><CheckCircle2 className="h-4 w-4" /> {incident.bestScore}%</span>}
            </div>
            <h2 className="mt-4 font-display text-lg text-foreground">{incident.title}</h2>
            <span className="label-mono mt-1 text-primary">{incident.difficulty}</span>
            <p className="mt-3 flex-1 text-sm leading-6 text-muted-foreground">{incident.symptom}</p>
            <span className="mt-4 flex items-center gap-1 border-t border-border/60 pt-4 font-display text-xs tracking-wider text-primary uppercase">Open incident <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" /></span>
          </Link>
        ))}
      </section>
    </div>
  );
}
