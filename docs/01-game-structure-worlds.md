# Game Structure & Worlds

## Hierarchy

```
World -> Campaign -> Operation -> Mission -> Objective -> Challenge/Lab
```

Example:

- **World:** Web Security
- **Campaign:** The Broken Marketplace
- **Operation:** Authentication Breach
- **Mission:** The Stolen Session
- **Objectives:** investigate authentication -> examine cookies -> identify
  the vulnerable session mechanism -> exploit the sandbox -> patch the issue

This hierarchy is what `@cyber-guardians/types` (`packages/types/src/mission.ts`)
encodes as `World`, `Campaign`, `Operation`, `Mission`, `Objective`, `Challenge`.

## Worlds

Each world has a topic list and, where noted, a boss mission that gates
progression to the next world.

| # | World | Boss |
|---|-------|------|
| 0 | Cyber Guardian Academy — intro, CIA triad, threats/vulnerabilities/exploits, passwords, MFA, phishing, social engineering, digital hygiene | The Identity Thief |
| 1 | Computer Fundamentals — CPU/RAM/storage, processes, filesystems, user/kernel mode, virtual memory, binary/hex/ASCII, bitwise ops, endianness, Base64, file signatures | Hex Phantom |
| 2 | Networking Kingdom — OSI, TCP/IP, IPv4/IPv6, subnets/CIDR, ARP, TCP/UDP, ports, three-way handshake, NAT, routing, VLANs, DHCP, DNS, HTTP/S, FTP/SSH/SMB, Wireshark & PCAP analysis | Packet Reaper |
| 3 | Linux Citadel — beginner shell commands through SUID/capabilities/namespaces/cgroups/PAM/audit logs/kernel modules | Root |
| 4 | Windows Fortress — architecture, NTFS, registry, CMD/PowerShell, Event Viewer, NTLM/Kerberos, Defender, Sysmon, WMI/WinRM | — |
| 5 | Programming for Cybersecurity — Python, Bash, PowerShell, JS fundamentals; builds a port scanner, log parser, HTTP client, automation utility, network tool | Automation Engine |
| 6 | Reconnaissance & OSINT — passive/active recon, DNS enum, WHOIS, subdomains, metadata, cert transparency, OSINT methodology, Shodan concepts | — |
| 7 | Web Security Metropolis — HTTP fundamentals, auth/session/JWT/OAuth flaws, SQLi/XSS/CSRF/SSRF/XXE/command injection/path traversal/IDOR/SSTI/deserialization, API security (BOLA, GraphQL, rate limiting) | Injection Serpent, Session Phantom, API Hydra |
| 8 | Penetration Testing Operations — methodology, Nmap/Netcat/Gobuster/ffuf/Burp/Metasploit concepts/John/Hashcat. All practical attacks target only platform-controlled vulnerable environments | — |
| 9 | Privilege Escalation — Linux (SUID, sudo, cron, PATH, capabilities, Docker misconfig) and Windows (services, registry, scheduled tasks, tokens) | — |
| 10 | Active Directory Empire — domains, LDAP, Kerberos/NTLM, GPO, trusts, SPNs, Kerberoasting/AS-REP concepts, BloodHound-style graph reasoning, ACL mistakes | Domain Emperor |
| 11 | SOC Command Center — SIEM/EDR/IDS/IPS, IOC/TTP, MITRE ATT&CK, alert triage, correlation, Sigma concepts, log sources across Linux/Windows/DNS/web/auth/firewall/cloud | — |
| 12 | Incident Response — Preparation/Detection/Triage/Containment/Eradication/Recovery/Lessons-learned; scenario missions (phishing, ransomware, stolen cloud key, insider threat, supply-chain) | — |
| 13 | Digital Forensics — evidence handling, chain of custody, disk images, filesystem/browser/email artifacts, timelines, memory & network forensics | Ghost Protocol |
| 14 | Malware Analysis & Reverse Engineering — static/dynamic analysis, PE/ELF, strings/hashes/imports, x86 concepts, Ghidra-style analysis, persistence & C2 behavior | ZeroDay |
| 15 | Cloud Security & DevSecOps — Docker (images, secrets, isolation, scanning), Kubernetes (RBAC, network policies, admission control), AWS/Azure/GCP IAM & attack paths | — |
| 16 | Cryptography — hashing, salts, symmetric/asymmetric encryption, AES/RSA, key exchange, digital signatures, TLS/PKI, JWT signing, common crypto mistakes | — |
| 17 | Advanced Red Team — sandbox-only: adversary simulation, credential access, lateral movement, pivoting/tunneling, persistence & evasion concepts, C2 concepts, OPSEC. Never targets arbitrary external systems | — |
| 18 | Threat Hunting & Intelligence — TI, IOCs/TTPs, MITRE ATT&CK, YARA/Sigma concepts, hunting hypotheses, behavior-based detection, APT investigation | — |
| 19 | AI Security — LLM fundamentals, embeddings/RAG/agents/tool calling/MCP, prompt injection (direct & indirect), retrieval poisoning, excessive agency, insecure output handling, memory poisoning, AI supply chain | Sentinel-X |

## Design constraint

Every practical/offensive exercise across every world targets only
intentionally vulnerable, platform-controlled environments — see
[Lab System](./05-lab-system.md). Nothing in Cyber Guardians attacks
arbitrary external targets.
