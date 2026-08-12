const path = require("node:path");
const { _electron: electron } = require("../../web/node_modules/@playwright/test");

async function main() {
  const executablePath = path.resolve(__dirname, "../dist/win-unpacked/Breachsphire.exe");
  const app = await electron.launch({ executablePath });
  const errors = [];
  app.process().stderr?.on("data", (chunk) => errors.push(String(chunk).trim()));

  try {
    const window = await app.firstWindow({ timeout: 30_000 });
    window.on("pageerror", (error) => errors.push(error.message));
    window.on("console", (message) => {
      if (message.type() === "error") errors.push(message.text());
    });

    try {
      await window.getByRole("heading", { name: "Agent sign-in" }).waitFor({ timeout: 30_000 });
    } catch (error) {
      const diagnostic = await window.evaluate(() => ({
        title: document.title,
        url: window.location.href,
        text: document.body?.innerText.slice(0, 500),
        html: document.documentElement?.outerHTML.slice(0, 1_000),
      }));
      throw new Error(`${error.message}\nDiagnostic: ${JSON.stringify(diagnostic)}\nConsole: ${errors.join(" | ")}`);
    }
    const runtime = await window.evaluate(() => ({
      title: document.title,
      protocol: window.location.protocol,
      route: window.location.hash,
      nodeProcessType: typeof window.process,
      rootChildren: document.querySelector("#root")?.childElementCount ?? 0,
    }));
    const preferences = await app.evaluate(({ BrowserWindow }) =>
      BrowserWindow.getAllWindows()[0]?.webContents.getLastWebPreferences(),
    );

    if (runtime.title !== "Cyber Guardians — Join the Ops Division") {
      throw new Error(`Unexpected document title: ${runtime.title}`);
    }
    if (runtime.protocol !== "file:" || !runtime.route.startsWith("#/login")) {
      throw new Error(`Packaged routing failed: ${runtime.protocol}${runtime.route}`);
    }
    if (runtime.rootChildren < 1 || runtime.nodeProcessType !== "undefined") {
      throw new Error(`Desktop renderer did not initialize securely: ${JSON.stringify({ runtime, preferences })}`);
    }
    if (errors.length) throw new Error(`Renderer errors: ${errors.join(" | ")}`);

    process.stdout.write(`${JSON.stringify(runtime, null, 2)}\n`);
  } finally {
    await app.close();
  }
}

main().catch((error) => {
  process.stderr.write(`${error.stack || error.message}\n`);
  process.exitCode = 1;
});
