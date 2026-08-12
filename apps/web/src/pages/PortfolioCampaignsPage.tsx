import { Link } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { ArrowRight, Boxes, CheckCircle2, Circle, GitBranch } from "lucide-react";
import { fetchPortfolioCampaigns } from "@/lib/api";
import { ForgeHeader } from "@/components/backend/ForgeNav";
import { XPBar } from "@/components/guardians/XPBar";
import { usePathwayStore } from "@/store/pathway";

export default function PortfolioCampaignsPage() {
  const pathwayId = usePathwayStore((state) => state.selectedPathwayId)!;
  const isAi = usePathwayStore((state) => state.selectedPathwaySlug === "ai-ml");
  const { data, isLoading, error } = useQuery({
    queryKey: ["portfolio-campaigns", pathwayId],
    queryFn: () => fetchPortfolioCampaigns(pathwayId),
  });
  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Loading project bays…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Portfolio registry unavailable.</span></div>;

  return (
    <div className="mx-auto max-w-6xl px-5 py-8">
      <ForgeHeader
        eyebrow="Portfolio Campaigns"
        title="Build proof outside the simulator."
        description={isAi
          ? "Each project moves from data and evaluation to a running AI system, repository evidence, operational proof, and a reflection you can defend in an interview."
          : "Each campaign ends in a real repository, running system, operational evidence, and a reflection you can discuss in an interview. Choose any supported stack; the engineering outcomes stay constant."}
      />

      <section className="mt-7 space-y-4">
        {data.map((campaign, index) => (
          <Link
            key={campaign.id}
            to={`/forge/portfolio/${campaign.slug}`}
            className="hud-panel corner-cut group grid gap-5 p-5 transition-colors hover:border-primary/60 md:grid-cols-[64px_minmax(0,1fr)_220px] md:items-center"
          >
            <span className="grid h-14 w-14 place-items-center border border-primary/40 bg-primary/10 text-primary">
              {campaign.status === "completed" ? <CheckCircle2 className="h-6 w-6" /> : campaign.status === "in_progress" ? <GitBranch className="h-6 w-6" /> : <Boxes className="h-6 w-6" />}
            </span>
            <div>
              <span className="label-mono text-telemetry">Campaign {String(index + 1).padStart(2, "0")} · {campaign.status.replace("_", " ")}</span>
              <h2 className="mt-1 font-display text-xl text-foreground">{campaign.title}</h2>
              <p className="mt-1 text-sm text-primary">{campaign.tagline}</p>
              <p className="mt-2 max-w-3xl text-sm leading-6 text-muted-foreground">{campaign.summary}</p>
              <div className="mt-3 flex flex-wrap gap-2">{campaign.stackOptions.map((stack) => <span key={stack} className="border border-border px-2 py-1 text-xs text-muted-foreground">{stack}</span>)}</div>
            </div>
            <div>
              <XPBar value={campaign.milestonesCompleted} max={campaign.milestonesTotal} label="Milestones" />
              <span className="mt-4 flex items-center justify-end gap-2 font-display text-xs tracking-wider text-primary uppercase">Open campaign <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" /></span>
            </div>
          </Link>
        ))}
      </section>

      <div className="mt-6 flex items-start gap-3 border border-border bg-surface/40 p-4 text-sm text-muted-foreground">
        <Circle className="mt-0.5 h-4 w-4 shrink-0 text-telemetry" />
        Breachsphire stores progress and links, not your source code. Keep credentials out of evidence and use a repository you control.
      </div>
    </div>
  );
}
