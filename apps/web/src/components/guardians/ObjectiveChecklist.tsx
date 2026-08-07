import { Check } from "lucide-react";
import { cn } from "@/lib/utils";

export type Objective = {
  id: string;
  label: string;
  done: boolean;
  optional?: boolean;
};

export type ObjectiveChecklistProps = {
  objectives: Objective[];
  onToggle?: (id: string) => void;
  className?: string;
};

export function ObjectiveChecklist({ objectives, onToggle, className }: ObjectiveChecklistProps) {
  const done = objectives.filter((o) => o.done).length;
  return (
    <div className={cn("w-full", className)}>
      <div className="flex items-center justify-between">
        <span className="label-mono text-telemetry">Objectives</span>
        <span className="font-mono text-xs text-foreground">
          {done}/{objectives.length}
        </span>
      </div>
      <ol className="mt-3 space-y-2">
        {objectives.map((o, i) => (
          <li key={o.id}>
            <button
              type="button"
              onClick={() => onToggle?.(o.id)}
              className="flex w-full items-start gap-3 border border-transparent p-2 text-left transition-colors hover:border-border hover:bg-surface-raised/60"
            >
              <span
                className={cn(
                  "mt-0.5 grid h-5 w-5 shrink-0 place-items-center border font-mono text-[0.6rem]",
                  o.done
                    ? "border-telemetry/60 bg-telemetry/15 text-telemetry"
                    : "border-border text-muted-foreground",
                )}
              >
                {o.done ? <Check className="h-3 w-3" /> : String(i + 1).padStart(2, "0")}
              </span>
              <span
                className={cn(
                  "text-sm leading-snug",
                  o.done ? "text-muted-foreground line-through" : "text-foreground",
                )}
              >
                {o.label}
                {o.optional && <span className="label-mono ml-2">bonus</span>}
              </span>
            </button>
          </li>
        ))}
      </ol>
    </div>
  );
}
