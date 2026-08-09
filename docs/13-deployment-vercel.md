# Deployment: Vercel

Single Vercel project rooted at the repo root, serving both apps under one
domain — no Docker or real Linux containers anywhere in this path (see
[05-lab-system.md](./05-lab-system.md) and
[09-development-phases.md](./09-development-phases.md) Phase 7: the
in-browser terminal in `apps/web/src/lib/terminal/` is a client-side
simulation, not a real sandboxed shell, and stays that way).

## How it's wired

- **`apps/web`** builds as a static Vite/React SPA. `vercel.json`'s
  `buildCommand`/`outputDirectory` point at it directly.
- **`apps/api`** (NestJS) does **not** run as a long-lived `listen()`
  process in production. [`api/[...path].ts`](../api/[...path].ts) at the
  repo root is a Vercel Node.js serverless function that boots the same
  `AppModule` on an Express instance and hands it to Vercel's (req, res)
  handler contract. Nest bootstraps once per cold start and the Express app
  is cached across warm invocations of the same function instance.
- Nest's controllers are registered without an `/api` prefix (`/health`,
  `/worlds`, ...). Locally, `apps/web/vite.config.ts`'s dev proxy strips
  `/api` before forwarding to `localhost:3001`. In production, the
  serverless function does the same strip on `req.url` before delegating to
  Express, so `apps/web/src/lib/api.ts`'s `fetch("/api/...")` calls need no
  code changes between local dev and Vercel.
- `vercel.json`'s rewrite sends every non-`/api` path to `/index.html` so
  `react-router-dom`'s `BrowserRouter` client-side routes resolve on a hard
  refresh or direct link.
- The root `package.json` carries `express`, `@nestjs/core`,
  `@nestjs/platform-express` and `reflect-metadata` as direct dependencies
  purely so `api/[...path].ts` (which lives outside the `apps/api` pnpm
  workspace package) can resolve them — `apps/api`'s own copies are what
  actually run when the Nest app boots from `apps/api/src/app.module.ts`.

## Required environment variables (set in the Vercel dashboard)

| Variable | Used by | Notes |
|---|---|---|
| `VITE_SUPABASE_URL` | build (web) | Baked in at build time — set for Production **and** Preview. |
| `VITE_SUPABASE_ANON_KEY` | build (web) | Same as above. |
| `SUPABASE_URL` | runtime (api function) | Same Supabase project URL, used server-side for JWKS session verification. |
| `DATABASE_URL` | runtime (api function) | **Transaction pooler** string (port 6543), not the session pooler used in local dev — see `apps/api/.env.example`. |

None of these have safe defaults; the api function throws on cold start if
`DATABASE_URL`/`SUPABASE_URL` are missing, same as local dev.

## Deploying

This repo only prepares the config — actually linking/deploying needs your
Vercel account, so run it yourself:

```bash
npx vercel link
npx vercel env add VITE_SUPABASE_URL production
npx vercel env add VITE_SUPABASE_ANON_KEY production
npx vercel env add SUPABASE_URL production
npx vercel env add DATABASE_URL production
npx vercel deploy --prod
```

(Repeat the `env add` calls with `preview`/`development` targets if you want
preview deployments to hit a real backend too.)

## Known limitations carried into production

- `db.ts` connections are created once per module load and reused across
  warm invocations — fine for the transaction pooler, but a cold-start burst
  (e.g. right after a deploy) can briefly open one pooled connection per
  concurrently-cold instance. Not a problem at this project's scale; worth
  revisiting only if Supabase connection-limit errors show up in practice.
- The API function has no request timeout tuning beyond Vercel's default —
  fine for this app's synchronous DB-backed endpoints, but would need
  attention if a long-running endpoint (e.g. a future AI/agent call) is
  added later.
