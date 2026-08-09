/**
 * Evaluates a submitted challenge answer against a challenge's
 * `completionConditions` (packages/types/src/mission.ts's
 * `Challenge.completionConditions`). Pure and DB-free by design — the one
 * shape that needs outside state (`boss_encounter`'s `requiredObjectiveIds`)
 * takes it as an explicit `completedObjectiveIds` set rather than querying
 * anything itself, so this stays independently testable.
 *
 * One branch per `completionConditions` shape actually used in the World 0
 * content (docs' Phase 2.4 plan documents the convention per
 * `ChallengeType`). Order matters: shapes are checked most-specific first
 * so a conditions object that happens to carry multiple recognized keys
 * doesn't fall through to the wrong branch.
 */

export interface CompletionContext {
  /** Objective ids already completed by this player — used only by the
   * `requiredObjectiveIds` (boss_encounter synthesis) shape. */
  completedObjectiveIds: ReadonlySet<string>;
}

export class UnrecognizedCompletionConditionsError extends Error {
  constructor(conditions: Record<string, unknown>) {
    super(`Unrecognized completionConditions shape: ${Object.keys(conditions).join(", ")}`);
    this.name = "UnrecognizedCompletionConditionsError";
  }
}

function isStringArray(value: unknown): value is string[] {
  return Array.isArray(value) && value.every((v) => typeof v === "string");
}

function setsEqual(a: unknown, b: unknown): boolean {
  if (!isStringArray(a) || !isStringArray(b)) return false;
  if (a.length !== b.length) return false;
  const setB = new Set(b);
  return a.every((v) => setB.has(v));
}

function arraysEqualInOrder(a: unknown, b: unknown): boolean {
  if (!isStringArray(a) || !isStringArray(b)) return false;
  if (a.length !== b.length) return false;
  return a.every((v, i) => v === b[i]);
}

function isPlainRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function mappingsEqual(a: unknown, b: unknown): boolean {
  if (!isPlainRecord(a) || !isPlainRecord(b)) return false;
  const aKeys = Object.keys(a);
  const bKeys = Object.keys(b);
  if (aKeys.length !== bKeys.length) return false;
  return aKeys.every((k) => a[k] === b[k]);
}

export function evaluateCompletion(
  conditions: Record<string, unknown>,
  answer: Record<string, unknown>,
  ctx: CompletionContext,
): boolean {
  // boss_encounter synthesis: doesn't look at `answer` at all — it checks
  // that the mission's other objectives are already recorded as complete.
  if ("requiredObjectiveIds" in conditions && conditions.allCorrect === true) {
    const required = conditions.requiredObjectiveIds;
    if (!isStringArray(required)) return false;
    return required.every((id) => ctx.completedObjectiveIds.has(id));
  }

  if ("acknowledged" in conditions) {
    return answer.acknowledged === true;
  }

  // terminal_simulation: the player captures a value by exploring the
  // virtual filesystem client-side (TerminalChallenge.tsx) and submits it
  // via the shell's `submit`/`done` builtin. `requireEvidencePreserved`
  // additionally requires the client-computed evidencePreserved flag (no
  // protected path was deleted or overwritten during the session).
  if ("requiredFlag" in conditions) {
    if (typeof conditions.requiredFlag !== "string") return false;
    if (answer.flag !== conditions.requiredFlag) return false;
    if (conditions.requireEvidencePreserved === true && answer.evidencePreserved !== true) return false;
    return true;
  }

  if ("correctOptionId" in conditions) {
    return typeof conditions.correctOptionId === "string" && answer.selectedOptionId === conditions.correctOptionId;
  }

  // Multi-select variant of the above (e.g. "select every affected
  // project" in a browser_simulation challenge).
  if ("correctOptionIds" in conditions) {
    return setsEqual(answer.selectedOptionIds, conditions.correctOptionIds);
  }

  if ("correctPageId" in conditions) {
    return typeof conditions.correctPageId === "string" && answer.selectedPageId === conditions.correctPageId;
  }

  if ("requiredActionId" in conditions) {
    return typeof conditions.requiredActionId === "string" && answer.actionId === conditions.requiredActionId;
  }

  if ("correctOrderIds" in conditions) {
    return arraysEqualInOrder(answer.orderedIds, conditions.correctOrderIds);
  }

  if ("correctMapping" in conditions) {
    return mappingsEqual(answer.mapping, conditions.correctMapping);
  }

  if ("correctArtifactIds" in conditions) {
    return setsEqual(answer.selectedArtifactIds, conditions.correctArtifactIds);
  }

  if ("requiredEvidenceIds" in conditions) {
    return setsEqual(answer.selectedEvidenceIds, conditions.requiredEvidenceIds);
  }

  // code_debugging: the player clicks the offending line(s) in a code/config
  // block; the id compared here is the line's exact text, not a synthetic id.
  if ("requiredLineIds" in conditions) {
    return setsEqual(answer.selectedLineIds, conditions.requiredLineIds);
  }

  // log_analysis: same shape as requiredEvidenceIds, over log lines instead.
  if ("requiredLogLineIds" in conditions) {
    return setsEqual(answer.selectedLogLineIds, conditions.requiredLogLineIds);
  }

  throw new UnrecognizedCompletionConditionsError(conditions);
}
