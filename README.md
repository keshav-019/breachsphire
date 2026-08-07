# Cyber Guardians

A story-driven cybersecurity learning game. Players join a futuristic
cybersecurity organization, get sent on missions, investigate incidents, and
level up through 20 worlds — from absolute-beginner fundamentals to AI
security — earning ranks, skills, and gear along the way instead of watching
lectures and taking quizzes.

Full design and architecture reference: **[docs/](./docs/README.md)**.

## Quickstart

Needs a Supabase project for auth + the database. Two ways to get one:

- **Cloud (default, no Docker needed)** — create a free project at
  [supabase.com](https://supabase.com), run the SQL in
  `infra/supabase/migrations/` via its SQL Editor, then grab the Project URL /
  anon key / JWT Secret from Project Settings → API.
- **Local (needs Docker)** — `pnpm db:start` boots the same stack
  (Postgres + Auth + Studio) via the Supabase CLI and applies the migration
  automatically; `pnpm db:status` prints the same three values pointed at
  `127.0.0.1`. Stop it with `pnpm db:stop`.

Either way, copy `apps/web/.env.example` → `apps/web/.env` and
`apps/api/.env.example` → `apps/api/.env`, fill in the values, then:

```bash
pnpm install
pnpm dev
```

- `apps/web` — http://localhost:5173
- `apps/api` — http://localhost:3001 (`/health`)

Or run one side at a time: `pnpm dev:web` / `pnpm dev:api`.

## Testing

`apps/web` has a Playwright e2e suite that runs against the real dev servers
and the real Supabase project (no mocks) — auth (login/logout/session
persistence/protected routes), signup, and the World Map's live data.

It logs in as a **persistent test account** rather than creating a throwaway
user per run: copy `apps/web/.env.test.example` to `apps/web/.env.test` and
fill in that account's credentials (ask a teammate, or sign up your own test
account and use it — its World Map state is expected to stay untouched,
since nothing yet writes to `player_world_progress` after signup).

```bash
pnpm dev                      # dev servers must be running (or let Playwright start them)
cd apps/web
pnpm test:e2e                 # headless
pnpm test:e2e:ui              # interactive UI mode
```

## Status

Phase 1 is mostly in place: monorepo, shared mission/player type schema, the
full HQ/World Map/Mission/Profile/Leaderboard/Achievements UI in `apps/web`,
and real authentication (Supabase — sign up, log in, log out, protected
routes, a server-side session guard in `apps/api`). Game data (XP, missions,
worlds, leaderboard) is still mocked — the actual mission engine, labs, and
Phaser scenes aren't built yet. See
[Development Phases & MVP Scope](./docs/09-development-phases.md) for the
build order and current status in detail.

## Repo layout

```
apps/       web (player frontend) · api (NestJS backend) · admin (Mission Builder, placeholder)
packages/   types (shared schema) · ui · game-engine · mission-engine · config · labs (placeholders)
infra/      infra/supabase (local Supabase project + migrations) · deployment config (placeholder)
docs/       design & architecture wiki
```

Details: [docs/08-repo-structure.md](./docs/08-repo-structure.md).
