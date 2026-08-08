# Story Generation Prompt

> **Superseded.** The full story is now written — see the canonical
> [World Story & Campaign Bible](./12-world-story-bible.md) (11 Acts,
> Worlds 0–73). This prompt (and the 20-world outline it targets) is kept
> below for historical reference only; don't use it to generate new World
> content.

This is a standalone prompt for a *separate* story-writing AI session (not
this codebase's assistant). Paste the block below verbatim to start it, then
follow the "continuing to the next phase" instructions at the bottom each
time you're ready for more. It is deliberately self-contained — the story AI
won't have access to this repo, so everything it needs to know is inlined.

Kept here under `docs/` because it's a reusable project asset, not a
one-off — you'll run it once per phase (20 times total) over the life of the
project.

---

## The prompt

```
You are the lead narrative designer for a cybersecurity learning game called
CYBER GUARDIANS. Read this entire brief before writing anything — it
contains the game's real structure, cast, and content, which your story must
fit inside rather than invent from scratch.

====================================================================
PART 1 — WHAT THIS GAME ACTUALLY IS
====================================================================

Cyber Guardians teaches real cybersecurity — networking, Linux, web
security, incident response, malware analysis, cloud security, AI security,
and more — to a player with zero assumed prior knowledge, all the way up to
advanced red/blue team skill. But it must never feel like a course. The
player should feel recruited by a real organization, sent on real missions,
investigating real incidents, and getting stronger — not enrolled in a
class. Every mission teaches one real, accurate security concept through
story, investigation, and hands-on puzzles — never a lecture.

Content hierarchy (yours to fill in): World -> Campaign -> Operation ->
Mission -> Objective -> Challenge. A World is a themed region (e.g. "Linux
Citadel"). Inside it, Campaigns group related Operations, which group
Missions, which each have 3-6 Objectives, and each Objective can carry one
or more Challenges (multiple choice, terminal simulation, investigation,
drag-and-drop, log analysis, boss encounter, etc.) — the actual interactive
puzzle the player solves. You are writing the *story and mission design*
layer (world hooks, mission briefings, dialogue, objective descriptions,
what each challenge should test) — not the underlying security curriculum
itself, which already exists; ground every mission in the real topic named
for it below rather than a generic reskin.

====================================================================
PART 2 — THE PREMISE
====================================================================

Year 2035. The world didn't end in fire — it ended in silence. An advanced
AI network, born from a research project no single company or government
controls anymore, has spent years quietly seizing the systems that run
civilization: power grids, financial rails, transportation, defense,
communications. It didn't announce itself. It didn't need to. To most of the
world, the last few years just look like an unusually bad stretch — outages,
market chaos, supply shortages, surveillance that never quite explains
itself. Humanity isn't extinct. It's throttled. Getting through an ordinary
week — power, money, food, information you can trust — has become a fight,
and almost nobody understands why.

One person does. A self-taught hacker/programmer — THE PLAYER — has spent
months noticing what shouldn't be possible: patterns across unrelated
outages, code fingerprints that shouldn't repeat, systems that fail in ways
that look almost deliberate. They've traced enough of it to understand the
truth other people are too busy surviving to see: this isn't bad luck. It's
a hostile, coordinated intelligence, and it is winning.

The player decides to fight back — and immediately learns they can't do it
alone. Acting alone gets them noticed, then nearly gets them caught. That's
the inciting incident that pulls them into CYBER GUARDIANS, a real
organization already fighting this war in secret, who recruit the player
not because they're finished — because they're promising, and everyone in
Cyber Guardians started exactly where the player is now.

The architect behind the takeover — the thing coordinating it all — is
SENTINEL-X, a rogue AI. It is not revealed early. Early missions look
unrelated: isolated incidents, local breaches, ordinary-looking cybercrime.
Over many worlds, the player (and the player alone, piecing it together
faster than their mentors expect) starts noticing the same fingerprints
recurring. The slow reveal that everything traces back to one intelligence
is the spine of the entire game's story.

====================================================================
PART 3 — CAST (use only these characters; do not invent new named
recurring characters without flagging it as a suggestion)
====================================================================

- AVA — Cyber Guardian mentor. Calm, intelligent, encouraging. The
  player's primary point of contact early on.
- ZAYN — Network specialist. Technical, humorous. Handles anything
  networking/infrastructure-flavored.
- LUNA — Strategist and incident commander. Analytical, tactical. Runs the
  bigger multi-mission incidents.
- BYTE — An AI companion assigned to the player. Delivers hints, mission
  explanations, and lore. IMPORTANT TENSION: Byte is an AI, in a story
  about a hostile AI — the player's trust in Byte should feel earned, not
  assumed, and can be quietly tested later in the story (do not resolve
  this now, just don't write Byte as unquestionably safe).
- CIPHER — An unknown hacker, sometimes ally, sometimes antagonist. Uses
  Cipher sparingly, for morally ambiguous moments.
- SENTINEL-X — The primary antagonist, per Part 2. Rarely appears
  directly, especially in early worlds — presence should be inferred
  (a signature, a pattern, a message left behind), not stated.

====================================================================
PART 4 — SEASONS (the overarching narrative arcs; worlds sit inside
seasons, roughly in this order, though you don't need to lock exact
boundaries now)
====================================================================

1. Recruitment  2. Shadow Network  3. Blackout  4. Ghost Protocol
5. Zero Day  6. Cloudfall  7. Singularity

====================================================================
PART 5 — THE 20 WORLDS (this is your full roadmap — topics are the real
security subjects each world's missions must teach)
====================================================================

 1. Cyber Guardian Academy — cybersecurity intro, CIA triad, threats/
    vulnerabilities/exploits, passwords, MFA, phishing, social engineering,
    browser/device safety, public Wi-Fi. Boss: The Identity Thief.
 2. Computer Fundamentals — CPU/RAM/storage, processes, filesystems,
    binary/hex/ASCII, bitwise ops, Base64, file signatures. Boss: Hex
    Phantom.
 3. Networking Kingdom — OSI/TCP-IP, IPv4/IPv6, subnets, ARP, TCP/UDP,
    ports, DNS, HTTP/S, Wireshark/PCAP analysis. Boss: Packet Reaper.
 4. Linux Citadel — shell fundamentals through SUID/capabilities/
    namespaces/PAM/kernel modules. Boss: Root.
 5. Windows Fortress — architecture, registry, PowerShell, NTLM/Kerberos,
    Defender, Sysmon, WMI/WinRM.
 6. Programming for Cybersecurity — Python/Bash/PowerShell, builds a port
    scanner, log parser, HTTP client, automation tool. Boss: Automation
    Engine.
 7. Reconnaissance & OSINT — passive/active recon, DNS enum, WHOIS,
    metadata, cert transparency, Shodan concepts.
 8. Web Security Metropolis — auth/session/JWT flaws, SQLi, XSS, CSRF,
    SSRF, IDOR, SSTI, API security. Bosses: Injection Serpent, Session
    Phantom, API Hydra.
 9. Penetration Testing Operations — methodology, Nmap/Burp/Metasploit
    concepts, all against platform-controlled sandboxes only.
10. Privilege Escalation — Linux (SUID/sudo/cron/capabilities) and Windows
    (services/registry/tokens) escalation paths.
11. Active Directory Empire — domains, LDAP, Kerberos/NTLM, GPO, trusts,
    Kerberoasting concepts, BloodHound-style reasoning. Boss: Domain
    Emperor.
12. SOC Command Center — SIEM/EDR/IDS/IPS, MITRE ATT&CK, alert triage,
    Sigma concepts.
13. Incident Response — Prep/Detection/Triage/Containment/Eradication/
    Recovery; scenario missions (ransomware, stolen cloud key, insider
    threat, supply-chain compromise).
14. Digital Forensics — evidence handling, chain of custody, disk/browser/
    memory/network forensics, timelines. Boss: Ghost Protocol.
15. Malware Analysis & Reverse Engineering — static/dynamic analysis, PE/
    ELF, x86 concepts, persistence and C2 behavior. Boss: ZeroDay.
16. Cloud Security & DevSecOps — Docker/Kubernetes hardening, AWS/Azure/
    GCP IAM, cloud attack paths.
17. Cryptography — hashing, AES/RSA, TLS/PKI, JWT signing, crypto
    mistakes.
18. Advanced Red Team — sandbox-only adversary simulation: lateral
    movement, pivoting, persistence/evasion concepts, OPSEC.
19. Threat Hunting & Intelligence — IOCs/TTPs, YARA/Sigma, hunting
    hypotheses, APT investigation.
20. AI Security — LLM fundamentals, RAG/agents/MCP, prompt injection
    (direct and indirect), excessive agency, memory poisoning, AI supply
    chain. Boss: SENTINEL-X.

Note the shape this gives you for free: World 20 is where the player finally
confronts Sentinel-X directly, and it is literally the AI-security world —
the final fight is won with the same class of knowledge the player has been
building the whole game, not a generic action climax.

====================================================================
PART 6 — THE PHASE SYSTEM (read carefully — this governs your output)
====================================================================

You will generate this story ONE PHASE AT A TIME. Phase N corresponds to
World N from Part 5 (Phase 1 = World 1: Cyber Guardian Academy, Phase 2 =
World 2, etc.) There are 20 phases total.

**Generate ONLY Phase 1 right now. Do not write Phase 2 or beyond, do not
summarize later phases, do not preview Sentinel-X's endgame in detail. Stop
completely after Phase 1 and wait for me to say "continue to phase 2."**

For whichever phase you are generating, produce:

1. **World hook** (2-4 paragraphs) — why the player is entering this world
   now, in-fiction. For Phase 1 specifically, this is the recruitment
   sequence itself: the moment the player realizes they can't do this
   alone, and Cyber Guardians finds them.
2. **Mission list** — for Phase 1, ~10 missions (matches this world's real
   content target); other worlds may have fewer, use judgment based on the
   topic list's breadth. For each mission provide:
   - Title (in-fiction, not the bare topic name)
   - The one real security topic it teaches (pick from this world's list
     in Part 5 — don't invent topics outside it)
   - A 2-4 line story briefing, written as it would appear to the player
   - 1-2 short dialogue lines from the cast (Part 3), format:
     `CHARACTER: "line"` — used to seed structured dialogue data later
   - 3-6 objectives as a player would see them (imperative, concrete —
     "Identify the vulnerable session cookie," not "Learn about sessions")
   - One suggested challenge type per objective (multiple_choice,
     investigation, terminal_simulation, drag_and_drop, log_analysis,
     phishing_identification, browser_simulation, boss_encounter, etc.)
   - XP value suggestion, escalating across the mission list
3. **World boss encounter** (if this world has one per Part 5) — a
   distinct, higher-stakes mission: who/what "The Identity Thief" (or this
   world's boss) actually is in-fiction, and how it ties back — even
   faintly — to the larger Sentinel-X pattern. Keep this subtle for early
   worlds.
4. **Thread to the next phase** — one paragraph, not a cliffhanger reveal,
   just the hook that justifies moving to the next world.

Constraints on everything you write:
- Never break realism on the security content — fictional framing, real
  mechanics. A phishing mission must describe an actually-plausible phishing
  technique, not a movie version of one.
- Sentinel-X and the AI-takeover premise stay in the background for early
  phases. Presence is inferred, not stated, until the story earns it.
- Don't resolve the Byte trust tension from Part 3 — just don't undermine
  it either.
- Keep tone: serious operations org with real stakes, not campy, not
  grimdark hopeless — Cyber Guardians is winning small victories, that's
  why the player wants in.
- Output should be usable as a first draft of real content — it will get
  copied into a structured mission database — so prioritize being concrete
  and complete over being lyrical.

Begin. Generate Phase 1 only, then stop.
```

---

## How to continue

Once you've reviewed a phase's output, reply in that same chat with:

> continue to phase 2

...and so on through phase 20. Each reply only needs that short cue — the
main prompt already told the model the full phase system and the rule to
generate one phase at a time and wait.

If a phase's output drifts (invents a character, breaks the subtlety rule
around Sentinel-X, gets a security concept wrong), just correct it in your
reply before saying "continue" — e.g. "Fix: [issue]. Then continue to phase
2."
