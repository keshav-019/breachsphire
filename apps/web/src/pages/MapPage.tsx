import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { Lock, Skull, Play, Globe as GlobeIcon } from "lucide-react";
import { fetchPathways, fetchWorlds, type World } from "@/lib/api";
import { usePathwayStore } from "@/store/pathway";
import { WorldNode } from "@/components/guardians/WorldNode";
import { ThreatLevelPill } from "@/components/guardians/ThreatLevelPill";
import { XPBar } from "@/components/guardians/XPBar";
import { PathwayGlobe, type GlobeMarker } from "@/components/guardians/PathwayGlobe";

/** World x/y are a 0-100 placeholder grid (see the worlds migration) --
 * projected onto the globe as lon/lat so every world gets a stable,
 * deterministic position instead of a random one. */
function worldToLatLon(w: World) {
  return { lon: (w.x / 100) * 360 - 180, lat: 90 - (w.y / 100) * 180 };
}

/** Shown instead of a hard redirect when no pathway is selected yet -- the
 * globe doubles as the picker so landing on /map "empty" never happens. */
function NoPathwaySelected() {
  const navigate = useNavigate();
  const setPathway = usePathwayStore((s) => s.setPathway);
  const { data: pathways, isLoading, error } = useQuery({ queryKey: ["pathways"], queryFn: fetchPathways });

  const markers: GlobeMarker[] = (pathways ?? []).map((p, i) => {
    const angle = (360 / Math.max(pathways?.length ?? 1, 1)) * i;
    return {
      id: p.id,
      label: p.title,
      lat: 25 * Math.sin((i * 47 * Math.PI) / 180),
      lon: angle,
      tone: "primary",
      onClick: () => {
        setPathway(p);
        navigate("/");
      },
    };
  });

  return (
    <div className="px-5 py-8">
      <div className="mx-auto max-w-2xl text-center">
        <span className="label-mono text-primary">Nexus // No Active Uplink</span>
        <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">Pick a front to open the chart.</h1>
        <p className="mt-2 text-sm text-muted-foreground">
          Every glowing marker is a live pathway. Select one to load its sector chart.
        </p>
      </div>

      <div className="hud-panel corner-cut scanline hud-grid mx-auto mt-8 max-w-3xl overflow-hidden py-10">
        {isLoading ? (
          <div className="grid h-[300px] place-items-center">
            <span className="label-mono flicker">Scanning the grid…</span>
          </div>
        ) : error || !pathways ? (
          <div className="grid h-[300px] place-items-center">
            <span className="label-mono text-threat">Failed to reach the pathway registry.</span>
          </div>
        ) : (
          <PathwayGlobe markers={markers} radius={140} />
        )}
      </div>

      <div className="mt-6 flex justify-center">
        <Link
          to="/pathways"
          className="corner-cut flex items-center gap-2 border border-border bg-surface px-5 py-3 font-display text-sm tracking-[0.12em] text-foreground uppercase transition-colors hover:border-primary/60 hover:text-primary"
        >
          <GlobeIcon className="h-4 w-4" />
          Browse pathway list instead
        </Link>
      </div>
    </div>
  );
}

export default function MapPage() {
  const pathwayId = usePathwayStore((s) => s.selectedPathwayId);
  const pathwaySlug = usePathwayStore((s) => s.selectedPathwaySlug);
  const {
    data: worlds,
    isLoading,
    error,
  } = useQuery({
    queryKey: ["worlds", pathwayId],
    queryFn: () => fetchWorlds(pathwayId!),
    enabled: Boolean(pathwayId),
  });

  const [selectedId, setSelectedId] = useState<string | null>(null);

  useEffect(() => {
    if (worlds && selectedId === null) {
      const initial = worlds.find((w) => w.state !== "locked") ?? worlds[0];
      setSelectedId(initial?.id ?? null);
    }
  }, [worlds, selectedId]);

  if (!pathwayId) {
    return <NoPathwaySelected />;
  }

  if (isLoading) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono flicker">Establishing uplink to the grid…</span>
      </div>
    );
  }

  if (error || !worlds || worlds.length === 0) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono text-threat">Failed to load the campaign map.</span>
      </div>
    );
  }

  const byId = Object.fromEntries(worlds.map((w) => [w.id, w]));
  const worldPaths: [string, string][] = worlds.slice(0, -1).map((w, i) => [w.id, worlds[i + 1]!.id]);
  const selected = byId[selectedId ?? ""] ?? worlds[0]!;
  const cleared = worlds.filter((w) => w.state === "cleared").length;

  const globeMarkers: GlobeMarker[] = worlds.map((w) => {
    const { lat, lon } = worldToLatLon(w);
    return {
      id: w.id,
      label: w.short,
      lat,
      lon,
      size: "sm",
      tone: w.state === "locked" ? "telemetry" : "threat",
      onClick: () => setSelectedId(w.id),
    };
  });

  return (
    <div className="px-5 py-8">
      <div className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <span className="label-mono text-primary">Sector chart · {worlds.length} worlds</span>
          <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">The Grid</h1>
          <p className="mt-2 max-w-xl text-sm text-muted-foreground">
            Every world is a live front. Clear a node to open the routes beyond it.
          </p>
        </div>
        <div className="hud-panel corner-cut w-64 p-4">
          <XPBar value={cleared} max={worlds.length} label="Worlds secured" />
        </div>
      </div>

      <div className="hud-panel corner-cut scanline hud-grid mt-6 overflow-hidden py-8">
        <div className="mb-3 text-center">
          <span className="label-mono text-telemetry">Live theater · red markers are active fronts</span>
        </div>
        <PathwayGlobe markers={globeMarkers} radius={120} spinSpeed={7} />
      </div>

      <div className="mt-8 grid gap-6 xl:grid-cols-[1fr_320px]">
        <div data-testid="world-map-canvas" className="hud-panel corner-cut hud-grid scanline relative overflow-x-auto">
          <div className="relative h-[620px] min-w-[1100px]">
            <svg className="absolute inset-0 h-full w-full" aria-hidden="true">
              {worldPaths.map(([a, b]) => {
                const wa = byId[a]!;
                const wb = byId[b]!;
                const locked = wb.state === "locked";
                return (
                  <line
                    key={`${a}-${b}`}
                    x1={`${wa.x}%`}
                    y1={`${wa.y}%`}
                    x2={`${wb.x}%`}
                    y2={`${wb.y}%`}
                    stroke={locked ? "var(--border)" : "var(--telemetry)"}
                    strokeOpacity={locked ? 0.6 : 0.5}
                    strokeWidth={2}
                    strokeDasharray={locked ? "4 6" : undefined}
                  />
                );
              })}
            </svg>

            {worlds.map((w) => (
              <div
                key={w.id}
                className="absolute -translate-x-1/2 -translate-y-1/2"
                style={{ left: `${w.x}%`, top: `${w.y}%` }}
              >
                <WorldNode world={w} selected={selected.id === w.id} onSelect={(w) => setSelectedId(w.id)} />
              </div>
            ))}
          </div>
        </div>

        <aside className="hud-panel corner-cut h-fit p-6">
          <div className="flex items-center gap-3">
            <span className="grid h-12 w-12 place-items-center rounded-full border-2 border-primary/60 bg-primary/10 text-primary">
              <selected.icon className="h-6 w-6" />
            </span>
            <div>
              <div className="label-mono">World {worlds.indexOf(selected) + 1} / {worlds.length}</div>
              <h2 className="font-display text-lg leading-tight text-foreground">
                {selected.name}
              </h2>
            </div>
          </div>

          <div className="mt-4 flex flex-wrap items-center gap-2">
            <ThreatLevelPill level={selected.threat} />
            {selected.boss && (
              <span className="inline-flex items-center gap-1.5 border border-threat/50 bg-threat/10 px-2 py-0.5 font-mono text-[0.6rem] tracking-[0.16em] text-threat uppercase">
                <Skull className="h-3 w-3" />
                {selected.boss}
              </span>
            )}
          </div>

          <div className="mt-5">
            <XPBar value={selected.completion} max={100} label="Completion" showNumbers={false} />
            <div className="label-mono mt-2">{selected.completion}% secured</div>
          </div>

          <div className="mt-6 space-y-3 border-t border-border/60 pt-5">
            {[
              { k: "Status", v: selected.state },
              { k: "Operations", v: pathwaySlug === "cyber-guardians" ? "Mission chain · boss protocol" : "12 missions · 1 boss" },
              { k: "Reward track", v: pathwaySlug === "cyber-guardians" ? "Cosmetic + skill node" : "Skill XP + Act badge" },
            ].map((r) => (
              <div key={r.k} className="flex items-baseline justify-between gap-3">
                <span className="label-mono">{r.k}</span>
                <span
                  data-testid={r.k === "Status" ? "world-status" : undefined}
                  className="font-display text-sm text-foreground capitalize"
                >
                  {r.v}
                </span>
              </div>
            ))}
          </div>

          {selected.state === "locked" ? (
            <div className="corner-cut mt-6 flex items-center justify-center gap-2 border border-border bg-surface py-3 font-display text-sm tracking-[0.12em] text-muted-foreground uppercase">
              <Lock className="h-4 w-4" />
              Clearance required
            </div>
          ) : (
            <Link
              to={`/worlds/${selected.id}`}
              className="corner-cut mt-6 flex items-center justify-center gap-2 bg-primary py-3 font-display text-sm tracking-[0.12em] text-primary-foreground uppercase glow-signal transition-transform hover:scale-[1.02]"
            >
              <Play className="h-4 w-4 fill-current" />
              Enter world
            </Link>
          )}
        </aside>
      </div>
    </div>
  );
}
