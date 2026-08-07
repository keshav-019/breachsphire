# Overview

## What Cyber Guardians is

A production-grade, web-first cybersecurity learning game. It combines:

- **TryHackMe's** learning depth — real technical content, real labs.
- **Duolingo's** progression and habit-building — streaks, daily challenges,
  levels, bite-sized loops.
- **An RPG's** atmosphere and progression — ranks, worlds, bosses, a
  companion cast, a season-based story.

It must never feel like a course website. The player should feel recruited
by a futuristic cybersecurity organization, sent on missions, and getting
stronger — not enrolled in a class.

## Who plays it

Players start with **zero assumed cybersecurity knowledge** and progress
through fundamentals, networking, Linux, Windows, programming, web security,
recon, pentesting, privesc, Active Directory, defensive security, SOC ops,
incident response, forensics, malware analysis, reverse engineering, cloud
security, containers/Kubernetes, threat hunting, red team concepts, and AI
security — see [Game Structure & Worlds](./01-game-structure-worlds.md).

## Content is data, not code

The platform is built to eventually hold 700+ missions. New missions must be
addable without touching application code — see
[Mission Content Engine](./04-mission-content-engine.md).

## The core gameplay loop

```
Explore
  -> Receive incident
  -> Investigate
  -> Learn
  -> Experiment
  -> Solve
  -> Defend or exploit sandbox
  -> Submit evidence
  -> Receive explanation
  -> Earn XP
  -> Unlock next mission
```

This deliberately avoids the traditional course pattern of
**Read -> Watch -> Quiz**.

## Cyber Guardians HQ

A central dashboard styled as a futuristic cybersecurity operations center.
It surfaces: player avatar, rank, XP, credits, current campaign, skill
progression, mission alerts, daily challenge, world map, friends,
leaderboard, achievements, inbox, and a cyber threat level indicator.

Example incident card:

> **CRITICAL INCIDENT**
> Mercy Hospital — Ransomware infection detected.
> Severity: HIGH · Reward: 3,400 XP · Difficulty: Advanced
> `[ START MISSION ]`

`apps/web` currently renders a first pass of this dashboard shell.

## Mission UI shape

- **Left panel** — story and objectives
- **Center** — the interactive environment (terminal, diagram, sandbox, etc.)
- **Right panel** — hints, evidence, inventory
- **Bottom** — terminal, when the mission needs one

Players learn both attack *and* defense in the same mission arc where it
makes sense (exploit the vulnerable environment, then patch it).

## The one rule everything else serves

> The user should never feel like they opened an online course. They should
> feel that Cyber Guardians contacted them because there is a cyber incident
> that only they can solve.

Education is embedded inside exploration, investigation, puzzles, missions,
and controlled labs — never delivered as a lecture. Build the platform
first, then make new content cheap to add.
