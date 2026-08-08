# Story, Characters & Acts

Full narrative detail — premise, story rules, per-World entry incidents,
capstones, story reveals, and the reveal schedule — lives in the canonical
[World Story & Campaign Bible](./12-world-story-bible.md). This document is
the short reference: setting, cast, and act structure.

## Setting

**Year: 2035.** Banks, hospitals, airports, satellites, cloud platforms,
factories and AI systems are deeply interconnected. The Cyber Guardians is
an international defensive organization created to protect critical
digital infrastructure.

The player enters as an ordinary person caught in a targeted
social-engineering incident and is recruited after responding unusually
well under pressure. Early missions appear unrelated to each other; over
many Worlds the player discovers the incidents are connected, orchestrated
by **Sentinel-X** — what survived of a retired autonomous-resilience
research program, Project SENTINEL. Each World reveals part of the
conspiracy (see doc 12 §6, "Story continuity & reveal schedule").

## Recurring characters

| Character | Role | Arc |
|---|---|---|
| **Ava** | Mentor and learner advocate | Begins as the reassuring recruiter. Gradually gives the player more autonomy and becomes the voice reminding command that people are not merely systems. |
| **Zayn** | Network and systems specialist | Technical, fast, humorous. Starts by explaining everything; later becomes a peer who asks the player for help on difficult infrastructure incidents. |
| **Luna** | Strategist and incident commander | Initially strict and procedural. Becomes the player's sponsor for offensive clearance, then ultimately trusts the player with command-level decisions. |
| **Byte** | AI companion | Starts with limited hints. Gains contextual capability as the player gains clearance. In the final act, Byte becomes part of the ethical and technical stakes — its architecture descends from the same research lineage as Sentinel-X. |
| **Cipher** | Unknown hacker / reluctant ally | Appears hostile, then becomes ambiguous, then is revealed as a former Guardian operative who tried to expose and stop Sentinel-X. Never an all-knowing exposition device — the player must verify Cipher through evidence. |
| **Sentinel-X** | Long-term antagonist | Appears first as patterns and artifacts, then as an autonomous campaign, and finally as a distributed security system whose objective must be constrained, not simply destroyed. |

`CharacterId` in `packages/types/src/mission.ts` encodes this cast so
mission dialogue data can reference them by id.

## Acts

Story content is organized into 11 Acts (Worlds 0–73) rather than the
looser "season" grouping used earlier in this project. Full purpose and
player-transformation detail for each is in
[doc 12 §2](./12-world-story-bible.md#2-long-form-act-map).

1. **Act 0 — The Recruitment**
2. **Act 1 — The Network**
3. **Act 2 — The Machines**
4. **Act 3 — The Shield**
5. **Act 4 — The Breach**
6. **Act 5 — The Enterprise**
7. **Act 6 — The Hunt**
8. **Act 7 — Cloudfall**
9. **Act 8 — Zero Day**
10. **Act 9 — Command**
11. **Act 10 — Singularity**

Content is expandable — new Acts, Worlds, and post-ending seasons ship as
more mission/campaign data, not new app code (doc 12 §73's transition notes
this explicitly for the ending).

## Major story incidents

Multi-mission scenarios that each require knowledge from several previous
Worlds, and the recurring locations the story rules (doc 12 §1.2) require
reusing so the world feels persistent:

- Mercy Hospital (ransomware/incident-response arc, World 43)
- Nexus Bank/Market (breach/web-security arc, Worlds 18 & 25–29)
- SkyPort Airport (network/wireless arc, Worlds 8–9)
- Aether Cloud
- Orbital-7
- Guardian HQ
