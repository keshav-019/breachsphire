import { useState } from "react";
import { ChevronDown, TerminalSquare } from "lucide-react";
import { cn } from "@/lib/utils";

export type TerminalLine = {
  kind: "input" | "output" | "error" | "success";
  text: string;
};

export type TerminalPanelProps = {
  history: TerminalLine[];
  prompt?: string;
  defaultOpen?: boolean;
  className?: string;
};

const lineTone: Record<TerminalLine["kind"], string> = {
  input: "text-foreground",
  output: "text-muted-foreground",
  error: "text-threat",
  success: "text-telemetry",
};

export function TerminalPanel({
  history,
  prompt = "nova@guardian:~$",
  defaultOpen = true,
  className,
}: TerminalPanelProps) {
  const [open, setOpen] = useState(defaultOpen);

  return (
    <section className={cn("hud-panel border-x-0 border-b-0", className)}>
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        className="flex w-full items-center gap-3 px-4 py-2.5"
      >
        <TerminalSquare className="h-4 w-4 text-telemetry" />
        <span className="label-mono text-telemetry">Console — shell/01</span>
        <span className="label-mono ml-auto">{open ? "collapse" : "expand"}</span>
        <ChevronDown
          className={cn("h-4 w-4 text-muted-foreground transition-transform", open && "rotate-180")}
        />
      </button>

      {open && (
        <div className="max-h-64 overflow-y-auto bg-background/80 px-4 py-3 font-mono text-[0.72rem] leading-relaxed">
          {history.map((l, i) => (
            <div key={i} className={lineTone[l.kind]}>
              {l.kind === "input" && <span className="mr-2 text-primary">{prompt}</span>}
              {l.text}
            </div>
          ))}
          <div className="flex items-center text-foreground">
            <span className="mr-2 text-primary">{prompt}</span>
            <span className="flicker inline-block h-3.5 w-2 bg-primary" />
          </div>
        </div>
      )}
    </section>
  );
}
