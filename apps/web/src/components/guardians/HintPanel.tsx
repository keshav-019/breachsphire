import { useState } from "react";
import { ChevronDown, Lightbulb, Lock } from "lucide-react";
import { cn } from "@/lib/utils";

export type Hint = {
  tier: string;
  xpCost: number;
  revealed: boolean;
  text: string | null;
};

export type HintPanelProps = {
  hints: Hint[];
  onReveal?: (tier: string) => void;
  revealing?: boolean;
  className?: string;
};

const TIER_LABEL: Record<string, string> = {
  orientation: "Orientation",
  concept: "Concept",
  tool_direction: "Tool direction",
  near_solution: "Near solution",
  solution: "Solution",
};

export function HintPanel({ hints, onReveal, revealing, className }: HintPanelProps) {
  const [openTier, setOpenTier] = useState<string | null>(null);

  return (
    <div className={cn("hud-panel corner-cut p-4", className)}>
      <div className="flex items-center gap-2">
        <Lightbulb className="h-4 w-4 text-primary" />
        <span className="label-mono text-primary">Hints</span>
        <span className="label-mono ml-auto">costs XP</span>
      </div>

      <ul className="mt-3 space-y-2">
        {hints.map((h, i) => {
          const open = openTier === h.tier;
          const priorUnrevealed = hints.slice(0, i).some((prior) => !prior.revealed);
          return (
            <li key={h.tier} className="border border-border/70 bg-surface-raised/40">
              <button
                type="button"
                disabled={!h.revealed && priorUnrevealed}
                onClick={() => {
                  if (h.revealed) {
                    setOpenTier(open ? null : h.tier);
                  } else {
                    onReveal?.(h.tier);
                  }
                }}
                className={cn(
                  "flex w-full items-center gap-2 px-3 py-2 text-left",
                  !h.revealed && priorUnrevealed && "cursor-not-allowed opacity-50",
                )}
              >
                {!h.revealed && <Lock className="h-3.5 w-3.5 text-muted-foreground" />}
                <span className="font-display text-xs text-foreground">
                  {TIER_LABEL[h.tier] ?? h.tier}
                </span>
                <span className="font-mono ml-auto text-[0.65rem] text-primary">
                  {h.revealed ? "revealed" : revealing ? "…" : `-${h.xpCost} XP`}
                </span>
                {h.revealed && (
                  <ChevronDown
                    className={cn(
                      "h-3.5 w-3.5 text-muted-foreground transition-transform",
                      open && "rotate-180",
                    )}
                  />
                )}
              </button>
              {open && h.revealed && (
                <p className="border-t border-border/60 px-3 py-2 text-xs leading-relaxed text-muted-foreground">
                  {h.text}
                </p>
              )}
            </li>
          );
        })}
      </ul>
    </div>
  );
}
