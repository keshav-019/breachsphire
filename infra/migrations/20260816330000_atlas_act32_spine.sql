-- Atlas Division pathway ("The Silence"): World row for Act 32,
-- "Supply Chain", closing act-atlas-9 ("World IX -- Platform City")
-- entirely (Acts 30-32 done -- confirmed via the doc's own
-- `# WORLD X -- ATLAS` heading appearing only after this Act's topics,
-- no new Act row needed). Content (missions) follows in its own
-- migration.
--
-- Narrative thread: Act 31 closed by naming the next problem directly --
-- not how services talk to each other, but what actually goes into them
-- before they are ever allowed to run. Rook builds a full software
-- supply chain security pipeline: SAST, dependency and container
-- scanning, SBOMs, signing, provenance, policy enforcement, secret
-- scanning and runtime security. "Trusted Poison" proves every static
-- scan can pass cleanly on a genuinely compromised dependency -- the
-- catch only comes from provenance verification and a live runtime
-- alert, not from anything that inspects code at rest.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-supply-chain', 'act-atlas-9', 31, 'supply-chain', 'Supply Chain', 'Supply Chain',
   'Shift left; SAST; DAST concepts; dependency scanning; container scanning; SBOM; signing; provenance; policy enforcement; secret scanning; runtime security.',
   'The mesh now governs how services on this fleet talk to each other. Nothing yet governs what actually goes into a service before it is allowed to run at all. Rook builds a real software supply chain security pipeline, end to end, before that gap gets found the hard way.',
   'Trusted Poison',
   '"Trusted Poison" is not caught by anything that inspects code at rest. A dependency pulled in through an otherwise ordinary update passes static analysis cleanly, has no known CVE, and its container image scans clean -- because the malicious change was published after the fact, directly to the package registry, never touching the dependency''s own public source repository at all. It is only caught because provenance verification compares the published package against its supposedly matching signed source commit and finds they do not match, and a runtime security alert catches the same service making an anomalous outbound connection moments later, confirming the tampering was not just present but actively exploited.',
   'This fleet can now prove, cryptographically, that what actually runs matches what was actually reviewed and signed. Every hard-won discipline in this pathway has lived inside one team''s infrastructure. What none of it has ever accounted for is what happens when the cost of running that infrastructure stops being anyone''s problem at all.',
   'Trusted Poison', 'ShieldAlert', 'critical', 146, 10, 'pathway-atlas');
