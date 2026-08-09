import { Lightbulb, Sparkles } from "lucide-react";
import type { MissionHint } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { CharacterAvatar } from "./CharacterAvatar";

type IdleHintPromptProps = {
  hint: MissionHint;
  revealing?: boolean;
  onReveal: (tier: string) => void;
  onDismiss: () => void;
};

const TIER_NAME: Record<string, string> = {
  orientation: "orientation hint",
  concept: "concept hint",
  tool_direction: "tool direction",
  near_solution: "near-solution clue",
  solution: "full solution",
};

export function IdleHintPrompt({
  hint,
  revealing,
  onReveal,
  onDismiss,
}: IdleHintPromptProps) {
  const isSolution = hint.tier === "solution";
  const cost = hint.xpCost === 0 ? "This one is free." : "It costs " + hint.xpCost + " XP.";

  return (
    <section
      aria-label="Hint offer"
      aria-live="polite"
      data-testid="idle-hint-prompt"
      className="corner-cut border border-primary/45 bg-primary/8 p-4 shadow-[0_0_30px_-18px_var(--color-primary)]"
    >
      <div className="flex items-start gap-3">
        <CharacterAvatar tag="Byte" characterId="byte" size="md" tone="signal" online />
        <div className="min-w-0 flex-1">
          <div className="flex items-center gap-2">
            <Sparkles className="h-4 w-4 text-primary" />
            <h3 className="font-display text-sm text-foreground">Need a hand?</h3>
          </div>
          <p className="mt-1 text-xs leading-relaxed text-muted-foreground">
            You&apos;ve been working this one for a bit. I can reveal the next{" "}
            {TIER_NAME[hint.tier] ?? "hint"} without taking the controls away. {cost}
          </p>
          <div className="mt-3 flex flex-wrap gap-2">
            <Button
              type="button"
              size="sm"
              disabled={revealing}
              onClick={() => onReveal(hint.tier)}
            >
              <Lightbulb />
              {revealing
                ? "Decrypting…"
                : isSolution
                  ? "Open full solution"
                  : "Reveal next hint"}
            </Button>
            <Button type="button" size="sm" variant="ghost" onClick={onDismiss}>
              I&apos;ll keep trying
            </Button>
          </div>
        </div>
      </div>
    </section>
  );
}
