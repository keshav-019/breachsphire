import { Award, Flame, Shield, Target, Timer, Zap } from "lucide-react";
import { CharacterAvatar } from "@/components/guardians/CharacterAvatar";
import { RankBadge } from "@/components/guardians/RankBadge";
import { SkillProgressBar } from "@/components/guardians/SkillProgressBar";
import { StatTile } from "@/components/guardians/StatTile";
import { XPBar } from "@/components/guardians/XPBar";
import { AchievementCard } from "@/components/guardians/AchievementCard";
import { ACHIEVEMENTS, RANKS, SKILL_TRACKS } from "@/lib/game-data";
import { cn } from "@/lib/utils";

export default function ProfilePage() {
  return (
    <div className="px-5 py-8">
      <section className="hud-panel corner-cut scanline relative flex flex-wrap items-center gap-6 p-6">
        <CharacterAvatar tag="NOVA" size="xl" tone="signal" online />
        <div className="min-w-0 flex-1">
          <h1 className="text-3xl font-bold text-foreground">AGENT NOVA</h1>
          <div className="mt-3 flex flex-wrap items-center gap-2">
            <RankBadge clearance="III" title="Nightfall Operative" />
            <span className="label-mono">Cell 07 · Enlisted 214 days ago</span>
          </div>
          <div className="mt-5 max-w-md">
            <XPBar value={12480} max={35000} label="Progress to Clearance IV" />
          </div>
        </div>
      </section>

      <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <StatTile icon={Target} label="Missions cleared" value="63" sub="4 apex targets" tone="signal" />
        <StatTile icon={Flame} label="Duty streak" value="17 days" sub="best: 34" tone="signal" />
        <StatTile icon={Timer} label="Field time" value="41h 12m" />
        <StatTile icon={Shield} label="Containment rate" value="94%" />
      </div>

      <section className="mt-10">
        <h2 className="text-2xl font-bold text-foreground">Rank progression</h2>
        <ol className="mt-6 grid gap-4 md:grid-cols-5">
          {RANKS.map((r) => (
            <li
              key={r.name}
              className={cn(
                "hud-panel corner-cut p-4",
                r.state === "current" && "border-primary/60 glow-signal",
                r.state === "locked" && "opacity-60",
              )}
            >
              <div className="label-mono">Clearance {r.clearance}</div>
              <div className="mt-2 font-display text-sm text-foreground">{r.name}</div>
              <div className="mt-3 font-mono text-xs text-telemetry">{r.xp} XP</div>
              <div
                className={cn(
                  "mt-3 h-1",
                  r.state === "locked" ? "bg-border" : "bg-primary/70",
                )}
              />
            </li>
          ))}
        </ol>
      </section>

      <section className="mt-10">
        <div className="flex flex-wrap items-end justify-between gap-3">
          <h2 className="text-2xl font-bold text-foreground">Capability matrix</h2>
          <span className="label-mono">14 tracks</span>
        </div>
        <div className="mt-6 grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {SKILL_TRACKS.map((s, i) => (
            <div key={s.name} className="hud-panel corner-cut p-4">
              <SkillProgressBar {...s} tone={i % 2 ? "signal" : "telemetry"} />
            </div>
          ))}
        </div>
      </section>

      <section className="mt-10 grid gap-6 lg:grid-cols-[1fr_320px]">
        <div>
          <h2 className="text-2xl font-bold text-foreground">Recent commendations</h2>
          <div className="mt-6 grid gap-4 sm:grid-cols-2">
            {ACHIEVEMENTS.filter((a) => a.unlocked)
              .slice(0, 4)
              .map((a) => (
                <AchievementCard key={a.id} achievement={a} />
              ))}
          </div>
        </div>

        <aside className="space-y-4">
          <div className="hud-panel corner-cut p-5">
            <div className="flex items-center gap-2">
              <Award className="h-4 w-4 text-primary" />
              <span className="label-mono text-primary">Titles</span>
            </div>
            <ul className="mt-3 space-y-2">
              {["Nightfall Operative", "Packet Whisperer", "Citadel Breaker", "Log Diver"].map(
                (t, i) => (
                  <li
                    key={t}
                    className={cn(
                      "border px-3 py-2 font-display text-sm",
                      i === 0
                        ? "border-primary/50 bg-primary/10 text-primary"
                        : "border-border text-muted-foreground",
                    )}
                  >
                    {t}
                    {i === 0 && <span className="label-mono ml-2">equipped</span>}
                  </li>
                ),
              )}
            </ul>
          </div>

          <div className="hud-panel corner-cut p-5">
            <div className="flex items-center gap-2">
              <Zap className="h-4 w-4 text-telemetry" />
              <span className="label-mono text-telemetry">Equipped cosmetics</span>
            </div>
            <ul className="mt-3 space-y-2 text-sm">
              {[
                { k: "Avatar frame", v: "Nightfall Chrome" },
                { k: "Terminal theme", v: "Amber Signal" },
                { k: "Callsign glyph", v: "Sable Wing" },
                { k: "Banner", v: "Grid Under Siege" },
              ].map((c) => (
                <li key={c.k} className="flex items-baseline justify-between gap-3">
                  <span className="label-mono">{c.k}</span>
                  <span className="font-display text-foreground">{c.v}</span>
                </li>
              ))}
            </ul>
          </div>
        </aside>
      </section>
    </div>
  );
}
