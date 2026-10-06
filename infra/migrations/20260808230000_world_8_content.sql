-- Phase 2.4i: world-8 mission content, generated from
-- docs/12-world-story-bible.md. Mission 1 is cross-world-gated on
-- the previous world's boss mission where applicable.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-8a', 'world-8', 'packet-reaper', '8A - Packet Reaper', 'A massive SkyPort capture from a ten-minute outage -- human analysts couldn''t find the initiating event.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-8a-1', 'campaign-8a', 'foundations', 'Foundations', 'Filters, streams and timelines, learned as investigative lenses.', 1),
  ('operation-8a-2', 'campaign-8a', 'investigation', 'Investigation', 'Find the first malicious conversation in a noisy capture.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w8-01', 'world-8', 'campaign-8a', 'operation-8a-1', 'packet-reaper', 'Packet Reaper', 'SkyPort''s SOC handed over a ten-minute outage and a capture file too big for any human to read line by line.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w7-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w8-02', 'world-8', 'campaign-8a', 'operation-8a-1', 'filter-first', 'Filter First', 'A capture filter decides what you record. A display filter decides what you actually look at.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w8-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"display-filter-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w8-03', 'world-8', 'campaign-8a', 'operation-8a-1', 'follow-the-stream', 'Follow the Stream', 'Streams, not individual packets. Follow the whole conversation.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w8-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"stream-follow-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w8-04', 'world-8', 'campaign-8a', 'operation-8a-2', 'build-the-timeline', 'Build the Timeline', 'The outage didn''t start when the alerts fired. Reconstruct what actually happened, in order.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w8-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"timeline-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w8-05', 'world-8', 'campaign-8a', 'operation-8a-2', 'bookmark-the-evidence', 'Bookmark the Evidence', 'Not everything you find belongs in the same evidence bucket. Sort it before you write the report.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w8-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"evidence-bookmark-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w8-06', 'world-8', 'campaign-8a', 'operation-8a-2', 'packet-reaper-boss', 'Packet Reaper', 'Somewhere in ten minutes of chaos is the one packet that started it all. Find it, and prove your chain of evidence.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w8-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"packet-reaper-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["packet-reaper"],"skillXp":{"networking":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w8-01', 1, 'zayn', 'SkyPort''s SOC just handed us a ten-minute outage and a capture file too big for any human to read line by line. Byte, is Wireshark loaded?'),
  ('mission-w8-01', 2, 'byte', 'Loaded. Filters are your friend here -- not scrolling.'),
  ('mission-w8-01', 3, 'zayn', 'This one''s different. I''m not going to walk you through every step. Form a hypothesis, test it against the evidence, and be ready to be wrong.'),
  ('mission-w8-02', 1, 'zayn', 'A capture filter decides what you record. A display filter decides what you actually look at. Know which one you need.'),
  ('mission-w8-03', 1, 'zayn', 'Streams, not individual packets. Follow the whole conversation.'),
  ('mission-w8-04', 1, 'zayn', 'The outage didn''t start when the alerts fired. Reconstruct what actually happened, in order.'),
  ('mission-w8-05', 1, 'zayn', 'Not everything you find belongs in the same evidence bucket. Sort it before you write the report.'),
  ('mission-w8-06', 1, 'zayn', 'Somewhere in ten minutes of chaos is the one packet that started it all. Find it, and prove your chain of evidence.'),
  ('mission-w8-06', 2, 'zayn', 'Got it. And it''s hours older than the outage itself.'),
  ('mission-w8-06', 3, 'byte', 'Timing matches the SX beacon signature exactly. Low entropy, same interval family we''ve seen since World 0.'),
  ('mission-w8-06', 4, 'zayn', 'So the outage wasn''t the attack. The outage was collateral damage from something that had already been sitting here for hours. This came in over the wireless maintenance network -- that''s where we go next.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w8-01-o1', 'mission-w8-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to investigate without step-by-step narration.'),
  ('mission-w8-02-o1', 'mission-w8-02', 1, 'Pick the display filter', 'Choose the filter that narrows to the exact traffic needed.'),
  ('mission-w8-03-o1', 'mission-w8-03', 1, 'Pick the stream to chase', 'Identify which stream is most worth investigating first.'),
  ('mission-w8-04-o1', 'mission-w8-04', 1, 'Order the events', 'Order the events as they actually occurred.'),
  ('mission-w8-05-o1', 'mission-w8-05', 1, 'Classify each item', 'Sort each item into indicator, reference, or noise.'),
  ('mission-w8-06-o1', 'mission-w8-06', 1, 'Find the first malicious packet', 'Identify the actual first malicious event in the capture.'),
  ('mission-w8-06-o2', 'mission-w8-06', 2, 'Confirm the signature', 'Tie the packet to the recurring SX pattern.'),
  ('mission-w8-06-o3', 'mission-w8-06', 3, 'Submit the evidence chain', 'Submit the exact evidence chain as the flag.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w8-01-o1-c1', 'mission-w8-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"This time you drive. Ready to form your own hypotheses?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),
  ('mission-w8-02-o1-c1', 'mission-w8-02-o1', 1, 'multiple_choice', 'You need to see only HTTP traffic to a specific suspect address, 203.0.113.50, within an already-captured file. Which display filter does that?', '{"question":"You need to see only HTTP traffic to a specific suspect address, 203.0.113.50, within an already-captured file. Which display filter does that?","options":[{"id":"a","text":"tcp.port == 80"},{"id":"b","text":"ip.addr == 203.0.113.50"},{"id":"c","text":"http && ip.addr == 203.0.113.50"},{"id":"d","text":"ip.src == 203.0.113.50 or ip.dst == 203.0.113.50 and udp"}]}'::jsonb, '{"correctOptionId":"c"}'::jsonb),
  ('mission-w8-03-o1-c1', 'mission-w8-03-o1', 1, 'investigation', 'Which stream is most worth investigating first?', '{"evidence":[{"id":"strm1","label":"Stream 14 -- HTTP GET /status.html, 200 OK","detail":"Ordinary monitoring check, repeats every 60 seconds, consistent for weeks"},{"id":"strm2","label":"Stream 88 -- TLS handshake to an address with no matching DNS query beforehand","detail":"No prior name resolution recorded for the destination anywhere in the capture"},{"id":"strm3","label":"Stream 91 -- SMB file listing, internal file server","detail":"Normal internal traffic, consistent with routine file access"},{"id":"strm4","label":"Stream 12 -- DHCP renewal","detail":"Ordinary lease renewal from a workstation"}],"question":"Which stream is most worth investigating first?"}'::jsonb, '{"requiredEvidenceIds":["strm2"]}'::jsonb),
  ('mission-w8-04-o1-c1', 'mission-w8-04-o1', 1, 'interactive_diagram', 'Order these events as they actually occurred, earliest first.', '{"hotspots":[{"id":"beacon","label":"Low-entropy beacon packet observed","explanation":"A small, regular packet appears hours before anything else in this list."},{"id":"tls","label":"Unresolved TLS connection established","explanation":"The connection with no prior DNS lookup begins."},{"id":"spike","label":"Traffic volume spike on the OT VLAN","explanation":"A sudden increase in traffic on the operational technology network segment."},{"id":"alert","label":"SOC alert fires","explanation":"Automated monitoring finally raises an alert, well after the activity began."},{"id":"outage","label":"Service outage begins","explanation":"The floor actually loses connectivity."}],"task":"Order these events as they actually occurred, earliest first."}'::jsonb, '{"correctOrderIds":["beacon","tls","spike","alert","outage"]}'::jsonb),
  ('mission-w8-05-o1-c1', 'mission-w8-05-o1', 1, 'drag_and_drop', 'Classify each item as an indicator, reference material, or noise.', '{"items":[{"id":"ev_a","text":"The low-entropy beacon packet itself"},{"id":"ev_b","text":"RFC reference explaining normal TLS handshake behavior"},{"id":"ev_c","text":"The unresolved TLS connection''s destination IP"},{"id":"ev_d","text":"A routine DHCP renewal, unrelated to the incident"}],"targets":[{"id":"indicator","label":"Indicator (directly tied to the incident)"},{"id":"reference","label":"Reference material"},{"id":"noise","label":"Noise (unrelated)"}]}'::jsonb, '{"correctMapping":{"ev_a":"indicator","ev_b":"reference","ev_c":"indicator","ev_d":"noise"}}'::jsonb),
  ('mission-w8-06-o1-c1', 'mission-w8-06-o1', 1, 'investigation', 'Which packet is the actual first malicious event in this capture?', '{"evidence":[{"id":"fp1","label":"Packet at T-6h12m -- low-entropy beacon, 64 bytes, to the unresolved TLS destination","detail":"Predates every other flagged event by hours"},{"id":"fp2","label":"Packet at T-4m -- traffic spike begins on OT VLAN","detail":"The first packet of the volume spike"},{"id":"fp3","label":"Packet at T-0 -- SOC alert correlation packet","detail":"The packet that triggered the automated alert"},{"id":"fp4","label":"Packet at T-8h -- routine scheduled backup job","detail":"Scheduled, expected, unrelated traffic"}],"question":"Which packet is the actual first malicious event in this capture?"}'::jsonb, '{"requiredEvidenceIds":["fp1"]}'::jsonb),
  ('mission-w8-06-o2-c1', 'mission-w8-06-o2', 1, 'multiple_choice', 'What about this packet ties it to the pattern seen since World 0''s phishing incident?', '{"question":"What about this packet ties it to the pattern seen since World 0''s phishing incident?","options":[{"id":"a","text":"It contains a readable ransom note"},{"id":"b","text":"Its low-entropy, regular-interval structure matches the same beacon timing family observed before"},{"id":"c","text":"It was sent from the same IP address as every prior incident"},{"id":"d","text":"It uses the same file extension as the World 1 executable"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-w8-06-o3-c1', 'mission-w8-06-o3', 1, 'boss_encounter', 'Submit the exact evidence chain as the flag.', '{"stages":[{"objectiveRef":"mission-w8-06-o1","label":"The first malicious packet"},{"objectiveRef":"mission-w8-06-o2","label":"The confirmed signature"}],"task":"Submit the exact evidence chain as the flag."}'::jsonb, '{"requiredObjectiveIds":["mission-w8-06-o1","mission-w8-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w8-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),
  ('mission-w8-02-o1-c1', 'orientation', 'You need both conditions to be true at once -- protocol AND address.', 10, 1),
  ('mission-w8-02-o1-c1', 'solution', '''http && ip.addr == 203.0.113.50'' correctly narrows to HTTP traffic specifically involving that one address.', 20, 2),
  ('mission-w8-03-o1-c1', 'orientation', 'Three of these four streams have a completely mundane, expected explanation.', 10, 1),
  ('mission-w8-03-o1-c1', 'concept', 'A connection with no prior DNS lookup is unusual -- most legitimate traffic resolves a name before connecting.', 20, 2),
  ('mission-w8-03-o1-c1', 'solution', 'Stream 88''s TLS connection has no matching DNS query anywhere in the capture -- that''s the one worth chasing first; the others are routine.', 30, 3),
  ('mission-w8-04-o1-c1', 'orientation', 'The alert firing is almost never the first thing that actually happened.', 10, 1),
  ('mission-w8-04-o1-c1', 'concept', 'Work backward from the outage: what had to happen for the alert to fire, and what had to happen before that?', 20, 2),
  ('mission-w8-04-o1-c1', 'solution', 'beacon -> unresolved TLS connection -> traffic spike -> SOC alert -> outage is the real order -- the alert and the outage were both late symptoms, not the start.', 30, 3),
  ('mission-w8-05-o1-c1', 'orientation', 'Ask whether each item is direct evidence, background material, or simply unrelated.', 10, 1),
  ('mission-w8-05-o1-c1', 'solution', 'The beacon and the suspect connection''s IP are indicators; the RFC is reference material; the routine DHCP renewal is noise.', 20, 2),
  ('mission-w8-06-o1-c1', 'orientation', 'The oldest timestamp in this list isn''t automatically the answer -- one item is older but unrelated.', 15, 1),
  ('mission-w8-06-o1-c1', 'concept', 'Connect each candidate to the destination you already flagged as unresolved and suspicious.', 25, 2),
  ('mission-w8-06-o1-c1', 'tool_direction', 'Compare each packet''s destination against the stream you flagged earlier as having no prior DNS lookup.', 35, 3),
  ('mission-w8-06-o1-c1', 'solution', 'fp1 -- the low-entropy beacon at T-6h12m -- predates every other flagged event and matches the destination with no prior DNS resolution; fp4 is an unrelated scheduled job, and fp2/fp3 are later downstream symptoms.', 45, 4),
  ('mission-w8-06-o2-c1', 'orientation', 'The connection isn''t about a shared address or file -- it''s about a shared behavioral fingerprint.', 15, 1),
  ('mission-w8-06-o2-c1', 'solution', 'The consistent low-entropy, fixed-interval beacon structure is the recurring signature, independent of source address or payload details.', 25, 2),
  ('mission-w8-06-o3-c1', 'orientation', 'You''ve already gathered everything you need -- combine the packet with the signature that confirms it.', 20, 1),
  ('mission-w8-06-o3-c1', 'concept', 'The evidence chain needs both the specific packet and why it matches the known pattern.', 30, 2),
  ('mission-w8-06-o3-c1', 'tool_direction', 'State the packet''s timestamp and destination, then the signature match.', 40, 3),
  ('mission-w8-06-o3-c1', 'near_solution', 'The T-6h12m beacon, matched against the known low-entropy interval family.', 50, 4),
  ('mission-w8-06-o3-c1', 'solution', 'The first malicious packet is the T-6h12m beacon, and its low-entropy fixed-interval structure matches the SX signature family -- that''s the complete evidence chain.', 60, 5);
