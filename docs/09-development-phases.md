# Development Phases & MVP Scope

## Build order (do not reorder)

1. **Phase 1** — Project architecture, authentication, database, dashboard,
   profile. *(architecture, dashboard shell, and core auth: done — see below;
   real profile data and the rest of Phase 1's surface area is still ahead)*
2. **Phase 2** — World system, campaign system, mission engine, mission
   progression.
3. **Phase 3** — Dialogue engine, question engine, puzzle engine, reward
   engine.
4. **Phase 4** — Terminal simulator, Linux challenges, networking challenges.
5. **Phase 5** — Phaser headquarters, characters, mission map, animations.
6. **Phase 6** — Mission Builder admin application.
7. **Phase 7** — First Docker sandbox, lab orchestration.
8. **Phase 8** — Daily challenges, leaderboards, achievements.
9. **Phase 9** — Capacitor Android build.

## MVP content target

Not hundreds of missions initially — the platform plus **~30 polished
missions**:

- 10 Cyber Guardian Academy
- 5 Networking
- 5 Linux
- 5 Web Security
- 5 incident missions

Plus: one boss, one real Docker lab, one simulated Linux terminal, one
simulated web security challenge, one investigation mission, one phishing
mission.

## MVP feature checklist

Authentication, profile, avatar, XP, ranks, skill levels, world map, mission
map, mission engine, dialogue system, question challenges, terminal
simulation, interactive puzzles, achievements, mission rewards, leaderboard,
daily challenge, Mission Builder, responsive UI.

## Where we are right now

Phase 1 has a working slice: the monorepo, `packages/types`, `apps/web` (the
full HQ/World Map/Mission/Profile/Leaderboard/Achievements UI, reachable in a
browser), and `apps/api` (health endpoint the web app polls live).

Authentication is real, not mocked: local Supabase (Postgres + Auth) runs via
`pnpm db:start` (see [Architecture & Tech Stack](./06-architecture-tech-stack.md)).
Sign up / log in / log out work end-to-end, sessions persist across reloads,
game routes are protected client-side, and `apps/api` has a
`SupabaseAuthGuard` that verifies sessions server-side (`GET /players/me`). A
`public.profiles` row is auto-created per signup via a Postgres trigger.

Still mocked: XP, rank, skills, missions, worlds, leaderboard, achievements —
the Dossier/Profile page reads real identity but fabricated stats. Wiring
those to real data is Phase 2 (mission engine) territory, not this pass.
