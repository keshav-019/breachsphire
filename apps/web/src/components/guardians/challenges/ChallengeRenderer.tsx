import type { MissionChallenge } from "@/lib/api";
import { StoryDialogueChallenge } from "./StoryDialogueChallenge";
import { MultipleChoiceChallenge } from "./MultipleChoiceChallenge";
import { PhishingIdentificationChallenge } from "./PhishingIdentificationChallenge";
import { InvestigationChallenge } from "./InvestigationChallenge";
import { BrowserSimulationChallenge } from "./BrowserSimulationChallenge";
import { InteractiveDiagramChallenge } from "./InteractiveDiagramChallenge";
import { DragAndDropChallenge } from "./DragAndDropChallenge";
import { BossEncounterChallenge } from "./BossEncounterChallenge";
import { TerminalChallenge } from "./TerminalChallenge";

export type ChallengeRendererProps = {
  challenge: MissionChallenge;
  onSubmit: (answer: Record<string, unknown>) => void;
  submitting?: boolean;
};

export function ChallengeRenderer({ challenge, onSubmit, submitting }: ChallengeRendererProps) {
  const props = { content: challenge.content, onSubmit, submitting };

  switch (challenge.type) {
    case "story_dialogue":
      return <StoryDialogueChallenge {...props} />;
    case "multiple_choice":
      return <MultipleChoiceChallenge {...props} />;
    case "phishing_identification":
      return <PhishingIdentificationChallenge {...props} />;
    case "investigation":
      return <InvestigationChallenge {...props} />;
    case "browser_simulation":
      return <BrowserSimulationChallenge {...props} />;
    case "interactive_diagram":
      return <InteractiveDiagramChallenge {...props} />;
    case "drag_and_drop":
      return <DragAndDropChallenge {...props} />;
    case "boss_encounter":
      return <BossEncounterChallenge {...props} />;
    case "terminal_simulation":
      return <TerminalChallenge {...props} />;
    default:
      return (
        <div className="text-sm text-muted-foreground">
          Unsupported challenge type: <span className="font-mono">{challenge.type}</span>
        </div>
      );
  }
}
