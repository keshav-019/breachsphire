import { Link } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { ArrowRight, Boxes, Code2, DraftingCompass, Layers3, MessagesSquare, Stethoscope } from "lucide-react";
import { fetchAiPracticeOverview, fetchBackendOverview } from "@/lib/api";
import { ForgeHeader } from "@/components/backend/ForgeNav";
import { XPBar } from "@/components/guardians/XPBar";
import { usePathwayStore } from "@/store/pathway";

export default function ForgeLabPage() {
  const pathwayId = usePathwayStore((state) => state.selectedPathwayId)!;
  const isAi = usePathwayStore((state) => state.selectedPathwaySlug === "ai-ml");
  const { data, isLoading, error } = useQuery({
    queryKey: ["expansion-overview", pathwayId],
    queryFn: () => fetchBackendOverview(pathwayId),
  });
  const { data: aiPractice } = useQuery({ queryKey: ["ai-practice-overview"], queryFn: fetchAiPracticeOverview, enabled: isAi });

  if (isLoading) {
    return <div className="px-5 py-8"><span className="label-mono flicker">Opening Forge Lab…</span></div>;
  }
  if (error || !data) {
    return <div className="px-5 py-8"><span className="label-mono text-threat">Forge Lab is unavailable.</span></div>;
  }

  const stations = [
    {
      to: "/forge/arena",
      icon: DraftingCompass,
      label: "Station 01",
      title: "System Design Arena",
      description: isAi
        ? "Twelve AI system briefs spanning data, models, evaluation, serving, safety, cost, and failure recovery."
        : "Twelve ambiguous design briefs, four operating modes, freeform architecture submissions, and visible rubric feedback.",
      value: data.arena.completed,
      max: data.arena.total,
      meta: data.arena.bestScore === null ? "No design submitted" : `Best rubric signal ${data.arena.bestScore}%`,
    },
    {
      to: "/forge/portfolio",
      icon: Boxes,
      label: "Station 02",
      title: "Portfolio Campaigns",
      description: isAi
        ? "Six production AI builds with concrete milestones, repository evidence, deployment proof, and reflection."
        : "Five real builds with concrete milestones, deployable evidence, and reflection—not simulated mission completion.",
      value: data.portfolio.milestonesCompleted,
      max: data.portfolio.milestonesTotal,
      meta: `${data.portfolio.completed} of ${data.portfolio.total} projects shipped`,
    },
    {
      to: "/forge/tracks",
      icon: Code2,
      label: "Station 03",
      title: isAi ? "Specialist Tracks" : "Language Specializations",
      description: isAi
        ? "Go deeper in mathematics, frameworks, vision, NLP, LLMs, RAG, agents, or MLOps through dedicated capstones."
        : "Carry the same backend judgment into Java/Spring, Python/FastAPI, or Go through a dedicated capstone track.",
      value: data.tracks.modulesCompleted,
      max: data.tracks.modulesTotal,
      meta: `${data.tracks.enrolled} enrolled · ${data.tracks.completed} completed`,
    },
    ...(isAi ? [
      {
        to: "/forge/incidents", icon: Stethoscope, label: "Station 04", title: "Cipher On-Call",
        description: "Thirty repeatable production incidents. Diagnose from evidence, contain the blast radius, and plan a safe recovery.",
        value: aiPractice?.incidents.attempted ?? 0, max: aiPractice?.incidents.total ?? 30,
        meta: aiPractice?.incidents.bestScore == null ? "No incident attempted" : `Best response ${aiPractice.incidents.bestScore}%`,
      },
      {
        to: "/forge/interviews", icon: MessagesSquare, label: "Station 05", title: "Interview Arena",
        description: "Thirty concept and system-design prompts with signal-based feedback you can rehearse until the answer is precise.",
        value: aiPractice?.interviews.attempted ?? 0, max: aiPractice?.interviews.total ?? 30,
        meta: aiPractice?.interviews.bestScore == null ? "No answer practiced" : `Best answer ${aiPractice.interviews.bestScore}%`,
      },
    ] : []),
  ];

  return (
    <div className="mx-auto max-w-6xl px-5 py-8">
      <ForgeHeader
        eyebrow={isAi ? "Post-Game Intelligence" : "Post-Game Systems"}
        title={isAi ? "Cipher Lab" : "Forge Lab"}
        description={isAi
          ? "The campaign taught how machines learn. Cipher Lab is where you design complete AI systems, build production evidence, specialize, handle incidents, and defend your reasoning aloud."
          : "The campaign taught the tools under pressure. Forge Lab is where you design without a script, build outside the simulator, and prove the same skills in a production language."}
      />

      <section className="mt-8 grid gap-5 lg:grid-cols-3">
        {stations.map((station) => (
          <Link
            key={station.to}
            to={station.to}
            className="hud-panel corner-cut group flex min-h-[320px] flex-col p-6 transition-transform hover:-translate-y-1"
          >
            <div className="flex items-center justify-between">
              <span className="grid h-12 w-12 place-items-center border border-primary/50 bg-primary/10 text-primary">
                <station.icon className="h-6 w-6" />
              </span>
              <span className="label-mono text-telemetry">{station.label}</span>
            </div>
            <h2 className="mt-5 font-display text-xl text-foreground">{station.title}</h2>
            <p className="mt-3 flex-1 text-sm leading-6 text-muted-foreground">{station.description}</p>
            <div className="mt-5">
              <XPBar value={station.value} max={station.max} label="Progress" />
              <p className="label-mono mt-2">{station.meta}</p>
            </div>
            <span className="mt-5 flex items-center gap-2 font-display text-sm tracking-wider text-primary uppercase">
              Enter station <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
            </span>
          </Link>
        ))}
      </section>

      <section className="hud-panel corner-cut mt-6 flex flex-wrap items-center justify-between gap-5 p-5">
        <div className="flex items-start gap-3">
          <Layers3 className="mt-0.5 h-5 w-5 text-telemetry" />
          <div>
            <h2 className="font-display text-base text-foreground">Core mastery remains on the World Map</h2>
            <p className="mt-1 max-w-2xl text-sm text-muted-foreground">
              {isAi
                ? "The 432-mission journey stays in the campaign engine. Freeform designs, external builds, specializations, incident notes, and interview answers keep purpose-built progress here."
                : "Messaging, GraphQL, and database mastery are structured lessons, so they stay in the mission engine. These three stations use purpose-built progress instead."}
            </p>
          </div>
        </div>
        <Link to="/map" className="label-mono text-primary hover:underline">Open World Map →</Link>
      </section>
    </div>
  );
}
