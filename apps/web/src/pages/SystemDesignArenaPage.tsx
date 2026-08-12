import { Link } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { ArrowRight, CheckCircle2, Clock3, DraftingCompass } from "lucide-react";
import { fetchArenaChallenges } from "@/lib/api";
import { ForgeHeader } from "@/components/backend/ForgeNav";
import { usePathwayStore } from "@/store/pathway";

export default function SystemDesignArenaPage() {
  const pathwayId = usePathwayStore((state) => state.selectedPathwayId)!;
  const isAi = usePathwayStore((state) => state.selectedPathwaySlug === "ai-ml");
  const { data, isLoading, error } = useQuery({
    queryKey: ["arena-challenges", pathwayId],
    queryFn: () => fetchArenaChallenges(pathwayId),
  });
  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Loading Arena briefs…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Arena registry unavailable.</span></div>;

  const completed = data.filter((item) => item.submissionCount > 0).length;
  return (
    <div className="mx-auto max-w-6xl px-5 py-8">
      <ForgeHeader
        eyebrow="System Design Arena"
        title={isAi ? "Twelve AI systems. Every layer matters." : "Twelve briefs. No prescribed diagram."}
        description={isAi
          ? "Design data, model, evaluation, serving, monitoring, cost and safety together. The deterministic rubric is a practice signal—not a substitute for human architecture review."
          : "State assumptions, propose the architecture, and defend the tradeoffs. The deterministic rubric is a practice signal—not a claim that keyword coverage replaces an engineering review."}
      />

      <div className="mt-7 flex flex-wrap items-center gap-3">
        <span className="label-mono border border-primary/40 bg-primary/10 px-3 py-2 text-primary">{completed} / {data.length} attempted</span>
        <span className="label-mono border border-border px-3 py-2">Foundation · Scale · Incident · Interview</span>
      </div>

      <section className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
        {data.map((challenge, index) => (
          <Link
            key={challenge.id}
            to={`/forge/arena/${challenge.slug}`}
            className="hud-panel corner-cut group flex min-h-[270px] flex-col p-5 transition-colors hover:border-primary/60"
          >
            <div className="flex items-center justify-between gap-3">
              <span className="label-mono text-telemetry">Brief {String(index + 1).padStart(2, "0")}</span>
              {challenge.submissionCount > 0 ? (
                <span className="flex items-center gap-1 text-xs text-telemetry"><CheckCircle2 className="h-4 w-4" /> {challenge.bestScore}%</span>
              ) : (
                <DraftingCompass className="h-4 w-4 text-muted-foreground" />
              )}
            </div>
            <h2 className="mt-4 font-display text-lg text-foreground">{challenge.title}</h2>
            <p className="label-mono mt-1 text-primary">{challenge.domain}</p>
            <p className="mt-3 flex-1 text-sm leading-6 text-muted-foreground">{challenge.summary}</p>
            <div className="mt-4 flex items-center justify-between border-t border-border/60 pt-4">
              <span className="flex items-center gap-1.5 text-xs text-muted-foreground"><Clock3 className="h-3.5 w-3.5" /> {challenge.estimatedMinutes} min</span>
              <span className="flex items-center gap-1 font-display text-xs tracking-wider text-primary uppercase">Open brief <ArrowRight className="h-3.5 w-3.5 transition-transform group-hover:translate-x-1" /></span>
            </div>
          </Link>
        ))}
      </section>
    </div>
  );
}
