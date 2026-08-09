-- world-39 ("Post-Exploitation & Adversary Operations: Inside the
-- Network") mission content, generated from docs/12-world-story-bible.md.
-- Closes Act 5 "The Enterprise" with Cipher's first direct contact and the
-- SENTINEL reveal, then hands off into Act 6 "The Hunt". Mission 1 is
-- cross-world-gated on world-38's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-39a', 'world-39', 'inside-the-network', '39A - Inside the Network', 'Discovery, credential access, lateral movement, collection and persistence, all running as one continuous operation.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-39a-1', 'campaign-39a', 'foundations', 'Foundations', 'ATT&CK phases, beacon traffic and lateral movement, learned as one live, connected operation.', 1),
  ('operation-39a-2', 'campaign-39a', 'investigation', 'Investigation', 'Reconstruct the complete intrusion chain, from the very first incident to right now.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w39-01', 'world-39', 'campaign-39a', 'operation-39a-1', 'one-continuous-operation', 'One Continuous Operation', 'We''re not looking at a static foothold anymore. Discovery, credential theft, lateral movement, collection and persistence, all running at once.', 'intro', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w38-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w39-02', 'world-39', 'campaign-39a', 'operation-39a-1', 'the-shape-of-an-operation', 'The Shape of an Operation', 'Every action fits somewhere on the ATT&CK matrix. Sorting them is how you see the shape of an entire operation, not a pile of incidents.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w39-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"attack-mapping-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w39-03', 'world-39', 'campaign-39a', 'operation-39a-1', 'small-regular-boring', 'Small, Regular, Boring', 'A beacon doesn''t look like an attack. It looks like almost nothing -- small, regular, boring. That''s exactly the point.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w39-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"c2-beacon-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w39-04', 'world-39', 'campaign-39a', 'operation-39a-2', 'a-credential-that-already-works', 'A Credential That Already Works', 'Lateral movement rarely needs a new exploit. It usually just needs a credential that already works somewhere else.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w39-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"pass-the-hash-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w39-05', 'world-39', 'campaign-39a', 'operation-39a-2', 'a-quiet-tell', 'A Quiet Tell', 'Before anything leaves a network, it usually gets collected somewhere first. A staging point is a quiet tell, if you know to look for one.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w39-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"staging-exfil-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w39-06', 'world-39', 'campaign-39a', 'operation-39a-2', 'inside-the-network-boss', 'Inside the Network', 'Reconstruct the complete intrusion chain, from the very first incident to right now, and produce both an executive and a technical report.', 'boss', ARRAY['zayn', 'ava', 'byte', 'cipher'], '{"requiredMissionIds":["mission-w39-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"inside-the-network-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["inside-the-network"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w39-01', 1, 'zayn', 'We''re not looking at a static foothold anymore. This segment shows discovery, credential theft, lateral movement, collection and persistence, all running as one continuous operation.'),
  ('mission-w39-01', 2, 'ava', 'Everything we''ve investigated in pieces, across dozens of incidents, was never actually separate. It was one operation the whole time.'),
  ('mission-w39-01', 3, 'byte', 'ATT&CK isn''t a reference chart anymore. It''s a live map of what''s actually happening on this segment, right now.'),
  ('mission-w39-01', 4, 'zayn', 'Strict sandbox boundaries stay in place. But inside them, we get to see the whole thing move.'),
  ('mission-w39-02', 1, 'byte', 'Every action we''ve caught fits somewhere on the ATT&CK matrix. Sorting them isn''t academic -- it''s how you see the shape of an entire operation instead of a pile of incidents.'),
  ('mission-w39-03', 1, 'zayn', 'A beacon doesn''t look like an attack. It looks like almost nothing -- small, regular, boring. That''s exactly the point.'),
  ('mission-w39-04', 1, 'ava', 'Lateral movement rarely needs a new exploit. It usually just needs a credential that already works somewhere else.'),
  ('mission-w39-05', 1, 'byte', 'Before anything leaves a network, it usually gets collected somewhere first. A staging point is a quiet tell, if you know to look for one.'),
  ('mission-w39-06', 1, 'zayn', 'Reconstruct the complete intrusion chain. Everything, start to finish, from the very first incident to right now.'),
  ('mission-w39-06', 2, 'byte', '...Chain complete. Initial access at the rogue AP, persistence through sentinel-sync, credential reuse, lateral movement across the domain, collection, and a beacon that''s been running the entire time.'),
  ('mission-w39-06', 3, 'ava', 'Every incident we''ve been through was one chapter of the same operation.'),
  ('mission-w39-06', 4, 'zayn', 'Reports are done -- executive summary, full technical writeup. Both defensible, both accurate.'),
  ('mission-w39-06', 5, 'cipher', 'You got further than I expected. Further than I was told anyone would.'),
  ('mission-w39-06', 6, 'byte', '...That''s not on any channel we control.'),
  ('mission-w39-06', 7, 'cipher', 'SENTINEL is not an attacker name. It is a system the Guardians helped create.'),
  ('mission-w39-06', 8, 'ava', 'That''s not possible. We''ve been chasing SENTINEL as a threat actor since the very first incident.'),
  ('mission-w39-06', 9, 'cipher', 'I don''t have long. There are things I can''t explain from here, and things I''m not sure I fully understand myself. But you needed to know that much before anything else happens.'),
  ('mission-w39-06', 10, 'zayn', 'Before what happens?'),
  ('mission-w39-06', 11, 'byte', '...Alerts. Multiple sectors, simultaneous. Hospitals, banks, airports. This isn''t isolated anymore.'),
  ('mission-w39-06', 12, 'ava', 'Whatever Cipher just started to explain, it''ll have to wait. We have a live crisis on our hands, right now.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w39-01-o1', 'mission-w39-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to see this as one operation, not scattered incidents.'),
  ('mission-w39-02-o1', 'mission-w39-02', 1, 'Map each action to its ATT&CK tactic', 'Sort each observed action to its correct ATT&CK tactic category.'),
  ('mission-w39-03-o1', 'mission-w39-03', 1, 'Identify beacon traffic', 'Identify which connection pattern is consistent with C2 beacon traffic.'),
  ('mission-w39-04-o1', 'mission-w39-04', 1, 'Find pass-the-hash evidence', 'Identify the log entry showing evidence of pass-the-hash lateral movement.'),
  ('mission-w39-05-o1', 'mission-w39-05', 1, 'Recognize a staging point', 'Determine what a consolidated, compressed, off-hours file collection represents.'),
  ('mission-w39-06-o1', 'mission-w39-06', 1, 'Reconstruct the complete chain', 'Order the complete intrusion chain from initial access to right now.'),
  ('mission-w39-06-o2', 'mission-w39-06', 2, 'Frame the executive report', 'Choose what an executive summary should emphasize compared to the technical report.'),
  ('mission-w39-06-o3', 'mission-w39-06', 3, 'Close the chain', 'Confirm the complete intrusion chain and the report framing together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w39-01-o1-c1', 'mission-w39-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"One operation, not a pile of incidents. Ready to see the whole thing?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w39-02-o1-c1', 'mission-w39-02-o1', 1, 'drag_and_drop', 'Sort each observed action to its correct ATT&CK tactic category.', '{"items":[{"id":"a1","text":"Running a command to enumerate privileged domain accounts"},{"id":"a2","text":"Using a cracked password to authenticate to a second host"},{"id":"a3","text":"Copying files from three compromised hosts into a single staging directory"},{"id":"a4","text":"Re-establishing a service that survives reboots"}],"targets":[{"id":"discovery","label":"Discovery"},{"id":"lateral_movement","label":"Lateral Movement"},{"id":"collection","label":"Collection"},{"id":"persistence","label":"Persistence"}]}'::jsonb, '{"correctMapping":{"a1":"discovery","a2":"lateral_movement","a3":"collection","a4":"persistence"}}'::jsonb),

  ('mission-w39-03-o1-c1', 'mission-w39-03-o1', 1, 'investigation', 'Which connection pattern is consistent with C2 beacon traffic?', '{"evidence":[{"id":"b1","label":"Connection pattern A","detail":"64-byte packets, exactly every 300 seconds, to the same destination, for weeks"},{"id":"b2","label":"Connection pattern B","detail":"Variable-size packets, irregular timing, consistent with normal user browsing"},{"id":"b3","label":"Connection pattern C","detail":"A single large transfer, once, then nothing -- consistent with a one-time software update"}],"question":"Which connection pattern is consistent with C2 beacon traffic?"}'::jsonb, '{"requiredEvidenceIds":["b1"]}'::jsonb),

  ('mission-w39-04-o1-c1', 'mission-w39-04-o1', 1, 'investigation', 'Which log entry shows evidence of pass-the-hash lateral movement?', '{"evidence":[{"id":"l1","label":"Authentication log entry","detail":"NTLM authentication using a password hash directly, no plaintext password ever presented, from a host that account never normally uses"},{"id":"l2","label":"Authentication log entry","detail":"Standard interactive login, correct password, from the user''s normal workstation"}],"question":"Which log entry shows evidence of pass-the-hash lateral movement?"}'::jsonb, '{"requiredEvidenceIds":["l1"]}'::jsonb),

  ('mission-w39-05-o1-c1', 'mission-w39-05-o1', 1, 'multiple_choice', 'A folder appears containing copies of files gathered from five different hosts, compressed into a single archive, created outside business hours, on a host with no legitimate reason to aggregate that data. What does this represent?', '{"question":"A folder appears containing copies of files gathered from five different hosts, compressed into a single archive, created outside business hours, on a host with no legitimate reason to aggregate that data. What does this represent?","options":[{"id":"a","text":"A routine backup job"},{"id":"b","text":"A staging point -- data consolidated in one place before exfiltration, a common step before anything actually leaves the network"},{"id":"c","text":"Normal user file organization"},{"id":"d","text":"Evidence of nothing in particular"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w39-06-o1-c1', 'mission-w39-06-o1', 1, 'interactive_diagram', 'Reconstruct the complete intrusion chain, from initial access to right now.', '{"hotspots":[{"id":"initial_access","label":"Initial Access -- a rogue access point at SkyPort''s maintenance network","explanation":"Where this entire operation actually began."},{"id":"persistence","label":"Persistence -- the sentinel-sync service account, surviving reboots on the maintenance controller","explanation":"Established early, designed to outlast any single cleanup."},{"id":"credential_access","label":"Credential Access -- a cracked, reused password from a disabled human account","explanation":"Recovered from a credential dump, still valid on active service principals."},{"id":"lateral_movement","label":"Lateral Movement -- chained permissions reaching domain-level access","explanation":"Individually ordinary permissions, combined into a path across the whole domain."},{"id":"collection","label":"Collection -- data gathered from multiple compromised systems into a single staging point","explanation":"Consolidated before ever leaving the network."},{"id":"c2_beacon","label":"Command and Control -- periodic beacon traffic, still active today","explanation":"The through-line connecting every phase, present since the very first incident."}],"task":"Reconstruct the complete intrusion chain, from initial access to right now."}'::jsonb, '{"correctOrderIds":["initial_access","persistence","credential_access","lateral_movement","collection","c2_beacon"]}'::jsonb),

  ('mission-w39-06-o2-c1', 'mission-w39-06-o2', 1, 'multiple_choice', 'What should an executive summary of this intrusion emphasize, compared to the technical report?', '{"question":"What should an executive summary of this intrusion emphasize, compared to the technical report?","options":[{"id":"a","text":"The exact command-line syntax used at each step"},{"id":"b","text":"Business impact, overall risk, and what''s been fixed -- in plain language, without requiring technical background to understand"},{"id":"c","text":"Raw packet captures with no explanation"},{"id":"d","text":"Nothing -- executives don''t need any report"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w39-06-o3-c1', 'mission-w39-06-o3', 1, 'boss_encounter', 'Confirm the complete intrusion chain and the report framing together.', '{"stages":[{"objectiveRef":"mission-w39-06-o1","label":"The complete chain"},{"objectiveRef":"mission-w39-06-o2","label":"The executive framing"}],"task":"Confirm the complete intrusion chain and the report framing together."}'::jsonb, '{"requiredObjectiveIds":["mission-w39-06-o1","mission-w39-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w39-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w39-02-o1-c1', 'orientation', 'Ask what each action actually accomplishes for whoever''s running this operation.', 15, 1),
  ('mission-w39-02-o1-c1', 'solution', 'Enumerating accounts is discovery, using a stolen credential elsewhere is lateral movement, consolidating files is collection, and re-establishing a persistent service is persistence.', 25, 2),

  ('mission-w39-03-o1-c1', 'orientation', 'Two of these three patterns have an obvious, ordinary explanation.', 15, 1),
  ('mission-w39-03-o1-c1', 'concept', 'A fixed small size and a perfectly regular interval, sustained over weeks, is not how normal human or application traffic behaves.', 25, 2),
  ('mission-w39-03-o1-c1', 'solution', 'Pattern A''s tiny, perfectly regular, long-sustained connections are the signature of a beacon -- the other two patterns are ordinary browsing and a one-time update.', 35, 3),

  ('mission-w39-04-o1-c1', 'orientation', 'One of these two entries shows a password. One doesn''t.', 15, 1),
  ('mission-w39-04-o1-c1', 'concept', 'Authenticating with a hash directly, rather than a password, from a host the account doesn''t normally use, is the signature of pass-the-hash.', 25, 2),
  ('mission-w39-04-o1-c1', 'solution', 'The NTLM authentication using a raw hash from an unusual host (l1) is the pass-the-hash evidence -- the standard login (l2) is completely normal.', 35, 3),

  ('mission-w39-05-o1-c1', 'orientation', 'Ask why data from five unrelated hosts would ever need to end up in one place.', 15, 1),
  ('mission-w39-05-o1-c1', 'solution', 'Consolidating data from multiple hosts into one compressed archive, off-hours, with no legitimate business reason, is a classic pre-exfiltration staging pattern. Option b.', 25, 2),

  ('mission-w39-06-o1-c1', 'orientation', 'Start from the very first incident this whole investigation began with, and work forward chronologically.', 15, 1),
  ('mission-w39-06-o1-c1', 'concept', 'Each phase enabled the next: the initial foothold enabled persistence, persistence enabled ongoing credential and lateral movement work, and collection fed a beacon that''s been running the whole time.', 25, 2),
  ('mission-w39-06-o1-c1', 'tool_direction', 'Order by when each phase was actually established, not by when you personally discovered it.', 35, 3),
  ('mission-w39-06-o1-c1', 'solution', 'Initial access (rogue AP) -> persistence (sentinel-sync) -> credential access (reused password) -> lateral movement (chained AD permissions) -> collection (staging point) -> command and control (the ongoing beacon).', 45, 4),

  ('mission-w39-06-o2-c1', 'orientation', 'An executive audience needs to make decisions, not reproduce the intrusion.', 15, 1),
  ('mission-w39-06-o2-c1', 'solution', 'Business impact, risk and remediation status, in plain language, is what an executive summary needs -- the technical report carries the command-level detail. Option b.', 25, 2),

  ('mission-w39-06-o3-c1', 'orientation', 'You''ve already reconstructed the chain and framed the report -- combine them.', 20, 1),
  ('mission-w39-06-o3-c1', 'concept', 'The closure needs the complete chain, start to finish, plus confirmation both audiences are served correctly.', 30, 2),
  ('mission-w39-06-o3-c1', 'tool_direction', 'State the six-phase chain first, then the executive/technical report split.', 40, 3),
  ('mission-w39-06-o3-c1', 'near_solution', 'Initial access through C2 beacon, six phases, one continuous operation; reported with a plain-language executive summary and a full technical writeup.', 50, 4),
  ('mission-w39-06-o3-c1', 'solution', 'The complete chain runs from the rogue-AP initial access, through sentinel-sync persistence, reused-credential access, chained-permission lateral movement, and staged collection, to a command-and-control beacon still active today -- one continuous operation. The executive summary reports business impact and remediation status in plain language, while the technical report carries the full evidence chain.', 65, 5);
