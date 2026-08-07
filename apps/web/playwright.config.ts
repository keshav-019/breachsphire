import { defineConfig, devices } from "@playwright/test";
import path from "node:path";
import fs from "node:fs";

const envTestPath = path.resolve(import.meta.dirname, ".env.test");
if (fs.existsSync(envTestPath)) {
  process.loadEnvFile(envTestPath);
}

export default defineConfig({
  testDir: "./e2e",
  fullyParallel: false,
  workers: 1,
  retries: 0,
  reporter: [["list"]],
  use: {
    baseURL: "http://localhost:5173",
    trace: "retain-on-failure",
  },
  projects: [
    {
      name: "chromium",
      use: { ...devices["Desktop Chrome"] },
    },
  ],
  webServer: {
    command: "pnpm dev",
    cwd: path.resolve(import.meta.dirname, "../.."),
    url: "http://localhost:5173",
    reuseExistingServer: true,
    timeout: 120_000,
  },
});
