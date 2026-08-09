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

/**
 * Worlds 0-39 only ever used the `pages[]` lookalike-website shape below.
 * Worlds 40+ reuse `browser_simulation` for other console-style UIs (IAM
 * policy viewers, storage buckets, scanner findings, SBOM inventories,
 * traffic captures, ...) that don't share one fixed field name -- each
 * world's `content` names its own array (`policies`, `objects`, `findings`,
 * `projects`, ...). Rather than special-case every one, the fallback below
 * scans `content` for the first array of `{id, ...}` records and renders it
 * generically as a set of selectable cards.
 */
function findRecordArray(content: Record<string, unknown>): { id: string; [key: string]: unknown }[] | null {
  for (const value of Object.values(content)) {
    if (
      Array.isArray(value) &&
      value.length > 0 &&
      value.every((v) => typeof v === "object" && v !== null && typeof (v as Record<string, unknown>).id === "string")
    ) {
      return value as { id: string; [key: string]: unknown }[];
    }
  }
  return null;
}

export function BrowserSimulationChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const pages = content.pages as BrowserPage[] | undefined;
  const question = (content.question as string | undefined) ?? (content.task as string | undefined);
  const instructions = (content.instructions as string | undefined) ?? question;
  const screen = content.screen as string | undefined;
  const [selected, setSelected] = useState<Set<string>>(new Set());

  if (pages && pages.length <= 1) {
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

  if (pages && pages.length > 1) {
    const singleSelected = selected.size > 0 ? Array.from(selected)[0] : null;
    return (
      <div className="mx-auto max-w-2xl space-y-4">
        {instructions && <p className="text-sm leading-relaxed text-foreground">{instructions}</p>}
        <div className="grid gap-3 sm:grid-cols-2">
          {pages.map((p) => {
            const active = singleSelected === p.id;
            return (
              <button
                key={p.id}
                type="button"
                onClick={() => setSelected(new Set([p.id]))}
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
        <Button disabled={!singleSelected || submitting} onClick={() => singleSelected && onSubmit({ selectedPageId: singleSelected })}>
          Submit
        </Button>
      </div>
    );
  }

  // Generic console-style fallback for worlds 40+.
  const records = findRecordArray(content);
  const toggle = (id: string) =>
    setSelected((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });

  return (
    <div className="mx-auto max-w-2xl space-y-4">
      {screen && <p className="label-mono text-[0.65rem] text-muted-foreground">{screen}</p>}
      {question && <p className="text-sm leading-relaxed text-foreground">{question}</p>}
      <div className="space-y-2">
        {records?.map((r) => {
          const active = selected.has(r.id);
          const fields = Object.entries(r).filter(([k]) => k !== "id");
          return (
            <button
              key={r.id}
              type="button"
              onClick={() => toggle(r.id)}
              className={cn(
                "w-full border p-3 text-left text-xs transition-colors",
                active
                  ? "border-telemetry/60 bg-telemetry/10 text-foreground"
                  : "border-border text-muted-foreground hover:border-border/60",
              )}
            >
              {fields.map(([k, v]) => (
                <div key={k} className={cn(k === fields[0][0] ? "font-display text-foreground" : "mt-1 whitespace-pre-wrap font-mono text-[0.7rem]")}>
                  {typeof v === "string" ? v : JSON.stringify(v)}
                </div>
              ))}
            </button>
          );
        })}
      </div>
      <Button
        disabled={selected.size === 0 || submitting}
        onClick={() => {
          const ids = Array.from(selected);
          onSubmit({ selectedOptionId: ids[0], selectedOptionIds: ids });
        }}
      >
        Submit
      </Button>
    </div>
  );
}
