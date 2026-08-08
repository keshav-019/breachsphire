# Development Phases & MVP Scope

## Build order (do not reorder)

1. **Phase 1** — Project architecture, authentication, database, dashboard,
   profile. *(architecture, dashboard shell, and core auth: done — see below;
   real profile data and the rest of Phase 1's surface area is still ahead)*
2. **Phase 2** — World system, campaign system, mission engine, mission
   progression. Sub-phases, since this is where the
   [World Story & Campaign Bible](./12-world-story-bible.md) lands:
   - **2.1 — done.** Flat `worlds` table + per-player world progress (map
     display only — name/icon/boss/x/y, no campaign/mission content).
   - **2.2 — done.** Canonize the story bible: `docs/12`, the Act-grouped
     world index in `docs/01`, and the `Act`/richer `World`/tiered `Hint`
     additions to `packages/types/src/mission.ts`.
   - **2.3** — DB schema + migrations for `acts`, `campaigns`,
     `operations`, `missions`, `objectives`, `challenges`, `dialogue_lines`,
     `hints`, `player_mission_progress`, `player_objective_progress`,
     `player_challenge_attempts`. Re-seed `worlds` against the real
     74-world list with `act_id`.
   - **2.4** — Author real content for Act 0 only (World 0 + World 1) as a
     vertical-slice proof, using `docs/12` as the source of truth for
     entry incident/capstone/story reveal per world.
   - **2.5** — API endpoints: world/campaign/mission detail, objective/
     challenge attempt submission, mission progression state machine,
     reward application (XP/credits/skill XP per `MissionRewards`).
3. **Phase 3** — Dialogue engine, question engine, puzzle engine, reward
   engine. Wires `DialogueBox`/`HintPanel`/`ObjectiveChecklist` to real
   data instead of the mocks in `apps/web/src/lib/game-data.ts` and
   `MissionPage.tsx`; challenge-type renderers per `ChallengeType`; 5-tier
   hint escalation (`docs/12` §2.3).
4. **Phase 4** — Terminal simulator, Linux challenges, networking challenges.
5. **Phase 5** — Phaser headquarters, characters, mission map, animations.
6. **Phase 6** — Mission Builder admin application.
7. **Phase 7** — First Docker sandbox, lab orchestration.
8. **Phase 8** — Daily challenges, leaderboards, achievements.
9. **Phase 9** — Capacitor Android build.

## MVP content target

Not hundreds of missions initially — the platform plus **~30 polished
missions**, covering Act 0 and Act 1 of the
[World Story & Campaign Bible](./12-world-story-bible.md):

- World 0 — Digital Survival: First Contact (~10 missions, boss: The
  Identity Thief)
- World 1 — How Computers Actually Work: The Machine Room (~5 missions)
- World 2 — Network Foundations: Signal Path (~5 missions)
- World 8 — Packet Analysis: Packet Reaper (~5 missions, boss: Packet
  Reaper)
- 5 further incident missions drawn from Worlds 3–7 and 9 as needed to
  round out Act 1

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
