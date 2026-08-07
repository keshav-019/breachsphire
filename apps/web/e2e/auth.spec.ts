import { test, expect } from "@playwright/test";
import { loginAsTestUser, TEST_USER } from "./helpers";

test.describe("authentication", () => {
  test("redirects unauthenticated visitors to /login", async ({ page }) => {
    await page.goto("/");
    await page.waitForURL("/login");
    await expect(page.getByRole("heading", { name: "Agent sign-in" })).toBeVisible();
  });

  test("redirects to /login when visiting a protected route directly", async ({ page }) => {
    await page.goto("/map");
    await page.waitForURL("/login");
  });

  test("rejects an invalid password with a visible error and no navigation", async ({ page }) => {
    await page.goto("/login");
    await page.getByLabel("Email").fill(TEST_USER.email);
    await page.getByLabel("Password").fill("definitely-the-wrong-password");
    await page.getByRole("button", { name: "Sign in" }).click();

    await expect(page.getByTestId("login-error")).toBeVisible();
    await expect(page).toHaveURL(/\/login$/);
  });

  test("logs in with valid credentials and reaches the HQ dashboard", async ({ page }) => {
    await loginAsTestUser(page);

    await expect(page).toHaveURL("http://localhost:5173/");
    await expect(page.getByText(TEST_USER.displayName, { exact: true })).toBeVisible();
    await expect(page.getByRole("heading", { name: /grid is under attack/i })).toBeVisible();
  });

  test("session persists across a page reload", async ({ page }) => {
    await loginAsTestUser(page);
    await page.reload();
    await expect(page).toHaveURL("http://localhost:5173/");
    await expect(page.getByRole("button", { name: "Sign out" })).toBeVisible();
  });

  test("logs out and redirects to /login, and the route stays protected afterwards", async ({ page }) => {
    await loginAsTestUser(page);
    await page.getByRole("button", { name: "Sign out" }).click();
    await page.waitForURL("/login");

    // confirm the session is really gone, not just a client-side redirect
    await page.goto("/");
    await page.waitForURL("/login");
  });
});
