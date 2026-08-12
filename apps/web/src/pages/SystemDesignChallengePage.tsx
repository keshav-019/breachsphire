import { useState, type FormEvent } from "react";
import { Link, useParams } from "react-router-dom";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { AlertTriangle, ArrowLeft, CheckCircle2, Gauge, Send } from "lucide-react";
import type { ArenaMode } from "@cyber-guardians/types";
import { fetchArenaChallenge, submitArenaDesign } from "@/lib/api";
import { ForgeNav } from "@/components/backend/ForgeNav";
import { usePathwayStore } from "@/store/pathway";

const fieldClass = "mt-2 min-h-32 w-full resize-y border border-input bg-background/60 p-3 text-sm leading-6 text-foreground outline-none transition-colors placeholder:text-muted-foreground/60 focus:border-primary";

export default function SystemDesignChallengePage() {
  const { slug = "" } = useParams();
  const pathwayId = usePathwayStore((state) => state.selectedPathwayId)!;
  const queryClient = useQueryClient();
  const [mode, setMode] = useState<ArenaMode>("foundation");
  const [assumptions, setAssumptions] = useState("");
  const [architecture, setArchitecture] = useState("");
  const [tradeoffs, setTradeoffs] = useState("");
  const { data, isLoading, error } = useQuery({
    queryKey: ["arena-challenge", pathwayId, slug],
    queryFn: () => fetchArenaChallenge(slug, pathwayId),
  });
  const submit = useMutation({
    mutationFn: () => submitArenaDesign(slug, pathwayId, { mode, assumptions, architecture, tradeoffs }),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["arena-challenge", pathwayId, slug] });
      queryClient.invalidateQueries({ queryKey: ["arena-challenges", pathwayId] });
      queryClient.invalidateQueries({ queryKey: ["expansion-overview", pathwayId] });
    },
  });

  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Opening design room…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Design brief unavailable.</span></div>;

  const selectedMode = data.modes.find((item) => item.id === mode) ?? data.modes[0];
  const result = submit.data ?? data.latestSubmission;

  function onSubmit(event: FormEvent) {
    event.preventDefault();
    submit.mutate();
  }

  return (
    <div className="mx-auto max-w-7xl px-5 py-8">
      <Link to="/forge/arena" className="label-mono inline-flex items-center gap-2 text-primary hover:underline">
        <ArrowLeft className="h-3.5 w-3.5" /> All briefs
      </Link>
      <div className="mt-5 flex flex-wrap items-end justify-between gap-4">
        <div>
          <span className="label-mono text-telemetry">{data.domain} · {data.estimatedMinutes} minutes</span>
          <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">{data.title}</h1>
          <p className="mt-2 max-w-3xl text-sm leading-6 text-muted-foreground">{data.context}</p>
        </div>
        {data.bestScore !== null && (
          <div className="corner-cut border border-telemetry/40 bg-telemetry/10 px-4 py-3 text-right">
            <span className="label-mono text-telemetry">Personal best</span>
            <div className="font-display text-2xl text-foreground">{data.bestScore}%</div>
          </div>
        )}
      </div>
      <ForgeNav />

      <div className="mt-7 grid gap-6 xl:grid-cols-[minmax(0,1fr)_340px]">
        <main>
          <section className="hud-panel corner-cut p-6">
            <span className="label-mono text-primary">The prompt</span>
            <p className="mt-3 font-display text-lg leading-7 text-foreground">{data.prompt}</p>
            <div className="mt-6 grid gap-5 md:grid-cols-2">
              <div>
                <h2 className="label-mono text-telemetry">Functional requirements</h2>
                <ul className="mt-3 space-y-2 text-sm text-muted-foreground">
                  {data.functionalRequirements.map((item) => <li key={item} className="flex gap-2"><span className="text-telemetry">◆</span>{item}</li>)}
                </ul>
              </div>
              <div>
                <h2 className="label-mono text-primary">Quality constraints</h2>
                <ul className="mt-3 space-y-2 text-sm text-muted-foreground">
                  {data.nonfunctionalRequirements.map((item) => <li key={item} className="flex gap-2"><span className="text-primary">◆</span>{item}</li>)}
                </ul>
              </div>
            </div>
          </section>

          <form onSubmit={onSubmit} className="hud-panel corner-cut mt-6 p-6">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <span className="label-mono text-primary">Your design review</span>
                <h2 className="mt-1 font-display text-xl text-foreground">Choose operating conditions</h2>
              </div>
              <span className="label-mono">Submission {data.submissionCount + 1}</span>
            </div>

            <div className="mt-5 grid gap-2 sm:grid-cols-2 lg:grid-cols-4">
              {data.modes.map((item) => (
                <button
                  key={item.id}
                  type="button"
                  onClick={() => setMode(item.id)}
                  className={`border p-3 text-left transition-colors ${mode === item.id ? "border-primary bg-primary/10" : "border-border bg-background/40 hover:border-muted-foreground"}`}
                >
                  <span className={`font-display text-sm ${mode === item.id ? "text-primary" : "text-foreground"}`}>{item.label}</span>
                  <span className="mt-1 block text-xs leading-5 text-muted-foreground">{item.description}</span>
                </button>
              ))}
            </div>

            {selectedMode && (
              <div className="mt-4 border-l-2 border-primary bg-primary/5 px-4 py-3">
                <span className="label-mono text-primary">Active constraints</span>
                <div className="mt-2 flex flex-wrap gap-2">
                  {selectedMode.constraints.map((item) => <span key={item} className="border border-primary/30 px-2 py-1 text-xs text-muted-foreground">{item}</span>)}
                </div>
              </div>
            )}

            <label className="mt-6 block">
              <span className="font-display text-sm text-foreground">1. Assumptions & estimates</span>
              <span className="ml-2 text-xs text-muted-foreground">minimum 40 characters</span>
              <textarea value={assumptions} onChange={(event) => setAssumptions(event.target.value)} className={fieldClass} placeholder="Traffic shape, data size, retention, consistency needs, and the questions you would ask…" />
            </label>
            <label className="mt-5 block">
              <span className="font-display text-sm text-foreground">2. Architecture & request flows</span>
              <span className="ml-2 text-xs text-muted-foreground">minimum 120 characters</span>
              <textarea value={architecture} onChange={(event) => setArchitecture(event.target.value)} className={`${fieldClass} min-h-56`} placeholder="Name each component, its ownership, the data model, write/read flow, scaling plan, and failure behavior…" />
            </label>
            <label className="mt-5 block">
              <span className="font-display text-sm text-foreground">3. Tradeoffs & alternatives</span>
              <span className="ml-2 text-xs text-muted-foreground">minimum 40 characters</span>
              <textarea value={tradeoffs} onChange={(event) => setTradeoffs(event.target.value)} className={fieldClass} placeholder="What did you choose, what did you reject, and which requirement made the difference?" />
            </label>

            {submit.error && (
              <div className="mt-4 flex items-center gap-2 text-sm text-threat"><AlertTriangle className="h-4 w-4" />{submit.error.message}</div>
            )}
            <button
              type="submit"
              disabled={submit.isPending}
              className="corner-cut mt-6 inline-flex items-center gap-2 bg-primary px-5 py-3 font-display text-sm tracking-wider text-primary-foreground uppercase glow-signal disabled:opacity-50"
            >
              <Send className="h-4 w-4" /> {submit.isPending ? "Reviewing…" : "Submit design"}
            </button>
          </form>
        </main>

        <aside className="space-y-6">
          <section className="hud-panel corner-cut p-5">
            <span className="label-mono text-telemetry">Visible rubric</span>
            <p className="mt-2 text-xs leading-5 text-muted-foreground">Signals help structure practice; thoughtful synonyms and rationale still receive depth credit.</p>
            <div className="mt-4 space-y-4">
              {data.rubric.map((item) => (
                <div key={item.key}>
                  <div className="flex justify-between gap-3"><span className="font-display text-sm text-foreground">{item.label}</span><span className="label-mono text-primary">{item.weight}</span></div>
                  <p className="mt-1 text-xs leading-5 text-muted-foreground">{item.description}</p>
                  <div className="mt-2 flex flex-wrap gap-1">{item.keywords.slice(0, 5).map((word) => <span key={word} className="bg-surface-raised px-1.5 py-0.5 font-mono text-[0.6rem] text-muted-foreground">{word}</span>)}</div>
                </div>
              ))}
            </div>
          </section>

          {result && (
            <section className="hud-panel corner-cut border-telemetry/40 p-5">
              <div className="flex items-center justify-between">
                <span className="label-mono text-telemetry">Latest review</span>
                <span className="flex items-center gap-1 font-display text-xl text-foreground"><Gauge className="h-5 w-5 text-telemetry" />{result.score}%</span>
              </div>
              <div className="mt-4 space-y-3">
                {result.criterionScores.map((item) => (
                  <div key={item.key}>
                    <div className="flex justify-between text-xs"><span className="text-muted-foreground">{item.label}</span><span className="text-foreground">{item.score}/{item.maxScore}</span></div>
                    <div className="mt-1 h-1.5 bg-muted"><div className="h-full bg-telemetry" style={{ width: `${(item.score / item.maxScore) * 100}%` }} /></div>
                  </div>
                ))}
              </div>
              <div className="mt-5 space-y-2 border-t border-border pt-4">
                {result.feedback.map((item) => <p key={item} className="flex gap-2 text-xs leading-5 text-muted-foreground"><CheckCircle2 className="mt-0.5 h-3.5 w-3.5 shrink-0 text-telemetry" />{item}</p>)}
              </div>
            </section>
          )}
        </aside>
      </div>
    </div>
  );
}
