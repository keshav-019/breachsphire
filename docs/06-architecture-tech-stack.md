# Architecture & Tech Stack

A single TypeScript monorepo, deliberately not a distributed architecture
for v1. NestJS as a **modular monolith**, not microservices, during the MVP.

| Layer | Technology |
|---|---|
| Web application | React + TypeScript + Vite |
| Styling | Tailwind CSS |
| Animations | CSS animations (Tailwind + tw-animate-css) |
| 2D game portions | Phaser |
| Android | Capacitor (same React frontend, no second frontend) |
| Desktop (later) | Tauri — Windows, Linux, macOS |
| API | NestJS + TypeScript |
| Database | PostgreSQL 18 (self-hosted on the VM, TLS required) |
| Auth | Built into the API: email/password (bcrypt), JWT access + rotating refresh tokens |
| ORM | Drizzle (decided — see `apps/api/src/db`) |
| Validation | Zod |
| Client state | Zustand |
| Data fetching | TanStack Query |
| Terminal UI | xterm.js |
| E2E testing | Playwright (`apps/web/e2e`) — runs against real dev servers and the real API/database, no mocks |
| Monorepo tooling | pnpm workspaces + Turborepo |
| Object storage | Not needed yet; when it is, large files (art, audio, PCAPs, forensics files) go to object storage, never into Postgres |
| Containers | Docker Compose on the VM (Postgres + API); Docker also for future Type C labs — see [Lab System](./05-lab-system.md) |
| CI/CD | GitHub Actions |

## Frontend split: React vs. Phaser

React owns UI, dashboard, missions, profiles, settings, and learning content.
Phaser is scoped to interactive game scenes only — the HQ map, world map,
character animation, mini-games. The whole app is not built inside Phaser.

## Hosting

- Frontend: Vercel (static build of `apps/web`; `/api/*` is proxied to the VM)
- API, database and auth: one VM (`vanisher.projectyourown.com`) running
  Docker Compose, deployed by GitHub Actions on every push to `main`
- Real labs: a dedicated Docker host, introduced after the MVP

Details: [Deployment](./13-deployment.md).

## Current implementation status

- `apps/web` — Vite + React + TS + Tailwind v4 + shadcn/ui (New York style,
  Radix primitives) + TanStack Query + Zustand + React Router.
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
  endpoint live. Real auth: `src/lib/auth-client.ts` (talks to the API's
  `/auth` endpoints, keeps the session in localStorage, refreshes tokens),
  `src/store/auth.ts` (Zustand: session init/sign-in/sign-up/sign-out),
  `src/pages/LoginPage.tsx` /
  `SignupPage.tsx`, `src/components/auth/RequireAuth.tsx` gating the six game
  routes. HudBar shows the real signed-in identity and a logout control.
  Everything past identity (XP, rank, skills, missions) is still mocked.
- `apps/api` — NestJS. `src/auth` issues and verifies sessions
  (`POST /auth/signup|login|refresh|logout`; `JwtAuthGuard` protects every
  player route). The rest of the module list in
  [Repo Structure](./08-repo-structure.md) is the target shape, not yet
  built.
- `packages/types` — the mission/player schema, shared by both apps.
- **Database** — PostgreSQL on the VM, schema from `infra/migrations` (see
  [infra/README.md](../infra/README.md)). Accounts live in `auth.users`; a
  `public.profiles` row is created per signup by a trigger.
- Mobile (Capacitor), Phaser scenes and object storage above are **not wired
  up yet** — those rows describe the target, not the current state.
