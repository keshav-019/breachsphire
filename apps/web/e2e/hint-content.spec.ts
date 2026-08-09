import fs from "node:fs";
import path from "node:path";
import { expect, test } from "@playwright/test";

const migrationsDirectory = path.resolve(import.meta.dirname, "../../../infra/supabase/migrations");
const migrationSql = fs
  .readdirSync(migrationsDirectory)
  .filter((fileName) => fileName.endsWith(".sql"))
  .sort()
  .map((fileName) => fs.readFileSync(path.join(migrationsDirectory, fileName), "utf8"))
  .join("\n");

const challengePattern =
  /\(\s*'(mission-w\d+-\d+-o\d+-c\d+)'\s*,\s*'mission-w\d+-\d+-o\d+'\s*,\s*\d+\s*,\s*'([^']+)'/g;
const hintPattern =
  /\(\s*'(mission-w\d+-\d+-o\d+-c\d+)'\s*,\s*'(orientation|concept|tool_direction|near_solution|solution)'/g;

function collectChallengeTypes() {
  const challenges = new Map<string, string>();

  for (const match of migrationSql.matchAll(challengePattern)) {
    challenges.set(match[1], match[2]);
  }

  return challenges;
}

function collectHintTiers() {
  const hints = new Map<string, Set<string>>();

  for (const match of migrationSql.matchAll(hintPattern)) {
    const tiers = hints.get(match[1]) ?? new Set<string>();
    tiers.add(match[2]);
    hints.set(match[1], tiers);
  }

  return hints;
}

test.describe("hint content contract", () => {
  test("every challenge has progressive help content", () => {
    const challenges = collectChallengeTypes();
    const hints = collectHintTiers();
    const missingHints = [...challenges.keys()].filter((challengeId) => !hints.has(challengeId));

    expect(challenges.size).toBeGreaterThan(0);
    expect(missingHints, "Challenges without any hint tiers").toEqual([]);
  });

  test("every interactive challenge has a full solution", () => {
    const challenges = collectChallengeTypes();
    const hints = collectHintTiers();
    const missingSolutions = [...challenges.entries()]
      .filter(([, challengeType]) => challengeType !== "story_dialogue")
      .filter(([challengeId]) => !hints.get(challengeId)?.has("solution"))
      .map(([challengeId]) => challengeId);

    expect(missingSolutions, "Interactive challenges without a solution tier").toEqual([]);
  });
});
