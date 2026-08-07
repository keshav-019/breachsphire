import { useState } from "react";
import { ChevronDown, Lightbulb } from "lucide-react";
import { cn } from "@/lib/utils";

export type Hint = {
  id: string;
  title: string;
  body: string;
  cost: number;
};

export type HintPanelProps = {
  hints: Hint[];
  className?: string;
};

export function HintPanel({ hints, className }: HintPanelProps) {
  const [openId, setOpenId] = useState<string | null>(null);
  const [revealed, setRevealed] = useState<string[]>([]);

  return (
    <div className={cn("hud-panel corner-cut p-4", className)}>
      <div className="flex items-center gap-2">
        <Lightbulb className="h-4 w-4 text-primary" />
        <span className="label-mono text-primary">Hints</span>
        <span className="label-mono ml-auto">costs XP</span>
      </div>

      <ul className="mt-3 space-y-2">
        {hints.map((h) => {
          const open = openId === h.id;
          const isRevealed = revealed.includes(h.id);
          return (
            <li key={h.id} className="border border-border/70 bg-surface-raised/40">
              <button
                type="button"
                onClick={() => {
                  setOpenId(open ? null : h.id);
                  if (!isRevealed) setRevealed((r) => [...r, h.id]);
                }}
                className="flex w-full items-center gap-2 px-3 py-2 text-left"
              >
                <span className="font-display text-xs text-foreground">{h.title}</span>
                <span className="font-mono ml-auto text-[0.65rem] text-primary">-{h.cost} XP</span>
                <ChevronDown
                  className={cn(
                    "h-3.5 w-3.5 text-muted-foreground transition-transform",
                    open && "rotate-180",
                  )}
                />
              </button>
              {open && (
                <p className="border-t border-border/60 px-3 py-2 text-xs leading-relaxed text-muted-foreground">
                  {h.body}
                </p>
              )}
            </li>
          );
        })}
      </ul>
    </div>
  );
}
