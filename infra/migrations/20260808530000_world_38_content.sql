-- world-38 ("Pivoting & Segmentation: Through the Wall") mission content,
-- generated from docs/12-world-story-bible.md. Mission 1 is
-- cross-world-gated on world-37's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-38a', 'world-38', 'through-the-wall', '38A - Through the Wall', 'Whatever''s behind that private connector was never exposed publicly. It was reached through trusted intermediaries.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-38a-1', 'campaign-38a', 'foundations', 'Foundations', 'Multi-homed hosts, forwarding types and routing, learned as ways of reaching a network you don''t directly control.', 1),
  ('operation-38a-2', 'campaign-38a', 'investigation', 'Investigation', 'Reproduce the historical route, then redesign segmentation so it can''t happen again.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w38-01', 'world-38', 'campaign-38a', 'operation-38a-1', 'trusted-intermediaries', 'Trusted Intermediaries', 'Whatever''s on the other side of that private connector was never exposed publicly. It was reached through something else entirely.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w37-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w38-02', 'world-38', 'campaign-38a', 'operation-38a-1', 'the-only-kind-of-bridge', 'The Only Kind of Bridge', 'A multi-homed host sits on two networks at once. That''s the only kind of host that can actually bridge two segments.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w38-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"multihomed-host-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w38-03', 'world-38', 'campaign-38a', 'operation-38a-1', 'three-kinds-of-tunnel', 'Three Kinds of Tunnel', 'Local forwarding reaches the far side. Remote forwarding exposes your side. Dynamic forwarding is a general-purpose proxy into wherever the tunnel goes.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w38-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"forwarding-types-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w38-04', 'world-38', 'campaign-38a', 'operation-38a-2', 'one-path-planned-end-to-end', 'One Path, Planned End to End', 'A route through three pivot points isn''t three separate hacks. It''s one path, planned end to end before the first hop.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w38-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"route-planning-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w38-05', 'world-38', 'campaign-38a', 'operation-38a-2', 'a-gap-not-a-design-choice', 'A Gap, Not a Design Choice', 'Segmentation only works where it''s actually enforced. A missing rule between two segments is a gap, not a design choice.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w38-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"segmentation-gap-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w38-06', 'world-38', 'campaign-38a', 'operation-38a-2', 'through-the-wall-boss', 'Through the Wall', 'Reach the authorized internal objective through the exact same route used historically, then redesign segmentation so that route can''t exist again.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w38-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"through-the-wall-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["through-the-wall"],"skillXp":{"networking":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w38-01', 1, 'zayn', 'Whatever''s on the other side of that private connector was never exposed publicly. The adversary reached it through something else entirely -- trusted intermediaries, not open doors.'),
  ('mission-w38-01', 2, 'byte', 'Multi-homed hosts, port forwarding, SOCKS proxies, SSH tunnels, VPNs. All different ways of using a host you already control to reach a network you don''t.'),
  ('mission-w38-01', 3, 'zayn', 'This is a layered replica -- multiple segments, multiple hops. Plan the route before you take it.'),
  ('mission-w38-01', 4, 'byte', 'Let''s map what''s actually reachable from where.'),
  ('mission-w38-02', 1, 'zayn', 'A multi-homed host sits on two networks at once. That''s not a vulnerability by itself -- it''s just the only kind of host that can actually bridge two segments.'),
  ('mission-w38-03', 1, 'byte', 'Local forwarding reaches something on the far side of a tunnel through a port you control locally. Remote forwarding does the opposite -- it exposes something on your side to the far end. Dynamic forwarding just hands you a general-purpose proxy into wherever the tunnel goes.'),
  ('mission-w38-04', 1, 'zayn', 'A route through three pivot points isn''t three separate hacks. It''s one path, planned end to end before the first hop.'),
  ('mission-w38-05', 1, 'byte', 'Segmentation only works where it''s actually enforced. A missing rule between two segments that should never talk to each other is a gap, not a design choice.'),
  ('mission-w38-06', 1, 'zayn', 'Reach the authorized internal objective through the exact same route used historically. Then redesign segmentation so that route can''t exist again.'),
  ('mission-w38-06', 2, 'byte', '...Route confirmed. Three hops: the compromised gateway, through a multi-homed jump host, into a segment that was never supposed to be reachable from where we started.'),
  ('mission-w38-06', 3, 'zayn', 'Objective reached, exactly reproducing the historical path. Now close it -- not by blocking one hop, but by making sure that segment can''t be reached this way at all.'),
  ('mission-w38-06', 4, 'byte', 'Segmentation redesigned, route verified closed. But look at what''s actually running on that final segment.'),
  ('mission-w38-06', 5, 'zayn', 'Automation infrastructure. And it''s talking outbound on a schedule -- small, regular, periodic. That''s not a person operating anything.'),
  ('mission-w38-06', 6, 'byte', 'That''s a beacon. We''re not looking at a static foothold anymore. We''re looking at something that''s actively, continuously part of an operation.'),
  ('mission-w38-06', 7, 'zayn', 'We''ve been following a perimeter this whole time. This is the first time we''re actually standing inside the thing that''s been running it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w38-01-o1', 'mission-w38-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to plan a route, not just take one step at a time.'),
  ('mission-w38-02-o1', 'mission-w38-02', 1, 'Find the pivot host', 'Identify the host that could actually bridge the two segments.'),
  ('mission-w38-03-o1', 'mission-w38-03', 1, 'Match each forwarding type', 'Sort each use case to its correct SSH forwarding type.'),
  ('mission-w38-04-o1', 'mission-w38-04', 1, 'Plan the route', 'Order the route from the initial foothold to the final objective.'),
  ('mission-w38-05-o1', 'mission-w38-05', 1, 'Find the segmentation gap', 'Identify which segment boundary has an actual enforcement gap.'),
  ('mission-w38-06-o1', 'mission-w38-06', 1, 'Confirm the reproduced route', 'Identify the evidence confirming this session reproduced the historical route.'),
  ('mission-w38-06-o2', 'mission-w38-06', 2, 'Choose the correct redesign', 'Select the redesign that actually stops this route from being reproduced.'),
  ('mission-w38-06-o3', 'mission-w38-06', 3, 'Close the wall', 'Confirm the reproduced route and the redesign together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w38-01-o1-c1', 'mission-w38-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"Plan the whole route before the first hop. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w38-02-o1-c1', 'mission-w38-02-o1', 1, 'investigation', 'Which host could actually serve as a pivot point between the DMZ and the restricted internal segment?', '{"evidence":[{"id":"h1","label":"Host JUMP-HOST-04 network interfaces","detail":"eth0: 10.20.1.15 (DMZ segment), eth1: 10.20.9.5 (restricted internal segment)"},{"id":"h2","label":"Host WEB-01 network interfaces","detail":"eth0: 10.20.1.22 (DMZ segment only)"},{"id":"h3","label":"Host DB-03 network interfaces","detail":"eth0: 10.20.9.30 (restricted internal segment only)"}],"question":"Which host could actually serve as a pivot point between the DMZ and the restricted internal segment?"}'::jsonb, '{"requiredEvidenceIds":["h1"]}'::jsonb),

  ('mission-w38-03-o1-c1', 'mission-w38-03-o1', 1, 'drag_and_drop', 'Sort each use case to its correct SSH forwarding type.', '{"items":[{"id":"f1","text":"Reach an internal database only visible from the far side of the tunnel, using a port on your own machine"},{"id":"f2","text":"Expose a listener running on your machine so the far side of the tunnel can reach back to it"},{"id":"f3","text":"Route arbitrary, changing destinations through the tunnel without configuring a new forward for each one"}],"targets":[{"id":"local","label":"Local forwarding"},{"id":"remote","label":"Remote forwarding"},{"id":"dynamic","label":"Dynamic forwarding (SOCKS proxy)"}]}'::jsonb, '{"correctMapping":{"f1":"local","f2":"remote","f3":"dynamic"}}'::jsonb),

  ('mission-w38-04-o1-c1', 'mission-w38-04-o1', 1, 'interactive_diagram', 'Order this route from the initial foothold to the final objective.', '{"hotspots":[{"id":"start","label":"Attacker-controlled foothold on the DMZ segment","explanation":"The starting point -- already-compromised access, nothing new here."},{"id":"pivot1","label":"Tunnel through JUMP-HOST-04 into the restricted internal segment","explanation":"The only viable bridge between these two segments."},{"id":"pivot2","label":"From the restricted segment, reach the automation subnet via an internal proxy","explanation":"A second hop, using a host inside the restricted segment that itself reaches a further-isolated subnet."},{"id":"objective","label":"Access the authorized internal objective on the automation subnet","explanation":"The final destination -- reached only by planning and executing every prior hop in order."}],"task":"Order this route from the initial foothold to the final objective."}'::jsonb, '{"correctOrderIds":["start","pivot1","pivot2","objective"]}'::jsonb),

  ('mission-w38-05-o1-c1', 'mission-w38-05-o1', 1, 'investigation', 'Which segment boundary has an actual enforcement gap?', '{"evidence":[{"id":"g1","label":"Firewall rules between DMZ and restricted internal segment","detail":"Explicit deny-all, with only JUMP-HOST-04''s specific management port excepted -- correctly scoped"},{"id":"g2","label":"Firewall rules between restricted internal segment and the automation subnet","detail":"No explicit rule exists at all -- traffic is currently permitted by default"},{"id":"g3","label":"Firewall rules between the corporate network and the DMZ","detail":"Explicit, narrowly scoped rules, correctly enforced"}],"question":"Which segment boundary has an actual enforcement gap?"}'::jsonb, '{"requiredEvidenceIds":["g2"]}'::jsonb),

  ('mission-w38-06-o1-c1', 'mission-w38-06-o1', 1, 'investigation', 'Which evidence confirms this session reproduced the actual historical route?', '{"evidence":[{"id":"r1","label":"Historical connection log","detail":"Traffic from the DMZ foothold to JUMP-HOST-04, then from JUMP-HOST-04 into the automation subnet, matching this session''s exact route"},{"id":"r2","label":"JUMP-HOST-04 configuration","detail":"Multi-homed, confirmed bridge between the two segments"},{"id":"r3","label":"Unrelated historical connection to WEB-01","detail":"Ordinary web traffic, no bearing on this route"}],"question":"Which evidence confirms this session reproduced the actual historical route?"}'::jsonb, '{"requiredEvidenceIds":["r1","r2"]}'::jsonb),

  ('mission-w38-06-o2-c1', 'mission-w38-06-o2', 1, 'multiple_choice', 'What redesign actually stops this exact route from being reproduced again?', '{"question":"What redesign actually stops this exact route from being reproduced again?","options":[{"id":"a","text":"Just change JUMP-HOST-04''s password"},{"id":"b","text":"Add an explicit, narrowly scoped firewall rule between the restricted internal segment and the automation subnet, closing the default-permit gap the route relied on"},{"id":"c","text":"Take the automation subnet offline permanently"},{"id":"d","text":"Do nothing -- the route required too many steps to matter"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w38-06-o3-c1', 'mission-w38-06-o3', 1, 'boss_encounter', 'Confirm the reproduced route and the redesign together.', '{"stages":[{"objectiveRef":"mission-w38-06-o1","label":"The reproduced route"},{"objectiveRef":"mission-w38-06-o2","label":"The redesign"}],"task":"Confirm the reproduced route and the redesign together."}'::jsonb, '{"requiredObjectiveIds":["mission-w38-06-o1","mission-w38-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w38-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w38-02-o1-c1', 'orientation', 'Only one of these three hosts has an interface on both segments at once.', 10, 1),
  ('mission-w38-02-o1-c1', 'solution', 'JUMP-HOST-04 has interfaces on both the DMZ and the restricted segment -- the only host that can actually bridge them.', 20, 2),

  ('mission-w38-03-o1-c1', 'orientation', 'Ask which side of the tunnel each scenario needs to reach, and how many destinations it needs to reach.', 15, 1),
  ('mission-w38-03-o1-c1', 'solution', 'Reaching the far side through a local port is local forwarding; exposing your side to the far end is remote forwarding; a flexible, multi-destination proxy is dynamic forwarding.', 25, 2),

  ('mission-w38-04-o1-c1', 'orientation', 'The route only works in one direction -- from where you start to where you''re authorized to end up.', 15, 1),
  ('mission-w38-04-o1-c1', 'concept', 'Each hop depends on the one before it being established first -- you can''t reach the second pivot without already being through the first.', 25, 2),
  ('mission-w38-04-o1-c1', 'solution', 'DMZ foothold -> tunnel through JUMP-HOST-04 -> second hop via the internal proxy -> the automation subnet objective.', 35, 3),

  ('mission-w38-05-o1-c1', 'orientation', 'Two of these three boundaries have explicit, narrowly scoped rules already in place.', 15, 1),
  ('mission-w38-05-o1-c1', 'concept', 'A boundary with no explicit rule at all defaults to permit -- that''s a real gap, not a deliberate design choice.', 25, 2),
  ('mission-w38-05-o1-c1', 'solution', 'The boundary between the restricted segment and the automation subnet has no explicit rule and defaults to permit -- that''s the gap.', 35, 3),

  ('mission-w38-06-o1-c1', 'orientation', 'One of these three items is unrelated to the route in question.', 15, 1),
  ('mission-w38-06-o1-c1', 'concept', 'Reproducing a historical route needs both a matching connection log and confirmation the bridging host is actually capable of it.', 25, 2),
  ('mission-w38-06-o1-c1', 'tool_direction', 'Compare the historical log against JUMP-HOST-04''s known configuration.', 35, 3),
  ('mission-w38-06-o1-c1', 'solution', 'The historical connection log matching this session''s exact path (r1), confirmed by JUMP-HOST-04''s multi-homed bridge configuration (r2), together confirm the route was reproduced -- the WEB-01 connection is unrelated.', 45, 4),

  ('mission-w38-06-o2-c1', 'orientation', 'The fix needs to close the specific gap the route actually depended on, not something unrelated.', 15, 1),
  ('mission-w38-06-o2-c1', 'solution', 'An explicit, narrowly scoped rule at the boundary that previously defaulted to permit directly closes the gap this route relied on. Option b.', 25, 2),

  ('mission-w38-06-o3-c1', 'orientation', 'You''ve already confirmed the route and chosen the redesign -- combine them.', 20, 1),
  ('mission-w38-06-o3-c1', 'concept', 'The closure needs to name the reproduced route and the exact boundary that gets locked down.', 30, 2),
  ('mission-w38-06-o3-c1', 'tool_direction', 'State the three-hop route first, then the new firewall rule.', 40, 3),
  ('mission-w38-06-o3-c1', 'near_solution', 'DMZ -> JUMP-HOST-04 -> automation subnet, matching the historical log; closed with an explicit rule at the previously default-permit boundary.', 50, 4),
  ('mission-w38-06-o3-c1', 'solution', 'The route ran from the DMZ foothold through the multi-homed JUMP-HOST-04 into the automation subnet, exactly matching the historical connection log. Adding an explicit, narrowly scoped firewall rule at the boundary that previously defaulted to permit closes this route completely, without affecting any of the segment''s legitimate traffic.', 65, 5);
