import { useState } from "react";
import { ScrollText } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

interface LogLine {
  id: string;
  source?: string;
  text: string;
}

export function LogAnalysisChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const question = content.question as string | undefined;
  const logLines = (content.logLines as LogLine[] | undefined) ?? [];
  const [selected, setSelected] = useState<Set<string>>(new Set());

  const toggle = (id: string) =>
    setSelected((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });

  return (
    <div className="mx-auto max-w-2xl space-y-4">
      {question && <p className="text-sm leading-relaxed text-foreground">{question}</p>}
      <div className="space-y-1.5 font-mono text-xs">
        {logLines.map((l) => {
          const active = selected.has(l.id);
          return (
            <button
              key={l.id}
              type="button"
              onClick={() => toggle(l.id)}
              className={cn(
                "flex w-full items-start gap-2 border p-2.5 text-left transition-colors",
                active
                  ? "border-telemetry/60 bg-telemetry/10 text-foreground"
                  : "border-border text-muted-foreground hover:border-border/60",
              )}
            >
              <ScrollText className="mt-0.5 h-3.5 w-3.5 shrink-0" />
              <span>
                {l.source && <span className="label-mono mr-2 text-[0.6rem] text-telemetry">{l.source}</span>}
                <span className="whitespace-pre-wrap">{l.text}</span>
              </span>
            </button>
          );
        })}
      </div>
      <Button disabled={selected.size === 0 || submitting} onClick={() => onSubmit({ selectedLogLineIds: Array.from(selected) })}>
        Submit
      </Button>
    </div>
  );
}
