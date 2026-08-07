import { Flame, Radio, Trophy } from "lucide-react";

const squad = [
  { rank: "01", tag: "V3CTOR", clearance: "V", xp: "48,120", streak: 96 },
  { rank: "02", tag: "HALCYON", clearance: "V", xp: "44,905", streak: 71 },
  { rank: "03", tag: "NOVA", clearance: "III", xp: "12,480", streak: 17, you: true },
  { rank: "04", tag: "DRIFTWOOD", clearance: "III", xp: "11,204", streak: 12 },
  { rank: "05", tag: "KESTREL", clearance: "II", xp: "9,860", streak: 8 },
];

const week = ["M", "T", "W", "T", "F", "S", "S"];
const done = [true, true, true, true, true, false, false];

export function SquadOps() {
  return (
    <section className="mx-auto grid max-w-7xl gap-6 px-5 py-16 lg:grid-cols-[1.2fr_1fr]">
      <div className="hud-panel corner-cut p-6">
        <div className="flex items-center gap-3">
          <Trophy className="h-4 w-4 text-primary" />
          <h2 className="font-display text-lg text-foreground">Squad standings — Cell 07</h2>
          <span className="label-mono ml-auto">Resets in 3d 04h</span>
        </div>

        <ul className="mt-6 divide-y divide-border/60">
          {squad.map((a) => (
            <li
              key={a.tag}
              className={`flex items-center gap-4 py-3 ${a.you ? "bg-primary/8 px-3" : ""}`}
            >
              <span className="font-mono text-sm text-muted-foreground">{a.rank}</span>
              <span className="corner-cut grid h-8 w-8 place-items-center bg-muted font-display text-xs text-foreground">
                {a.tag.slice(0, 2)}
              </span>
              <div className="min-w-0">
                <div className="font-display text-sm text-foreground">
                  {a.tag}
                  {a.you && <span className="ml-2 label-mono text-primary">you</span>}
                </div>
                <div className="label-mono mt-0.5">Clearance {a.clearance}</div>
              </div>
              <div className="ml-auto flex items-center gap-5">
                <span className="flex items-center gap-1 font-mono text-xs text-primary">
                  <Flame className="h-3.5 w-3.5" />
                  {a.streak}
                </span>
                <span className="font-mono text-sm text-telemetry">{a.xp}</span>
              </div>
            </li>
          ))}
        </ul>
      </div>

      <div className="space-y-6">
        <div className="hud-panel corner-cut p-6">
          <div className="flex items-center gap-3">
            <Flame className="h-4 w-4 text-primary" />
            <h2 className="font-display text-lg text-foreground">Duty streak</h2>
          </div>
          <p className="mt-2 text-sm text-muted-foreground">
            Log one contact with the field per day. Miss two and your clearance goes under review.
          </p>
          <div className="mt-5 flex gap-2">
            {week.map((d, i) => (
              <div key={i} className="flex-1 text-center">
                <div
                  className={`grid h-10 place-items-center border ${
                    done[i]
                      ? "border-primary/60 bg-primary/20 text-primary"
                      : "border-border bg-surface text-muted-foreground"
                  }`}
                >
                  <span className="font-mono text-xs">{d}</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="hud-panel corner-cut relative overflow-hidden p-6">
          <div className="pointer-events-none absolute inset-y-0 w-24 bg-gradient-to-r from-transparent via-telemetry/10 to-transparent sweep-line" />
          <div className="flex items-center gap-3">
            <Radio className="h-4 w-4 text-telemetry" />
            <h2 className="font-display text-lg text-foreground">Daily drill</h2>
          </div>
          <p className="mt-2 text-sm text-muted-foreground">
            90 seconds. One suspicious log line. Call it: benign or breach.
          </p>
          <div className="mt-4 bg-background/70 p-3 font-mono text-[0.7rem] text-telemetry">
            Aug 07 02:11:44 svc-auth sshd[2291]: Accepted password for root from 45.9.148.x
          </div>
          <button className="corner-cut mt-5 w-full bg-telemetry py-3 font-display text-sm tracking-[0.12em] text-accent-foreground uppercase transition-transform hover:scale-[1.01] glow-telemetry">
            Run drill
          </button>
        </div>
      </div>
    </section>
  );
}
