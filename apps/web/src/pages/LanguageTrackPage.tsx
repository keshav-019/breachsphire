import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { ArrowLeft, CheckCircle2, ChevronDown, ChevronUp, Code2, Play, Save } from "lucide-react";
import { enrollLanguageTrack, fetchLanguageTrack, setLanguageModule } from "@/lib/api";
import { ForgeNav } from "@/components/backend/ForgeNav";
import { XPBar } from "@/components/guardians/XPBar";
import { usePathwayStore } from "@/store/pathway";

export default function LanguageTrackPage() {
  const { slug = "" } = useParams();
  const pathwayId = usePathwayStore((state) => state.selectedPathwayId)!;
  const queryClient = useQueryClient();
  const [openModule, setOpenModule] = useState<string | null>(null);
  const [reflections, setReflections] = useState<Record<string, string>>({});
  const { data, isLoading, error } = useQuery({
    queryKey: ["language-track", pathwayId, slug],
    queryFn: () => fetchLanguageTrack(slug, pathwayId),
  });

  useEffect(() => {
    if (!data) return;
    setReflections(Object.fromEntries(data.modules.map((module) => [module.id, module.reflection])));
    setOpenModule((current) => current ?? data.modules.find((module) => !module.completed)?.id ?? data.modules[0]?.id ?? null);
  }, [data]);

  const refresh = () => {
    queryClient.invalidateQueries({ queryKey: ["language-track", pathwayId, slug] });
    queryClient.invalidateQueries({ queryKey: ["language-tracks", pathwayId] });
    queryClient.invalidateQueries({ queryKey: ["expansion-overview", pathwayId] });
  };
  const enroll = useMutation({ mutationFn: () => enrollLanguageTrack(slug, pathwayId), onSuccess: refresh });
  const moduleMutation = useMutation({
    mutationFn: ({ id, completed }: { id: string; completed: boolean }) => setLanguageModule(id, completed, reflections[id] ?? ""),
    onSuccess: refresh,
  });

  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Opening specialization…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Specialization unavailable.</span></div>;

  return (
    <div className="mx-auto max-w-6xl px-5 py-8">
      <Link to="/forge/tracks" className="label-mono inline-flex items-center gap-2 text-primary hover:underline"><ArrowLeft className="h-3.5 w-3.5" /> All tracks</Link>
      <div className="mt-5 grid gap-5 lg:grid-cols-[1fr_300px] lg:items-end">
        <div>
          <span className="label-mono text-telemetry">{data.language} · {data.framework} · {data.estimatedHours} hours</span>
          <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">{data.title}</h1>
          <p className="mt-3 max-w-3xl text-sm leading-6 text-muted-foreground">{data.description}</p>
        </div>
        <div className="hud-panel corner-cut p-4"><XPBar value={data.modulesCompleted} max={data.modulesTotal} label="Track progress" /></div>
      </div>
      <ForgeNav />

      <section className="hud-panel corner-cut mt-7 flex flex-wrap items-center justify-between gap-5 p-5">
        <div className="flex max-w-3xl items-start gap-3"><Code2 className="mt-0.5 h-5 w-5 shrink-0 text-primary" /><div><span className="label-mono text-primary">Capstone</span><p className="mt-1 text-sm leading-6 text-muted-foreground">{data.capstone}</p></div></div>
        {data.status === "not_started" ? (
          <button type="button" onClick={() => enroll.mutate()} disabled={enroll.isPending} className="corner-cut flex items-center gap-2 bg-primary px-5 py-3 font-display text-sm tracking-wider text-primary-foreground uppercase"><Play className="h-4 w-4 fill-current" />{enroll.isPending ? "Enrolling…" : "Enroll in track"}</button>
        ) : (
          <span className="label-mono flex items-center gap-2 text-telemetry"><CheckCircle2 className="h-4 w-4" />{data.status.replace("_", " ")}</span>
        )}
      </section>

      <section className="mt-6 space-y-3">
        {data.modules.map((module) => {
          const open = openModule === module.id;
          return (
            <article key={module.id} className={`hud-panel corner-cut ${module.completed ? "border-telemetry/40" : ""}`}>
              <button type="button" onClick={() => setOpenModule(open ? null : module.id)} className="grid w-full grid-cols-[48px_minmax(0,1fr)_24px] items-center gap-3 p-5 text-left">
                <span className={`grid h-11 w-11 place-items-center border ${module.completed ? "border-telemetry bg-telemetry/10 text-telemetry" : "border-border text-muted-foreground"}`}>{module.completed ? <CheckCircle2 className="h-5 w-5" /> : <span className="font-display text-sm">{String(module.order).padStart(2, "0")}</span>}</span>
                <span><span className="font-display text-base text-foreground">{module.title}</span><span className="mt-1 block text-sm text-muted-foreground">{module.description}</span></span>
                {open ? <ChevronUp className="h-4 w-4 text-primary" /> : <ChevronDown className="h-4 w-4 text-muted-foreground" />}
              </button>
              {open && (
                <div className="border-t border-border px-5 pb-5 pt-4 md:pl-[5rem]">
                  <div className="flex flex-wrap gap-2">{module.focus.map((item) => <span key={item} className="border border-border bg-background/30 px-2 py-1 text-xs text-muted-foreground">{item}</span>)}</div>
                  <div className="mt-4 border-l-2 border-primary/50 bg-primary/5 px-3 py-2 text-sm leading-6 text-muted-foreground"><span className="font-semibold text-foreground">Capstone step:</span> {module.projectStep}</div>
                  <label className="mt-4 block"><span className="label-mono">Notes / proof</span><textarea value={reflections[module.id] ?? ""} onChange={(event) => setReflections((current) => ({ ...current, [module.id]: event.target.value }))} className="mt-2 min-h-24 w-full resize-y border border-input bg-background/60 p-3 text-sm text-foreground outline-none placeholder:text-muted-foreground/60 focus:border-primary" placeholder="What you built, test or trace that proves it, and the decision you made…" /></label>
                  <button
                    type="button"
                    disabled={data.status === "not_started" || moduleMutation.isPending}
                    onClick={() => moduleMutation.mutate({ id: module.id, completed: !module.completed })}
                    className={`corner-cut mt-4 inline-flex items-center gap-2 px-4 py-2.5 font-display text-xs tracking-wider uppercase disabled:cursor-not-allowed disabled:opacity-40 ${module.completed ? "border border-border text-muted-foreground" : "bg-primary text-primary-foreground"}`}
                  >
                    {module.completed ? <><Save className="h-4 w-4" /> Save & reopen</> : <><CheckCircle2 className="h-4 w-4" /> Save & complete</>}
                  </button>
                  {data.status === "not_started" && <span className="label-mono ml-3">Enroll to record progress</span>}
                </div>
              )}
            </article>
          );
        })}
      </section>
    </div>
  );
}
