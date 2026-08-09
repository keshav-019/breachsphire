-- world-24 ("Vulnerability Management: The Vulnerability Queue") mission
-- content, generated from docs/12-world-story-bible.md. Closes Act 3 "The
-- Shield" and hands off into Act 4 "The Breach". Mission 1 is
-- cross-world-gated on world-23's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-24a', 'world-24', 'the-vulnerability-queue', '24A - The Vulnerability Queue', 'A full scan across every redesigned system comes back with thousands of findings. Fixing everything is impossible -- deciding what matters is the actual job.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-24a-1', 'campaign-24a', 'foundations', 'Foundations', 'CVE, CWE, CVSS and validation, learned as the vocabulary of triage under volume.', 1),
  ('operation-24a-2', 'campaign-24a', 'investigation', 'Investigation', 'Prioritize by real exploitability, not raw score, and close the chain that actually matters before the deadline.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w24-01', 'world-24', 'campaign-24a', 'operation-24a-1', 'too-many-findings', 'Too Many Findings', 'The redesign sweep triggered a full scan across every system it touched. Thousands of findings came back. Nobody reads a list that long line by line.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w23-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w24-02', 'world-24', 'campaign-24a', 'operation-24a-1', 'three-different-letters', 'Three Different Letters', 'CVE, CWE and CVSS all describe a finding -- but none of them alone tells you whether it matters to us, specifically, today.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w24-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"cve-cwe-cvss-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w24-03', 'world-24', 'campaign-24a', 'operation-24a-1', 'prove-it-first', 'Prove It First', 'Scanners lie constantly, not out of malice -- they just can''t see everything a human investigation can.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w24-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"false-positive-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w24-04', 'world-24', 'campaign-24a', 'operation-24a-2', 'score-versus-reach', 'Score Versus Reach', 'A 9.8 sitting behind three closed doors matters less than a 6.1 an attacker can actually reach right now.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w24-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"prioritization-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w24-05', 'world-24', 'campaign-24a', 'operation-24a-2', 'the-blast-radius', 'The Blast Radius', 'Every patch has a blast radius. Deploying blind because a score is scary is how you cause your own outage.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w24-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"patch-impact-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w24-06', 'world-24', 'campaign-24a', 'operation-24a-2', 'forty-eight-hours-boss', 'Forty-Eight Hours', 'One finding only looks low-severity in isolation. Find the one that becomes critical when it chains with something we already know about -- before the next SX beacon window.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w24-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"forty-eight-hours-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["forty-eight-hours"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w24-01', 1, 'zayn', 'Ava and Byte just closed a hundred flattened boundaries. That triggered a full scan across every system we touched. Guess how many findings came back.'),
  ('mission-w24-01', 2, 'byte', 'Selection bias aside, the technical answer is: too many. Thousands. Nobody reads a list that long line by line.'),
  ('mission-w24-01', 3, 'zayn', 'Which is the actual lesson here. This isn''t about finding every vulnerability. It''s about deciding, fast and correctly, which ones matter right now.'),
  ('mission-w24-01', 4, 'byte', 'Fixing everything is impossible. Fixing the right five things isn''t.'),
  ('mission-w24-02', 1, 'byte', 'A CVE names a specific vulnerability. A CWE names the general category of mistake behind it. A CVSS score tries to rate how bad it is. None of those three tells you whether it matters to us, specifically, today.'),
  ('mission-w24-03', 1, 'zayn', 'Scanners lie constantly, not out of malice -- they just can''t see everything a human investigation can. Half of triage is proving a finding is real before anyone touches a fix.'),
  ('mission-w24-04', 1, 'byte', 'A 9.8 sitting behind three closed doors matters less than a 6.1 an attacker can actually reach right now. Severity and priority are not the same number.'),
  ('mission-w24-05', 1, 'zayn', 'Every patch has a blast radius. Deploying blind because a CVE score is scary is how you cause your own outage.'),
  ('mission-w24-06', 1, 'zayn', 'One of these findings only looks low-severity in isolation. Find the one that becomes critical when it chains with something else we already know about.'),
  ('mission-w24-06', 2, 'byte', '...Found it. CVSS 4.3, authentication bypass on a legacy telemetry endpoint. Nobody would prioritize that alone.'),
  ('mission-w24-06', 3, 'zayn', 'Except that endpoint still accepts the exact kind of long-lived service credential we just deprecated, and it got missed by the fortress redesign sweep -- it still has a direct path to the internal database.'),
  ('mission-w24-06', 4, 'byte', 'Chain those together and a 4.3 becomes a full compromise path. The scoring system was never wrong. It just can''t see context.'),
  ('mission-w24-06', 5, 'zayn', 'We have until the next scheduled SX beacon window. Prioritize the chain, not the score, and get it closed.'),
  ('mission-w24-06', 6, 'byte', '...Confirmed closed, with time to spare.'),
  ('mission-w24-06', 7, 'zayn', 'This is the last thing we fix from a report. Everything after this, we go find ourselves. Luna''s authorized controlled penetration testing to reproduce the actual attack path, start to finish.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w24-01-o1', 'mission-w24-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to prioritize under volume, not chase every finding.'),
  ('mission-w24-02-o1', 'mission-w24-02', 1, 'Distinguish CVE, CWE and CVSS', 'Explain what each of the three actually tells you.'),
  ('mission-w24-03-o1', 'mission-w24-03', 1, 'Find the false positive', 'Identify which finding is confirmed to be a false positive after manual validation.'),
  ('mission-w24-04-o1', 'mission-w24-04', 1, 'Prioritize by real exploitability', 'Choose the finding that should be prioritized first, given limited time.'),
  ('mission-w24-05-o1', 'mission-w24-05', 1, 'Match each patch to its rollout path', 'Sort each patch into the correct deployment timing based on its actual blast radius.'),
  ('mission-w24-06-o1', 'mission-w24-06', 1, 'Find the compromise chain', 'Identify the evidence that turns a low-severity finding into a critical one.'),
  ('mission-w24-06-o2', 'mission-w24-06', 2, 'Choose the correct action', 'Select the response that treats the chain as critical, not the isolated score.'),
  ('mission-w24-06-o3', 'mission-w24-06', 3, 'Close the queue', 'Confirm the compromise chain and the action that closes it.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w24-01-o1-c1', 'mission-w24-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"Thousands of findings, no time to read them all one by one. Ready to prioritize instead?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w24-02-o1-c1', 'mission-w24-02-o1', 1, 'multiple_choice', 'A scan result lists: CVE-2024-31337, CWE-89 (SQL Injection), CVSS 9.8. What does each part actually tell you?', '{"question":"A scan result lists: CVE-2024-31337, CWE-89 (SQL Injection), CVSS 9.8. What does each part actually tell you?","options":[{"id":"a","text":"They''re three different ways of saying the same thing"},{"id":"b","text":"CVE identifies this specific vulnerability, CWE names the general weakness category behind it, and CVSS scores its severity -- three different, complementary pieces of information"},{"id":"c","text":"CVSS identifies the vulnerability and CVE scores it"},{"id":"d","text":"CWE is a newer replacement for CVE"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w24-03-o1-c1', 'mission-w24-03-o1', 1, 'investigation', 'Which finding is confirmed to be a false positive after manual validation?', '{"evidence":[{"id":"f1","label":"Scanner finding: outdated OpenSSH banner, CVSS 7.5","detail":"Banner reports OpenSSH 8.2 -- the version string matches a range with a known vulnerability"},{"id":"f2","label":"Vendor advisory and changelog","detail":"The vendor backported the security fix into 8.2 without changing the banner string -- confirmed patched"},{"id":"f3","label":"Scanner finding: exposed admin panel, no authentication observed, CVSS 8.1","detail":"Panel reachable at a public URL during the scan"},{"id":"f4","label":"Manual verification of the admin panel","detail":"Panel loads fully with no credential prompt at all -- confirmed reachable and unauthenticated exactly as the scanner reported"}],"question":"Which finding is confirmed to be a false positive after manual validation?"}'::jsonb, '{"requiredEvidenceIds":["f1","f2"]}'::jsonb),

  ('mission-w24-04-o1-c1', 'mission-w24-04-o1', 1, 'investigation', 'Given limited time, which finding should be prioritized first?', '{"evidence":[{"id":"v1","label":"CVSS 9.8 finding on an internal batch-processing server","detail":"Not internet-facing, reachable only from one other internal host, no known active exploitation"},{"id":"v2","label":"CVSS 6.1 finding on the public storefront''s login endpoint","detail":"Internet-facing, high real-world exploitation probability, a public proof-of-concept exists"},{"id":"v3","label":"CVSS 8.4 finding on a decommissioned staging server","detail":"Scheduled for teardown next week, not connected to production data"},{"id":"v4","label":"CVSS 5.0 finding on an unused development VLAN","detail":"No production traffic, no scheduled use"}],"question":"Given limited time, which finding should be prioritized first?"}'::jsonb, '{"requiredEvidenceIds":["v2"]}'::jsonb),

  ('mission-w24-05-o1-c1', 'mission-w24-05-o1', 1, 'drag_and_drop', 'Sort each patch into the correct deployment timing based on its actual blast radius.', '{"items":[{"id":"p1","text":"Critical patch for the public storefront''s login service, well-tested by the vendor, staged in a canary environment first"},{"id":"p2","text":"Kernel-level patch for the database cluster, requires a reboot and has caused outages in this environment before"},{"id":"p3","text":"Emergency patch for a vulnerability with confirmed active exploitation against this exact system, right now"},{"id":"p4","text":"Routine patch for an internal tool nobody depends on for uptime"}],"targets":[{"id":"deploy_now","label":"Deploy immediately"},{"id":"scheduled_window","label":"Deploy in the next tested maintenance window"},{"id":"emergency","label":"Emergency out-of-band patch, accept disruption risk"}]}'::jsonb, '{"correctMapping":{"p1":"deploy_now","p2":"scheduled_window","p3":"emergency","p4":"scheduled_window"}}'::jsonb),

  ('mission-w24-06-o1-c1', 'mission-w24-06-o1', 1, 'investigation', 'Which two pieces of evidence, combined with the low-severity finding, create a critical compromise path?', '{"evidence":[{"id":"g1","label":"Finding: authentication bypass on the legacy telemetry endpoint, CVSS 4.3","detail":"Scored low because exploitation alone only grants read access to non-sensitive telemetry data"},{"id":"g2","label":"Credential audit of the telemetry endpoint","detail":"Still accepts the same long-lived service-credential pattern just deprecated after the sentinel-orchestrator incident -- migration was scheduled here but not yet completed"},{"id":"g3","label":"Zone audit of the telemetry endpoint","detail":"This specific endpoint was missed by the fortress redesign sweep -- it still has a direct, unmediated path to the internal database"},{"id":"g4","label":"SX beacon activity schedule","detail":"Beacon activity observed on a recurring interval; the next window begins in under 48 hours"}],"question":"Which two pieces of evidence, combined with the low-severity finding, create a critical compromise path?"}'::jsonb, '{"requiredEvidenceIds":["g2","g3"]}'::jsonb),

  ('mission-w24-06-o2-c1', 'mission-w24-06-o2', 1, 'multiple_choice', 'Given the 48-hour window before the next SX beacon activity, what''s the correct action?', '{"question":"Given the 48-hour window before the next SX beacon activity, what''s the correct action?","options":[{"id":"a","text":"Deprioritize it -- the CVSS score is only 4.3"},{"id":"b","text":"Migrate the endpoint''s credentials, mediate its database access through the application tier, and patch the auth bypass -- treat the chain as critical regardless of the individual score"},{"id":"c","text":"Wait for the next scheduled quarterly patch cycle"},{"id":"d","text":"Only patch the auth bypass and leave the credential and zoning issues for later"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w24-06-o3-c1', 'mission-w24-06-o3', 1, 'boss_encounter', 'Confirm the compromise chain and the action that closes it.', '{"stages":[{"objectiveRef":"mission-w24-06-o1","label":"The compromise chain"},{"objectiveRef":"mission-w24-06-o2","label":"The remediation action"}],"task":"Confirm the compromise chain and the action that closes it."}'::jsonb, '{"requiredObjectiveIds":["mission-w24-06-o1","mission-w24-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w24-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w24-02-o1-c1', 'orientation', 'Three different fields on the same finding usually answer three different questions, not one.', 10, 1),
  ('mission-w24-02-o1-c1', 'solution', 'CVE = which vulnerability, CWE = what kind of mistake it is, CVSS = how severe it''s rated -- complementary, not redundant. Option b.', 20, 2),

  ('mission-w24-03-o1-c1', 'orientation', 'A version banner and the actual patched state of a package aren''t always the same thing.', 15, 1),
  ('mission-w24-03-o1-c1', 'concept', 'Vendors sometimes backport fixes without bumping the visible version string, which fools banner-based scanning specifically.', 25, 2),
  ('mission-w24-03-o1-c1', 'solution', 'The OpenSSH finding (f1) is a false positive -- the vendor advisory (f2) confirms the fix was backported without changing the banner. The admin panel finding is confirmed real by direct manual testing (f3/f4).', 35, 3),

  ('mission-w24-04-o1-c1', 'orientation', 'Two of these four findings sit on systems with almost no real exposure at all.', 15, 1),
  ('mission-w24-04-o1-c1', 'concept', 'A high score with low reachability matters less right now than a moderate score that''s internet-facing with active proof-of-concept exploitation.', 25, 2),
  ('mission-w24-04-o1-c1', 'solution', 'v2 is internet-facing with a public proof-of-concept and high real-world exploitation probability -- that beats every higher-CVSS finding sitting on isolated or decommissioned systems.', 35, 3),

  ('mission-w24-05-o1-c1', 'orientation', 'Ask two questions about each patch: how tested is it, and what happens if it goes wrong right now.', 15, 1),
  ('mission-w24-05-o1-c1', 'solution', 'p1 is well-tested and low-risk -- deploy now. p3 has active exploitation -- emergency, accept the disruption risk. p2 (history of outages) and p4 (no urgency) both belong in a tested, scheduled window.', 25, 2),

  ('mission-w24-06-o1-c1', 'orientation', 'The finding alone only grants read access. Something else has to extend that into real reach.', 15, 1),
  ('mission-w24-06-o1-c1', 'concept', 'A stale credential pattern plus a zoning gap the redesign sweep missed is exactly the combination that turns limited access into a real path to sensitive data.', 25, 2),
  ('mission-w24-06-o1-c1', 'tool_direction', 'Check the credential audit and the zone audit for this specific endpoint.', 35, 3),
  ('mission-w24-06-o1-c1', 'solution', 'The endpoint still uses the deprecated long-lived credential pattern (g2) and was missed by the fortress redesign sweep, leaving a direct database path (g3) -- combined with the auth bypass, that''s a full compromise chain.', 45, 4),

  ('mission-w24-06-o2-c1', 'orientation', 'The fix has to address the credential, the zoning, and the bypass together -- not just one of the three.', 15, 1),
  ('mission-w24-06-o2-c1', 'solution', 'Migrating the credential, mediating database access through the application tier, and patching the bypass together closes the whole chain -- treating the combined risk as critical, not the isolated 4.3 score. Option b.', 25, 2),

  ('mission-w24-06-o3-c1', 'orientation', 'You''ve already found both halves -- combine the chain with the fix.', 20, 1),
  ('mission-w24-06-o3-c1', 'concept', 'The closure needs to state what makes the chain critical and exactly what closes all three parts of it.', 30, 2),
  ('mission-w24-06-o3-c1', 'tool_direction', 'State the credential and zoning gaps first, then the combined remediation.', 40, 3),
  ('mission-w24-06-o3-c1', 'near_solution', 'Stale credential pattern plus a missed zoning gap turns a 4.3 auth bypass into a real compromise path; close it by migrating credentials, mediating access, and patching the bypass together.', 50, 4),
  ('mission-w24-06-o3-c1', 'solution', 'The telemetry endpoint''s auth bypass alone was low-severity, but its unmigrated long-lived credential and a zoning gap the redesign sweep missed together turn it into a real compromise path to the internal database. Closing it requires migrating the credential, mediating its database access through the application tier, and patching the bypass -- all three, before the next beacon window.', 65, 5);
