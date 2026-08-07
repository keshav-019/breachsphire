import { test, expect } from "@playwright/test";
import { loginAsTestUser } from "./helpers";

test.describe("world map", () => {
  test.beforeEach(async ({ page }) => {
    await loginAsTestUser(page);
    await page.getByRole("link", { name: "World Map" }).click();
    await page.waitForURL("/map");
  });

  test("renders all 20 worlds fetched from the real API", async ({ page }) => {
    await expect(page.getByRole("heading", { name: "The Grid" })).toBeVisible();
    await expect(page.getByRole("button", { name: "Cyber Guardian Academy" })).toBeVisible();
    await expect(page.getByRole("button", { name: "AI Security" })).toBeVisible();

    // One WorldNode <button> per world, scoped to the map canvas (the HudBar's
    // "Sign out" button is also a <button> but lives outside this container).
    await expect(page.getByTestId("world-map-canvas").getByRole("button")).toHaveCount(20);
  });

  test("a fresh account starts with only Academy unlocked", async ({ page }) => {
    await page.getByText("Worlds secured").locator("..").getByText("/ 20").isVisible();

    await page.getByRole("button", { name: "Cyber Guardian Academy" }).click();
    await expect(page.getByTestId("world-status")).toHaveText("unlocked");
    await expect(page.getByRole("link", { name: "Enter world" })).toBeVisible();

    await page.getByRole("button", { name: "Windows Fortress" }).click();
    await expect(page.getByTestId("world-status")).toHaveText("locked");
    await expect(page.getByText("Clearance required")).toBeVisible();
    await expect(page.getByRole("link", { name: "Enter world" })).toHaveCount(0);
  });
});
