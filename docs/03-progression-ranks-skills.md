# Progression, Ranks & Skills

## Ranks (clearance)

Civilian -> Recruit -> Cadet -> Analyst -> Operator -> Pentester -> Hunter
-> Specialist -> Commander -> Elite Guardian.

This is the clearance progression from the
[World Story & Campaign Bible](./12-world-story-bible.md#21-clearance-progression)
— a story wrapper around prerequisite mastery, not a separate XP-tier
system. New operational privileges (real Docker labs, advanced AD ranges,
exploit research, command simulations) unlock only after the required
skills and safety briefings for that clearance level are complete.

Encoded as `PLAYER_RANKS` in `packages/types/src/rank.ts`.

## What players earn

XP, Credits, Badges, Skill points, Equipment, Cosmetics, Titles.

Cosmetics/titles/badges are for status only — see
[Business Model](./10-business-model.md) for the "never sell power" rule.

## Skill tracks

Tracked independently and shown as separate progression bars, not folded
into one overall level:

Networking, Linux, Windows, Web Security, Programming, Pentesting, SOC,
Incident Response, Forensics, Malware Analysis, Cloud Security,
Cryptography, Threat Hunting, AI Security.

Encoded as `SKILL_TRACKS` / `PlayerSkill` in `packages/types/src/rank.ts`.
A mission can require a minimum skill level as a prerequisite and grant
skill-specific XP as a reward (`Mission.requiredSkills`,
`MissionRewards.skillXp`).

## Gameplay variety

Missions are not all the same shape. Supported challenge types (see
`ChallengeType` in `packages/types/src/mission.ts`): story dialogue,
investigation, multiple choice, interactive diagrams, drag-and-drop puzzles,
packet-routing puzzles, phishing identification, log analysis, terminal
simulation, browser simulation, code debugging, real sandbox labs, boss
encounters, timed incidents, CTFs.

## Daily / recurring gameplay

Daily mission, daily puzzle, login streak, XP challenges, weekly boss,
weekly CTF, season missions, community events.

## Achievements

Examples: First Blood, Packet Detective, Root Access, Web Hunter, SOC
Analyst, Malware Hunter, Cloud Defender, AI Guardian. Achievements grant
cosmetics and profile badges — never power.

## Guardian Exams

Optional assessment tracks: Bronze -> Silver -> Gold -> Elite Guardian.
Each uses scenario-based challenges and produces a public verification link
for a completed assessment. These are **not** accredited certifications from
any external body, and must never be presented as such.
