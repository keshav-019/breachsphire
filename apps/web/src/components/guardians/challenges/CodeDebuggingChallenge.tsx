import { useState } from "react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

/**
 * Two content shapes appear in the world content: most challenges show a
 * code/config block and ask the player to click the offending line
 * (`requiredLineIds` completion, matched against the clicked line's exact
 * text). A few instead pair a short snippet with multiple-choice options
 * about what it means (`correctOptionId` completion) -- handled the same
 * way MultipleChoiceChallenge does, just with a code block above it.
 */
export function CodeDebuggingChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const code = (content.code as string | undefined) ?? (content.codeSnippet as string | undefined) ?? "";
  const language = content.language as string | undefined;
  const question = content.question as string | undefined;
  const options = content.options as { id: string; text: string }[] | undefined;

  const [selectedLine, setSelectedLine] = useState<string | null>(null);
  const [selectedOption, setSelectedOption] = useState<string | null>(null);

  const lines = code.split("\n");

  return (
    <div className="mx-auto max-w-2xl space-y-4">
      {question && <p className="text-sm leading-relaxed text-foreground">{question}</p>}
      <div className="overflow-x-auto border border-border bg-surface-raised/40 p-3">
        {language && <p className="label-mono mb-2 text-[0.6rem] text-muted-foreground">{language}</p>}
        {options ? (
          <pre className="whitespace-pre font-mono text-xs text-foreground">{code}</pre>
        ) : (
          <div className="font-mono text-xs">
            {lines.map((line, i) => {
              const active = selectedLine === line;
              return (
                <button
                  key={i}
                  type="button"
                  onClick={() => setSelectedLine(line)}
                  className={cn(
                    "block w-full whitespace-pre px-1 text-left transition-colors",
                    active ? "bg-telemetry/20 text-foreground" : "text-muted-foreground hover:bg-surface-raised/60",
                  )}
                >
                  {line || " "}
                </button>
              );
            })}
          </div>
        )}
      </div>

      {options && (
        <div className="space-y-2">
          {options.map((o) => (
            <button
              key={o.id}
              type="button"
              onClick={() => setSelectedOption(o.id)}
              className={cn(
                "w-full border p-3 text-left text-sm transition-colors",
                selectedOption === o.id
                  ? "border-primary bg-primary/10 text-foreground"
                  : "border-border text-muted-foreground hover:border-border/60 hover:bg-surface-raised/40",
              )}
            >
              {o.text}
            </button>
          ))}
        </div>
      )}

      {options ? (
        <Button disabled={!selectedOption || submitting} onClick={() => selectedOption && onSubmit({ selectedOptionId: selectedOption })}>
          Submit
        </Button>
      ) : (
        <Button disabled={!selectedLine || submitting} onClick={() => selectedLine && onSubmit({ selectedLineIds: [selectedLine] })}>
          Submit
        </Button>
      )}
    </div>
  );
}
