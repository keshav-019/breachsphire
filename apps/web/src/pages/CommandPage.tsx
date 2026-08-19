import { Link, useNavigate } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { ChevronRight, Coins, Lock, Play, Satellite, ShieldHalf, Skull, Zap } from "lucide-react";
import { fetchMe, fetchPathways, fetchWorlds, type World } from "@/lib/api";
import { rankDisplay } from "@/lib/rank";
import { usePathwayStore } from "@/store/pathway";
import { StatTile } from "@/components/guardians/StatTile";
import { ThreatLevelPill } from "@/components/guardians/ThreatLevelPill";
import { XPBar } from "@/components/guardians/XPBar";

/** Picks the world the player should pick up where they left off: an
 * in-progress world first, otherwise the earliest unlocked-but-unstarted
 * one. `null` once every unlocked world is cleared. */
function findContinueWorld(worlds: World[]): World | null {
  return worlds.find((w) => w.state === "active") ?? worlds.find((w) => w.state === "unlocked") ?? null;
}

/** Purely flavor text for the footer -- keyed by pathway slug (not id, so
 * it degrades gracefully if a pathway's id ever changes). */
const PATHWAY_FLAVOR: Record<string, { division: string; node: string }> = {
  "cyber-guardians": { division: "Ops Division", node: "Node 07" },
  "backend-engineering": { division: "Forge Division", node: "Node 12" },
  "ai-ml": { division: "Cipher Division", node: "Node 03" },
  "robotics-iot": { division: "Vector Division", node: "Node 19" },
  "cloud-devops-sre": { division: "Atlas Division", node: "Node 24" },
};

/** Shown instead of a hard redirect when no pathway is selected yet. */
function NoPathwaySelected() {
  const navigate = useNavigate();
  const setPathway = usePathwayStore((s) => s.setPathway);
  const { data: pathways, isLoading, error } = useQuery({ queryKey: ["pathways"], queryFn: fetchPathways });

  return (
    <div className="px-5 py-8">
      <span className="label-mono text-primary">Nexus // No Active Uplink</span>
      <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">No operation in progress.</h1>
      <p className="mt-2 max-w-xl text-sm text-muted-foreground">
        Command needs a live pathway to report on. Pick one to bring this terminal back online.
      </p>

      {isLoading ? (
        <div className="mt-8">
          <span className="label-mono flicker">Scanning available fronts…</span>
        </div>
      ) : error || !pathways ? (
        <div className="mt-8">
          <span className="label-mono text-threat">Failed to reach the pathway registry.</span>
        </div>
      ) : (
        <div className="mt-8 grid gap-4 sm:grid-cols-2">
          {pathways.map((p) => {
            const Icon = p.icon;
            return (
              <button
                key={p.id}
                type="button"
                onClick={() => {
                  setPathway(p);
                  navigate("/");
                }}
                className="hud-panel corner-cut scanline group flex items-center gap-3 p-4 text-left transition-transform hover:scale-[1.01]"
              >
                <span className="grid h-11 w-11 shrink-0 place-items-center rounded-full border-2 border-primary/60 bg-primary/10 text-primary">
                  <Icon className="h-5 w-5" />
                </span>
                <span className="min-w-0 flex-1">
                  <span className="block font-display text-base text-foreground">{p.title}</span>
                  <span className="label-mono block truncate text-telemetry">{p.tagline}</span>
                </span>
                <ChevronRight className="h-4 w-4 shrink-0 text-muted-foreground transition-transform group-hover:translate-x-0.5" />
              </button>
            );
          })}
        </div>
      )}

      <Link to="/pathways" className="label-mono mt-6 inline-flex items-center gap-2 text-primary hover:underline">
        <Satellite className="h-3.5 w-3.5" />
        View full pathway roster
      </Link>
    </div>
  );
}

export default function CommandPage() {
  const pathwayId = usePathwayStore((s) => s.selectedPathwayId);
  const pathwaySlug = usePathwayStore((s) => s.selectedPathwaySlug);
  const pathwayTitle = usePathwayStore((s) => s.selectedPathwayTitle);
  const flavor = (pathwaySlug ? PATHWAY_FLAVOR[pathwaySlug] : undefined) ?? { division: "Ops Division", node: "Node 07" };
  const { data: me, isLoading: meLoading } = useQuery({ queryKey: ["me"], queryFn: fetchMe, enabled: Boolean(pathwayId) });
  const {
    data: worlds,
    isLoading: worldsLoading,
    error,
  } = useQuery({
    queryKey: ["worlds", pathwayId],
    queryFn: () => fetchWorlds(pathwayId!),
    enabled: Boolean(pathwayId),
  });

  if (!pathwayId) {
    return <NoPathwaySelected />;
  }

  if (meLoading || worldsLoading) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono flicker">Establishing uplink…</span>
      </div>
    );
  }

  if (error || !worlds) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono text-threat">Failed to reach Ops Division systems.</span>
      </div>
    );
  }

  const cleared = worlds.filter((w) => w.state === "cleared").length;
  const active = worlds.filter((w) => w.state === "active").length;
  const unlocked = worlds.filter((w) => w.state === "unlocked");
  const rank = rankDisplay(me?.rank ?? "recruit");
  const continueWorld = findContinueWorld(worlds);
  const upNext = unlocked.filter((w) => w.id !== continueWorld?.id).slice(0, 4);

  return (
    <div className="px-5 py-8">
      <div>
        <span className="label-mono text-primary">
          {flavor.division} // {flavor.node}
        </span>
        <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">
          Welcome back, {me?.displayName ?? "Agent"}.
        </h1>
        <p className="mt-2 max-w-xl text-sm text-muted-foreground">
          {cleared} of {worlds.length} worlds secured. The grid is waiting on you.
        </p>
      </div>

      <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <StatTile icon={ShieldHalf} label="Clearance" value={rank.clearance} sub={rank.title} tone="signal" />
        <StatTile icon={Zap} label="Experience" value={(me?.xp ?? 0).toLocaleString()} tone="telemetry" />
        <StatTile icon={Coins} label="Credits" value={(me?.credits ?? 0).toLocaleString()} tone="telemetry" />
        <StatTile
          icon={Skull}
          label="Worlds secured"
          value={`${cleared} / ${worlds.length}`}
          sub={active > 0 ? `${active} in progress` : undefined}
          tone="signal"
        />
      </div>

      <div className="mt-8 grid gap-6 lg:grid-cols-[1fr_320px]">
        <section className="hud-panel corner-cut scanline p-6">
          <span className="label-mono text-primary">Continue operations</span>
          {continueWorld ? (
            <>
              <div className="mt-4 flex items-center gap-3">
                <span className="grid h-12 w-12 place-items-center rounded-full border-2 border-primary/60 bg-primary/10 text-primary">
                  <continueWorld.icon className="h-6 w-6" />
                </span>
                <div>
                  <div className="label-mono">
                    World {worlds.indexOf(continueWorld) + 1} / {worlds.length}
                  </div>
                  <h2 className="font-display text-lg leading-tight text-foreground">{continueWorld.name}</h2>
                </div>
              </div>

              <div className="mt-4 flex flex-wrap items-center gap-2">
                <ThreatLevelPill level={continueWorld.threat} />
                {continueWorld.boss && (
                  <span className="inline-flex items-center gap-1.5 border border-threat/50 bg-threat/10 px-2 py-0.5 font-mono text-[0.6rem] tracking-[0.16em] text-threat uppercase">
                    <Skull className="h-3 w-3" />
                    {continueWorld.boss}
                  </span>
                )}
              </div>

              <div className="mt-5 max-w-sm">
                <XPBar value={continueWorld.completion} max={100} label="Completion" showNumbers={false} />
                <div className="label-mono mt-2">{continueWorld.completion}% secured</div>
              </div>

              <Link
                to={`/worlds/${continueWorld.id}`}
                className="corner-cut mt-6 flex w-fit items-center justify-center gap-2 bg-primary px-5 py-3 font-display text-sm tracking-[0.12em] text-primary-foreground uppercase glow-signal transition-transform hover:scale-[1.02]"
              >
                <Play className="h-4 w-4 fill-current" />
                {continueWorld.state === "active" ? "Resume" : "Deploy"}
              </Link>
            </>
          ) : (
            <div className="mt-4 text-sm text-muted-foreground">
              {worlds.length > 0 && cleared === worlds.length
                ? "Every world is secured. The campaign is complete — for now."
                : "No world is currently unlocked. Check the World Map for what's next."}
            </div>
          )}
        </section>

        <aside className="hud-panel corner-cut h-fit p-5">
          <span className="label-mono text-telemetry">Up next</span>
          {upNext.length > 0 ? (
            <ul className="mt-4 space-y-2">
              {upNext.map((w) => (
                <li key={w.id}>
                  <Link
                    to={`/worlds/${w.id}`}
                    className="flex items-center gap-3 border border-border p-2.5 text-left transition-colors hover:border-border/60 hover:bg-surface-raised/40"
                  >
                    <w.icon className="h-4 w-4 shrink-0 text-muted-foreground" />
                    <span className="min-w-0 flex-1 truncate text-sm text-foreground">{w.short}</span>
                    <ThreatLevelPill level={w.threat} />
                  </Link>
                </li>
              ))}
            </ul>
          ) : (
            <div className="mt-4 flex items-center gap-2 text-sm text-muted-foreground">
              <Lock className="h-4 w-4 shrink-0" />
              Nothing else is unlocked yet.
            </div>
          )}
          <Link to="/map" className="label-mono mt-4 block text-primary hover:underline">
            View full sector chart →
          </Link>
        </aside>
      </div>

      <footer className="mt-10 border-t border-border py-8">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <span className="label-mono">
            {pathwayTitle ?? "Cyber Guardians"} · {flavor.division} · {flavor.node}
          </span>
          <span className="label-mono text-telemetry">All systems nominal</span>
        </div>
      </footer>
    </div>
  );
}
