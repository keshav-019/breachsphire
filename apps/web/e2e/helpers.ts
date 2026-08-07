import type { Page } from "@playwright/test";

export const TEST_USER = {
  email: process.env.E2E_TEST_EMAIL ?? "",
  password: process.env.E2E_TEST_PASSWORD ?? "",
  displayName: process.env.E2E_TEST_DISPLAY_NAME ?? "",
};

if (!TEST_USER.email || !TEST_USER.password) {
  throw new Error(
    "E2E_TEST_EMAIL / E2E_TEST_PASSWORD are not set — copy apps/web/.env.test.example to .env.test and fill in the persistent test account's credentials.",
  );
}

/** Logs in as the persistent test account and waits for the HQ dashboard. */
export async function loginAsTestUser(page: Page) {
  await page.goto("/login");
  await page.getByLabel("Email").fill(TEST_USER.email);
  await page.getByLabel("Password").fill(TEST_USER.password);
  await page.getByRole("button", { name: "Sign in" }).click();
  await page.waitForURL("/");
}
