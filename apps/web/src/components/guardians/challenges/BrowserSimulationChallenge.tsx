import { useState } from "react";
import { Lock, ShieldAlert } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

interface BrowserPage {
  id: string;
  url: string;
  title: string;
  indicators?: Record<string, boolean>;
}

export function BrowserSimulationChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const pages = (content.pages as BrowserPage[] | undefined) ?? [];
  const instructions = (content.instructions as string | undefined) ?? (content.task as string | undefined);
  const [selected, setSelected] = useState<string | null>(null);

  if (pages.length <= 1) {
    const page = pages[0];
    return (
      <div className="mx-auto max-w-md space-y-4 text-center">
        {instructions && <p className="text-sm leading-relaxed text-foreground">{instructions}</p>}
        {page && (
          <div className="border border-border bg-surface-raised/40 p-3 text-left font-mono text-xs">
            <div className="flex items-center gap-1.5 text-telemetry">
              <Lock className="h-3 w-3" />
              {page.url}
            </div>
            <div className="mt-1 text-foreground">{page.title}</div>
          </div>
        )}
        <Button
          disabled={submitting}
          onClick={() => onSubmit({ actionId: (content.actionId as string | undefined) ?? page?.id })}
        >
          Perform action
        </Button>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-2xl space-y-4">
      {instructions && <p className="text-sm leading-relaxed text-foreground">{instructions}</p>}
      <div className="grid gap-3 sm:grid-cols-2">
        {pages.map((p) => {
          const active = selected === p.id;
          return (
            <button
              key={p.id}
              type="button"
              onClick={() => setSelected(p.id)}
              className={cn(
                "space-y-2 border p-3 text-left transition-colors",
                active ? "border-primary bg-primary/10" : "border-border hover:border-border/60",
              )}
            >
              <div className="flex items-center gap-1.5 font-mono text-[0.7rem] text-foreground">
                {p.indicators?.https ? <Lock className="h-3 w-3 text-telemetry" /> : <ShieldAlert className="h-3 w-3 text-threat" />}
                <span className="truncate">{p.url}</span>
              </div>
              <div className="text-sm text-foreground">{p.title}</div>
              {p.indicators && (
                <div className="flex flex-wrap gap-1">
                  {Object.entries(p.indicators).map(([k, v]) => (
                    <span
                      key={k}
                      className={cn(
                        "label-mono px-1.5 py-0.5 text-[0.55rem]",
                        v ? "border border-telemetry/40 text-telemetry" : "border border-threat/40 text-threat",
                      )}
                    >
                      {k}
                    </span>
                  ))}
                </div>
              )}
            </button>
          );
        })}
      </div>
      <Button disabled={!selected || submitting} onClick={() => selected && onSubmit({ selectedPageId: selected })}>
        Submit
      </Button>
    </div>
  );
}
