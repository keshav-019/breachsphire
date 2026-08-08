import { useState } from "react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

export function MultipleChoiceChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const question = content.question as string | undefined;
  const options = (content.options as { id: string; text: string }[] | undefined) ?? [];
  const [selected, setSelected] = useState<string | null>(null);

  return (
    <div className="mx-auto max-w-lg space-y-4">
      {question && <p className="text-sm leading-relaxed text-foreground">{question}</p>}
      <div className="space-y-2">
        {options.map((o) => (
          <button
            key={o.id}
            type="button"
            onClick={() => setSelected(o.id)}
            className={cn(
              "w-full border p-3 text-left text-sm transition-colors",
              selected === o.id
                ? "border-primary bg-primary/10 text-foreground"
                : "border-border text-muted-foreground hover:border-border/60 hover:bg-surface-raised/40",
            )}
          >
            {o.text}
          </button>
        ))}
      </div>
      <Button disabled={!selected || submitting} onClick={() => selected && onSubmit({ selectedOptionId: selected })}>
        Submit
      </Button>
    </div>
  );
}
