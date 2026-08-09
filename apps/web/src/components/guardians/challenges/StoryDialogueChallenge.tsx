import { Button } from "@/components/ui/button";
import { DialogueBox } from "@/components/guardians/DialogueBox";
import { getCharacterProfile } from "@/lib/characters";
import type { ChallengeComponentProps } from "./types";

export function StoryDialogueChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const lines = (content.lines as { characterId: string; text: string }[] | undefined) ?? [];

  return (
    <div className="mx-auto max-w-md space-y-4 text-center">
      {lines.map((line, i) => {
        const info = getCharacterProfile(line.characterId);

        return (
          <DialogueBox
            key={i}
            speaker={info.name}
            characterId={line.characterId}
            role={info.role}
            line={line.text}
            className="text-left"
          />
        );
      })}
      <Button disabled={submitting} onClick={() => onSubmit({ acknowledged: true })}>
        Acknowledge
      </Button>
    </div>
  );
}
