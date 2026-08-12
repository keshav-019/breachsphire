import { useState, type FormEvent } from "react";
import { Link, useParams } from "react-router-dom";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { AlertTriangle, ArrowLeft, CheckCircle2, Search, Send, Siren } from "lucide-react";
import { fetchAiIncident, submitAiIncident } from "@/lib/api";
import { ForgeNav } from "@/components/backend/ForgeNav";

const fieldClass = "mt-2 min-h-36 w-full resize-y border border-input bg-background/60 p-3 text-sm leading-6 text-foreground outline-none placeholder:text-muted-foreground/60 focus:border-primary";

export default function AiIncidentPage() {
  const { slug = "" } = useParams();
  const queryClient = useQueryClient();
  const [diagnosis, setDiagnosis] = useState("");
  const [mitigation, setMitigation] = useState("");
  const { data, isLoading, error } = useQuery({ queryKey: ["ai-incident", slug], queryFn: () => fetchAiIncident(slug) });
  const submit = useMutation({
    mutationFn: () => submitAiIncident(slug, diagnosis, mitigation),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["ai-incident", slug] });
      queryClient.invalidateQueries({ queryKey: ["ai-incidents"] });
      queryClient.invalidateQueries({ queryKey: ["ai-practice-overview"] });
    },
  });

  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Opening incident room…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Incident unavailable.</span></div>;
  const result = submit.data ?? data.latestAttempt;

  function onSubmit(event: FormEvent) {
    event.preventDefault();
    submit.mutate();
  }

  return (
    <div className="mx-auto max-w-7xl px-5 py-8">
      <Link to="/forge/incidents" className="label-mono inline-flex items-center gap-2 text-primary hover:underline"><ArrowLeft className="h-3.5 w-3.5" /> Incident rotation</Link>
      <div className="mt-5 flex flex-wrap items-end justify-between gap-4">
        <div><span className="label-mono text-threat">{data.difficulty} incident</span><h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">{data.title}</h1><p className="mt-2 max-w-3xl text-sm leading-6 text-muted-foreground">{data.symptom}</p></div>
        <Siren className="h-10 w-10 text-threat" />
      </div>
      <ForgeNav />

      <div className="mt-7 grid gap-6 xl:grid-cols-[minmax(0,1fr)_390px]">
        <div className="space-y-5">
          <section className="hud-panel corner-cut p-5">
            <span className="label-mono text-primary">Evidence packet</span>
            <div className="mt-4 space-y-3">{data.evidence.map((item) => <article key={item.label} className="border border-border bg-surface/50 p-4"><h2 className="flex items-center gap-2 font-display text-sm text-foreground"><Search className="h-4 w-4 text-telemetry" />{item.label}</h2><p className="mt-2 text-sm leading-6 text-muted-foreground">{item.detail}</p></article>)}</div>
          </section>
          <form onSubmit={onSubmit} className="hud-panel corner-cut p-5">
            <span className="label-mono text-primary">Incident response</span>
            <label className="mt-4 block"><span className="text-sm font-semibold text-foreground">Diagnosis</span><textarea className={fieldClass} value={diagnosis} onChange={(event) => setDiagnosis(event.target.value)} placeholder="Name the likely mechanism and connect it to specific evidence. Include what you would inspect next…" /></label>
            <label className="mt-5 block"><span className="text-sm font-semibold text-foreground">Containment, recovery, and prevention</span><textarea className={fieldClass} value={mitigation} onChange={(event) => setMitigation(event.target.value)} placeholder="Limit impact first, preserve evidence, define rollback, then describe the durable correction and verification…" /></label>
            {submit.error && <p className="mt-3 flex items-center gap-2 text-sm text-threat"><AlertTriangle className="h-4 w-4" />{submit.error.message}</p>}
            <button type="submit" disabled={submit.isPending} className="corner-cut mt-5 flex items-center gap-2 bg-primary px-5 py-3 font-display text-sm tracking-wider text-primary-foreground uppercase disabled:opacity-50"><Send className="h-4 w-4" />{submit.isPending ? "Reviewing…" : "Submit response"}</button>
          </form>
        </div>

        <aside className="hud-panel corner-cut h-fit p-5">
          <span className="label-mono">Latest review</span>
          {result ? <><div className="mt-4 flex items-center gap-3"><CheckCircle2 className="h-7 w-7 text-telemetry" /><span className="font-display text-3xl text-foreground">{result.score}%</span></div><ul className="mt-4 space-y-3">{result.feedback.map((item) => <li key={item} className="border-l-2 border-primary/50 pl-3 text-sm leading-6 text-muted-foreground">{item}</li>)}</ul></> : <p className="mt-4 text-sm leading-6 text-muted-foreground">Submit a diagnosis and mitigation plan to receive signal-based feedback and the reference recovery.</p>}
        </aside>
      </div>
    </div>
  );
}
