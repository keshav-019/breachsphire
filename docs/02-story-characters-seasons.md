# Story, Characters & Seasons

## Setting

**Year: 2035.** The world's infrastructure — banks, hospitals, airports,
satellites, power grids, governments, AI systems — is deeply interconnected.
A wave of sophisticated cyberattacks begins spreading globally. The Cyber
Guardians organization recruits talented individuals and trains them to
protect digital infrastructure.

The player joins as a recruit. Early missions appear unrelated to each
other; over time the player discovers the attacks are connected, orchestrated
by a rogue AI: **Sentinel-X**. Each world reveals part of the conspiracy.

## Recurring characters

| Character | Role | Personality |
|---|---|---|
| **Ava** | Cyber Guardian mentor | Calm, intelligent, encouraging |
| **Zayn** | Network specialist | Technical, humorous |
| **Luna** | Strategist / incident commander | Analytical, tactical |
| **Byte** | AI robot companion | Gives hints, mission explanations, lore, general assistance |
| **Cipher** | Unknown hacker | Sometimes ally, sometimes antagonist |
| **Sentinel-X** | Primary long-term villain | Advanced rogue AI coordinating the global attack campaign |

`CharacterId` in `packages/types/src/mission.ts` encodes this cast so
mission dialogue data can reference them by id.

## Seasons

1. **Season 1 — Recruitment**
2. **Season 2 — Shadow Network**
3. **Season 3 — Blackout**
4. **Season 4 — Ghost Protocol**
5. **Season 5 — Zero Day**
6. **Season 6 — Cloudfall**
7. **Season 7 — Singularity**

Season content is expandable — new seasons ship as more mission/campaign data,
not new app code.

## Major story incidents

Multi-mission scenarios that each require knowledge from several previous
worlds:

- Mercy Hospital Ransomware
- Nexus Bank Database Breach
- SkyPort Airport Network Attack
- Orbital-7 Satellite Intrusion
- Aether Cloud Compromise
- Government Credential Leak
- AI Research Lab Attack
