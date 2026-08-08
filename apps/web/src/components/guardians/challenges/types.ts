/**
 * Shared prop shape for every per-ChallengeType renderer. `content` is
 * loosely typed (mirrors `MissionChallenge.content: Record<string,
 * unknown>` in lib/api.ts, itself a jsonb column on the API side) — each
 * component narrows the fields it expects itself rather than the
 * dispatcher casting on their behalf.
 */
export interface ChallengeComponentProps {
  content: Record<string, unknown>;
  onSubmit: (answer: Record<string, unknown>) => void;
  submitting?: boolean;
}
