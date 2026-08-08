import { Button } from "@/components/ui/button";
import type { ChallengeComponentProps } from "./types";

export function StoryDialogueChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const lines = (content.lines as { characterId: string; text: string }[] | undefined) ?? [];

  return (
    <div className="mx-auto max-w-md space-y-4 text-center">
      {lines.map((l, i) => (
        <p key={i} className="text-sm leading-relaxed text-muted-foreground">
          {l.text}
        </p>
      ))}
      <Button disabled={submitting} onClick={() => onSubmit({ acknowledged: true })}>
        Acknowledge
      </Button>
    </div>
  );
}
