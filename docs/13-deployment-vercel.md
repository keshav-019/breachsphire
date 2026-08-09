# Deployment: Vercel (frontend) + Render (API)

Split hosting: `apps/web` on Vercel as a static SPA, `apps/api` on Render as
a normal long-lived NestJS process — no Docker or real Linux containers
anywhere in this path (see [05-lab-system.md](./05-lab-system.md) and
[09-development-phases.md](./09-development-phases.md) Phase 7: the
in-browser terminal in `apps/web/src/lib/terminal/` is a client-side
simulation, not a real sandboxed shell, and stays that way).

A single-Vercel-project setup (frontend + a Vercel serverless function for
the API) was tried first and abandoned — the NestJS app wrapped in a Vercel
Node function threw `FUNCTION_INVOCATION_FAILED` at runtime in production
despite working in a local esbuild-bundled smoke test. Rather than keep
debugging Nest-on-Vercel-serverless, the API moved to Render, which runs it
exactly like local dev (`node dist/main.js`, no serverless adapter, no
request/response wrapping) — simpler and more predictable for a stateful
NestJS app.

## How it's wired

- **`apps/web`** builds as a static Vite/React SPA on Vercel. `vercel.json`'s
  `buildCommand`/`outputDirectory` point at it directly.
- **`apps/api`** (NestJS) runs on Render as a genuine long-lived
  `listen()` process — the same `pnpm --filter @cyber-guardians/api build`
  + `pnpm --filter @cyber-guardians/api start` (`node dist/main.js`) as
  local dev, reading `PORT` from Render's environment
  (`apps/api/src/main.ts` already does this). Render Root Directory is left
  at the repo root so the pnpm workspace resolves correctly.
- Nest's controllers are registered without an `/api` prefix (`/health`,
  `/worlds`, ...). `vercel.json` rewrites `/api/:path*` to
  `https://breachsphire-api.onrender.com/:path*`, stripping the `/api`
  prefix via the rewrite's capture group — the same effective behavior as
  the local Vite dev-server proxy (`apps/web/vite.config.ts`). Because the
  rewrite runs server-side at Vercel's edge, the browser only ever talks to
  one origin (`breachsphire.vercel.app`), so `apps/web/src/lib/api.ts`'s
  relative `fetch("/api/...")` calls work unchanged and there's no CORS
  concern to configure.
- `vercel.json`'s second rewrite sends every non-`/api` path to
  `/index.html` so `react-router-dom`'s `BrowserRouter` client-side routes
  resolve on a hard refresh or direct link. Order matters: the `/api/:path*`
  rewrite is listed first so it wins before the catch-all.
- `apps/api/src/db/client.ts` still passes `{ prepare: false }` to the
  postgres client. Harmless for the session pooler Render uses (matching
  local dev), and keeps the option open to move to a transaction pooler
  later without another code change.

## Required environment variables

| Variable | Set where | Notes |
|---|---|---|
| `VITE_SUPABASE_URL` | Vercel (build-time) | Baked in at build time — set for Production **and** Preview. |
| `VITE_SUPABASE_ANON_KEY` | Vercel (build-time) | Same as above. |
| `SUPABASE_URL` | Render (runtime) | Same value as local `apps/api/.env`. |
| `DATABASE_URL` | Render (runtime) | Same value as local `apps/api/.env` (session pooler) — Render runs a persistent process like local dev, so no pooler-mode change is needed here, unlike the abandoned Vercel-serverless approach. |

None of these have safe defaults; the API throws on boot if
`DATABASE_URL`/`SUPABASE_URL` are missing, same as local dev.

## Deploying

Both platforms are git-connected to `main` — push, and both redeploy
automatically. First-time setup (already done for this project, documented
here for reference):

**Vercel** — `npx vercel link` then `npx vercel env add <NAME> production`
for each `VITE_*` variable, or set them in the dashboard under Project
Settings → Environment Variables.

**Render** — Web Service, root directory blank (repo root), build command
`pnpm install && pnpm --filter @cyber-guardians/api build`, start command
`pnpm --filter @cyber-guardians/api start`, `SUPABASE_URL`/`DATABASE_URL`
set under the service's Environment tab.

## Known limitations carried into production

- Render's free tier spins the service down after ~15 minutes of
  inactivity; the next request pays a cold-start penalty (tens of seconds).
  Acceptable for this project's current scale — worth upgrading off the
  free tier if that latency becomes a real problem.
- No request timeout tuning beyond each platform's default — fine for this
  app's synchronous DB-backed endpoints, but would need attention if a
  long-running endpoint (e.g. a future AI/agent call) is added later.
