import { useState } from "react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

interface DndItem {
  id: string;
  text: string;
}
interface DndTarget {
  id: string;
  label: string;
}

/** Sorting task: click an item to select it, then click the bucket it
 * belongs in -- no DnD library installed, functionally equivalent to
 * dragging. */
export function DragAndDropChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const items = (content.items as DndItem[] | undefined) ?? [];
  const targets = (content.targets as DndTarget[] | undefined) ?? [];
  const [mapping, setMapping] = useState<Record<string, string>>({});
  const [activeItemId, setActiveItemId] = useState<string | null>(null);

  const assign = (targetId: string) => {
    if (!activeItemId) return;
    setMapping((prev) => ({ ...prev, [activeItemId]: targetId }));
    setActiveItemId(null);
  };

  const targetLabel = (id: string) => targets.find((t) => t.id === id)?.label;

  return (
    <div className="mx-auto max-w-xl space-y-4">
      <p className="text-xs text-muted-foreground">Select an item, then select the bucket it belongs in.</p>

      <div className="flex flex-wrap gap-2">
        {items.map((item) => {
          const assigned = mapping[item.id];
          const active = activeItemId === item.id;
          return (
            <button
              key={item.id}
              type="button"
              onClick={() => setActiveItemId(item.id)}
              className={cn(
                "border px-3 py-2 text-left text-xs transition-colors",
                active
                  ? "border-primary bg-primary/10 text-foreground"
                  : assigned
                    ? "border-telemetry/40 text-foreground"
                    : "border-border text-muted-foreground hover:border-border/60",
              )}
            >
              {item.text}
              {assigned && <span className="label-mono ml-2 text-telemetry">-&gt; {targetLabel(assigned)}</span>}
            </button>
          );
        })}
      </div>

      <div className="flex flex-wrap gap-2">
        {targets.map((t) => (
          <button
            key={t.id}
            type="button"
            disabled={!activeItemId}
            onClick={() => assign(t.id)}
            className="border border-border px-3 py-1.5 text-xs text-foreground disabled:cursor-not-allowed disabled:opacity-40"
          >
            {t.label}
          </button>
        ))}
      </div>

      <Button
        disabled={items.some((i) => !mapping[i.id]) || submitting}
        onClick={() => onSubmit({ mapping })}
      >
        Submit
      </Button>
    </div>
  );
}
