# Architecture & Tech Stack

A single TypeScript monorepo, deliberately not a distributed architecture
for v1. NestJS as a **modular monolith**, not microservices, during the MVP.

| Layer | Technology |
|---|---|
| Web application | React + TypeScript + Vite |
| Styling | Tailwind CSS |
| Animations | Motion (Framer Motion) |
| 2D game portions | Phaser |
| Android | Capacitor (same React frontend, no second frontend) |
| Desktop (later) | Tauri — Windows, Linux, macOS |
| API | NestJS + TypeScript |
| Database | PostgreSQL |
| Initial DB/Auth | Supabase (email/password, Google OAuth, GitHub OAuth) |
| ORM | Prisma or Drizzle |
| Validation | Zod |
| Client state | Zustand |
| Data fetching | TanStack Query |
| Terminal UI | xterm.js |
| Monorepo tooling | pnpm workspaces + Turborepo |
| Object storage | Cloudflare R2 (character/mission art, audio, PCAPs, forensics files — never large binaries in Postgres) |
| Containers | Docker (Type C labs — see [Lab System](./05-lab-system.md)) |
| CI/CD | GitHub Actions |

## Frontend split: React vs. Phaser

React owns UI, dashboard, missions, profiles, settings, and learning content.
Phaser is scoped to interactive game scenes only — the HQ map, world map,
character animation, mini-games. The whole app is not built inside Phaser.

## Hosting

- Frontend: Cloudflare Pages
- Backend: Cloudflare Workers where practical; NestJS services needing a
  persistent Node runtime start on Railway (or similar) until that changes
- Database/Auth: Supabase
- Assets: Cloudflare R2
- Real labs: a dedicated Docker host, introduced after the MVP

## Current implementation status

- `apps/web` — Vite + React + TS + Tailwind v4 + shadcn/ui (New York style,
  Radix primitives) + TanStack Query + Motion + Zustand + React Router.
  Six routed pages (Command/HQ, World Map, Mission, Dossier/Profile,
  Standings/Leaderboard, Commendations/Achievements) with a shared `AppShell`
  layout, styled with the "Cyber Guardians" oklch-based dark amber/teal
  design system in `src/index.css`. UI was drafted in Lovable from a design
  brief, exported (originally on TanStack Start), then ported onto this
  app's plain Vite + React Router setup — routing and `Link`/`NavLink` usage
  were rewritten, everything else carried over as-is. Domain components live
  in `src/components/guardians`, shadcn primitives in `src/components/ui`,
  mock game data in `src/lib/game-data.ts`. The sidebar's "Uplink" indicator
  is the original `SystemStatus` component, polling `apps/api`'s health
  endpoint live. Real auth: `src/lib/supabase.ts` (client), `src/store/auth.ts`
  (Zustand — the first real use of the dependency, session init/persistence/
  sign-in/sign-up/sign-out), `src/pages/LoginPage.tsx` /
  `SignupPage.tsx`, `src/components/auth/RequireAuth.tsx` gating the six game
  routes. HudBar shows the real signed-in identity and a logout control.
  Everything past identity (XP, rank, skills, missions) is still mocked.
- `apps/api` — NestJS with `HealthModule` and `PlayersModule`
  (`src/auth/supabase-auth.guard.ts` verifies the Supabase session JWT;
  `GET /players/me` is the first protected route). The rest of the module
  list in [Repo Structure](./08-repo-structure.md) is the target shape, not
  yet built.
- `packages/types` — the mission/player schema, shared by both apps.
- **Database/Auth** — Supabase, per the target above. Either a cloud project
  or `infra/supabase` run locally via the CLI (`pnpm db:start`) — see
  [infra/README.md](../infra/README.md). One migration so far: `profiles`
  (one row per `auth.users` row, auto-created via trigger on signup).
- Everything under Storage/Hosting/Mobile/Desktop above is **not wired up
  yet** — this doc describes the target, not the current state.
