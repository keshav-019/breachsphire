import { Link } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { ArrowRight, Binary, Bot, Braces, CheckCircle2, Clock3, Cloud, Coffee, Flame, Image as ImageIcon, MessageSquare, Network, Search, Terminal, Workflow } from "lucide-react";
import type { LucideIcon } from "lucide-react";
import { fetchLanguageTracks } from "@/lib/api";
import { ForgeHeader } from "@/components/backend/ForgeNav";
import { XPBar } from "@/components/guardians/XPBar";
import { usePathwayStore } from "@/store/pathway";

const TRACK_ICONS: Record<string, LucideIcon> = { Coffee, Braces, Terminal, Binary, Flame, Workflow, Image: ImageIcon, MessageSquare, Bot, Search, Network, Cloud };

export default function LanguageTracksPage() {
  const pathwayId = usePathwayStore((state) => state.selectedPathwayId)!;
  const isAi = usePathwayStore((state) => state.selectedPathwaySlug === "ai-ml");
  const { data, isLoading, error } = useQuery({
    queryKey: ["language-tracks", pathwayId],
    queryFn: () => fetchLanguageTracks(pathwayId),
  });
  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Loading specialization tracks…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Track registry unavailable.</span></div>;

  return (
    <div className="mx-auto max-w-6xl px-5 py-8">
      <ForgeHeader
        eyebrow={isAi ? "Specialist Tracks" : "Language Specialization"}
        title={isAi ? "Go deeper without losing the system." : "Same judgment. A different runtime."}
        description={isAi
          ? "Each track deepens one part of the AI stack through failures, implementation, evaluation, and a production capstone. You may enroll in more than one."
          : "These are not syntax tours. Each track replays API, data, security, messaging, testing, and operations through the language’s real conventions, ending in a deployable capstone. You may enroll in more than one."}
      />

      <section className="mt-7 grid gap-5 lg:grid-cols-3">
        {data.map((track) => {
          const Icon = TRACK_ICONS[track.icon] ?? Terminal;
          return (
            <Link key={track.id} to={`/forge/tracks/${track.slug}`} className="hud-panel corner-cut group flex min-h-[390px] flex-col p-6 transition-transform hover:-translate-y-1">
              <div className="flex items-center justify-between">
                <span className="grid h-14 w-14 place-items-center border border-primary/50 bg-primary/10 text-primary"><Icon className="h-7 w-7" /></span>
                {track.status === "completed" && <CheckCircle2 className="h-5 w-5 text-telemetry" />}
              </div>
              <span className="label-mono mt-5 text-telemetry">{track.language} · {track.framework}</span>
              <h2 className="mt-2 font-display text-xl text-foreground">{track.title}</h2>
              <p className="mt-3 flex-1 text-sm leading-6 text-muted-foreground">{track.description}</p>
              <div className="mt-5"><XPBar value={track.modulesCompleted} max={track.modulesTotal} label="Modules" /></div>
              <div className="mt-4 flex items-center justify-between border-t border-border/60 pt-4">
                <span className="flex items-center gap-1.5 text-xs text-muted-foreground"><Clock3 className="h-3.5 w-3.5" /> {track.estimatedHours} hours</span>
                <span className="flex items-center gap-1 font-display text-xs tracking-wider text-primary uppercase">{track.status === "not_started" ? "Inspect" : "Continue"}<ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" /></span>
              </div>
            </Link>
          );
        })}
      </section>
    </div>
  );
}
