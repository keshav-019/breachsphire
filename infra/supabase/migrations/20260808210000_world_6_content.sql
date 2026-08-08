-- Phase 2.4g: world-6 mission content, generated from
-- docs/12-world-story-bible.md. Mission 1 is cross-world-gated on
-- the previous world's boss mission where applicable.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-6a', 'world-6', 'handshake', '6A - Handshake', 'A compromised server communicates in bursts that look normal until sequence, timing and connection behavior are examined.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-6a-1', 'campaign-6a', 'foundations', 'Foundations', 'TCP/UDP/ICMP behavior, learned by reconstructing conversations.', 1),
  ('operation-6a-2', 'campaign-6a', 'investigation', 'Investigation', 'Find which session actually carried command traffic.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w6-01', 'world-6', 'campaign-6a', 'operation-6a-1', 'handshake', 'Handshake', 'Whatever rode through the hijacked route left a session behind that looks ordinary -- and isn''t.', 'intro', ARRAY['zayn'], '{"requiredMissionIds":["mission-w5-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w6-02', 'world-6', 'campaign-6a', 'operation-6a-1', 'three-way-handshake', 'Three-Way Handshake', 'Every reliable TCP conversation starts and ends with a specific, predictable sequence.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w6-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"handshake-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w6-03', 'world-6', 'campaign-6a', 'operation-6a-1', 'read-the-flags', 'Read the Flags', 'Flag combinations tell you what''s actually happening in a TCP conversation, if you know how to read them.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w6-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"tcp-flags-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w6-04', 'world-6', 'campaign-6a', 'operation-6a-2', 'tcp-or-udp', 'TCP or UDP', 'Reliable delivery costs overhead -- some traffic can''t afford to wait for it.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w6-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"tcp-udp-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w6-05', 'world-6', 'campaign-6a', 'operation-6a-2', 'icmp-tells-the-truth', 'ICMP Tells the Truth', 'ICMP is diagnostic chatter -- except when it''s being used to map or manipulate a network instead.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w6-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"icmp-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w6-06', 'world-6', 'campaign-6a', 'operation-6a-2', 'broken-handshake', 'Broken Handshake', 'One of these sessions is carrying something it shouldn''t. Prove which one, from the packet behavior alone.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w6-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"broken-handshake-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["broken-handshake"],"skillXp":{"networking":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w6-01', 1, 'zayn', 'Whatever rode through that hijacked route left a session behind. It looks like ordinary traffic. It isn''t.'),
  ('mission-w6-01', 2, 'zayn', 'TCP, UDP, ICMP -- this is where connections actually get established, torn down, and sometimes faked in between. Attackers love hiding inside behavior that looks completely normal.'),
  ('mission-w6-02', 1, 'zayn', 'Every reliable TCP conversation starts and ends with a specific, predictable sequence. Know it well enough to spot when it''s wrong.'),
  ('mission-w6-03', 1, 'zayn', 'Flag combinations tell you what''s actually happening in a TCP conversation, if you know how to read them.'),
  ('mission-w6-04', 1, 'zayn', 'Reliable delivery costs overhead. Some traffic can''t afford to wait for it.'),
  ('mission-w6-05', 1, 'zayn', 'ICMP is diagnostic chatter -- except when it''s being used to map or manipulate a network instead.'),
  ('mission-w6-06', 1, 'zayn', 'One of these sessions is carrying something it shouldn''t. Prove which one, from the packet behavior alone.'),
  ('mission-w6-06', 2, 'zayn', 'Found it. The client''s data was never actually sent -- but the server keeps acknowledging it anyway.'),
  ('mission-w6-06', 3, 'byte', 'That''s the tell. A real TCP stack doesn''t acknowledge data it never received. Something on the server side is faking the conversation to look ordinary.'),
  ('mission-w6-06', 4, 'zayn', 'So the payload isn''t hiding in a weird port or a strange protocol. It''s hiding in acknowledgment numbers that don''t add up. That''s disturbingly elegant.'),
  ('mission-w6-06', 5, 'zayn', 'This session touched half a dozen application protocols on its way through. We need to understand what''s actually normal in each of those before we can say what''s not.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w6-01-o1', 'mission-w6-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to examine connection behavior closely.'),
  ('mission-w6-02-o1', 'mission-w6-02', 1, 'Order the sequence', 'Order the handshake and teardown steps correctly.'),
  ('mission-w6-03-o1', 'mission-w6-03', 1, 'Interpret the flag', 'Interpret an unprompted RST flag.'),
  ('mission-w6-04-o1', 'mission-w6-04', 1, 'Match the use case', 'Assign each use case to the protocol that actually fits it.'),
  ('mission-w6-05-o1', 'mission-w6-05', 1, 'Spot the anomaly', 'Identify the ICMP message that''s worth investigating.'),
  ('mission-w6-06-o1', 'mission-w6-06', 1, 'Find the anomalous session', 'Identify which session shows the server acknowledging data the client never sent.'),
  ('mission-w6-06-o2', 'mission-w6-06', 2, 'Explain the mechanism', 'Explain what an inflated acknowledgment number actually indicates.'),
  ('mission-w6-06-o3', 'mission-w6-06', 3, 'Name the carrier', 'Identify which session carried command traffic and justify it from packet behavior.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w6-01-o1-c1', 'mission-w6-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"Ordinary-looking traffic is exactly where this gets hidden. Ready to look closer?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),
  ('mission-w6-02-o1-c1', 'mission-w6-02-o1', 1, 'interactive_diagram', 'Order these from connection start to the beginning of teardown.', '{"hotspots":[{"id":"syn","label":"SYN","explanation":"Client requests a connection, proposing an initial sequence number."},{"id":"synack","label":"SYN-ACK","explanation":"Server acknowledges and proposes its own initial sequence number."},{"id":"ack","label":"ACK","explanation":"Client acknowledges -- the connection is now established."},{"id":"fin","label":"FIN","explanation":"One side signals it has no more data to send."},{"id":"finack","label":"FIN-ACK","explanation":"The other side acknowledges and sends its own FIN."}],"task":"Order these from connection start to the beginning of teardown."}'::jsonb, '{"correctOrderIds":["syn","synack","ack","fin","finack"]}'::jsonb),
  ('mission-w6-03-o1-c1', 'mission-w6-03-o1', 1, 'multiple_choice', 'A packet arrives with only the RST flag set, unprompted by any prior SYN from this host. What does it most likely indicate?', '{"question":"A packet arrives with only the RST flag set, unprompted by any prior SYN from this host. What does it most likely indicate?","options":[{"id":"a","text":"A normal connection close"},{"id":"b","text":"An attempt to reset a connection that was never actually established, possibly a scan or spoofed traffic"},{"id":"c","text":"A retransmission of lost data"},{"id":"d","text":"A keep-alive probe"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-w6-04-o1-c1', 'mission-w6-04-o1', 1, 'drag_and_drop', 'Match each use case to the protocol that fits it.', '{"items":[{"id":"dns","text":"DNS lookup"},{"id":"video","text":"Live video stream"},{"id":"file","text":"File transfer"},{"id":"voip","text":"VoIP call audio"}],"targets":[{"id":"tcp","label":"TCP -- reliable, ordered delivery matters more than speed"},{"id":"udp","label":"UDP -- speed matters more than guaranteed delivery"}]}'::jsonb, '{"correctMapping":{"dns":"udp","video":"udp","file":"tcp","voip":"udp"}}'::jsonb),
  ('mission-w6-05-o1-c1', 'mission-w6-05-o1', 1, 'investigation', 'Which ICMP message indicates something worth investigating rather than normal diagnostic behavior?', '{"evidence":[{"id":"i1","label":"Echo Request/Reply (ping)","detail":"A single request-reply pair between two known internal hosts"},{"id":"i2","label":"Destination Unreachable","detail":"One reply after a host tried to reach a genuinely offline service"},{"id":"i3","label":"Redirect message","detail":"Received from a host that is not a router, instructing a workstation to use a different gateway"},{"id":"i4","label":"Time Exceeded","detail":"A single expected reply during a normal traceroute"}],"question":"Which ICMP message indicates something worth investigating rather than normal diagnostic behavior?"}'::jsonb, '{"requiredEvidenceIds":["i3"]}'::jsonb),
  ('mission-w6-06-o1-c1', 'mission-w6-06-o1', 1, 'investigation', 'Which session shows the server acknowledging data the client never actually sent?', '{"evidence":[{"id":"sess1","label":"Session A -- client sent 4,200 bytes, server ACKs up to byte 4,200","detail":"Sequence and acknowledgment numbers match exactly throughout"},{"id":"sess2","label":"Session B -- client sent 1,100 bytes, server ACKs up to byte 3,800","detail":"Server is acknowledging far more data than the client actually transmitted"},{"id":"sess3","label":"Session C -- client sent 900 bytes, server ACKs up to byte 900","detail":"Sequence and acknowledgment numbers match exactly throughout"},{"id":"sess4","label":"Session B retransmission log","detail":"No retransmissions recorded -- the extra acknowledged bytes were never requested again either"}],"question":"Which session shows the server acknowledging data the client never actually sent?"}'::jsonb, '{"requiredEvidenceIds":["sess2","sess4"]}'::jsonb),
  ('mission-w6-06-o2-c1', 'mission-w6-06-o2', 1, 'multiple_choice', 'What does an acknowledgment number that exceeds the data actually sent most likely indicate?', '{"question":"What does an acknowledgment number that exceeds the data actually sent most likely indicate?","options":[{"id":"a","text":"Normal TCP window scaling"},{"id":"b","text":"The server and client are communicating out-of-band, using sequence/ack numbers themselves to carry hidden data or signaling"},{"id":"c","text":"A checksum error that will be automatically corrected"},{"id":"d","text":"The client is about to close the connection"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-w6-06-o3-c1', 'mission-w6-06-o3', 1, 'boss_encounter', 'Identify which session carried command traffic and justify it from packet behavior.', '{"stages":[{"objectiveRef":"mission-w6-06-o1","label":"The anomalous session"},{"objectiveRef":"mission-w6-06-o2","label":"The mechanism"}],"task":"Identify which session carried command traffic and justify it from packet behavior."}'::jsonb, '{"requiredObjectiveIds":["mission-w6-06-o1","mission-w6-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w6-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),
  ('mission-w6-02-o1-c1', 'orientation', 'The first three steps establish a connection; the rest begin closing it.', 10, 1),
  ('mission-w6-02-o1-c1', 'concept', 'Each step in the handshake acknowledges the step before it -- follow the acknowledgments.', 20, 2),
  ('mission-w6-02-o1-c1', 'solution', 'SYN -> SYN-ACK -> ACK establishes the connection; FIN -> FIN-ACK begins the teardown that follows.', 30, 3),
  ('mission-w6-03-o1-c1', 'orientation', 'RST alone, with no matching prior connection, isn''t a normal teardown.', 10, 1),
  ('mission-w6-03-o1-c1', 'solution', 'An unprompted RST with no matching connection state usually indicates a scan, spoofed packet, or an attempt to reset something that was never really open.', 20, 2),
  ('mission-w6-04-o1-c1', 'orientation', 'Ask which of these would rather drop a little data than wait for a retransmission.', 10, 1),
  ('mission-w6-04-o1-c1', 'solution', 'File transfer needs every byte correct and in order (TCP); DNS, video and VoIP all favor speed and can tolerate some loss (UDP).', 20, 2),
  ('mission-w6-05-o1-c1', 'orientation', 'Three of these four are exactly what you''d expect from routine network operation.', 10, 1),
  ('mission-w6-05-o1-c1', 'concept', 'An ICMP Redirect is only legitimate coming from an actual router on the path -- who''s sending this one?', 20, 2),
  ('mission-w6-05-o1-c1', 'solution', 'The redirect message is the anomaly -- it came from a host that isn''t a router, attempting to change where a workstation sends its traffic. The other three are all normal diagnostic behavior.', 30, 3),
  ('mission-w6-06-o1-c1', 'orientation', 'Two of these four sessions have perfectly matched sequence and acknowledgment numbers -- start by ruling those out.', 15, 1),
  ('mission-w6-06-o1-c1', 'concept', 'An acknowledgment number that exceeds what was actually transmitted needs an explanation -- retransmission is the normal one.', 25, 2),
  ('mission-w6-06-o1-c1', 'tool_direction', 'Check whether the excess acknowledged bytes in session B show up anywhere in a retransmission log.', 35, 3),
  ('mission-w6-06-o1-c1', 'solution', 'Session B''s ack number (3,800) far exceeds what the client actually transmitted (1,100 bytes), and there''s no retransmission history to explain the gap (sess4) -- sessions A and C both have perfectly matched sequence/ack numbers, exactly as expected.', 45, 4),
  ('mission-w6-06-o2-c1', 'orientation', 'Rule out anything that''s a normal, expected part of TCP''s design.', 15, 1),
  ('mission-w6-06-o2-c1', 'solution', 'Encoding information in sequence/acknowledgment numbers beyond what was actually transmitted is a known covert-channel technique -- not a normal TCP behavior.', 25, 2),
  ('mission-w6-06-o3-c1', 'orientation', 'You''ve already gathered everything you need -- name the session and the mechanism together.', 20, 1),
  ('mission-w6-06-o3-c1', 'concept', 'The justification needs to point at the specific numeric evidence, not just a hunch.', 30, 2),
  ('mission-w6-06-o3-c1', 'tool_direction', 'State the session, then the acknowledgment mismatch that proves it.', 40, 3),
  ('mission-w6-06-o3-c1', 'near_solution', 'Session B; its ack numbers are inflated with no retransmission to explain them.', 50, 4),
  ('mission-w6-06-o3-c1', 'solution', 'Session B carried the command traffic -- its acknowledgment numbers exceed what the client actually sent, with no retransmission to explain it, consistent with a sequence-number covert channel.', 60, 5);
