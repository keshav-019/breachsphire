-- Phase 2.4f: world-5 mission content, generated from
-- docs/12-world-story-bible.md. Mission 1 is cross-world-gated on
-- the previous world's boss mission where applicable.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-5a', 'world-5', 'the-broken-route', '5A - The Broken Route', 'Traffic from the hidden subnet appears in several cities despite originating from one network -- routing is moving it.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-5a-1', 'campaign-5a', 'foundations', 'Foundations', 'Routing tables, metrics and path selection, learned as tools for following route advertisements.', 1),
  ('operation-5a-2', 'campaign-5a', 'investigation', 'Investigation', 'Find and stop the route leak.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w5-01', 'world-5', 'campaign-5a', 'operation-5a-1', 'the-broken-route', 'The Broken Route', 'Traffic tied to the hidden subnet is showing up in three different cities, all from one origin network.', 'intro', ARRAY['zayn'], '{"requiredMissionIds":["mission-w4-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w5-02', 'world-5', 'campaign-5a', 'operation-5a-1', 'reading-the-routing-table', 'Reading the Routing Table', 'A router doesn''t pick the ''best'' route abstractly -- it picks the most specific one it has.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w5-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"routing-table-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w5-03', 'world-5', 'campaign-5a', 'operation-5a-1', 'neighbors-and-metrics', 'Neighbors and Metrics', 'When multiple routers advertise a path to the same destination, the lowest metric wins.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w5-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"ospf-metric-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w5-04', 'world-5', 'campaign-5a', 'operation-5a-2', 'compare-the-paths', 'Compare the Paths', 'BGP path selection isn''t just about the shortest route -- sometimes the ''best'' path is engineered to look attractive.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w5-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"bgp-compare-sim"}'::jsonb, '{"xp":110,"credits":20}'::jsonb, false, 4),
  ('mission-w5-05', 'world-5', 'campaign-5a', 'operation-5a-2', 'filter-the-route', 'Filter the Route', 'Prevention beats detection -- route filters decide, up front, what a router is even allowed to believe.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w5-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"route-filter-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w5-06', 'world-5', 'campaign-5a', 'operation-5a-2', 'routebreaker', 'Routebreaker', 'The leak is live right now -- find the false advertisement and get Guardian telemetry back on a trusted path.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w5-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"routebreaker-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["routebreaker"],"skillXp":{"networking":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w5-01', 1, 'zayn', 'Traffic tied to that hidden subnet is showing up in three different cities. It all originates from one network. Something''s rerouting it.'),
  ('mission-w5-01', 2, 'zayn', 'Routing is how a packet decides which direction to go at every single hop. Get this wrong and you''ll chase ghosts across an ISP that was never involved.'),
  ('mission-w5-02', 1, 'zayn', 'A router doesn''t necessarily pick the ''best'' route in some abstract sense -- it picks the most specific one it has. Longest prefix wins, always.'),
  ('mission-w5-03', 1, 'zayn', 'When multiple routers advertise a path to the same destination, the lowest metric wins -- assuming everything else is equal.'),
  ('mission-w5-04', 1, 'zayn', 'BGP path selection isn''t just about the shortest route. Sometimes the ''best'' path is the one specifically engineered to be interesting to an attacker.'),
  ('mission-w5-05', 1, 'zayn', 'Prevention beats detection. Route filters decide, up front, what a router is even allowed to believe.'),
  ('mission-w5-06', 1, 'zayn', 'The leak is live right now. Find the false advertisement and get Guardian telemetry back on a trusted path.'),
  ('mission-w5-06', 2, 'zayn', 'Filtered. Traffic''s back on the legitimate path.'),
  ('mission-w5-06', 3, 'byte', 'I compared the leak''s timing against our incident response logs. It didn''t just steal traffic -- it appears engineered to measure exactly how long we took to notice and react.'),
  ('mission-w5-06', 4, 'zayn', 'That''s not what a criminal does. That''s what someone doing research does. We need to understand what rode inside that diverted traffic -- the transport layer, next.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w5-01-o1', 'mission-w5-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to follow the route.'),
  ('mission-w5-02-o1', 'mission-w5-02', 1, 'Pick the route that''s used', 'Determine which route a router will actually select for a given destination.'),
  ('mission-w5-03-o1', 'mission-w5-03', 1, 'Choose the winning path', 'Determine which advertised path an OSPF router selects.'),
  ('mission-w5-04-o1', 'mission-w5-04', 1, 'Spot the hijacked path', 'Identify the evidence proving a route has been hijacked.'),
  ('mission-w5-05-o1', 'mission-w5-05', 1, 'Map scenario to action', 'Decide whether each route-advertisement scenario should be permitted or denied.'),
  ('mission-w5-06-o1', 'mission-w5-06', 1, 'Identify the false advertisement', 'Prove which announcements together constitute the route leak.'),
  ('mission-w5-06-o2', 'mission-w5-06', 2, 'Choose the fix', 'Pick the correct immediate response to stop the leak.'),
  ('mission-w5-06-o3', 'mission-w5-06', 3, 'Restore trusted routing', 'Confirm the leak source and the fix applied.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w5-01-o1-c1', 'mission-w5-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"Every hop makes its own decision about where a packet goes next. Ready to follow one?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),
  ('mission-w5-02-o1-c1', 'mission-w5-02-o1', 1, 'investigation', 'Which route will the router actually use to reach 10.66.66.4?', '{"evidence":[{"id":"route1","label":"0.0.0.0/0 via 203.0.113.1","detail":"Default route -- used only when nothing more specific matches"},{"id":"route2","label":"10.66.66.0/24 via 192.0.2.9","detail":"A specific route directly matching the destination subnet"},{"id":"route3","label":"10.66.0.0/16 via 192.0.2.1","detail":"A broader route that also technically covers the destination"},{"id":"route4","label":"10.0.0.0/8 via 192.0.2.254","detail":"An even broader route that also technically covers the destination"}],"question":"Which route will the router actually use to reach 10.66.66.4?"}'::jsonb, '{"requiredEvidenceIds":["route2"]}'::jsonb),
  ('mission-w5-03-o1-c1', 'mission-w5-03-o1', 1, 'multiple_choice', 'Three OSPF neighbors advertise a route to the same destination with costs 10, 25, and 15. Which path does the router select?', '{"question":"Three OSPF neighbors advertise a route to the same destination with costs 10, 25, and 15. Which path does the router select?","options":[{"id":"a","text":"The path with cost 25, since higher cost usually means a more robust link"},{"id":"b","text":"The path with cost 10, the lowest advertised cost"},{"id":"c","text":"Whichever neighbor advertised first"},{"id":"d","text":"All three, split evenly"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-w5-04-o1-c1', 'mission-w5-04-o1', 1, 'investigation', 'Which evidence indicates the destination''s route has been hijacked?', '{"evidence":[{"id":"path1","label":"AS Path: 64500 64501 64502 (destination network)","detail":"Long-standing announcement, matches the network''s registered owner (AS 64502)"},{"id":"path2","label":"AS Path: 64777 64502 (destination network)","detail":"Recently appeared, shorter path, originates from an AS with no prior relationship to this network"},{"id":"path3","label":"AS Path: 64500 64501 64502 (destination network), alternate peer","detail":"Same legitimate path, seen via a second peer, consistent with path1"},{"id":"path4","label":"RPKI validation","detail":"path2''s origin AS does not match the destination network''s registered RPKI origin; path1 and path3 do"}],"question":"Which evidence indicates the destination''s route has been hijacked?"}'::jsonb, '{"requiredEvidenceIds":["path2","path4"]}'::jsonb),
  ('mission-w5-05-o1-c1', 'mission-w5-05-o1', 1, 'drag_and_drop', 'Decide whether each scenario should be permitted or denied.', '{"items":[{"id":"s1","text":"A peer advertises a route for a prefix they don''t own and have no agreement to carry"},{"id":"s2","text":"A customer advertises routes for their own legitimately assigned address space"},{"id":"s3","text":"A peer advertises an overly broad prefix that could blackhole huge swaths of the internet"},{"id":"s4","text":"A customer advertises a route matching their signed RPKI ROA"}],"targets":[{"id":"deny","label":"Deny"},{"id":"permit","label":"Permit"}]}'::jsonb, '{"correctMapping":{"s1":"deny","s2":"permit","s3":"deny","s4":"permit"}}'::jsonb),
  ('mission-w5-06-o1-c1', 'mission-w5-06-o1', 1, 'investigation', 'Which announcements together prove the route leak?', '{"evidence":[{"id":"ann1","label":"AS 64502 announcing 10.66.66.0/24","detail":"The legitimate registered origin, consistent for years"},{"id":"ann2","label":"AS 64999 announcing 10.66.66.0/24","detail":"Appeared six hours ago, no RPKI match, no peering agreement on record"},{"id":"ann3","label":"Guardian telemetry traffic pattern","detail":"Began routing through AS 64999 within minutes of ann2 appearing"},{"id":"ann4","label":"AS 64502 announcing 10.20.0.0/16","detail":"Unrelated, long-standing announcement for a different prefix"}],"question":"Which announcements together prove the route leak?"}'::jsonb, '{"requiredEvidenceIds":["ann2","ann3"]}'::jsonb),
  ('mission-w5-06-o2-c1', 'mission-w5-06-o2', 1, 'multiple_choice', 'What''s the correct immediate response to stop this leak?', '{"question":"What''s the correct immediate response to stop this leak?","options":[{"id":"a","text":"Wait for AS 64999 to withdraw the announcement on its own"},{"id":"b","text":"Apply a route filter denying AS 64999''s announcement for this prefix"},{"id":"c","text":"Shut down the legitimate route entirely until the investigation concludes"},{"id":"d","text":"Announce an even more specific prefix from AS 64502 to compete"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-w5-06-o3-c1', 'mission-w5-06-o3', 1, 'boss_encounter', 'Confirm the leak source and the fix applied.', '{"stages":[{"objectiveRef":"mission-w5-06-o1","label":"The false advertisement"},{"objectiveRef":"mission-w5-06-o2","label":"The fix"}],"task":"Confirm the leak source and the fix applied."}'::jsonb, '{"requiredObjectiveIds":["mission-w5-06-o1","mission-w5-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w5-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),
  ('mission-w5-02-o1-c1', 'orientation', 'All four of these routes technically cover the destination address -- only one will actually be chosen.', 10, 1),
  ('mission-w5-02-o1-c1', 'concept', 'Routers always prefer the most specific matching prefix available, not the shortest path or the oldest rule.', 20, 2),
  ('mission-w5-02-o1-c1', 'solution', 'route2 (10.66.66.0/24) is the longest, most specific prefix that matches 10.66.66.4 -- it wins over the broader /16, /8, and default routes every time.', 30, 3),
  ('mission-w5-03-o1-c1', 'orientation', 'OSPF cost is explicitly designed so that lower always means better.', 10, 1),
  ('mission-w5-03-o1-c1', 'solution', 'The path with cost 10 wins -- OSPF always prefers the lowest total cost to a destination.', 20, 2),
  ('mission-w5-04-o1-c1', 'orientation', 'A shorter path isn''t automatically the legitimate one -- that''s exactly what makes route hijacking effective.', 10, 1),
  ('mission-w5-04-o1-c1', 'concept', 'Compare who''s actually authorized to originate this network''s route against who''s claiming to.', 20, 2),
  ('mission-w5-04-o1-c1', 'tool_direction', 'RPKI exists specifically to confirm which AS is the legitimate origin for a given prefix.', 30, 3),
  ('mission-w5-04-o1-c1', 'solution', 'path2''s suspiciously short, newly-appeared route is contradicted by RPKI validation (path4), which confirms only path1/path3''s origin AS is legitimate -- that combination proves the hijack.', 40, 4),
  ('mission-w5-05-o1-c1', 'orientation', 'Ask whether the party advertising the route actually has any legitimate claim to it.', 10, 1),
  ('mission-w5-05-o1-c1', 'concept', 'An overly broad prefix is dangerous regardless of who''s advertising it -- it can capture traffic meant for huge parts of the internet.', 20, 2),
  ('mission-w5-05-o1-c1', 'solution', 's1 (unauthorized prefix) and s3 (dangerously broad prefix) should be denied; s2 and s4 (legitimate, authorized advertisements) should be permitted.', 30, 3),
  ('mission-w5-06-o1-c1', 'orientation', 'An unauthorized announcement alone shows intent; you need something that shows it actually took effect.', 15, 1),
  ('mission-w5-06-o1-c1', 'concept', 'Pair the false announcement with proof that real traffic actually followed it.', 25, 2),
  ('mission-w5-06-o1-c1', 'tool_direction', 'Check the timing between the new announcement and the telemetry''s routing change.', 35, 3),
  ('mission-w5-06-o1-c1', 'solution', 'ann2 (the unauthorized announcement with no RPKI match) combined with ann3 (traffic actually rerouting within minutes of it appearing) together prove the leak -- ann1 and ann4 are unrelated legitimate baselines.', 45, 4),
  ('mission-w5-06-o2-c1', 'orientation', 'The direct fix targets the false announcement specifically, not the legitimate service.', 15, 1),
  ('mission-w5-06-o2-c1', 'solution', 'Filtering out AS 64999''s unauthorized announcement directly stops the leak without disrupting legitimate service.', 25, 2),
  ('mission-w5-06-o3-c1', 'orientation', 'You''ve already gathered everything you need -- combine the source with the fix.', 20, 1),
  ('mission-w5-06-o3-c1', 'concept', 'The report needs to name the false announcer and the specific control that stops it.', 30, 2),
  ('mission-w5-06-o3-c1', 'tool_direction', 'State who leaked the route, then what was applied to stop it.', 40, 3),
  ('mission-w5-06-o3-c1', 'near_solution', 'AS 64999''s unauthorized announcement diverted traffic; a filter is what stops it.', 50, 4),
  ('mission-w5-06-o3-c1', 'solution', 'AS 64999 falsely announced 10.66.66.0/24 with no RPKI backing, diverting Guardian telemetry within minutes -- filtering that announcement at the boundary restores the legitimate path.', 60, 5);
