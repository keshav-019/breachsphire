import { useState } from "react";
import { Boxes, Code2, Globe, Network, Send, Sparkles } from "lucide-react";
import { DialogueBox } from "@/components/guardians/DialogueBox";
import { ObjectiveChecklist, type Objective } from "@/components/guardians/ObjectiveChecklist";
import { HintPanel } from "@/components/guardians/HintPanel";
import { TerminalPanel, type TerminalLine } from "@/components/guardians/TerminalPanel";
import { ThreatLevelPill } from "@/components/guardians/ThreatLevelPill";
import { cn } from "@/lib/utils";

const TABS = [
  { id: "diagram", label: "Diagram", icon: Network },
  { id: "browser", label: "Browser Sim", icon: Globe },
  { id: "code", label: "Code", icon: Code2 },
] as const;

const HISTORY: TerminalLine[] = [
  { kind: "input", text: "ssh operator@10.42.7.19" },
  { kind: "output", text: "Warning: host key changed since last contact." },
  { kind: "error", text: "auth failed — 3 attempts remaining" },
  { kind: "input", text: "nmap -sS -p- 10.42.7.19 --open" },
  { kind: "output", text: "502/tcp open  modbus" },
  { kind: "output", text: "8443/tcp open  https-alt" },
  { kind: "success", text: "[+] evidence captured: beacon_interval=300s" },
];

const HINTS = [
  {
    id: "h1",
    title: "Where is the implant calling home?",
    body: "Modbus should never egress. Filter the pcap for outbound 8443 from the OT VLAN and look at the SNI.",
    cost: 40,
  },
  {
    id: "h2",
    title: "Containment without downtime",
    body: "Blocking at the PLC kills production. Push the deny rule at the boundary firewall instead.",
    cost: 75,
  },
  {
    id: "h3",
    title: "Preserving logs",
    body: "Snapshot the historian before you touch anything — the implant clears its own journal on restart.",
    cost: 120,
  },
];

export default function MissionPage() {
  const [tab, setTab] = useState<(typeof TABS)[number]["id"]>("diagram");
  const [objectives, setObjectives] = useState<Objective[]>([
    { id: "o1", label: "Map the OT subnet and identify live hosts", done: true },
    { id: "o2", label: "Locate the beaconing device", done: true },
    { id: "o3", label: "Capture the C2 domain from outbound traffic", done: false },
    { id: "o4", label: "Apply containment at the boundary firewall", done: false },
    { id: "o5", label: "Snapshot the historian before remediation", done: false, optional: true },
  ]);

  const toggle = (id: string) =>
    setObjectives((prev) => prev.map((o) => (o.id === id ? { ...o, done: !o.done } : o)));

  return (
    <div className="flex min-h-[calc(100vh-4rem)] flex-col">
      <div className="flex flex-wrap items-center gap-3 border-b border-border px-5 py-3">
        <span className="font-mono text-xs text-primary">OP-2291 // BLACKOUT</span>
        <ThreatLevelPill level="severe" />
        <span className="label-mono ml-auto">Elapsed 08:41</span>
      </div>

      <div className="grid flex-1 gap-4 p-4 lg:grid-cols-[300px_1fr_300px]">
        {/* LEFT — story + objectives */}
        <div className="space-y-4">
          <DialogueBox
            speaker="Commander Rell"
            role="Ops Division · Handler"
            line="Nova, the implant has been in Meridian's network for eleven days. It is patient, which means it is not a smash-and-grab. Find its voice before it finds ours."
            tone="signal"
          />
          <div className="hud-panel corner-cut p-4">
            <ObjectiveChecklist objectives={objectives} onToggle={toggle} />
          </div>
        </div>

        {/* CENTER — interactive environment */}
        <div className="hud-panel corner-cut flex min-h-[420px] flex-col">
          <div className="flex items-center gap-1 border-b border-border px-2">
            {TABS.map((t) => (
              <button
                key={t.id}
                type="button"
                onClick={() => setTab(t.id)}
                className={cn(
                  "flex items-center gap-2 px-4 py-3 font-mono text-[0.68rem] tracking-[0.16em] uppercase transition-colors",
                  tab === t.id
                    ? "border-b-2 border-primary text-primary"
                    : "text-muted-foreground hover:text-foreground",
                )}
              >
                <t.icon className="h-3.5 w-3.5" />
                {t.label}
              </button>
            ))}
            <span className="label-mono ml-auto pr-3">Sandbox live</span>
          </div>

          <div className="hud-grid relative flex flex-1 items-center justify-center p-6">
            <div className="pointer-events-none absolute inset-y-0 w-32 bg-gradient-to-r from-transparent via-telemetry/8 to-transparent sweep-line" />
            <div className="text-center">
              <span className="mx-auto grid h-16 w-16 place-items-center rounded-full border-2 border-telemetry/50 bg-telemetry/10 text-telemetry">
                <Boxes className="h-7 w-7" />
              </span>
              <h2 className="mt-4 font-display text-lg text-foreground">
                {TABS.find((t) => t.id === tab)?.label} environment
              </h2>
              <p className="mx-auto mt-2 max-w-sm text-sm text-muted-foreground">
                Interactive scenario surface mounts here — network topology, simulated browser, or
                the code workspace for this objective.
              </p>
              <div className="mt-5 inline-flex gap-2">
                <span className="label-mono border border-border px-3 py-1.5">Zoom</span>
                <span className="label-mono border border-border px-3 py-1.5">Inspect</span>
                <span className="label-mono border border-border px-3 py-1.5">Reset</span>
              </div>
            </div>
          </div>
        </div>

        {/* RIGHT — hints, evidence, companion */}
        <div className="space-y-4">
          <HintPanel hints={HINTS} />

          <div className="hud-panel corner-cut p-4">
            <span className="label-mono text-telemetry">Evidence locker</span>
            <ul className="mt-3 space-y-2">
              {[
                { n: "pcap_meridian_0311.pcap", t: "Capture" },
                { n: "beacon_interval=300s", t: "Indicator" },
                { n: "hash: 8f2a…c19d", t: "Artifact" },
                { n: "historian_snapshot.img", t: "Locked" },
              ].map((e) => (
                <li
                  key={e.n}
                  className="flex items-center justify-between gap-2 border border-border/70 bg-surface-raised/40 px-3 py-2"
                >
                  <span className="truncate font-mono text-[0.68rem] text-foreground">{e.n}</span>
                  <span className="label-mono shrink-0 text-[0.55rem]">{e.t}</span>
                </li>
              ))}
            </ul>
          </div>

          <div className="hud-panel corner-cut p-4">
            <div className="flex items-center gap-2">
              <Sparkles className="h-4 w-4 text-clearance" />
              <span className="label-mono text-clearance">Byte · AI companion</span>
            </div>
            <div className="mt-3 border border-clearance/30 bg-clearance/8 p-3 text-xs leading-relaxed text-foreground">
              I cross-checked the beacon timing against known clusters. 300s with jitter under 4% —
              that is HOLLOW TIDE tooling. Want me to pull their last known C2 ranges?
            </div>
            <div className="mt-3 flex items-center gap-2 border border-border bg-background/60 px-3 py-2">
              <input
                aria-label="Message Byte"
                placeholder="Ask Byte…"
                className="w-full bg-transparent font-mono text-xs text-foreground outline-none placeholder:text-muted-foreground"
              />
              <Send className="h-3.5 w-3.5 text-telemetry" />
            </div>
          </div>
        </div>
      </div>

      <TerminalPanel history={HISTORY} />
    </div>
  );
}
