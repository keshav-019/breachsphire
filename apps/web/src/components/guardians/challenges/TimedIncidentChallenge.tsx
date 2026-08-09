import { useEffect, useState } from "react";
import { Clock } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

interface AlertItem {
  id: string;
  source?: string;
  text?: string;
  detail?: string;
}
interface OptionItem {
  id: string;
  text: string;
  consequence?: string;
}

function useCountdown(seconds: number | undefined) {
  const [remaining, setRemaining] = useState(seconds ?? 0);
  useEffect(() => {
    if (!seconds) return;
    setRemaining(seconds);
    const interval = setInterval(() => setRemaining((r) => Math.max(0, r - 1)), 1000);
    return () => clearInterval(interval);
  }, [seconds]);
  return remaining;
}

/**
 * Two shapes appear in the world content: a mapping variant (assign each
 * alert to one of a fixed set of triage actions, `correctMapping`
 * completion) and a single-choice variant (pick the one correct response
 * to a live scenario, `correctOptionId` completion, `options` or object-
 * shaped `actions` for the choices). The countdown is atmospheric pressure,
 * not a hard submission lock -- there's no completion condition that
 * depends on beating the clock, only on choosing correctly.
 */
export function TimedIncidentChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const question = content.question as string | undefined;
  const scenario = content.scenario as string | undefined;
  const alerts = (content.alerts as AlertItem[] | undefined) ?? [];
  const remaining = useCountdown(content.timeLimitSeconds as number | undefined);

  const stringActions = Array.isArray(content.actions) && (content.actions as unknown[]).every((a) => typeof a === "string")
    ? (content.actions as string[])
    : null;
  const objectOptions =
    (content.options as OptionItem[] | undefined) ??
    (Array.isArray(content.actions) && !stringActions ? (content.actions as OptionItem[]) : undefined);

  const [mapping, setMapping] = useState<Record<string, string>>({});
  const [selectedOption, setSelectedOption] = useState<string | null>(null);

  const timerBadge = content.timeLimitSeconds ? (
    <div
      className={cn(
        "label-mono flex items-center gap-1.5 border px-2 py-1 text-[0.65rem]",
        remaining <= 10 ? "border-threat/60 text-threat" : "border-border text-muted-foreground",
      )}
    >
      <Clock className="h-3 w-3" />
      {remaining > 0 ? `${remaining}s` : "Time's up -- decide now"}
    </div>
  ) : null;

  if (stringActions) {
    return (
      <div className="mx-auto max-w-2xl space-y-4">
        <div className="flex items-center justify-between gap-3">
          {question && <p className="text-sm leading-relaxed text-foreground">{question}</p>}
          {timerBadge}
        </div>
        <div className="space-y-2">
          {alerts.map((a) => (
            <div key={a.id} className="border border-border p-2.5 text-xs">
              <div className="flex items-start gap-2 text-muted-foreground">
                {a.source && <span className="label-mono shrink-0 text-[0.6rem] text-telemetry">{a.source}</span>}
                <span className="whitespace-pre-wrap">{a.detail ?? a.text}</span>
              </div>
              <div className="mt-2 flex flex-wrap gap-1.5">
                {stringActions.map((action) => (
                  <button
                    key={action}
                    type="button"
                    onClick={() => setMapping((prev) => ({ ...prev, [a.id]: action }))}
                    className={cn(
                      "label-mono border px-2 py-1 text-[0.6rem] capitalize transition-colors",
                      mapping[a.id] === action
                        ? "border-primary bg-primary/10 text-foreground"
                        : "border-border text-muted-foreground hover:border-border/60",
                    )}
                  >
                    {action}
                  </button>
                ))}
              </div>
            </div>
          ))}
        </div>
        <Button disabled={alerts.some((a) => !mapping[a.id]) || submitting} onClick={() => onSubmit({ mapping })}>
          Submit
        </Button>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-2xl space-y-4">
      <div className="flex items-center justify-between gap-3">
        {question && <p className="text-sm leading-relaxed text-foreground">{question}</p>}
        {timerBadge}
      </div>
      {scenario && <p className="border border-border bg-surface-raised/40 p-3 text-xs text-muted-foreground">{scenario}</p>}
      {alerts.length > 0 && (
        <div className="space-y-1.5 font-mono text-xs text-muted-foreground">
          {alerts.map((a) => (
            <div key={a.id} className="border border-border p-2">
              {a.text ?? a.detail}
            </div>
          ))}
        </div>
      )}
      <div className="space-y-2">
        {objectOptions?.map((o) => (
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
            <div>{o.text}</div>
            {o.consequence && <div className="mt-1 text-xs text-muted-foreground/80">{o.consequence}</div>}
          </button>
        ))}
      </div>
      <Button disabled={!selectedOption || submitting} onClick={() => selectedOption && onSubmit({ selectedOptionId: selectedOption })}>
        Submit
      </Button>
    </div>
  );
}
