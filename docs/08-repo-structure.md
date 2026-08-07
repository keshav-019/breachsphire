# Repo Structure

A single pnpm-workspace monorepo:

```
apps/
  web      React + TS + Vite frontend (player-facing)
  api      NestJS backend
  admin    Mission Builder admin app (placeholder — Phase 6)
packages/
  types           Shared TS types: mission/content schema, player state, ranks/skills
  ui              Shared React components (placeholder — extract once things repeat)
  game-engine     Phaser scenes for HQ/world map/mini-games (placeholder — Phase 5)
  mission-engine  Runtime that interprets mission data into objective/challenge flow (placeholder)
  config          Shared lint/TS/Tailwind presets (placeholder)
  labs            Lab orchestration client for the Labs API module (placeholder — Phase 7)
infra/           Deployment config: Cloudflare Pages/Workers, Supabase migrations, R2, Docker host
docs/            This wiki
```

Root-level config: `package.json` (workspace scripts), `pnpm-workspace.yaml`,
`turbo.json`, `tsconfig.base.json`.

## Why placeholders instead of skipping them

The packages that aren't implemented yet (`ui`, `game-engine`,
`mission-engine`, `config`, `labs`, `apps/admin`) exist as directories with a
README stating what they'll hold and which phase builds them. This reserves
the workspace layout described in the master spec so later phases slot in
without a restructure, without pretending they're implemented today.

## NestJS module map (target)

`apps/api` is planned to hold these Nest modules as they're built: Auth,
Users, Players, Worlds, Campaigns, Missions, Progress, Skills, Achievements,
Inventory, Leaderboards, Challenges, Labs, Notifications, Admin, Analytics.
Only `HealthModule` exists today (`apps/api/src/health`).
