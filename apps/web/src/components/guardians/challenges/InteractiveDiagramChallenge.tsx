import { useState } from "react";
import { RotateCcw } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

interface Hotspot {
  id: string;
  label: string;
  explanation?: string;
}

/** Ranking task: click hotspots in order (weakest -> strongest, per the
 * task prompt) rather than drag-and-drop -- no DnD library installed,
 * and this achieves the same outcome. */
export function InteractiveDiagramChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const hotspots = (content.hotspots as Hotspot[] | undefined) ?? [];
  const task = content.task as string | undefined;
  const [order, setOrder] = useState<string[]>([]);

  const byId = new Map(hotspots.map((h) => [h.id, h]));
  const remaining = hotspots.filter((h) => !order.includes(h.id));

  return (
    <div className="mx-auto max-w-xl space-y-4">
      {task && <p className="text-sm leading-relaxed text-foreground">{task}</p>}

      <div>
        <span className="label-mono">Your order</span>
        <ol className="mt-2 space-y-1.5">
          {order.length === 0 && (
            <li className="text-xs text-muted-foreground">Click the items below in order.</li>
          )}
          {order.map((id, i) => (
            <li key={id} className="flex items-center gap-2 border border-telemetry/40 bg-telemetry/10 p-2 text-xs">
              <span className="font-mono text-telemetry">{i + 1}</span>
              <span className="text-foreground">{byId.get(id)?.label}</span>
            </li>
          ))}
        </ol>
      </div>

      {remaining.length > 0 && (
        <div className="flex flex-wrap gap-2">
          {remaining.map((h) => (
            <button
              key={h.id}
              type="button"
              onClick={() => setOrder((prev) => [...prev, h.id])}
              className={cn("border border-border px-3 py-1.5 text-left text-xs text-muted-foreground hover:border-border/60")}
            >
              {h.label}
            </button>
          ))}
        </div>
      )}

      <div className="flex items-center gap-2">
        <Button
          disabled={order.length !== hotspots.length || submitting}
          onClick={() => onSubmit({ orderedIds: order })}
        >
          Submit
        </Button>
        {order.length > 0 && (
          <Button variant="ghost" size="sm" onClick={() => setOrder([])}>
            <RotateCcw className="h-3.5 w-3.5" />
            Reset
          </Button>
        )}
      </div>
    </div>
  );
}
