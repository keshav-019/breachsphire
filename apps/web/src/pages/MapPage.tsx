import { useState } from "react";
import { Link } from "react-router-dom";
import { Lock, Skull, Play } from "lucide-react";
import { WORLDS, WORLD_PATHS, type World } from "@/lib/game-data";
import { WorldNode } from "@/components/guardians/WorldNode";
import { ThreatLevelPill } from "@/components/guardians/ThreatLevelPill";
import { XPBar } from "@/components/guardians/XPBar";

const byId = Object.fromEntries(WORLDS.map((w) => [w.id, w]));

export default function MapPage() {
  const [selected, setSelected] = useState<World>(byId["windows"]!);
  const cleared = WORLDS.filter((w) => w.state === "cleared").length;

  return (
    <div className="px-5 py-8">
      <div className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <span className="label-mono text-primary">Sector chart · 20 worlds</span>
          <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">The Grid</h1>
          <p className="mt-2 max-w-xl text-sm text-muted-foreground">
            Every world is a live front. Clear a node to open the routes beyond it.
          </p>
        </div>
        <div className="hud-panel corner-cut w-64 p-4">
          <XPBar value={cleared} max={WORLDS.length} label="Worlds secured" />
        </div>
      </div>

      <div className="mt-8 grid gap-6 xl:grid-cols-[1fr_320px]">
        <div className="hud-panel corner-cut hud-grid scanline relative overflow-x-auto">
          <div className="relative h-[620px] min-w-[1100px]">
            <svg className="absolute inset-0 h-full w-full" aria-hidden="true">
              {WORLD_PATHS.map(([a, b]) => {
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

            {WORLDS.map((w) => (
              <div
                key={w.id}
                className="absolute -translate-x-1/2 -translate-y-1/2"
                style={{ left: `${w.x}%`, top: `${w.y}%` }}
              >
                <WorldNode world={w} selected={selected.id === w.id} onSelect={setSelected} />
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
              <div className="label-mono">World {WORLDS.indexOf(selected) + 1} / 20</div>
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
              { k: "Operations", v: "8 missions · 3 drills" },
              { k: "Reward track", v: "Cosmetic + skill node" },
            ].map((r) => (
              <div key={r.k} className="flex items-baseline justify-between gap-3">
                <span className="label-mono">{r.k}</span>
                <span className="font-display text-sm text-foreground capitalize">{r.v}</span>
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
              to="/mission"
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
