-- world-41 ("Detection Engineering: Signal in the Noise") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 6 "The Hunt" --
-- the flood of world-40 is triaged but every signature the Guardians own is
-- already going stale, so the player builds behavior-based detections that
-- don't key on a single hash or IP. Mission 1 is cross-world-gated on
-- world-40's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-41a', 'world-41', 'signal-in-the-noise', '41A - Signal in the Noise', 'Sigma, YARA, Sysmon, Zeek and Suricata concepts, learned building behavior-based detections that don''t depend on a single hash or IP.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-41a-1', 'campaign-41a', 'foundations', 'Foundations', 'Sigma, YARA, Sysmon, Zeek and Suricata concepts, learned as the building blocks of behavior-based detection.', 1),
  ('operation-41a-2', 'campaign-41a', 'validation', 'Validation', 'Writing, tuning and validating a detection against real, replayed data -- not just theory.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w41-01', 'world-41', 'campaign-41a', 'operation-41a-1', 'faster-than-the-feed', 'Faster Than the Feed', 'Every IOC the team published yesterday is already useless. Sentinel-X is changing hashes, domains and infrastructure faster than any feed can keep up.', 'intro', ARRAY['luna', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w40-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w41-02', 'world-41', 'campaign-41a', 'operation-41a-1', 'the-rule-instead-of-the-hash', 'The Rule Instead of the Hash', 'A Sigma rule doesn''t say "block this hash." It says "alert when a process behaves like this" -- described once, matched anywhere.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w41-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"sigma-behavior-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w41-03', 'world-41', 'campaign-41a', 'operation-41a-1', 'what-sysmon-actually-sees', 'What Sysmon Actually Sees', 'Sysmon doesn''t replace an EDR, but it''s the free, detailed layer underneath almost every rule the team writes.', 'beginner', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w41-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"sysmon-events-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w41-04', 'world-41', 'campaign-41a', 'operation-41a-2', 'zeek-suricata-and-the-wire', 'Zeek, Suricata, and the Wire', 'One tool logs everything that happens on the wire. The other matches traffic against what it already knows to look for.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w41-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"zeek-suricata-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w41-05', 'world-41', 'campaign-41a', 'operation-41a-2', 'tuning-out-the-noise', 'Tuning Out the Noise', 'A detection nobody trusts gets muted within a week. Fix the noise before it ships.', 'advanced', ARRAY['byte', 'luna'], '{"requiredMissionIds":["mission-w41-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"rule-tuning-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w41-06', 'world-41', 'campaign-41a', 'operation-41a-2', 'signal-in-the-noise-boss', 'Signal in the Noise', 'Create a robust detection for a Sentinel-X behavior without keying on a single hash or IP.', 'boss', ARRAY['luna', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w41-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"signal-in-the-noise-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["signal-in-the-noise"],"skillXp":{"soc":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w41-01', 1, 'luna', 'Every IOC we published from yesterday''s flood is already dead. New hashes, new domains, new infrastructure -- Sentinel-X is rotating artifacts faster than any feed updates.'),
  ('mission-w41-01', 2, 'byte', 'I''ve tried matching against three different threat-intel feeds. All three are already stale by the time they sync.'),
  ('mission-w41-01', 3, 'zayn', 'So matching what it used to look like isn''t going to work anymore.'),
  ('mission-w41-01', 4, 'luna', 'Which means we stop chasing artifacts and start writing detections for what it does, not what it happens to be wearing today.'),
  ('mission-w41-02', 1, 'byte', 'A Sigma rule doesn''t say "block this hash." It says "alert when a process behaves like this" -- described once, matched anywhere.'),
  ('mission-w41-02', 2, 'byte', 'The best rules key on what an attacker has to do, not what tool they happened to use to do it.'),
  ('mission-w41-03', 1, 'zayn', 'Sysmon doesn''t replace your EDR, but it''s the free, detailed layer underneath almost everything we write rules against.'),
  ('mission-w41-03', 2, 'byte', 'Event ID 1 is process creation with the full command line. Event ID 3 is network connection. Event ID 11 is file creation. Almost everything else builds on those three.'),
  ('mission-w41-04', 1, 'zayn', 'Zeek doesn''t match signatures -- it builds a rich, structured log of every connection: protocol, duration, bytes, certificate details, all of it.'),
  ('mission-w41-04', 2, 'zayn', 'Suricata does the opposite. It matches traffic against defined rules and can block in-line, the way an IDS/IPS traditionally works.'),
  ('mission-w41-05', 1, 'byte', 'First draft of the rule is done. It''s also firing four hundred times an hour.'),
  ('mission-w41-05', 2, 'luna', 'A detection nobody trusts gets muted within a week. Fix the noise before it ships.'),
  ('mission-w41-06', 1, 'byte', 'Detection assembled. Running it live first, then against six months of replayed data just to be safe.'),
  ('mission-w41-06', 2, 'zayn', 'Live traffic first -- clean catch, no false positives so far.'),
  ('mission-w41-06', 3, 'byte', '...Now running it backward.'),
  ('mission-w41-06', 4, 'luna', 'How far backward.'),
  ('mission-w41-06', 5, 'byte', 'All the way. Six months of replayed logs, every organization in our archive.'),
  ('mission-w41-06', 6, 'byte', '...Confirmed. Multiple matches, well before the first flood alert. This behavior was here long before anyone noticed it.'),
  ('mission-w41-06', 7, 'luna', 'The detection reveals activity that began before any alert was generated.'),
  ('mission-w41-06', 8, 'zayn', 'So we weren''t slow to see the flood. The flood was already old news by the time it reached us.'),
  ('mission-w41-06', 9, 'luna', 'Which means chasing alerts isn''t enough anymore. We need to go looking before anything trips a wire at all.'),
  ('mission-w41-06', 10, 'byte', 'That''s not a detection engineering problem anymore. That''s threat hunting.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w41-01-o1', 'mission-w41-01', 1, 'Acknowledge the shift to behavior-based detection', 'Confirm you''re ready to stop chasing artifacts and start writing detections for behavior.'),
  ('mission-w41-02-o1', 'mission-w41-02', 1, 'Choose the rule that survives artifact rotation', 'Pick the detection approach that would still catch Sentinel-X next week.'),
  ('mission-w41-03-o1', 'mission-w41-03', 1, 'Match each Sysmon event ID to what it captures', 'Match the Sysmon event ID to the activity it actually logs.'),
  ('mission-w41-04-o1', 'mission-w41-04', 1, 'Pick the right tool for the need', 'Choose the tool that actually meets the stated requirement.'),
  ('mission-w41-05-o1', 'mission-w41-05', 1, 'Fix the overly broad detection rule', 'Choose the rule draft that''s actually ready to ship.'),
  ('mission-w41-06-o1', 'mission-w41-06', 1, 'Assemble a behavior-based detection', 'Choose which rule components generalize and which are artifacts that rotate.'),
  ('mission-w41-06-o2', 'mission-w41-06', 2, 'Interpret the replay results', 'Determine what running the detection against historical data actually reveals.'),
  ('mission-w41-06-o3', 'mission-w41-06', 3, 'Close the detection', 'Confirm the rule''s composition and what the replay revealed, together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w41-01-o1-c1', 'mission-w41-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"IOCs are already stale. Ready to build detections that don''t depend on them?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w41-02-o1-c1', 'mission-w41-02-o1', 1, 'multiple_choice', 'Sentinel-X changes its tooling constantly. Which detection approach would still catch it next week?', '{"question":"Sentinel-X changes its tooling constantly. Which detection approach would still catch it next week?","options":[{"id":"a","text":"A rule that matches a specific file hash observed yesterday"},{"id":"b","text":"A rule that matches a specific command-and-control domain observed yesterday"},{"id":"c","text":"A rule that matches the behavior of a process spawning from an office document and immediately making an outbound network connection, regardless of which binary is involved"},{"id":"d","text":"A rule that only matches if the exact same IP is used again"}]}'::jsonb, '{"correctOptionId":"c"}'::jsonb),

  ('mission-w41-03-o1-c1', 'mission-w41-03-o1', 1, 'drag_and_drop', 'Match each Sysmon event ID to what it captures.', '{"items":[{"id":"s1","text":"Event ID 1"},{"id":"s2","text":"Event ID 3"},{"id":"s3","text":"Event ID 11"}],"targets":[{"id":"process_creation","label":"Process creation, with full command line and parent process"},{"id":"network_connection","label":"A process making an outbound network connection"},{"id":"file_creation","label":"A file being created or overwritten on disk"}]}'::jsonb, '{"correctMapping":{"s1":"process_creation","s2":"network_connection","s3":"file_creation"}}'::jsonb),

  ('mission-w41-04-o1-c1', 'mission-w41-04-o1', 1, 'investigation', 'You need to retroactively search six months of connection metadata for anomalies with no existing rule to match against. Which tool actually gives you that?', '{"evidence":[{"id":"opt_zeek","label":"Zeek","detail":"Produces rich connection-level logs for all traffic, matched or not -- built for hunting and baselining"},{"id":"opt_suricata","label":"Suricata","detail":"Matches traffic against defined rules in real time and can block in-line -- built for known-bad detection at the wire"}],"question":"You need to retroactively search six months of connection metadata for anomalies with no existing rule to match against. Which tool actually gives you that?"}'::jsonb, '{"requiredEvidenceIds":["opt_zeek"]}'::jsonb),

  ('mission-w41-05-o1-c1', 'mission-w41-05-o1', 1, 'investigation', 'Which draft rule is actually ready to ship?', '{"evidence":[{"id":"r1","label":"Draft rule (broad)","detail":"Fires on any process where the parent image ends with winword.exe and the child image ends with powershell.exe -- roughly 400 alerts an hour, almost all of them legitimate mail-merge macros"},{"id":"r2","label":"Draft rule (tuned)","detail":"Fires only when the parent image ends with winword.exe, the child image ends with powershell.exe, and the command line contains an encoded-command or execution-policy-bypass flag -- under five alerts a day, all confirmed suspicious in testing"}],"question":"Which draft rule is actually ready to ship?"}'::jsonb, '{"requiredEvidenceIds":["r2"]}'::jsonb),

  ('mission-w41-06-o1-c1', 'mission-w41-06-o1', 1, 'drag_and_drop', 'Sort each rule component by whether it should be included (it generalizes) or excluded (it''s an artifact that rotates).', '{"items":[{"id":"c1","text":"Parent image ends with winword.exe or excel.exe, child image ends with powershell.exe or cmd.exe"},{"id":"c2","text":"Command line contains -enc, -e, or -EncodedCommand"},{"id":"c3","text":"Followed by an outbound network connection within 60 seconds"},{"id":"c4","text":"File hash matches one specific known-bad SHA256"},{"id":"c5","text":"Destination IP matches one specific address"}],"targets":[{"id":"include","label":"Include -- behavior that generalizes"},{"id":"exclude","label":"Exclude -- artifact that rotates"}]}'::jsonb, '{"correctMapping":{"c1":"include","c2":"include","c3":"include","c4":"exclude","c5":"exclude"}}'::jsonb),

  ('mission-w41-06-o2-c1', 'mission-w41-06-o2', 1, 'multiple_choice', 'You run the new detection against six months of replayed log data, not just live traffic. What does it find?', '{"question":"You run the new detection against six months of replayed log data, not just live traffic. What does it find?","options":[{"id":"a","text":"Nothing -- it only matches going forward"},{"id":"b","text":"A handful of false positives and nothing else"},{"id":"c","text":"Matching activity that began weeks before the first flood alert was ever generated"},{"id":"d","text":"An exact copy of the alerts you already had"}]}'::jsonb, '{"correctOptionId":"c"}'::jsonb),

  ('mission-w41-06-o3-c1', 'mission-w41-06-o3', 1, 'boss_encounter', 'Confirm the rule''s composition and what the replay revealed, together.', '{"stages":[{"objectiveRef":"mission-w41-06-o1","label":"What the rule is built from"},{"objectiveRef":"mission-w41-06-o2","label":"What the replay revealed"}],"task":"Confirm the rule''s composition and what the replay revealed, together."}'::jsonb, '{"requiredObjectiveIds":["mission-w41-06-o1","mission-w41-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w41-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w41-02-o1-c1', 'orientation', 'Ask which of these would still be true even if every hash, domain and IP changed overnight.', 15, 1),
  ('mission-w41-02-o1-c1', 'concept', 'Behavior -- what has to happen for the attack to work -- survives artifact rotation. Specific hashes, domains and IPs don''t.', 25, 2),
  ('mission-w41-02-o1-c1', 'solution', 'Option c describes the behavior an attacker needs regardless of tooling -- the other three all key on artifacts Sentinel-X can, and does, rotate freely.', 35, 3),

  ('mission-w41-03-o1-c1', 'orientation', 'Read each event ID name literally -- creation, connection, creation of what.', 15, 1),
  ('mission-w41-03-o1-c1', 'solution', 'Event ID 1 is process creation, Event ID 3 is network connection, Event ID 11 is file creation.', 25, 2),

  ('mission-w41-04-o1-c1', 'orientation', 'One of these tools only tells you about traffic it already has a rule for.', 15, 1),
  ('mission-w41-04-o1-c1', 'concept', 'Retroactive search across unrelated traffic needs a log of everything, not a match against a known pattern.', 25, 2),
  ('mission-w41-04-o1-c1', 'solution', 'Zeek''s connection logs cover all traffic regardless of whether a rule exists, which is exactly what retroactive, rule-less search needs -- Suricata only flags what it already has a signature for.', 35, 3),

  ('mission-w41-05-o1-c1', 'orientation', 'Ask what an encoded or execution-policy-bypass flag on a PowerShell command actually implies.', 15, 1),
  ('mission-w41-05-o1-c1', 'concept', 'Legitimate mail-merge macros spawn PowerShell too -- the broad rule can''t tell them apart from an attack.', 25, 2),
  ('mission-w41-05-o1-c1', 'solution', 'The tuned rule (r2) adds the encoded/bypass-flag condition, cutting the alert volume from hundreds an hour to a handful a day, all confirmed suspicious -- the broad rule (r1) is unusable noise.', 35, 3),

  ('mission-w41-06-o1-c1', 'orientation', 'Ask which of these five would still be true if Sentinel-X changed every hash, domain and IP tomorrow.', 15, 1),
  ('mission-w41-06-o1-c1', 'concept', 'Three of these describe what an attacker has to do. Two describe one specific, disposable artifact.', 25, 2),
  ('mission-w41-06-o1-c1', 'solution', 'Include c1, c2 and c3 -- the parent/child relationship, the encoded-command flag, and the follow-up connection all describe required behavior. Exclude c4 and c5 -- a single hash and a single IP are exactly the artifacts Sentinel-X rotates.', 35, 3),

  ('mission-w41-06-o2-c1', 'orientation', 'Consider why anyone would bother replaying old data through a brand-new detection.', 15, 1),
  ('mission-w41-06-o2-c1', 'solution', 'The replay finds matching activity from weeks before the first flood alert -- proof this behavior was already present, just never detected. Option c.', 25, 2),

  ('mission-w41-06-o3-c1', 'orientation', 'You''ve already built the rule and read the replay -- bring both together.', 20, 1),
  ('mission-w41-06-o3-c1', 'concept', 'Closing this out means stating what the rule keys on and what running it backward proved.', 30, 2),
  ('mission-w41-06-o3-c1', 'tool_direction', 'State the three behavioral components first, then what the historical replay actually found.', 40, 3),
  ('mission-w41-06-o3-c1', 'near_solution', 'A rule built on parent/child relationship, encoded-command flags and follow-up network activity -- and a replay showing matches that predate the first alert.', 50, 4),
  ('mission-w41-06-o3-c1', 'solution', 'The detection is built entirely on behavior -- office-to-shell parentage, encoded or bypass command-line flags, and a follow-up network connection -- with no single hash or IP anywhere in it. Run against six months of replayed data, it finds matching activity that began weeks before the first flood alert was ever generated: the detection reveals activity that began before any alert was generated.', 65, 5);
