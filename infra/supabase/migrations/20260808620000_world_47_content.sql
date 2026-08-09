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

