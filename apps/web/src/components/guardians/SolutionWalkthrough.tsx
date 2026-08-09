import * as Dialog from "@radix-ui/react-dialog";
import { BookOpenCheck, CheckCircle2, Crosshair, Route, ShieldCheck, X } from "lucide-react";
import { Button } from "@/components/ui/button";

export type SolutionContext = {
  challengePrompt: string;
  challengeType: string;
  objectiveTitle?: string;
  missionTitle?: string;
  missionDescription?: string;
};

type SolutionWalkthroughProps = {
  solution: string;
  context: SolutionContext;
  onClose: () => void;
};

const APPROACH_BY_CHALLENGE: Record<string, string> = {
  browser_simulation:
    "You are reading the browser as evidence: checking the real destination, trust boundary, and observable state instead of trusting visual appearance.",
  boss_encounter:
    "You are combining evidence gathered across earlier objectives into one defensible operational conclusion.",
  code_debugging:
    "You are tracing behavior through code, isolating the faulty assumption, and applying the smallest change that repairs it.",
  drag_and_drop:
    "You are classifying each item by the rule behind it, so the same reasoning transfers to unfamiliar examples later.",
  interactive_diagram:
    "You are turning a visual system into an ordered mental model, then using relationships between its parts to reach the answer.",
  investigation:
    "You are separating decisive evidence from background noise and building a conclusion that another investigator could reproduce.",
  log_analysis:
    "You are correlating timestamps, identities, and events to reconstruct what happened rather than reading isolated log lines.",
  multiple_choice:
    "You are testing each plausible answer against the available evidence, eliminating choices that are only superficially convincing.",
  phishing_identification:
    "You are examining identity, destination, context, and pressure tactics independently instead of judging the message by appearance alone.",
  terminal_simulation:
    "You are translating the investigation goal into precise commands, narrowing the evidence, and verifying the result before submitting it.",
  timed_incident:
    "You are prioritizing the actions that reduce immediate harm while preserving the evidence and options needed for the next decision.",
};

function splitSolutionIntoSteps(solution: string): string[] {
  const clean = solution.trim();
  if (!clean) return [];

  const arrowParts = clean.split(/\s*(?:->|→)\s*/).filter(Boolean);
  if (arrowParts.length > 1) return arrowParts;

  const sentences = clean.split(/(?<=[.!?])\s+(?=[A-Z0-9"'])/).filter(Boolean);
  if (sentences.length > 1) return sentences;

  const clauses = clean.split(/;\s+/).filter(Boolean);
  return clauses.length > 1 ? clauses : [clean];
}

export function SolutionWalkthrough({ solution, context, onClose }: SolutionWalkthroughProps) {
  const steps = splitSolutionIntoSteps(solution);
  const approach =
    APPROACH_BY_CHALLENGE[context.challengeType] ??
    "You are applying the evidence in the challenge methodically, then checking that the result satisfies the stated objective.";
  const missionSentence =
    context.missionTitle && context.missionDescription
      ? "Inside " +
        context.missionTitle +
        ", this advances the operation's purpose: " +
        context.missionDescription
      : null;
  const missionImpact = [
    context.objectiveTitle ? "This resolves the objective “" + context.objectiveTitle + ".”" : null,
    missionSentence,
  ]
    .filter(Boolean)
    .join(" ");

  return (
    <Dialog.Root open onOpenChange={(open) => !open && onClose()}>
      <Dialog.Portal>
        <Dialog.Overlay className="fixed inset-0 z-50 bg-background/85 backdrop-blur-sm" />
        <Dialog.Content
          data-testid="solution-walkthrough"
          className="corner-cut hud-grid fixed top-1/2 left-1/2 z-50 max-h-[90vh] w-[calc(100vw-2rem)] max-w-4xl -translate-x-1/2 -translate-y-1/2 overflow-y-auto border border-primary/40 bg-background p-5 shadow-2xl focus:outline-none sm:p-6"
        >
        <div className="flex items-start gap-3">
          <span className="grid h-9 w-9 shrink-0 place-items-center border border-primary/35 bg-primary/10 text-primary">
            <BookOpenCheck className="h-4 w-4" />
          </span>
          <div className="min-w-0 flex-1">
            <div className="label-mono text-primary">Step-by-step walkthrough</div>
            <Dialog.Title className="mt-1 font-display text-xl text-foreground">
              Full solution
            </Dialog.Title>
            <Dialog.Description className="mt-2 text-sm leading-relaxed text-muted-foreground">
              Goal: {context.challengePrompt}
            </Dialog.Description>
          </div>
          <Dialog.Close asChild>
            <Button type="button" size="icon" variant="ghost" aria-label="Close full solution">
              <X />
            </Button>
          </Dialog.Close>
        </div>

        <ol className="mt-4 space-y-3">
          {steps.map((step, index) => (
            <li
              key={index + "-" + step}
              className="flex gap-3 border border-border/70 bg-surface/65 p-3"
            >
              <span className="grid h-6 w-6 shrink-0 place-items-center bg-primary font-mono text-[0.65rem] font-bold text-primary-foreground">
                {index + 1}
              </span>
              <div>
                <div className="font-display text-xs text-foreground">Step {index + 1}</div>
                <p className="mt-1 text-xs leading-relaxed text-muted-foreground">{step}</p>
              </div>
            </li>
          ))}
        </ol>

        <div className="mt-4 grid gap-3">
          <div className="border border-telemetry/25 bg-telemetry/6 p-3">
            <div className="flex items-center gap-2 text-telemetry">
              <Crosshair className="h-3.5 w-3.5" />
              <span className="font-display text-xs">What you&apos;re doing</span>
            </div>
            <p className="mt-2 text-xs leading-relaxed text-muted-foreground">{approach}</p>
          </div>

          <div className="border border-clearance/25 bg-clearance/6 p-3">
            <div className="flex items-center gap-2 text-clearance">
              <Route className="h-3.5 w-3.5" />
              <span className="font-display text-xs">How this helps the operation</span>
            </div>
            <p className="mt-2 text-xs leading-relaxed text-muted-foreground">
              {missionImpact ||
                "This clears the current objective and preserves your progress through the operation."}
            </p>
          </div>

          <div className="border border-primary/25 bg-primary/6 p-3">
            <div className="flex items-center gap-2 text-primary">
              <ShieldCheck className="h-3.5 w-3.5" />
              <span className="font-display text-xs">Carry this forward</span>
            </div>
            <p className="mt-2 text-xs leading-relaxed text-muted-foreground">
              Don&apos;t memorize only the final answer. Notice which evidence or operation made it
              correct; that decision rule is what will help when the next mission changes the
              surface details.
            </p>
          </div>
        </div>

        <div className="mt-4 flex items-start gap-2 border-t border-border/60 pt-3 text-xs text-foreground">
          <CheckCircle2 className="mt-0.5 h-3.5 w-3.5 shrink-0 text-telemetry" />
          Apply the result above in the challenge, then verify it against the goal before submitting.
        </div>
        </Dialog.Content>
      </Dialog.Portal>
    </Dialog.Root>
  );
}
