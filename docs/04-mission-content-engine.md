# Mission Content Engine

This is the load-bearing architectural constraint of the whole project:

> Missions must be stored as data. Do not hard-code individual missions into
> React components.

The platform is meant to eventually hold 700+ missions. If adding a mission
requires shipping new frontend code, that goal is unreachable.

## Schema

Defined in `packages/types/src/mission.ts` and consumed by both
`apps/web` (renders it) and `apps/api` (serves/validates it):

- `World`, `Campaign`, `Operation` — the content hierarchy above a mission.
- `Mission` — id, world/campaign/operation id, slug, title, description,
  `Difficulty`, story dialogue (`DialogueLine[]`, referencing `CharacterId`),
  `Objective[]`, `PrerequisiteRule`, `requiredSkills`, `LabConfig`,
  `MissionRewards`, `isBoss`.
- `Objective` — ordered, holds one or more `Challenge`s.
- `Challenge` — a `ChallengeType`, a `prompt`, opaque `content` (shape
  depends on the challenge type), `hints`, and `completionConditions`.
- `MissionRewards` — xp, credits, badge ids, per-skill xp, item ids.
- `LabConfig` — which lab type backs this mission and its parameters; see
  [Lab System](./05-lab-system.md).

`PlayerProfile`, `PlayerSkill`, `MissionProgress`, `PlayerState` in
`packages/types/src/player.ts` are the corresponding player-side state.

## Mission Builder (admin)

`apps/admin` (placeholder today, Phase 6 of
[Development Phases](./09-development-phases.md)) will let administrators
create and edit missions against this schema without touching application
code — the actual authoring tool for the content-as-data promise above.
