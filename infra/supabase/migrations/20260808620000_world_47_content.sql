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

