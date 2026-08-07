# Lab System

Three lab types, referenced by `LabConfig.type` in
`packages/types/src/mission.ts`. A mission picks exactly one.

## Type A — Simulation

No server involved. Runs entirely client-side: Linux terminal simulator, SQL
simulator, packet-routing puzzle, firewall puzzle, phishing challenge. Use
these heavily — they're the cheapest to run and scale infinitely.

## Type B — Shared Lab

A shared, intentionally vulnerable service (web app, API, log-analysis
environment) with logical per-user isolation rather than a dedicated
container per player.

## Type C — Isolated Lab

A temporary Docker environment started per player: temporary target address,
temporary credentials, terminal access. Automatically destroyed after
inactivity or expiration.

Required constraints on the container network:

- Restrict network access to the lab environment only — no arbitrary
  outbound access, so a lab can never be used to attack real external
  targets.
- CPU limits, RAM limits, network limits, time limits, filesystem
  restrictions.

## MVP target

One real Docker lab (Type C), one simulated Linux terminal (Type A), one
simulated web security challenge (Type A) — see
[Development Phases & MVP Scope](./09-development-phases.md).
