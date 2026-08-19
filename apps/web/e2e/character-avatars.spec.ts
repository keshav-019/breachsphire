import { expect, test, type Locator, type Page } from "@playwright/test";
import { loginAsTestUser } from "./helpers";

type DialogueLine = {
  characterId: string;
  text: string;
};

type StoryChallenge = {
  characterId: string;
  text: string;
};

const TEST_MISSION_ID = "mission-avatar-test";

function missionPayload({
  storyDialogue = [],
  challengeLine,
}: {
  storyDialogue?: DialogueLine[];
  challengeLine?: StoryChallenge;
}) {
  return {
    id: TEST_MISSION_ID,
    worldId: "world-avatar-test",
    campaignId: "campaign-avatar-test",
    operationId: "operation-avatar-test",
    slug: "portrait-check",
    title: "Portrait Check",
    description: "A deterministic mission fixture for character portrait coverage.",
    difficulty: "beginner",
    characterIds: storyDialogue.map((line) => line.characterId),
    isBoss: false,
    rewards: { xp: 0, credits: 0 },
    status: "in_progress",
    storyDialogue,
    objectives: [
      {
        id: "objective-avatar-test",
        title: "Verify the roster",
        description: "Confirm every speaker has the expected portrait treatment.",
        completed: !challengeLine,
        challenges: challengeLine
          ? [
              {
                id: "challenge-avatar-test",
                type: "story_dialogue",
                prompt: "Review the incoming transmission.",
                content: { lines: [challengeLine] },
                hints: [],
              },
            ]
          : [],
      },
    ],
  };
}

async function openMockMission(page: Page, payload: ReturnType<typeof missionPayload>) {
  await page.route(`**/api/missions/${TEST_MISSION_ID}`, (route) =>
    route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify(payload),
    }),
  );

  await page.goto(`/mission/${TEST_MISSION_ID}`);
  await expect(page.getByText("Portrait Check", { exact: true })).toBeVisible();
}

async function expectLoadedPortrait(page: Page, name: string, assetName: string, scope?: Locator) {
  const portrait = (scope ?? page).getByRole("img", { name: `${name} avatar` });

  await expect(portrait).toBeVisible();
  await expect(portrait).toHaveAttribute(
    "src",
    new RegExp(`/assets/characters/${assetName}\\.webp(?:\\?.*)?$`),
  );
  await expect
    .poll(() => portrait.evaluate((image: HTMLImageElement) => image.complete && image.naturalWidth))
    .toBeGreaterThan(0);
}

test.describe("character portraits", () => {
  test.beforeEach(async ({ page }) => {
    await loginAsTestUser(page);
  });

  test("renders the correct portrait for whoever is currently speaking as the player taps through the scene", async ({ page }) => {
    await openMockMission(
      page,
      missionPayload({
        storyDialogue: [
          { characterId: "ava", text: "Ava portrait check." },
          { characterId: "zayn", text: "Zayn portrait check." },
          { characterId: "luna", text: "Luna portrait check." },
          { characterId: "byte", text: "Byte portrait check." },
        ],
      }),
    );

    const stage = page.getByTestId("dialogue-stage");
    const currentSpeaker = page.getByTestId("dialogue-current-speaker");

    // Only the first line is shown until the player taps through -- the
    // scene plays like a mobile visual-novel stage, one portrait at a time.
    await expectLoadedPortrait(page, "Ava", "ava", currentSpeaker);

    await stage.click();
    await expectLoadedPortrait(page, "Zayn", "zayn", currentSpeaker);

    await stage.click();
    await expectLoadedPortrait(page, "Luna", "luna", currentSpeaker);

    await stage.click();
    await expectLoadedPortrait(page, "Byte", "byte", currentSpeaker);
  });

  test("shows a character portrait inside story-dialogue challenges", async ({ page }) => {
    await openMockMission(
      page,
      missionPayload({
        challengeLine: { characterId: "byte", text: "Challenge portrait check." },
      }),
    );

    await expect(page.getByText("Challenge portrait check.")).toBeVisible();
    await expectLoadedPortrait(page, "Byte", "byte");
    await expect(page.getByRole("button", { name: "Acknowledge" })).toBeVisible();
  });

  test("keeps the initials fallback for speakers without portrait art", async ({ page }) => {
    await openMockMission(
      page,
      missionPayload({
        storyDialogue: [{ characterId: "system", text: "Fallback portrait check." }],
      }),
    );

    const currentSpeaker = page.getByTestId("dialogue-current-speaker");
    await expect(currentSpeaker.getByText("System", { exact: true })).toBeVisible();
    await expect(currentSpeaker.getByText("SY", { exact: true })).toBeVisible();
    await expect(page.getByRole("img", { name: "System avatar" })).toHaveCount(0);
  });
});
