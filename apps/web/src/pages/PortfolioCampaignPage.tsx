import { useEffect, useState, type FormEvent } from "react";
import { Link, useParams } from "react-router-dom";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { ArrowLeft, Check, CheckCircle2, ExternalLink, GitBranch, Save } from "lucide-react";
import { fetchPortfolioCampaign, savePortfolioEvidence, setPortfolioMilestone } from "@/lib/api";
import { ForgeNav } from "@/components/backend/ForgeNav";
import { XPBar } from "@/components/guardians/XPBar";
import { usePathwayStore } from "@/store/pathway";

const inputClass = "mt-2 w-full border border-input bg-background/60 px-3 py-2.5 text-sm text-foreground outline-none placeholder:text-muted-foreground/60 focus:border-primary";

export default function PortfolioCampaignPage() {
  const { slug = "" } = useParams();
  const pathwayId = usePathwayStore((state) => state.selectedPathwayId)!;
  const queryClient = useQueryClient();
  const [repoUrl, setRepoUrl] = useState("");
  const [liveUrl, setLiveUrl] = useState("");
  const [reflection, setReflection] = useState("");
  const { data, isLoading, error } = useQuery({
    queryKey: ["portfolio-campaign", pathwayId, slug],
    queryFn: () => fetchPortfolioCampaign(slug, pathwayId),
  });

  useEffect(() => {
    if (!data) return;
    setRepoUrl(data.evidence.repoUrl);
    setLiveUrl(data.evidence.liveUrl);
    setReflection(data.evidence.reflection);
  }, [data]);

  const refresh = () => {
    queryClient.invalidateQueries({ queryKey: ["portfolio-campaign", pathwayId, slug] });
    queryClient.invalidateQueries({ queryKey: ["portfolio-campaigns", pathwayId] });
    queryClient.invalidateQueries({ queryKey: ["expansion-overview", pathwayId] });
  };
  const milestoneMutation = useMutation({
    mutationFn: ({ id, completed }: { id: string; completed: boolean }) => setPortfolioMilestone(id, completed),
    onSuccess: refresh,
  });
  const evidenceMutation = useMutation({
    mutationFn: () => savePortfolioEvidence(slug, pathwayId, { repoUrl, liveUrl, reflection }),
    onSuccess: refresh,
  });

  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Opening project bay…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Portfolio campaign unavailable.</span></div>;

  function save(event: FormEvent) {
    event.preventDefault();
    evidenceMutation.mutate();
  }

  return (
    <div className="mx-auto max-w-7xl px-5 py-8">
      <Link to="/forge/portfolio" className="label-mono inline-flex items-center gap-2 text-primary hover:underline"><ArrowLeft className="h-3.5 w-3.5" /> All campaigns</Link>
      <div className="mt-5 grid gap-5 lg:grid-cols-[1fr_300px] lg:items-end">
        <div>
          <span className="label-mono text-telemetry">Portfolio campaign · {data.status.replace("_", " ")}</span>
          <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">{data.title}</h1>
          <p className="mt-1 font-display text-lg text-primary">{data.tagline}</p>
          <p className="mt-3 max-w-3xl text-sm leading-6 text-muted-foreground">{data.summary}</p>
        </div>
        <div className="hud-panel corner-cut p-4">
          <XPBar value={data.milestonesCompleted} max={data.milestonesTotal} label="Build progress" />
        </div>
      </div>
      <ForgeNav />

      <div className="mt-7 grid gap-6 xl:grid-cols-[minmax(0,1fr)_370px]">
        <main>
          <section className="hud-panel corner-cut p-6">
            <span className="label-mono text-primary">Definition of done</span>
            <div className="mt-4 grid gap-3 sm:grid-cols-2">
              {data.outcomes.map((outcome) => <div key={outcome} className="flex gap-2 border border-border bg-background/30 p-3 text-sm text-muted-foreground"><Check className="mt-0.5 h-4 w-4 shrink-0 text-telemetry" />{outcome}</div>)}
            </div>
            <div className="mt-5 flex flex-wrap gap-2">{data.stackOptions.map((stack) => <span key={stack} className="border border-primary/30 bg-primary/5 px-2 py-1 text-xs text-muted-foreground">{stack}</span>)}</div>
          </section>

          <section className="mt-6 space-y-3">
            <div className="flex items-end justify-between"><div><span className="label-mono text-telemetry">Build plan</span><h2 className="mt-1 font-display text-xl text-foreground">Milestones</h2></div><span className="label-mono">{data.milestonesCompleted}/{data.milestonesTotal}</span></div>
            {data.milestones.map((milestone) => (
              <article key={milestone.id} className={`hud-panel corner-cut grid gap-4 p-5 md:grid-cols-[48px_minmax(0,1fr)] ${milestone.completed ? "border-telemetry/40" : ""}`}>
                <button
                  type="button"
                  aria-label={`${milestone.completed ? "Reopen" : "Complete"} ${milestone.title}`}
                  disabled={milestoneMutation.isPending}
                  onClick={() => milestoneMutation.mutate({ id: milestone.id, completed: !milestone.completed })}
                  className={`grid h-11 w-11 place-items-center border transition-colors ${milestone.completed ? "border-telemetry bg-telemetry/15 text-telemetry" : "border-border text-muted-foreground hover:border-primary hover:text-primary"}`}
                >
                  {milestone.completed ? <CheckCircle2 className="h-5 w-5" /> : <span className="font-display text-sm">{String(milestone.order).padStart(2, "0")}</span>}
                </button>
                <div>
                  <h3 className="font-display text-base text-foreground">{milestone.title}</h3>
                  <p className="mt-1 text-sm leading-6 text-muted-foreground">{milestone.description}</p>
                  <div className="mt-3 border-l-2 border-primary/50 bg-primary/5 px-3 py-2 text-xs leading-5 text-muted-foreground"><span className="font-semibold text-foreground">Evidence:</span> {milestone.deliverable}</div>
                </div>
              </article>
            ))}
          </section>
        </main>

        <aside>
          <form onSubmit={save} className="hud-panel corner-cut sticky top-20 p-5">
            <div className="flex items-center gap-2"><GitBranch className="h-5 w-5 text-primary" /><h2 className="font-display text-lg text-foreground">Project evidence</h2></div>
            <p className="mt-2 text-xs leading-5 text-muted-foreground">Save links as you work. Completion is driven by the milestone checklist, so private or local projects still work.</p>
            <label className="mt-5 block"><span className="label-mono">Repository URL</span><input type="url" value={repoUrl} onChange={(event) => setRepoUrl(event.target.value)} className={inputClass} placeholder="https://github.com/…" /></label>
            <label className="mt-4 block"><span className="label-mono">Live / demo URL</span><input type="url" value={liveUrl} onChange={(event) => setLiveUrl(event.target.value)} className={inputClass} placeholder="https://…" /></label>
            <label className="mt-4 block"><span className="label-mono">Engineering reflection</span><textarea value={reflection} onChange={(event) => setReflection(event.target.value)} className={`${inputClass} min-h-40 resize-y`} placeholder="Hardest tradeoff, measured result, failure found, and what you would change…" /></label>
            {evidenceMutation.error && <p className="mt-3 text-xs text-threat">{evidenceMutation.error.message}</p>}
            {evidenceMutation.isSuccess && <p className="mt-3 flex items-center gap-2 text-xs text-telemetry"><CheckCircle2 className="h-4 w-4" /> Evidence saved.</p>}
            <button type="submit" disabled={evidenceMutation.isPending} className="corner-cut mt-5 flex w-full items-center justify-center gap-2 bg-primary py-3 font-display text-sm tracking-wider text-primary-foreground uppercase disabled:opacity-50"><Save className="h-4 w-4" />{evidenceMutation.isPending ? "Saving…" : "Save evidence"}</button>
            {(repoUrl || liveUrl) && <div className="mt-4 space-y-2 border-t border-border pt-4">{repoUrl && <a href={repoUrl} target="_blank" rel="noreferrer" className="label-mono flex items-center gap-2 text-primary hover:underline">Open repository <ExternalLink className="h-3 w-3" /></a>}{liveUrl && <a href={liveUrl} target="_blank" rel="noreferrer" className="label-mono flex items-center gap-2 text-primary hover:underline">Open demo <ExternalLink className="h-3 w-3" /></a>}</div>}
          </form>
        </aside>
      </div>
    </div>
  );
}
