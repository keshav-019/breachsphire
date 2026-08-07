import { AlertTriangle, Clock, Play, Terminal, Users } from "lucide-react";
import opsCenter from "@/assets/ops-center.jpg";

export function MissionBriefing() {
  return (
    <section className="relative overflow-hidden border-b border-border">
      <img
        src={opsCenter}
        alt="Cyber Guardians operations center tracking a live global intrusion"
        width={1600}
        height={912}
        className="absolute inset-0 h-full w-full object-cover opacity-35"
      />
      <div className="absolute inset-0 bg-gradient-to-t from-background via-background/85 to-background/40" />
      <div className="hud-grid absolute inset-0 opacity-70" />

      <div className="relative mx-auto grid max-w-7xl gap-10 px-5 py-16 lg:grid-cols-[1.35fr_1fr] lg:py-24">
        <div>
          <div className="flex items-center gap-3">
            <span className="pulse-ring inline-block h-2 w-2 rounded-full bg-threat" />
            <span className="label-mono text-threat">Live incident · Severity 4</span>
          </div>

          <h1 className="mt-5 max-w-2xl text-4xl leading-[1.05] font-bold text-foreground sm:text-6xl">
            The grid is under attack.
            <span className="block text-primary">You have been activated.</span>
          </h1>

          <p className="mt-5 max-w-xl text-base text-muted-foreground sm:text-lg">
            03:14 local. A supply-chain implant is beaconing out of Meridian Power&apos;s SCADA
            network. Trace it, contain it, and get the city&apos;s lights back before the next
            handshake window closes.
          </p>

          <div className="mt-8 flex flex-wrap items-center gap-3">
            <button className="corner-cut group inline-flex items-center gap-2 bg-primary px-6 py-3.5 font-display text-sm font-semibold tracking-[0.12em] text-primary-foreground uppercase transition-transform hover:scale-[1.02] glow-signal">
              <Play className="h-4 w-4 fill-current" />
              Deploy to mission
            </button>
            <button className="corner-cut inline-flex items-center gap-2 border border-border bg-surface/60 px-5 py-3.5 font-display text-sm tracking-[0.12em] text-foreground uppercase transition-colors hover:border-telemetry hover:text-telemetry">
              <Terminal className="h-4 w-4" />
              Read intel dossier
            </button>
          </div>

          <div className="mt-8 flex flex-wrap gap-x-8 gap-y-3">
            {[
              { icon: Clock, label: "Est. 22 min" },
              { icon: Users, label: "9,412 agents deployed" },
              { icon: AlertTriangle, label: "Failure resets containment" },
            ].map((m) => (
              <div key={m.label} className="flex items-center gap-2">
                <m.icon className="h-3.5 w-3.5 text-telemetry" />
                <span className="label-mono">{m.label}</span>
              </div>
            ))}
          </div>
        </div>

        <aside className="hud-panel corner-cut scanline relative self-start p-6">
          <div className="flex items-center justify-between">
            <span className="label-mono text-telemetry">Mission file</span>
            <span className="font-mono text-[0.65rem] text-primary">OP-2291 // BLACKOUT</span>
          </div>

          <div className="mt-5 space-y-4">
            {[
              { k: "Sector", v: "Meridian Power — OT Network" },
              { k: "Adversary", v: "Cluster: HOLLOW TIDE" },
              { k: "Objective", v: "Isolate implant, preserve logs" },
              { k: "Rules of engagement", v: "No production downtime" },
            ].map((row) => (
              <div key={row.k} className="border-b border-border/60 pb-3 last:border-0">
                <div className="label-mono">{row.k}</div>
                <div className="mt-1 font-display text-sm text-foreground">{row.v}</div>
              </div>
            ))}
          </div>

          <div className="mt-6">
            <div className="flex items-center justify-between">
              <span className="label-mono">Containment window</span>
              <span className="font-mono text-xs text-primary">61%</span>
            </div>
            <div className="mt-2 h-1.5 w-full overflow-hidden bg-muted">
              <div
                className="h-full"
                style={{ width: "61%", background: "var(--gradient-signal)" }}
              />
            </div>
          </div>

          <div className="mt-6 overflow-hidden bg-background/70 p-3 font-mono text-[0.7rem] leading-relaxed text-telemetry">
            <div>$ nmap -sS 10.42.7.0/24 --open</div>
            <div className="text-muted-foreground">
              [+] 10.42.7.19 : 502/tcp modbus <span className="text-threat">ANOMALY</span>
            </div>
            <div className="text-muted-foreground">[+] beacon interval ≈ 300s</div>
            <div className="flicker">_</div>
          </div>
        </aside>
      </div>
    </section>
  );
}
