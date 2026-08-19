import { lazy, Suspense, useEffect, useRef, useState } from "react";
import { BookOpenCheck, ChevronDown, Lightbulb, Lock, Unlock } from "lucide-react";
import type { SolutionContext } from "./SolutionWalkthrough";
import { cn } from "@/lib/utils";

const SolutionWalkthrough = lazy(() =>
  import("./SolutionWalkthrough").then((module) => ({ default: module.SolutionWalkthrough })),
);

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
  autoOpenTier?: string | null;
  context?: SolutionContext;
  className?: string;
};

const TIER_LABEL: Record<string, string> = {
  orientation: "Orientation",
  concept: "Concept",
  tool_direction: "Tool direction",
  near_solution: "Near solution",
  solution: "Full solution",
};

export function HintPanel({
  hints,
  onReveal,
  revealing,
  autoOpenTier,
  context,
  className,
}: HintPanelProps) {
  const [openTier, setOpenTier] = useState<string | null>(null);
  const autoOpenedRef = useRef<string | null>(null);
  const revealedCount = hints.filter((hint) => hint.revealed).length;
  const solutionContext = context ?? {
    challengePrompt: "Complete the current challenge.",
    challengeType: "unknown",
  };

  useEffect(() => {
    if (
      autoOpenTier &&
      autoOpenedRef.current !== autoOpenTier &&
      hints.some((hint) => hint.tier === autoOpenTier && hint.revealed)
    ) {
      setOpenTier(autoOpenTier);
      autoOpenedRef.current = autoOpenTier;
    }
  }, [autoOpenTier, hints]);

  return (
    <section
      aria-label="Mission support"
      className={cn("hud-panel corner-cut p-4", className)}
    >
      <div className="flex items-center gap-2">
        <Lightbulb className="h-4 w-4 text-primary" />
        <span className="label-mono text-primary">Mission support</span>
        <span className="label-mono ml-auto">
          {revealedCount}/{hints.length}
        </span>
      </div>

      <ul className="mt-3 space-y-2">
        {hints.map((hint, index) => {
          const open = openTier === hint.tier;
          const priorUnrevealed = hints.slice(0, index).some((prior) => !prior.revealed);
          const canReveal = !hint.revealed && !priorUnrevealed;
          const isSolution = hint.tier === "solution";
          const isDecrypting = revealing && canReveal;

          // The one tier the player can actually act on right now gets a
          // big, unmistakable "Unlock hint" button instead of blending
          // into the list -- everything else (already revealed, or still
          // genuinely locked behind an earlier tier) stays lower-key.
          if (canReveal) {
            return (
              <li key={hint.tier} data-testid={"hint-tier-" + hint.tier}>
                <button
                  type="button"
                  disabled={isDecrypting}
                  onClick={() => onReveal?.(hint.tier)}
                  className="glow-signal corner-cut flex w-full items-center justify-center gap-2 bg-primary px-4 py-3 font-display text-sm tracking-[0.08em] text-primary-foreground uppercase transition-transform hover:scale-[1.01] disabled:cursor-not-allowed disabled:opacity-70"
                >
                  {isDecrypting ? (
                    "Decrypting…"
                  ) : (
                    <>
                      <Unlock className="h-4 w-4" />
                      Unlock hint
                      <span className="font-mono text-xs normal-case opacity-85">
                        ({TIER_LABEL[hint.tier] ?? hint.tier}{hint.xpCost > 0 ? ` · -${hint.xpCost} XP` : ", free"})
                      </span>
                    </>
                  )}
                </button>
              </li>
            );
          }

          return (
            <li
              key={hint.tier}
              data-testid={"hint-tier-" + hint.tier}
              className={cn(
                "border bg-surface-raised/40",
                isSolution ? "border-primary/35" : "border-border/70",
                !hint.revealed && "opacity-50",
              )}
            >
              <button
                type="button"
                aria-expanded={hint.revealed ? open : undefined}
                disabled={!hint.revealed}
                onClick={() => {
                  if (hint.revealed) setOpenTier(open ? null : hint.tier);
                }}
                className={cn(
                  "flex w-full items-center gap-2 px-3 py-2.5 text-left",
                  !hint.revealed && "cursor-not-allowed",
                )}
              >
                {isSolution ? (
                  <BookOpenCheck className="h-3.5 w-3.5 text-primary" />
                ) : !hint.revealed ? (
                  <Lock className="h-3.5 w-3.5 text-muted-foreground" />
                ) : (
                  <Lightbulb className="h-3.5 w-3.5 text-telemetry" />
                )}
                <span className="font-display text-xs text-foreground">
                  {TIER_LABEL[hint.tier] ?? hint.tier}
                </span>
                <span className="font-mono ml-auto text-[0.65rem] text-primary">
                  {hint.revealed ? "revealed" : "locked"}
                </span>
                {hint.revealed && (
                  <ChevronDown
                    className={cn(
                      "h-3.5 w-3.5 text-muted-foreground transition-transform",
                      open && "rotate-180",
                    )}
                  />
                )}
              </button>

              {open &&
                hint.revealed &&
                (isSolution ? (
                  <Suspense
                    fallback={
                      <div className="label-mono border-t border-border/60 p-3 text-primary">
                        Opening walkthrough…
                      </div>
                    }
                  >
                    <SolutionWalkthrough
                      solution={hint.text ?? ""}
                      context={solutionContext}
                      onClose={() => setOpenTier(null)}
                    />
                  </Suspense>
                ) : (
                  <div className="border-t border-border/60 px-3 py-3">
                    <p className="text-xs leading-relaxed text-muted-foreground">{hint.text}</p>
                    <p className="label-mono mt-2 text-[0.6rem] text-telemetry">
                      Use the clue, then verify it in the challenge
                    </p>
                  </div>
                ))}
            </li>
          );
        })}
      </ul>
    </section>
  );
}
