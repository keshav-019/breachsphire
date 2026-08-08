# Game Structure & Worlds

## Hierarchy

```
Act -> World -> Campaign -> Operation -> Mission -> Objective -> Challenge/Lab
```

Example:

- **Act:** Act 4 — The Breach
- **World:** World 28 — Web Security: Metropolis Breach
- **Campaign:** 28B — Broken Doors
- **Operation:** Authorization Bypass
- **Mission:** The Stolen Session
- **Objectives:** investigate authentication -> examine cookies -> identify
  the vulnerable session mechanism -> exploit the sandbox -> patch the issue

This hierarchy is what `@cyber-guardians/types` (`packages/types/src/mission.ts`)
encodes as `Act`, `World`, `Campaign`, `Operation`, `Mission`, `Objective`,
`Challenge`.

Full narrative detail for every Act and World — entry incidents, capstones,
story reveals, transitions, cast arcs, hint ladder, flag philosophy, and the
worked example of turning a World into campaigns — lives in the canonical
[World Story & Campaign Bible](./12-world-story-bible.md). This document is
just the structural index; go there for the actual content to author from.

## Acts & Worlds

11 Acts, Worlds 0–73. Each World nests 3–6 Campaigns of its own (see bible
§4) — new mission content is added inside that structure as data, never as
new app code.

| Act | # | World | Boss |
|---|---|---|---|
| 0 — The Recruitment | 0 | Digital Survival: First Contact | The Identity Thief |
| 0 — The Recruitment | 1 | How Computers Actually Work: The Machine Room | — |
| 1 — The Network | 2 | Network Foundations: Signal Path | — |
| 1 — The Network | 3 | Ethernet & Layer 2: Ghosts in the Switch | Switchshade |
| 1 — The Network | 4 | IP Addressing: Address Unknown | — |
| 1 — The Network | 5 | Routing Kingdom: The Broken Route | Routebreaker |
| 1 — The Network | 6 | Transport & Network Protocols: Handshake | — |
| 1 — The Network | 7 | Application Protocol Universe: The Protocol Vault | Protocol Chimera |
| 1 — The Network | 8 | Packet Analysis: Packet Reaper | Packet Reaper |
| 1 — The Network | 9 | Wireless & Radio Security: Dead Air | — |
| 2 — The Machines | 10 | Linux I: Survival: First Shell | — |
| 2 — The Machines | 11 | Linux II: Administration: Operator | — |
| 2 — The Machines | 12 | Linux III: Power User: Under the Hood | Root |
| 2 — The Machines | 13 | Windows I: Windows of Opportunity | — |
| 2 — The Machines | 14 | Windows II & PowerShell: Blue Screen District | Vanishing Evidence |
| 2 — The Machines | 15 | Programming for Security: Automate or Die | — |
| 2 — The Machines | 16 | Shell & Automation: Ghost in the Shell | — |
| 2 — The Machines | 17 | Low-Level Programming: Bare Metal | — |
| 2 — The Machines | 18 | Web & Database Fundamentals: The Broken Marketplace | — |
| 3 — The Shield | 19 | Security Fundamentals: Rules of Defense | — |
| 3 — The Shield | 20 | Threats & Adversaries: Adversary Atlas | — |
| 3 — The Shield | 21 | Cryptography: The Keymaker | The Keymaker |
| 3 — The Shield | 22 | Identity & Access Management: Who Are You? | — |
| 3 — The Shield | 23 | Secure Architecture: Fortress Design | — |
| 3 — The Shield | 24 | Vulnerability Management: The Vulnerability Queue | — |
| 4 — The Breach | 25 | Penetration Testing Methodology: Rules of Engagement | — |
| 4 — The Breach | 26 | OSINT & Reconnaissance: Open Secrets | — |
| 4 — The Breach | 27 | Scanning & Enumeration: The Surface | — |
| 4 — The Breach | 28 | Web Security: Metropolis Breach | The Broken Marketplace |
| 4 — The Breach | 29 | API Security: API Hydra | API Hydra |
| 4 — The Breach | 30 | Authentication & Password Security: The Password Vault | — |
| 4 — The Breach | 31 | Social Engineering: Human Layer | — |
| 4 — The Breach | 32 | Network Attack & Defense: Wiretap | — |
| 4 — The Breach | 33 | Linux Privilege Escalation: Root | Root |
| 4 — The Breach | 34 | Windows Privilege Escalation: Elevation | — |
| 5 — The Enterprise | 35 | Active Directory Fundamentals: Kingdom of Trust | — |
| 5 — The Enterprise | 36 | Active Directory Security: Blood Paths | Domain Emperor |
| 5 — The Enterprise | 37 | Entra ID / Hybrid Identity: Cloud Identities | — |
| 5 — The Enterprise | 38 | Pivoting & Segmentation: Through the Wall | — |
| 5 — The Enterprise | 39 | Post-Exploitation & Adversary Operations: Inside the Network | Inside the Network |
| 6 — The Hunt | 40 | SOC Operations: Red Alert | — |
| 6 — The Hunt | 41 | Detection Engineering: Signal in the Noise | Signal in the Noise |
| 6 — The Hunt | 42 | Threat Hunting: Hunt Without an Alert | — |
| 6 — The Hunt | 43 | Incident Response: Containment | Mercy Hospital |
| 6 — The Hunt | 44 | Digital Forensics: Ghost Protocol | Ghost Protocol |
| 6 — The Hunt | 45 | Malware Analysis: The Specimen | — |
| 6 — The Hunt | 46 | Reverse Engineering: Under the Machine | — |
| 6 — The Hunt | 47 | Threat Intelligence: The Adversary Map | — |
| 7 — Cloudfall | 48 | Cloud Fundamentals: Above the Datacenter | — |
| 7 — Cloudfall | 49 | Cloud Security: Misconfigured Sky | Misconfigured Sky |
| 7 — Cloudfall | 50 | Containers: Boxed In | — |
| 7 — Cloudfall | 51 | Kubernetes: Clusterfall | Clusterfall |
| 7 — Cloudfall | 52 | DevSecOps: Pipeline Breach | — |
| 7 — Cloudfall | 53 | Software Supply Chain Security: Poisoned Dependency | Poisoned Dependency |
| 7 — Cloudfall | 54 | Mobile Security: Pocket Surface | — |
| 7 — Cloudfall | 55 | IoT Security: Embedded Secrets | — |
| 7 — Cloudfall | 56 | OT / ICS / SCADA: Blackout Grid | Blackout Grid |
| 8 — Zero Day | 57 | Operating-System Internals: Kernel Depths | — |
| 8 — Zero Day | 58 | Memory Corruption: Memory Fault | — |
| 8 — Zero Day | 59 | Exploit Mitigations: The Mitigation Wall | — |
| 8 — Zero Day | 60 | Exploit Development: Zero Day | Zero Day |
| 8 — Zero Day | 61 | Fuzzing: Crash Lab | — |
| 8 — Zero Day | 62 | Advanced Application Security: Edge Cases | Edge Cases |
| 8 — Zero Day | 63 | Product Security: Secure by Design | — |
| 9 — Command | 64 | Asset Security: Crown Jewels | — |
| 9 — Command | 65 | Risk Management: Risk Ledger | — |
| 9 — Command | 66 | Governance: The Boardroom | — |
| 9 — Command | 67 | Security Program Management: Program Zero | — |
| 9 — Command | 68 | Legal, Regulation & Privacy: Lines of Law | — |
| 9 — Command | 69 | Security Assessment & Audit: Proof | — |
| 9 — Command | 70 | Business Continuity & Disaster Recovery: Continuity | Continuity |
| 10 — Singularity | 71 | AI Fundamentals: The Machine Learns | — |
| 10 — Singularity | 72 | AI Security: Promptfall | Promptfall |
| 10 — Singularity | 73 | AI Red Team / AI Defense: Singularity | Sentinel-X (final boss) |

"Boss" here means the bible calls out a `Boss:` capstone mission (a distinct
higher-stakes encounter); "—" worlds still have a named `Capstone:` mission
closing them out, just not framed as a boss fight. See doc 12 for each
World's exact capstone name and story reveal.

## Design constraint

Every practical/offensive exercise across every World targets only
intentionally vulnerable, platform-controlled environments — see
[Lab System](./05-lab-system.md). Nothing in Cyber Guardians attacks
arbitrary external targets. See also doc 12 §1.2 ("Story rules that prevent
course-like design") and §7 ("Authoring rules for future missions").
