import { test, expect } from "@playwright/test";

test.describe("signup", () => {
  test("creates a new account and lands on the HQ dashboard", async ({ page }) => {
    // Unique per run so this never collides with the persistent test user
    // or with previous runs — signup is a real Supabase account creation,
    // there's no fake/mock path for it.
    const unique = Date.now();
    const email = `e2e.signup.${unique}@cyberguardians.dev`;
    const displayName = `SIGNUP${unique}`.slice(0, 16);

    await page.goto("/signup");
    await page.getByLabel("Callsign").fill(displayName);
    await page.getByLabel("Email").fill(email);
    await page.getByLabel("Password").fill("Freshly-Signed-Up-2026!");
    await page.getByRole("button", { name: "Create account" }).click();

    await page.waitForURL("http://localhost:5173/");
    await expect(page.getByText(displayName, { exact: true })).toBeVisible();
  });

  test("rejects signing up with an already-registered email", async ({ page }) => {
    await page.goto("/signup");
    await page.getByLabel("Callsign").fill("DUPLICATE");
    await page.getByLabel("Email").fill(process.env.E2E_TEST_EMAIL!);
    await page.getByLabel("Password").fill("Whatever-Password-2026!");
    await page.getByRole("button", { name: "Create account" }).click();

    await expect(page.getByTestId("signup-error")).toBeVisible();
    await expect(page).toHaveURL(/\/signup$/);
  });
});
