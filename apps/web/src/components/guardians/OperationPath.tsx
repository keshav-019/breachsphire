import { Check, Lock, Crosshair, Skull } from "lucide-react";

type Node = {
  code: string;
  title: string;
  kind: string;
  state: "cleared" | "active" | "locked" | "boss";
  xp: string;
};

const nodes: Node[] = [
  { code: "01", title: "Cold Boot", kind: "Recon · Nmap", state: "cleared", xp: "320" },
  { code: "02", title: "Ghost in the Inbox", kind: "Phishing forensics", state: "cleared", xp: "480" },
  { code: "03", title: "Silent Handshake", kind: "Traffic analysis", state: "cleared", xp: "540" },
  { code: "04", title: "Blackout Protocol", kind: "OT / SCADA response", state: "active", xp: "900" },
  { code: "05", title: "Salted Earth", kind: "Hash cracking", state: "locked", xp: "760" },
  { code: "06", title: "Hollow Tide", kind: "Threat actor takedown", state: "boss", xp: "2,400" },
];

const styles: Record<Node["state"], { ring: string; icon: React.ReactNode; badge: string }> = {
  cleared: {
    ring: "border-telemetry/60 bg-telemetry/10 text-telemetry",
    icon: <Check className="h-6 w-6" />,
    badge: "Cleared",
  },
  active: {
    ring: "border-primary bg-primary/15 text-primary pulse-ring",
    icon: <Crosshair className="h-6 w-6" />,
    badge: "In progress",
  },
  locked: {
    ring: "border-border bg-surface text-muted-foreground",
    icon: <Lock className="h-5 w-5" />,
    badge: "Locked",
  },
  boss: {
    ring: "border-threat/70 bg-threat/10 text-threat",
    icon: <Skull className="h-6 w-6" />,
    badge: "Apex target",
  },
};

export function OperationPath() {
  return (
    <section className="mx-auto max-w-7xl px-5 py-16">
      <div className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <span className="label-mono text-primary">Campaign · Season 2</span>
          <h2 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">Operation Nightfall</h2>
          <p className="mt-2 max-w-xl text-sm text-muted-foreground">
            Six linked operations. Every node you clear leaves a mark on the campaign map — and on
            the city.
          </p>
        </div>
        <div className="hud-panel corner-cut px-5 py-3">
          <div className="label-mono">Campaign progress</div>
          <div className="mt-1 font-display text-2xl text-foreground">
            3<span className="text-muted-foreground">/6</span>
          </div>
        </div>
      </div>

      <ol className="relative mt-12 grid gap-6 md:grid-cols-3">
        {nodes.map((n, i) => {
          const s = styles[n.state];
          return (
            <li
              key={n.code}
              className={`hud-panel corner-cut group relative p-5 transition-transform hover:-translate-y-1 ${
                i % 2 === 1 ? "md:translate-y-8" : ""
              }`}
            >
              <div className="flex items-start gap-4">
                <div
                  className={`grid h-14 w-14 shrink-0 place-items-center rounded-full border-2 ${s.ring}`}
                >
                  {s.icon}
                </div>
                <div className="min-w-0">
                  <div className="label-mono">
                    Node {n.code} · {s.badge}
                  </div>
                  <h3 className="mt-1 truncate font-display text-lg text-foreground">{n.title}</h3>
                  <p className="mt-1 text-sm text-muted-foreground">{n.kind}</p>
                </div>
              </div>

              <div className="mt-5 flex items-center justify-between border-t border-border/60 pt-4">
                <span className="font-mono text-xs text-telemetry">+{n.xp} XP</span>
                <span className="label-mono transition-colors group-hover:text-primary">
                  {n.state === "locked" ? "Requires Clearance IV" : "Open channel →"}
                </span>
              </div>
            </li>
          );
        })}
      </ol>
    </section>
  );
}
