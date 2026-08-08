import { Skull } from "lucide-react";
import { Button } from "@/components/ui/button";
import type { ChallengeComponentProps } from "./types";

interface Stage {
  objectiveRef?: string;
  label?: string;
}

/** This type's completionConditions is checked entirely server-side
 * against already-completed sibling objectives (Phase 2.5) -- there's no
 * real answer for the client to construct, just a confirmation. */
export function BossEncounterChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const task = content.task as string | undefined;
  const stages = (content.stages as Stage[] | undefined) ?? [];

  return (
    <div className="mx-auto max-w-xl space-y-4">
      {task && <p className="text-sm leading-relaxed text-foreground">{task}</p>}
      <ul className="space-y-2">
        {stages.map((s, i) => (
          <li key={i} className="flex items-center gap-2 border border-threat/40 bg-threat/5 p-2 text-xs text-foreground">
            <Skull className="h-3.5 w-3.5 text-threat" />
            {s.label}
          </li>
        ))}
      </ul>
      <Button disabled={submitting} onClick={() => onSubmit({})}>
        Submit
      </Button>
    </div>
  );
}
