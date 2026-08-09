-- world-64 ("Asset Security: Crown Jewels") mission content, generated from
-- docs/12-world-story-bible.md. Opens Act 9 "Command". Mission 1 is
-- cross-world-gated on world-63's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-64a', 'world-64', 'crown-jewels', '64A - Crown Jewels', 'Now responsible for an organization, the first question is deceptively simple: what are we actually protecting?', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-64a-1', 'campaign-64a', 'foundations', 'Foundations', 'Classification, ownership and data lifecycle, learned through a merger with unclear owners.', 1),
  ('operation-64a-2', 'campaign-64a', 'investigation', 'Investigation', 'Identify the critical assets and data flows that must drive the organization''s security strategy.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w64-01', 'world-64', 'campaign-64a', 'operation-64a-1', 'what-are-we-actually-protecting', 'What Are We Actually Protecting?', 'A recent merger doubled the organization''s footprint overnight. Nobody can answer a deceptively simple question: what are we actually protecting?', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w63-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w64-02', 'world-64', 'campaign-64a', 'operation-64a-1', 'not-everything-deserves-the-same-lock', 'Not Everything Deserves the Same Lock', 'A marketing PDF and a customer database don''t need the same protection. Classification is how you tell them apart at scale.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w64-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"classification-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w64-03', 'world-64', 'campaign-64a', 'operation-64a-1', 'systems-nobody-claims', 'Systems Nobody Claims', 'Post-merger, several critical systems have no assigned owner at all. An asset nobody owns is an asset nobody protects.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w64-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"ownership-mapping-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w64-04', 'world-64', 'campaign-64a', 'operation-64a-1', 'data-that-outlived-its-purpose', 'Data That Outlived Its Purpose', 'Some data has to be kept. Some has to be destroyed on schedule. Confusing the two creates risk either way.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w64-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"data-lifecycle-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w64-05', 'world-64', 'campaign-64a', 'operation-64a-2', 'a-flow-nobody-documented', 'A Flow Nobody Documented', 'Mapping how data actually moves through the merged systems reveals a data flow nobody wrote down, and nobody remembers approving.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w64-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"data-flow-mapping-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w64-06', 'world-64', 'campaign-64a', 'operation-64a-2', 'crown-jewels-boss', 'Crown Jewels', 'Identify the critical assets and data flows that must actually drive the organization''s security strategy, not just the ones that were easiest to inventory.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w64-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"crown-jewels-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["crown-jewels"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w64-01', 1, 'luna', 'The merger doubled our footprint overnight. Ask anyone in this building what we''re actually protecting, and you''ll get a different answer every time.'),
  ('mission-w64-01', 2, 'ava', 'This world isn''t about finding a vulnerability. It''s about knowing what actually matters before you can defend it.'),
  ('mission-w64-02', 1, 'zayn', 'A marketing PDF and a customer database don''t need the same protection. Classification is how an organization tells them apart at scale, instead of guessing case by case.'),
  ('mission-w64-03', 1, 'byte', 'Several critical systems from the merger have no assigned owner at all. An asset nobody owns is an asset nobody is actually protecting.'),
  ('mission-w64-04', 1, 'ava', 'Some data has to be kept for years. Some has to be destroyed on a schedule. Confusing the two creates risk in both directions.'),
  ('mission-w64-05', 1, 'byte', 'Mapping how data actually moves through the merged systems turned up a flow nobody documented, and nobody currently working here remembers approving.'),
  ('mission-w64-06', 1, 'luna', 'Tell me what actually matters. Not what was easiest to inventory -- what genuinely drives this organization''s security strategy.'),
  ('mission-w64-06', 2, 'byte', '...Critical assets and flows identified. And one of them is a legacy system nobody flagged during due diligence.'),
  ('mission-w64-06', 3, 'zayn', 'What''s in it?'),
  ('mission-w64-06', 4, 'byte', 'Datasets. Labeled with a project name none of us have seen anywhere else in this organization''s records: SENTINEL.'),
  ('mission-w64-06', 5, 'luna', 'No executive I''ve spoken to knew that system still existed.'),
  ('mission-w64-06', 6, 'ava', 'Then the question isn''t just what we''re protecting anymore. It''s what risk we just inherited without ever agreeing to.');

