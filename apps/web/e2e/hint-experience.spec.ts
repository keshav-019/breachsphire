import { expect, test, type Page } from "@playwright/test";
import { HINT_IDLE_DELAY_MS } from "../src/hooks/useIdleHintPrompt";
import { loginAsTestUser } from "./helpers";

const TEST_MISSION_ID = "mission-hint-experience-test";
const TEST_CHALLENGE_ID = "challenge-hint-experience-test";

const HINT_TEXT: Record<string, string> = {
  orientation: "Start by comparing the destination host with the service the request claims to use.",
  solution:
    "First, isolate the request whose destination does not match the approved service. Next, verify that its fixed interval continues without user activity. Finally, submit that request as the automated beacon because destination mismatch and machine-regular timing are independent pieces of evidence.",
};

function missionPayload(revealedTiers: Set<string>) {
  return {
    id: TEST_MISSION_ID,
    worldId: "world-hint-test",
    campaignId: "campaign-hint-test",
    operationId: "operation-hint-test",
    slug: "guided-investigation",
    title: "Guided Investigation",
    description:
      "Identify the disguised beacon before it reaches the next command window and preserve the evidence that proves it is automated.",
    difficulty: "beginner",
    characterIds: ["byte"],
    isBoss: false,
    rewards: { xp: 100, credits: 15 },
    status: "in_progress",
    storyDialogue: [],
    objectives: [
      {
        id: "objective-hint-experience-test",
        title: "Trace the suspicious request",
        description: "Separate the automated beacon from ordinary user traffic.",
        completed: false,
        challenges: [
          {
            id: TEST_CHALLENGE_ID,
            type: "multiple_choice",
            prompt: "Which request is the automated beacon?",
            content: {
              question: "Which request is the automated beacon?",
              options: [
                { id: "normal", text: "The user-initiated request to the approved service" },
                { id: "beacon", text: "The fixed-interval request to an unapproved host" },
              ],
            },
            hints: [
              {
                tier: "orientation",
                xpCost: 10,
                revealed: revealedTiers.has("orientation"),
                text: revealedTiers.has("orientation") ? HINT_TEXT.orientation : null,
              },
              {
                tier: "solution",
                xpCost: 50,
                revealed: revealedTiers.has("solution"),
                text: revealedTiers.has("solution") ? HINT_TEXT.solution : null,
              },
            ],
          },
        ],
      },
    ],
  };
}

async function openHintMission(page: Page, initiallyRevealed: string[] = []) {
  const revealedTiers = new Set(initiallyRevealed);

  await page.route("**/api/missions/" + TEST_MISSION_ID, (route) =>
    route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify(missionPayload(revealedTiers)),
    }),
  );

  await page.route("**/api/challenges/" + TEST_CHALLENGE_ID + "/hints/*", (route) => {
    const tier = new URL(route.request().url()).pathname.split("/").at(-1) ?? "";
    const text = HINT_TEXT[tier];

    if (!text) {
      return route.fulfill({
        status: 404,
        contentType: "application/json",
        body: JSON.stringify({ message: "Unknown test hint" }),
      });
    }

    revealedTiers.add(tier);
    return route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify({
        tier,
        text,
        xpCost: tier === "solution" ? 50 : 10,
      }),
    });
  });

  await page.goto("/mission/" + TEST_MISSION_ID);
  await expect(page.getByText("Guided Investigation", { exact: true })).toBeVisible();
}

test.describe("guided hint experience", () => {
  test.beforeEach(async ({ page }) => {
    await loginAsTestUser(page);
  });

  test("offers and opens the next hint after the learner becomes idle", async ({ page }) => {
    await page.clock.install();
    await openHintMission(page);

    await expect(page.getByTestId("idle-hint-prompt")).toHaveCount(0);
    await page.clock.fastForward(HINT_IDLE_DELAY_MS);

    const offer = page.getByTestId("idle-hint-prompt");
    await expect(offer).toBeVisible();
    await expect(offer.getByRole("heading", { name: "Need a hand?" })).toBeVisible();
    await expect(offer).toContainText("It costs 10 XP.");

    await offer.getByRole("button", { name: "Reveal next hint" }).click();

    await expect(page.getByText(HINT_TEXT.orientation)).toBeVisible();
    await expect(page.getByTestId("hint-tier-orientation").getByRole("button")).toHaveAttribute(
      "aria-expanded",
      "true",
    );
  });

  test("resets the idle window whenever the learner interacts", async ({ page }) => {
    await page.clock.install();
    await openHintMission(page);

    await page.clock.fastForward(HINT_IDLE_DELAY_MS - 5_000);
    await page
      .getByRole("button", { name: "The fixed-interval request to an unapproved host" })
      .click();
    await page.clock.fastForward(HINT_IDLE_DELAY_MS - 5_000);

    await expect(page.getByTestId("idle-hint-prompt")).toHaveCount(0);

    await page.clock.fastForward(5_000);
    await expect(page.getByTestId("idle-hint-prompt")).toBeVisible();
  });

  test("presents the full solution as an explanatory walkthrough", async ({ page }) => {
    await openHintMission(page, ["orientation"]);

    await page.getByTestId("hint-tier-solution").getByRole("button").click();

    const walkthrough = page.getByTestId("solution-walkthrough");
    await expect(walkthrough).toBeVisible();
    await expect(walkthrough.getByRole("heading", { name: "Full solution" })).toBeVisible();
    await expect(walkthrough.getByText("Step-by-step walkthrough")).toBeVisible();
    await expect(walkthrough.getByText("Step 1", { exact: true })).toBeVisible();
    await expect(walkthrough.getByText("Step 2", { exact: true })).toBeVisible();
    await expect(walkthrough.getByText("Step 3", { exact: true })).toBeVisible();
    await expect(walkthrough.getByText("What you're doing")).toBeVisible();
    await expect(walkthrough.getByText("How this helps the operation")).toBeVisible();
    await expect(walkthrough).toContainText("Trace the suspicious request");
    await expect(walkthrough).toContainText("Identify the disguised beacon");
    await expect(walkthrough.getByText("Carry this forward")).toBeVisible();

    await walkthrough.getByRole("button", { name: "Close full solution" }).click();
    await expect(walkthrough).toHaveCount(0);
  });
});
