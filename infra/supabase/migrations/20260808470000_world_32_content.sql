-- world-32 ("Network Attack & Defense: Wiretap") mission content,
-- generated from docs/12-world-story-bible.md. Continues directly from
-- World 31's closing question about what's moving across the internal
-- network. Mission 1 is cross-world-gated on world-31's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-32a', 'world-32', 'wiretap', '32A - Wiretap', 'Something is watching authentication traffic inside a network that''s supposed to be fully segmented -- from the inside.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-32a-1', 'campaign-32a', 'foundations', 'Foundations', 'ARP, DNS, sniffing and denial-of-service, learned as attack and detection pairs.', 1),
  ('operation-32a-2', 'campaign-32a', 'investigation', 'Investigation', 'Find the interception point, close it, and verify the traffic is actually clean.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w32-01', 'world-32', 'campaign-32a', 'operation-32a-1', 'someones-listening', 'Someone''s Listening', 'Something is watching authentication traffic inside a network that''s supposed to be fully segmented. Not from outside -- from inside.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w31-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w32-02', 'world-32', 'campaign-32a', 'operation-32a-1', 'no-authentication-built-in', 'No Authentication Built In', 'ARP has no authentication at all. Anything on the local segment can claim to be the gateway, and most devices will just believe it.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w32-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"arp-spoofing-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w32-03', 'world-32', 'campaign-32a', 'operation-32a-1', 'a-lookup-not-a-guarantee', 'A Lookup, Not a Guarantee', 'DNS is a lookup, not a guarantee. A poisoned response sends you somewhere real-looking that isn''t real at all.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w32-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"dns-manipulation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w32-04', 'world-32', 'campaign-32a', 'operation-32a-2', 'almost-nothing', 'Almost Nothing', 'Cleartext protocols hand over everything to anyone listening. Encrypted ones hand over almost nothing -- almost.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w32-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"sniffing-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w32-05', 'world-32', 'campaign-32a', 'operation-32a-2', 'not-every-flood-alike', 'Not Every Flood Alike', 'Different floods need different defenses. Treating every denial-of-service attack the same way is how you either overreact or underreact.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w32-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"dos-mitigation-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w32-06', 'world-32', 'campaign-32a', 'operation-32a-2', 'wiretap-boss', 'Wiretap', 'Find the actual interception point, prove the weakness in the sandbox, then close it and verify the traffic is actually clean afterward.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w32-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"wiretap-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["wiretap"],"skillXp":{"networking":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w32-01', 1, 'zayn', 'Something''s watching authentication traffic inside a network that''s supposed to be fully segmented. Not from outside -- from inside.'),
  ('mission-w32-01', 2, 'byte', 'Sniffing, ARP tricks, DNS manipulation, man-in-the-middle. All isolated simulations, all paired with how you''d actually catch each one.'),
  ('mission-w32-01', 3, 'zayn', 'Every attack we run today gets a detection and a repair. We''re not just breaking the wire, we''re learning to hear when someone else is on it.'),
  ('mission-w32-01', 4, 'byte', 'Let''s find out who''s listening.'),
  ('mission-w32-02', 1, 'zayn', 'ARP has no authentication built in at all. Anything on the local segment can claim to be the gateway, and most devices will just believe it.'),
  ('mission-w32-03', 1, 'byte', 'DNS is a lookup, not a guarantee. A poisoned response sends you somewhere real-looking that isn''t real at all.'),
  ('mission-w32-04', 1, 'zayn', 'Cleartext protocols hand over everything to anyone listening. Encrypted ones hand over almost nothing -- almost.'),
  ('mission-w32-05', 1, 'byte', 'Different floods need different defenses. Treating every denial-of-service attack the same way is how you either overreact or underreact.'),
  ('mission-w32-06', 1, 'zayn', 'Find the actual interception point, prove the weakness in the sandbox, then close it and verify the traffic is actually clean afterward.'),
  ('mission-w32-06', 2, 'byte', '...Found it. A rogue ARP entry on the segment carrying the admin VLAN, positioned exactly between a workstation and the actual gateway.'),
  ('mission-w32-06', 3, 'zayn', 'Textbook man-in-the-middle. Whatever went through there, they saw all of it.'),
  ('mission-w32-06', 4, 'byte', 'Captured traffic confirms it. A Linux administrative credential, sent in the clear during a legacy management session.'),
  ('mission-w32-06', 5, 'zayn', 'Deployed dynamic ARP inspection, verified clean traffic afterward. But that credential''s already out.'),
  ('mission-w32-06', 6, 'byte', 'It''s deliberately low-privilege. Not an admin account with the keys to everything -- something scoped down. Almost like whoever took it didn''t want to trip an alarm.'),
  ('mission-w32-06', 7, 'zayn', 'Low privilege just means the escalation happens somewhere else. Let''s go find out where that account actually lands.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w32-01-o1', 'mission-w32-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to pair every attack with its detection.'),
  ('mission-w32-02-o1', 'mission-w32-02', 1, 'Confirm ARP spoofing', 'Identify the evidence that together confirms ARP spoofing of the gateway.'),
  ('mission-w32-03-o1', 'mission-w32-03', 1, 'Identify DNS manipulation', 'Determine whether a DNS response shows signs of spoofing.'),
  ('mission-w32-04-o1', 'mission-w32-04', 1, 'Find the exposed session', 'Identify which captured session actually exposes credentials.'),
  ('mission-w32-05-o1', 'mission-w32-05', 1, 'Match each flood to its mitigation', 'Sort each denial-of-service pattern to its correct defense.'),
  ('mission-w32-06-o1', 'mission-w32-06', 1, 'Find the interception point', 'Identify the evidence that pinpoints the actual interception point.'),
  ('mission-w32-06-o2', 'mission-w32-06', 2, 'Choose the correct control', 'Select the control that actually closes this interception point.'),
  ('mission-w32-06-o3', 'mission-w32-06', 3, 'Close the wiretap', 'Confirm the interception point and the control together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w32-01-o1-c1', 'mission-w32-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"Someone''s on the wire. Ready to find them?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w32-02-o1-c1', 'mission-w32-02-o1', 1, 'investigation', 'Which evidence together confirms ARP spoofing of the gateway?', '{"evidence":[{"id":"a1","label":"ARP table entry: 10.10.5.1 -> aa:bb:cc:11:22:33","detail":"The legitimate gateway''s registered MAC address, consistent for months"},{"id":"a2","label":"ARP table entry: 10.10.5.1 -> ff:ee:dd:99:88:77","detail":"A second, conflicting MAC address claiming the same gateway IP, first seen 4 minutes ago"},{"id":"a3","label":"Switch port history for ff:ee:dd:99:88:77","detail":"Traces to an ordinary workstation port, not the router''s uplink port"},{"id":"a4","label":"Routine DHCP lease renewal","detail":"Ordinary, expected renewal from an unrelated device"}],"question":"Which evidence together confirms ARP spoofing of the gateway?"}'::jsonb, '{"requiredEvidenceIds":["a2","a3"]}'::jsonb),

  ('mission-w32-03-o1-c1', 'mission-w32-03-o1', 1, 'multiple_choice', 'A workstation queries mail.guardian-secops.example and receives a response pointing to an IP outside the organization''s known ranges, with an unusually short TTL of 5 seconds. What does this suggest?', '{"question":"A workstation queries mail.guardian-secops.example and receives a response pointing to an IP outside the organization''s known ranges, with an unusually short TTL of 5 seconds. What does this suggest?","options":[{"id":"a","text":"Normal DNS load balancing"},{"id":"b","text":"A likely DNS spoofing/poisoning response -- an unexpected IP and an artificially short TTL are both signs of an injected, not authoritative, answer"},{"id":"c","text":"The domain has permanently moved"},{"id":"d","text":"A client-side caching bug"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w32-04-o1-c1', 'mission-w32-04-o1', 1, 'investigation', 'Which captured session actually exposes credentials to anyone sniffing the segment?', '{"evidence":[{"id":"s1","label":"Captured legacy management session","detail":"Plaintext protocol -- an administrative username and password are visible directly in the packet payload"},{"id":"s2","label":"Captured HTTPS session to the storefront","detail":"TLS-encrypted, payload is unreadable ciphertext"},{"id":"s3","label":"Captured SSH session","detail":"Encrypted after the initial key exchange, payload unreadable"}],"question":"Which captured session actually exposes credentials to anyone sniffing the segment?"}'::jsonb, '{"requiredEvidenceIds":["s1"]}'::jsonb),

  ('mission-w32-05-o1-c1', 'mission-w32-05-o1', 1, 'drag_and_drop', 'Sort each denial-of-service pattern to its correct defense.', '{"items":[{"id":"d1","text":"SYN flood exhausting the server''s half-open connection table"},{"id":"d2","text":"Massive volumetric flood saturating the upstream link itself"},{"id":"d3","text":"Application-layer flood of legitimate-looking slow HTTP requests"}],"targets":[{"id":"syn_cookies","label":"SYN cookies / connection-table hardening"},{"id":"upstream_filtering","label":"Upstream scrubbing / rate-limiting before it reaches the link"},{"id":"app_layer_limits","label":"Application-layer request timeouts and rate limits"}]}'::jsonb, '{"correctMapping":{"d1":"syn_cookies","d2":"upstream_filtering","d3":"app_layer_limits"}}'::jsonb),

  ('mission-w32-06-o1-c1', 'mission-w32-06-o1', 1, 'investigation', 'Which evidence identifies the actual interception point?', '{"evidence":[{"id":"w1","label":"ARP anomaly location","detail":"A rogue entry positioned on the segment carrying the administrative VLAN, between a workstation and the real gateway"},{"id":"w2","label":"Traffic timeline","detail":"The rogue ARP entry appeared minutes before a legacy management session was initiated across that same segment"},{"id":"w3","label":"An unrelated, correctly functioning segment","detail":"No anomalies, normal traffic patterns, unrelated to the incident"}],"question":"Which evidence identifies the actual interception point?"}'::jsonb, '{"requiredEvidenceIds":["w1","w2"]}'::jsonb),

  ('mission-w32-06-o2-c1', 'mission-w32-06-o2', 1, 'multiple_choice', 'What control actually closes this specific interception point?', '{"question":"What control actually closes this specific interception point?","options":[{"id":"a","text":"Change all passwords and hope it doesn''t happen again"},{"id":"b","text":"Deploy dynamic ARP inspection on the admin VLAN segment, so unauthorized ARP claims are rejected instead of trusted"},{"id":"c","text":"Disconnect the entire network permanently"},{"id":"d","text":"Just monitor the segment without changing anything"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w32-06-o3-c1', 'mission-w32-06-o3', 1, 'boss_encounter', 'Confirm the interception point and the control together.', '{"stages":[{"objectiveRef":"mission-w32-06-o1","label":"The interception point"},{"objectiveRef":"mission-w32-06-o2","label":"The control"}],"task":"Confirm the interception point and the control together."}'::jsonb, '{"requiredObjectiveIds":["mission-w32-06-o1","mission-w32-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w32-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w32-02-o1-c1', 'orientation', 'A single gateway IP should only ever map to one MAC address at a time.', 15, 1),
  ('mission-w32-02-o1-c1', 'concept', 'A second, newly-appeared MAC claiming the same IP, traced to an ordinary workstation port instead of the router uplink, is exactly what ARP spoofing looks like.', 25, 2),
  ('mission-w32-02-o1-c1', 'solution', 'The conflicting new MAC claiming the gateway IP (a2), traced back to a workstation port instead of the router (a3), together confirm spoofing -- the DHCP renewal is unrelated.', 35, 3),

  ('mission-w32-03-o1-c1', 'orientation', 'A legitimate answer for a known internal domain should come from a known range with a normal TTL.', 15, 1),
  ('mission-w32-03-o1-c1', 'solution', 'An unexpected IP outside known ranges plus an unusually short TTL together point to an injected DNS response, not a legitimate one. Option b.', 25, 2),

  ('mission-w32-04-o1-c1', 'orientation', 'Two of these three sessions are protected by encryption that a sniffer can''t read.', 15, 1),
  ('mission-w32-04-o1-c1', 'solution', 'Only the plaintext legacy management session (s1) exposes actual credentials in the payload -- the HTTPS and SSH sessions are both encrypted.', 25, 2),

  ('mission-w32-05-o1-c1', 'orientation', 'Ask where each flood actually applies pressure: a connection table, the link itself, or the application logic.', 15, 1),
  ('mission-w32-05-o1-c1', 'solution', 'SYN floods target the connection table (SYN cookies fix that), volumetric floods saturate the link itself (needs upstream filtering before it arrives), and application-layer floods need request-level limits at the app itself.', 25, 2),

  ('mission-w32-06-o1-c1', 'orientation', 'One of these three items is unrelated background noise.', 15, 1),
  ('mission-w32-06-o1-c1', 'concept', 'The interception point is defined by both where the anomaly sits and when it appeared relative to the sensitive traffic.', 25, 2),
  ('mission-w32-06-o1-c1', 'tool_direction', 'Check the ARP anomaly''s location and its timing against the legacy session.', 35, 3),
  ('mission-w32-06-o1-c1', 'solution', 'The rogue ARP entry sitting on the admin VLAN (w1), appearing just before the legacy session started (w2), together pinpoint the interception point -- the unrelated segment (w3) is a distractor.', 45, 4),

  ('mission-w32-06-o2-c1', 'orientation', 'The fix needs to stop unauthorized ARP claims from being trusted at all, not just react after the fact.', 15, 1),
  ('mission-w32-06-o2-c1', 'solution', 'Dynamic ARP inspection rejects unauthorized ARP claims on the segment going forward, directly closing this interception method. Option b.', 25, 2),

  ('mission-w32-06-o3-c1', 'orientation', 'You''ve already found the interception point and the fix -- combine them.', 20, 1),
  ('mission-w32-06-o3-c1', 'concept', 'The closure needs to name where the interception happened and exactly what control stops it from recurring.', 30, 2),
  ('mission-w32-06-o3-c1', 'tool_direction', 'State the ARP anomaly and its location first, then the inspection control.', 40, 3),
  ('mission-w32-06-o3-c1', 'near_solution', 'Rogue ARP entry on the admin VLAN, positioned as a man-in-the-middle; closed with dynamic ARP inspection on that segment.', 50, 4),
  ('mission-w32-06-o3-c1', 'solution', 'A rogue ARP entry positioned itself as a man-in-the-middle on the administrative VLAN segment, intercepting a legacy management session and exposing a Linux administrative credential in the clear. Dynamic ARP inspection on that segment closes the interception method going forward, and the follow-up capture confirms clean traffic.', 65, 5);
