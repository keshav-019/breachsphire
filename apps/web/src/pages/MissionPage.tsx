import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { CheckCircle2, Sparkles, XCircle } from "lucide-react";
import {
  fetchMissionDetail,
  revealHint,
  startMission,
  submitAttempt,
  type AttemptResult,
} from "@/lib/api";
import { DialogueBox } from "@/components/guardians/DialogueBox";
import { ObjectiveChecklist, type Objective } from "@/components/guardians/ObjectiveChecklist";
import { HintPanel } from "@/components/guardians/HintPanel";
import { IdleHintPrompt } from "@/components/guardians/IdleHintPrompt";
import { ChallengeRenderer } from "@/components/guardians/challenges/ChallengeRenderer";
import { Button } from "@/components/ui/button";
import { getCharacterProfile } from "@/lib/characters";
import { useIdleHintPrompt } from "@/hooks/useIdleHintPrompt";
import { usePathwayStore } from "@/store/pathway";

/** Every pathway's own AI companion, keyed by slug -- used only as the
 * fallback when a mission's cast has neither (e.g. a Mira-only mission). */
const PATHWAY_DEFAULT_COMPANION: Record<string, string> = {
  "cyber-guardians": "byte",
  "backend-engineering": "forge",
};

export default function MissionPage() {
  const { missionId } = useParams<{ missionId: string }>();
  const queryClient = useQueryClient();
  const [lastResult, setLastResult] = useState<AttemptResult | null>(null);
  const [autoOpenHintTier, setAutoOpenHintTier] = useState<string | null>(null);

  const missionQuery = useQuery({
    queryKey: ["mission", missionId],
    queryFn: () => fetchMissionDetail(missionId!),
    enabled: Boolean(missionId),
  });

  const mission = missionQuery.data;
  const currentObjective = mission?.objectives.find((objective) => !objective.completed) ?? null;
  // World 0 is one challenge per objective throughout -- a future world
  // with multiple challenges per objective needs per-challenge completion
  // in the API response to pick the right one here.
  const currentChallenge = currentObjective?.challenges[0] ?? null;
  const currentChallengeId = currentChallenge?.id;
  const nextHint = currentChallenge?.hints.find((hint) => !hint.revealed) ?? null;
  const canOfferIdleHint =
    mission?.status === "in_progress" &&
    currentChallenge?.type !== "story_dialogue" &&
    Boolean(nextHint);
  const idleHintPrompt = useIdleHintPrompt({
    challengeId: currentChallengeId,
    enabled: canOfferIdleHint,
  });
  // Only ever attribute the "AI companion" panel to an actual AI character
  // (Byte for Cyber Guardians, Forge for The Fracture) -- never to a human
  // mentor like Ava/Mira just because they happen to be first in the cast.
  // Falls back to the *current pathway's* companion, not a hardcoded one --
  // plenty of missions (e.g. Mira-only ones) never mention Forge by name.
  const pathwaySlug = usePathwayStore((s) => s.selectedPathwaySlug);
  const AI_COMPANION_IDS = ["byte", "forge"];
  const defaultCompanionId = (pathwaySlug && PATHWAY_DEFAULT_COMPANION[pathwaySlug]) || "byte";
  const companionCharacterId =
    mission?.characterIds.find((id) => AI_COMPANION_IDS.includes(id)) ?? defaultCompanionId;
  const companionName = getCharacterProfile(companionCharacterId).name;

  useEffect(() => {
    setAutoOpenHintTier(null);
    setLastResult(null);
  }, [currentChallengeId]);

  const invalidateMission = () => queryClient.invalidateQueries({ queryKey: ["mission", missionId] });

  const startMutation = useMutation({
    mutationFn: () => startMission(missionId!),
    onSuccess: invalidateMission,
  });

  const hintMutation = useMutation({
    mutationFn: (tier: string) => revealHint(currentChallengeId!, tier),
    onSuccess: async (_hint, tier) => {
      setAutoOpenHintTier(tier);
      await invalidateMission();
    },
  });

  const attemptMutation = useMutation({
    mutationFn: (answer: Record<string, unknown>) => submitAttempt(currentChallengeId!, answer),
    onSuccess: (result) => {
      setLastResult(result);
      invalidateMission();
      if (mission) {
        queryClient.invalidateQueries({ queryKey: ["worldMissions", mission.worldId] });
        if (result.worldCleared) {
          queryClient.invalidateQueries({ queryKey: ["worlds"] });
        }
      }
    },
  });

  const handleHintReveal = (tier: string) => {
    idleHintPrompt.dismiss();
    hintMutation.mutate(tier);
  };

  if (missionQuery.isLoading) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono flicker">Decrypting mission file…</span>
      </div>
    );
  }

  if (missionQuery.error || !mission) {
    return (
      <div className="px-5 py-8">
        <span className="label-mono text-threat">Failed to load this mission.</span>
      </div>
    );
  }

  const allComplete = mission.objectives.every((o) => o.completed);
  const objectives: Objective[] = mission.objectives.map((o) => ({
    id: o.id,
    label: o.title,
    done: o.completed,
  }));

  return (
    <div className="flex min-h-[calc(100vh-4rem)] flex-col">
      <div className="flex flex-wrap items-center gap-3 border-b border-border px-5 py-3">
        <Link to={`/worlds/${mission.worldId}`} className="label-mono text-primary">
          &larr; Missions
        </Link>
        <span className="font-mono text-xs text-primary">{mission.title}</span>
        {mission.isBoss && <span className="label-mono text-threat">Boss</span>}
      </div>

      <div className="grid flex-1 gap-4 p-4 lg:grid-cols-[300px_1fr_300px]">
        {/* LEFT — story + objectives */}
        <div className="space-y-4">
          {mission.storyDialogue.map((line, i) => {
            const info = getCharacterProfile(line.characterId);
            return (
              <DialogueBox
                key={i}
                speaker={info.name}
                characterId={line.characterId}
                role={info.role}
                line={line.text}
              />
            );
          })}
          <div className="hud-panel corner-cut p-4">
            <ObjectiveChecklist objectives={objectives} />
          </div>
        </div>

        {/* CENTER — the challenge itself */}
        <div className="hud-panel corner-cut flex min-h-[420px] flex-col justify-center p-6">
          {mission.status === "available" && !startMutation.isSuccess ? (
            <div className="mx-auto max-w-sm space-y-4 text-center">
              <p className="text-sm text-muted-foreground">
                Briefing received. Start the mission to begin.
              </p>
              <Button disabled={startMutation.isPending} onClick={() => startMutation.mutate()}>
                Start mission
              </Button>
            </div>
          ) : allComplete ? (
            <div className="mx-auto max-w-sm space-y-4 text-center">
              <CheckCircle2 className="mx-auto h-10 w-10 text-telemetry" />
              <h2 className="font-display text-lg text-foreground">Mission complete</h2>
              {lastResult?.rewardsApplied && (
                <p className="font-mono text-sm text-telemetry">
                  +{lastResult.rewardsApplied.xp} XP · +{lastResult.rewardsApplied.credits} credits
                </p>
              )}
              {lastResult?.worldCleared && (
                <p className="text-xs text-primary">World cleared — the next world just unlocked.</p>
              )}
              <Button asChild variant="outline">
                <Link to={`/worlds/${mission.worldId}`}>Return to missions</Link>
              </Button>
            </div>
          ) : currentChallenge ? (
            <div className="space-y-6">
              <p className="mx-auto max-w-xl text-center text-sm text-muted-foreground">
                {currentChallenge.prompt}
              </p>
              <div
                data-testid="challenge-interaction-zone"
                onChangeCapture={idleHintPrompt.noteActivity}
                onClickCapture={idleHintPrompt.noteActivity}
                onInputCapture={idleHintPrompt.noteActivity}
                onKeyDownCapture={idleHintPrompt.noteActivity}
                onPointerDownCapture={idleHintPrompt.noteActivity}
              >
                <ChallengeRenderer
                  challenge={currentChallenge}
                  submitting={attemptMutation.isPending}
                  onSubmit={(answer) => attemptMutation.mutate(answer)}
                />
              </div>
              {idleHintPrompt.visible && nextHint && (
                <IdleHintPrompt
                  hint={nextHint}
                  revealing={hintMutation.isPending}
                  onReveal={handleHintReveal}
                  onDismiss={idleHintPrompt.dismiss}
                  companionName={companionName}
                  companionCharacterId={companionCharacterId}
                />
              )}
              {lastResult && !lastResult.correct && (
                <div className="mx-auto flex max-w-sm items-center gap-2 border border-threat/50 bg-threat/10 p-3 text-sm text-threat">
                  <XCircle className="h-4 w-4 shrink-0" />
                  Not quite. Check the hints if you're stuck.
                </div>
              )}
              {lastResult?.correct && !lastResult.missionCompleted && (
                <div className="mx-auto flex max-w-sm items-center gap-2 border border-telemetry/50 bg-telemetry/10 p-3 text-sm text-telemetry">
                  <CheckCircle2 className="h-4 w-4 shrink-0" />
                  Correct — moving to the next objective.
                </div>
              )}
            </div>
          ) : (
            <p className="text-center text-sm text-muted-foreground">No challenge available.</p>
          )}
        </div>

        {/* RIGHT — hints, companion */}
        <div className="space-y-4">
          {currentChallenge && currentChallenge.hints.length > 0 && (
            <HintPanel
              key={currentChallenge.id}
              hints={currentChallenge.hints}
              revealing={hintMutation.isPending}
              autoOpenTier={autoOpenHintTier}
              context={{
                challengePrompt: currentChallenge.prompt,
                challengeType: currentChallenge.type,
                objectiveTitle: currentObjective?.title,
                missionTitle: mission.title,
                missionDescription: mission.description,
              }}
              onReveal={handleHintReveal}
            />
          )}

          <div className="hud-panel corner-cut p-4">
            <div className="flex items-center gap-2">
              <Sparkles className="h-4 w-4 text-clearance" />
              <span className="label-mono text-clearance">{companionName} · AI companion</span>
            </div>
            <div className="mt-3 border border-clearance/30 bg-clearance/8 p-3 text-xs leading-relaxed text-foreground">
              {mission.description}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
