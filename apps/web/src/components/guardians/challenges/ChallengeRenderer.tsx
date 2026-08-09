import { Suspense, lazy } from "react";
import type { MissionChallenge } from "@/lib/api";

// Each challenge type is its own chunk. This matters most for
// TerminalChallenge, which pulls in xterm.js — a mission with no terminal
// challenge should never pay for that download.
const StoryDialogueChallenge = lazy(() => import("./StoryDialogueChallenge").then((m) => ({ default: m.StoryDialogueChallenge })));
const MultipleChoiceChallenge = lazy(() => import("./MultipleChoiceChallenge").then((m) => ({ default: m.MultipleChoiceChallenge })));
const PhishingIdentificationChallenge = lazy(() =>
  import("./PhishingIdentificationChallenge").then((m) => ({ default: m.PhishingIdentificationChallenge })),
);
const InvestigationChallenge = lazy(() => import("./InvestigationChallenge").then((m) => ({ default: m.InvestigationChallenge })));
const BrowserSimulationChallenge = lazy(() =>
  import("./BrowserSimulationChallenge").then((m) => ({ default: m.BrowserSimulationChallenge })),
);
const InteractiveDiagramChallenge = lazy(() =>
  import("./InteractiveDiagramChallenge").then((m) => ({ default: m.InteractiveDiagramChallenge })),
);
const DragAndDropChallenge = lazy(() => import("./DragAndDropChallenge").then((m) => ({ default: m.DragAndDropChallenge })));
const BossEncounterChallenge = lazy(() => import("./BossEncounterChallenge").then((m) => ({ default: m.BossEncounterChallenge })));
const TerminalChallenge = lazy(() => import("./TerminalChallenge").then((m) => ({ default: m.TerminalChallenge })));
const CodeDebuggingChallenge = lazy(() => import("./CodeDebuggingChallenge").then((m) => ({ default: m.CodeDebuggingChallenge })));
const LogAnalysisChallenge = lazy(() => import("./LogAnalysisChallenge").then((m) => ({ default: m.LogAnalysisChallenge })));
const TimedIncidentChallenge = lazy(() => import("./TimedIncidentChallenge").then((m) => ({ default: m.TimedIncidentChallenge })));

export type ChallengeRendererProps = {
  challenge: MissionChallenge;
  onSubmit: (answer: Record<string, unknown>) => void;
  submitting?: boolean;
};

function ChallengeFallback() {
  return <div className="label-mono flicker text-muted-foreground">Loading challenge…</div>;
}

export function ChallengeRenderer({ challenge, onSubmit, submitting }: ChallengeRendererProps) {
  const props = { content: challenge.content, onSubmit, submitting };

  let element: React.ReactNode;
  switch (challenge.type) {
    case "story_dialogue":
      element = <StoryDialogueChallenge {...props} />;
      break;
    case "multiple_choice":
      element = <MultipleChoiceChallenge {...props} />;
      break;
    case "phishing_identification":
      element = <PhishingIdentificationChallenge {...props} />;
      break;
    case "investigation":
      element = <InvestigationChallenge {...props} />;
      break;
    case "browser_simulation":
      element = <BrowserSimulationChallenge {...props} />;
      break;
    case "interactive_diagram":
      element = <InteractiveDiagramChallenge {...props} />;
      break;
    case "drag_and_drop":
      element = <DragAndDropChallenge {...props} />;
      break;
    case "boss_encounter":
      element = <BossEncounterChallenge {...props} />;
      break;
    case "terminal_simulation":
      element = <TerminalChallenge {...props} />;
      break;
    case "code_debugging":
      element = <CodeDebuggingChallenge {...props} />;
      break;
    case "log_analysis":
      element = <LogAnalysisChallenge {...props} />;
      break;
    case "timed_incident":
      element = <TimedIncidentChallenge {...props} />;
      break;
    default:
      return (
        <div className="text-sm text-muted-foreground">
          Unsupported challenge type: <span className="font-mono">{challenge.type}</span>
        </div>
      );
  }

  return <Suspense fallback={<ChallengeFallback />}>{element}</Suspense>;
}
