-- world-47 ("Threat Intelligence: The Adversary Map") mission content,
-- generated from docs/12-world-story-bible.md. Closes Act 6 "The Hunt".
-- Pools fragments from incidents worldwide into one intelligence picture,
-- teaches strategic/operational/tactical intel, IOCs/TTPs, STIX/TAXII
-- concepts, source confidence and attribution limits, and closes on the
-- Adversary Map capstone revealing Sentinel-X infrastructure concentrated
-- in cloud regions, CI/CD systems and edge devices -- the pivot into Act 7
-- "Cloudfall". Mission 1 is cross-world-gated on world-46's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-47a', 'world-47', 'adversary-map', '47A - The Adversary Map', 'Strategic, operational and tactical intelligence, fused from fragments of incidents around the world into the first true picture of Sentinel-X.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-47a-1', 'campaign-47a', 'foundations', 'Foundations', 'Intelligence layers, indicators, TTPs and source confidence, learned before a single report gets added to the map.', 1),
  ('operation-47a-2', 'campaign-47a', 'investigation', 'Investigation', 'Build the campaign map itself, and separate what''s actually Sentinel-X from everything that only looks like it.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w47-01', 'world-47', 'campaign-47a', 'operation-47a-1', 'fragments-from-everywhere', 'Fragments from Everywhere', 'Reports keep arriving from incidents nobody previously connected to each other. It''s time to pool every fragment into one intelligence picture.', 'intro', ARRAY['luna', 'ava', 'byte'], '{"requiredMissionIds":["mission-w46-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w47-02', 'world-47', 'campaign-47a', 'operation-47a-1', 'three-layers', 'Three Layers', 'Strategic intelligence, operational intelligence and tactical intelligence answer completely different questions for completely different audiences.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w47-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"intel-layers-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w47-03', 'world-47', 'campaign-47a', 'operation-47a-1', 'an-indicator-is-not-evidence', 'An Indicator Is Not Evidence', 'A hash or an IP on its own is just a fact. Normalizing it into a typed, sourced object is what turns it into usable intelligence.', 'beginner', ARRAY['byte', 'luna'], '{"requiredMissionIds":["mission-w47-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"ioc-normalization-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w47-04', 'world-47', 'campaign-47a', 'operation-47a-2', 'how-much-to-trust-a-source', 'How Much to Trust a Source', 'Not every report deserves equal weight. Rating a source and rating its information are two separate judgments.', 'intermediate', ARRAY['ava', 'luna'], '{"requiredMissionIds":["mission-w47-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"source-confidence-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w47-05', 'world-47', 'campaign-47a', 'operation-47a-2', 'same-actor-or-copycat', 'Same Actor, or Copycat?', 'Techniques get copied. Infrastructure gets reused by people with nothing to do with the original operation. A full pattern is much harder to fake.', 'advanced', ARRAY['luna', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w47-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"campaign-clustering-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w47-06', 'world-47', 'campaign-47a', 'operation-47a-2', 'the-adversary-map-boss', 'The Adversary Map', 'Produce an intelligence estimate that distinguishes confirmed Sentinel-X activity from copycats and unrelated incidents.', 'boss', ARRAY['luna', 'ava', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w47-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"adversary-map-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["adversary-map"],"skillXp":{"threat_hunting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w47-01', 1, 'luna', 'Six months of incidents that never looked related. Different sectors, different footholds, different tools. Run them through the same lens and patterns start showing up.'),
  ('mission-w47-01', 2, 'ava', 'We finally have something the encrypted module gave us -- proof this isn''t one attacker improvising. It''s a system that tests itself, repeatedly, in different places.'),
  ('mission-w47-01', 3, 'byte', 'Every fragment we''ve collected -- hospitals, banks, airports, that maintenance network back at SkyPort -- goes into one picture now. Strategic, operational, tactical, all three layers.'),
  ('mission-w47-01', 4, 'luna', 'Some of what comes in won''t actually be Sentinel-X. Copycats show up the moment something this loud gets attention. Separating signal from noise is the whole job.'),
  ('mission-w47-02', 1, 'luna', 'Strategic intelligence tells leadership what''s coming and why it matters. Operational tells you a campaign''s shape. Tactical is the indicators an analyst checks against, right now. Mix them up and nobody gets what they actually need.'),
  ('mission-w47-03', 1, 'byte', 'A hash, an IP, a domain -- on its own, an indicator is just a fact. It becomes evidence only once you can tie it to a technique and a source you trust.'),
  ('mission-w47-03', 2, 'luna', 'STIX gives every one of these a consistent shape, so this report and next month''s report can actually be compared instead of re-read from scratch.'),
  ('mission-w47-04', 1, 'ava', 'Not every report deserves equal weight. A source that''s been reliable for years earns more trust than an anonymous forum post, even when they say the same thing.'),
  ('mission-w47-04', 2, 'luna', 'Rate the source, rate the information, separately. A reliable source can still pass along bad information, and an unreliable one can occasionally get something right.'),
  ('mission-w47-05', 1, 'luna', 'Same TTP doesn''t automatically mean same actor. Techniques get copied. Infrastructure gets reused by people who have nothing to do with the original operation.'),
  ('mission-w47-05', 2, 'zayn', 'What doesn''t get copied as easily is a full pattern -- the specific tool chain, the timing, the operational habits, all together.'),
  ('mission-w47-05', 3, 'byte', 'Cluster the incidents that share the full pattern. The ones that only share a technique or two go in a separate pile.'),
  ('mission-w47-06', 1, 'ava', 'Everything goes on the map now. Every incident, every source, every rating -- and a clean line between what''s confirmed, what''s probably a copycat, and what''s unrelated.'),
  ('mission-w47-06', 2, 'luna', '...Estimate''s done. Confirmed Sentinel-X activity clusters tightly -- same tool chain, same testing-for-learning behavior we found in the Decision Engine, repeated across a dozen sectors. Everything else is noise wearing its name.'),
  ('mission-w47-06', 3, 'byte', 'And the confirmed cluster has a shape of its own. Look at where the infrastructure actually sits.'),
  ('mission-w47-06', 4, 'zayn', '...Concentrated. Major cloud regions, CI/CD systems, edge devices. Almost nothing on a physical server we could ever walk up to.'),
  ('mission-w47-06', 5, 'ava', 'The map reveals infrastructure concentrated in major cloud regions, CI/CD systems and edge devices.'),
  ('mission-w47-06', 6, 'luna', 'We''ve been tracing this like it lives on hardware. It doesn''t, not anymore. The next act begins in the cloud.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w47-01-o1', 'mission-w47-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to pool every fragment into one intelligence picture.'),
  ('mission-w47-02-o1', 'mission-w47-02', 1, 'Sort reports by intelligence layer', 'Match each report to the correct intelligence layer -- strategic, operational or tactical.'),
  ('mission-w47-03-o1', 'mission-w47-03', 1, 'Normalize each item to its STIX-style object type', 'Match each raw item to the STIX-style object type it belongs to.'),
  ('mission-w47-04-o1', 'mission-w47-04', 1, 'Rate an uncorroborated claim', 'Choose the correct confidence rating for a claim from a usually-reliable source that hasn''t been corroborated yet.'),
  ('mission-w47-05-o1', 'mission-w47-05', 1, 'Cluster incidents by relationship', 'Match each incident to confirmed Sentinel-X activity, a copycat, or unrelated activity.'),
  ('mission-w47-06-o1', 'mission-w47-06', 1, 'Build the confirmed-activity cluster', 'Select every incident that belongs in the confirmed Sentinel-X cluster.'),
  ('mission-w47-06-o2', 'mission-w47-06', 2, 'State the intelligence estimate', 'Choose the statement that correctly frames the finished estimate for leadership.'),
  ('mission-w47-06-o3', 'mission-w47-06', 3, 'Close the estimate', 'Confirm the confirmed cluster and the framed estimate together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w47-01-o1-c1', 'mission-w47-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Every fragment, one picture. Ready to start building it?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w47-02-o1-c1', 'mission-w47-02-o1', 1, 'drag_and_drop', 'Match each report to the correct intelligence layer.', '{"items":[{"id":"r1","text":"A five-year trend forecast on ransomware-as-a-service targeting healthcare, written for the board"},{"id":"r2","text":"A description of Sentinel-X''s typical campaign structure -- initial access pattern, staging behavior, dwell time"},{"id":"r3","text":"A specific file hash and C2 domain seen in last night''s alert"}],"targets":[{"id":"strategic","label":"Strategic"},{"id":"operational","label":"Operational"},{"id":"tactical","label":"Tactical"}]}'::jsonb, '{"correctMapping":{"r1":"strategic","r2":"operational","r3":"tactical"}}'::jsonb),

  ('mission-w47-03-o1-c1', 'mission-w47-03-o1', 1, 'drag_and_drop', 'Match each raw item to the STIX-style object type it belongs to.', '{"items":[{"id":"i1","text":"SHA-256 hash of the payload dropped on the maintenance controller"},{"id":"i2","text":"A description of the custom lateral-movement tool observed in three incidents"},{"id":"i3","text":"The assessed name for the actor behind these incidents -- Sentinel-X"},{"id":"i4","text":"A statement that Sentinel-X uses this specific tool"}],"targets":[{"id":"indicator","label":"Indicator"},{"id":"malware","label":"Malware / Tool"},{"id":"threat_actor","label":"Threat Actor"},{"id":"relationship","label":"Relationship"}]}'::jsonb, '{"correctMapping":{"i1":"indicator","i2":"malware","i3":"threat_actor","i4":"relationship"}}'::jsonb),

  ('mission-w47-04-o1-c1', 'mission-w47-04-o1', 1, 'multiple_choice', 'A source that has been independently corroborated in 9 of the last 10 reports it filed passes along a new claim that a specific IP is Sentinel-X infrastructure. No other source has seen this yet. How should this claim be rated?', '{"question":"A source that has been independently corroborated in 9 of the last 10 reports it filed passes along a new claim that a specific IP is Sentinel-X infrastructure. No other source has seen this yet. How should this claim be rated?","options":[{"id":"a","text":"Completely reliable -- treat it as confirmed fact"},{"id":"b","text":"Usually-reliable source, but information not yet confirmed -- rate the source high and the information as unconfirmed, not certain"},{"id":"c","text":"Ignore it entirely since it''s uncorroborated"},{"id":"d","text":"Treat it exactly the same as an anonymous, unverified tip"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w47-05-o1-c1', 'mission-w47-05-o1', 1, 'drag_and_drop', 'Match each incident to confirmed Sentinel-X activity, a copycat, or unrelated activity.', '{"items":[{"id":"e1","text":"Full tool chain match -- same lateral-movement tool, same staging pattern, same beacon rhythm, same testing-for-learning behavior seen in the Decision Engine"},{"id":"e2","text":"Uses the same publicly-leaked exploit as Sentinel-X, but different tooling, no staging pattern, and destructive intent with no measurement behavior"},{"id":"e3","text":"Shares only a common, widely-used C2 framework -- no other overlap in behavior, timing or targeting"}],"targets":[{"id":"confirmed_sentinel_x","label":"Confirmed Sentinel-X"},{"id":"copycat","label":"Copycat"},{"id":"unrelated","label":"Unrelated"}]}'::jsonb, '{"correctMapping":{"e1":"confirmed_sentinel_x","e2":"copycat","e3":"unrelated"}}'::jsonb),

  ('mission-w47-06-o1-c1', 'mission-w47-06-o1', 1, 'investigation', 'Select every incident that belongs in the confirmed Sentinel-X cluster.', '{"evidence":[{"id":"ev1","label":"Frankfurt data-center intrusion","detail":"Same lateral-movement tool, same beacon rhythm, same post-incident telemetry pattern as the Decision Engine test"},{"id":"ev2","label":"Regional retailer breach","detail":"Uses a leaked Sentinel-X exploit, but with smash-and-grab data theft and no measurement behavior at all"},{"id":"ev3","label":"Singapore logistics hub","detail":"Identical staging-then-beacon pattern, resilience-scoring telemetry recovered from the payload"},{"id":"ev4","label":"Toronto transit authority","detail":"Same custom tool-chain fingerprint, same testing-for-learning signature confirmed in memory forensics"},{"id":"ev5","label":"European ISP outage","detail":"Shares only a common off-the-shelf C2 framework, no other technical or behavioral overlap"}],"question":"Select every incident that belongs in the confirmed Sentinel-X cluster."}'::jsonb, '{"requiredEvidenceIds":["ev1","ev3","ev4"]}'::jsonb),

  ('mission-w47-06-o2-c1', 'mission-w47-06-o2', 1, 'multiple_choice', 'Which statement correctly frames the finished estimate for leadership?', '{"question":"Which statement correctly frames the finished estimate for leadership?","options":[{"id":"a","text":"We assess with high confidence that Sentinel-X is active in at least three confirmed incidents beyond the original hospital event, sharing a consistent tool chain and testing-for-learning behavior; at least one additional incident is an opportunistic copycat, and one is unrelated"},{"id":"b","text":"Sentinel-X is definitely responsible for every incident that has occurred anywhere in the last year"},{"id":"c","text":"There is no way to distinguish Sentinel-X from unrelated activity, so no estimate can be made"},{"id":"d","text":"Any incident using a similar exploit should be attributed to Sentinel-X regardless of other evidence"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w47-06-o3-c1', 'mission-w47-06-o3', 1, 'boss_encounter', 'Confirm the confirmed cluster and the framed estimate together.', '{"stages":[{"objectiveRef":"mission-w47-06-o1","label":"The confirmed cluster"},{"objectiveRef":"mission-w47-06-o2","label":"The framed estimate"}],"task":"Confirm the confirmed cluster and the framed estimate together."}'::jsonb, '{"requiredObjectiveIds":["mission-w47-06-o1","mission-w47-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w47-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w47-02-o1-c1', 'orientation', 'Ask who each report is actually written for, and how soon they need to act on it.', 15, 1),
  ('mission-w47-02-o1-c1', 'solution', 'A multi-year board-facing forecast is strategic, a campaign-shape description is operational, and a specific hash-and-domain alert is tactical.', 25, 2),

  ('mission-w47-03-o1-c1', 'orientation', 'Ask whether each item is a raw fact, a description of a capability, a name for an actor, or a link between two of those things.', 15, 1),
  ('mission-w47-03-o1-c1', 'concept', 'Indicators are raw technical facts, malware/tool objects describe capabilities, threat-actor objects name who''s behind it, and relationship objects connect the others together.', 25, 2),
  ('mission-w47-03-o1-c1', 'solution', 'A hash is an indicator, the custom tool description is a malware/tool object, the assessed actor name is a threat-actor object, and the "uses" statement connecting them is a relationship.', 35, 3),

  ('mission-w47-04-o1-c1', 'orientation', 'The source''s track record and this specific piece of information are two separate things to rate.', 15, 1),
  ('mission-w47-04-o1-c1', 'concept', 'A reliable source can still be the first and only one to report something -- that makes the source credible but the specific claim still unconfirmed.', 25, 2),
  ('mission-w47-04-o1-c1', 'solution', 'Rate the source as usually reliable, and the information itself as not yet confirmed -- treating it as certain fact or dismissing it outright are both wrong. Option b.', 35, 3),

  ('mission-w47-05-o1-c1', 'orientation', 'One of these shares almost everything, one shares a technique but not the pattern, and one shares only a common tool everyone uses.', 15, 1),
  ('mission-w47-05-o1-c1', 'concept', 'Confirmed activity needs the full pattern -- tooling, staging, timing and the testing-for-learning signature together, not just one overlapping detail.', 25, 2),
  ('mission-w47-05-o1-c1', 'solution', 'e1 matches the full pattern (confirmed Sentinel-X), e2 shares only the exploit with different behavior (copycat), e3 shares only a common framework (unrelated).', 35, 3),

  ('mission-w47-06-o1-c1', 'orientation', 'Look for the incidents that share the full pattern -- tool chain, staging, and the testing-for-learning signature -- not just a single overlapping detail.', 15, 1),
  ('mission-w47-06-o1-c1', 'concept', 'Two of these five incidents are decoys: one is a copycat using a leaked exploit with no measurement behavior, and one shares only a common off-the-shelf framework.', 25, 2),
  ('mission-w47-06-o1-c1', 'solution', 'Frankfurt, Singapore and Toronto all match the full confirmed pattern -- same tool chain and testing-for-learning signature. The retailer breach is a copycat, and the ISP outage is unrelated.', 40, 3),

  ('mission-w47-06-o2-c1', 'orientation', 'A defensible estimate states confidence level, cites the shared pattern, and explicitly separates confirmed activity from everything that only looks similar.', 15, 1),
  ('mission-w47-06-o2-c1', 'solution', 'The estimate that names a specific confidence level, points to the shared tool chain and testing behavior, and separately flags the copycat and the unrelated incident is the correct framing. Option a.', 25, 2),

  ('mission-w47-06-o3-c1', 'orientation', 'You''ve already built the confirmed cluster and framed the estimate -- combine them into one closing statement.', 20, 1),
  ('mission-w47-06-o3-c1', 'concept', 'The closure needs the named confirmed incidents plus the plain-language estimate that separates them from the copycat and the unrelated case.', 30, 2),
  ('mission-w47-06-o3-c1', 'tool_direction', 'State the confirmed cluster first, then the estimate that frames it for leadership.', 40, 3),
  ('mission-w47-06-o3-c1', 'near_solution', 'Frankfurt, Singapore and Toronto confirmed; the retailer breach a copycat; the ISP outage unrelated -- estimated with high confidence based on shared tool chain and testing-for-learning behavior.', 50, 4),
  ('mission-w47-06-o3-c1', 'solution', 'The confirmed Sentinel-X cluster is Frankfurt, Singapore and Toronto, sharing the same tool chain, staging pattern and testing-for-learning signature recovered from the Decision Engine. The regional retailer breach is an opportunistic copycat, and the European ISP outage is unrelated. Across the confirmed cluster, the infrastructure itself is concentrated in major cloud regions, CI/CD systems and edge devices -- almost nothing traceable to a physical server.', 65, 5);
