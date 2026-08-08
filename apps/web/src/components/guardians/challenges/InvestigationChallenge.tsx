import { useState } from "react";
import { Search } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

export function InvestigationChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const question = content.question as string | undefined;
  const evidence = (content.evidence as { id: string; label: string; detail: string }[] | undefined) ?? [];
  const [selected, setSelected] = useState<Set<string>>(new Set());

  const toggle = (id: string) =>
    setSelected((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });

  return (
    <div className="mx-auto max-w-xl space-y-4">
      {question && <p className="text-sm leading-relaxed text-foreground">{question}</p>}
      <div className="space-y-2">
        {evidence.map((e) => {
          const active = selected.has(e.id);
          return (
            <button
              key={e.id}
              type="button"
              onClick={() => toggle(e.id)}
              className={cn(
                "flex w-full items-start gap-2 border p-3 text-left text-xs transition-colors",
                active
                  ? "border-telemetry/60 bg-telemetry/10 text-foreground"
                  : "border-border text-muted-foreground hover:border-border/60",
              )}
            >
              <Search className="mt-0.5 h-3.5 w-3.5 shrink-0" />
              <span>
                <span className="font-display text-foreground">{e.label}</span>
                <span className="block text-muted-foreground">{e.detail}</span>
              </span>
            </button>
          );
        })}
      </div>
      <Button disabled={selected.size === 0 || submitting} onClick={() => onSubmit({ selectedEvidenceIds: Array.from(selected) })}>
        Submit
      </Button>
    </div>
  );
}
