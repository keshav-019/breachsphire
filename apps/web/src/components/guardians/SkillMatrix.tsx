import { Bug, Fingerprint, Network, ShieldCheck, KeyRound, Cpu } from "lucide-react";

const skills = [
  { icon: Network, name: "Network Recon", level: 4, max: 5, pct: 78, tone: "telemetry" },
  { icon: Bug, name: "Malware Analysis", level: 3, max: 5, pct: 52, tone: "signal" },
  { icon: Fingerprint, name: "Digital Forensics", level: 3, max: 5, pct: 44, tone: "telemetry" },
  { icon: KeyRound, name: "Cryptography", level: 2, max: 5, pct: 30, tone: "signal" },
  { icon: ShieldCheck, name: "Blue Team Defense", level: 4, max: 5, pct: 84, tone: "telemetry" },
  { icon: Cpu, name: "Hardware & OT", level: 1, max: 5, pct: 16, tone: "signal" },
];

export function SkillMatrix() {
  return (
    <section className="border-y border-border bg-surface/30">
      <div className="mx-auto max-w-7xl px-5 py-16">
        <div className="flex flex-wrap items-end justify-between gap-4">
          <div>
            <span className="label-mono text-telemetry">Agent dossier</span>
            <h2 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">Capability matrix</h2>
          </div>
          <p className="max-w-sm text-sm text-muted-foreground">
            Every action in the field feeds your dossier. Reach level 5 in any discipline to unlock
            specialist contracts.
          </p>
        </div>

        <div className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {skills.map((s) => (
            <article key={s.name} className="hud-panel corner-cut p-5">
              <div className="flex items-center gap-3">
                <s.icon
                  className={`h-5 w-5 ${s.tone === "signal" ? "text-primary" : "text-telemetry"}`}
                />
                <h3 className="font-display text-base text-foreground">{s.name}</h3>
                <span className="label-mono ml-auto">
                  LV {s.level}/{s.max}
                </span>
              </div>
              <div className="mt-4 h-1.5 w-full overflow-hidden bg-muted">
                <div
                  className="h-full"
                  style={{
                    width: `${s.pct}%`,
                    background:
                      s.tone === "signal" ? "var(--gradient-signal)" : "var(--gradient-telemetry)",
                  }}
                />
              </div>
              <div className="mt-3 flex gap-1">
                {Array.from({ length: s.max }).map((_, i) => (
                  <span
                    key={i}
                    className={`h-1 flex-1 ${i < s.level ? "bg-foreground/50" : "bg-border"}`}
                  />
                ))}
              </div>
            </article>
          ))}
        </div>
      </div>
    </section>
  );
}
