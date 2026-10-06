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

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w64-01-o1', 'mission-w64-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to inventory the organization''s real assets.'),
  ('mission-w64-02-o1', 'mission-w64-02', 1, 'Classify each asset', 'Assign each asset the correct classification level.'),
  ('mission-w64-03-o1', 'mission-w64-03', 1, 'Find the unowned system', 'Identify which critical system has no assigned owner.'),
  ('mission-w64-04-o1', 'mission-w64-04', 1, 'Choose the correct retention decision', 'Determine the correct action for data that has outlived its retention purpose.'),
  ('mission-w64-05-o1', 'mission-w64-05', 1, 'Find the undocumented data flow', 'Identify which data flow was never documented or approved.'),
  ('mission-w64-06-o1', 'mission-w64-06', 1, 'Identify the critical assets', 'Select the assets that genuinely qualify as critical to the organization''s strategy.'),
  ('mission-w64-06-o2', 'mission-w64-06', 2, 'Identify the critical data flow', 'Confirm which data flow must be prioritized in the security strategy.'),
  ('mission-w64-06-o3', 'mission-w64-06', 3, 'Confirm the strategy inputs', 'Confirm the critical assets and the critical flow together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w64-01-o1-c1', 'mission-w64-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Know what matters before you defend it. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w64-02-o1-c1', 'mission-w64-02-o1', 1, 'drag_and_drop', 'Assign each asset its correct classification level.', '{"items":[{"id":"a1","text":"Public marketing brochure PDF"},{"id":"a2","text":"Internal engineering wiki (no customer data)"},{"id":"a3","text":"Customer payment records"},{"id":"a4","text":"Unreleased product roadmap and pending M&A documents"}],"targets":[{"id":"public","label":"Public"},{"id":"internal","label":"Internal"},{"id":"confidential","label":"Confidential"},{"id":"restricted","label":"Restricted"}]}'::jsonb, '{"correctMapping":{"a1":"public","a2":"internal","a3":"confidential","a4":"restricted"}}'::jsonb),

  ('mission-w64-03-o1-c1', 'mission-w64-03-o1', 1, 'investigation', 'Which critical system has no assigned owner?', '{"evidence":[{"id":"sys1","label":"Customer billing platform","detail":"Owner: Finance Systems team, confirmed active"},{"id":"sys2","label":"Legacy partner-integration gateway (acquired in the merger)","detail":"Owner field: blank. No team in either organization''s org chart claims it."}],"question":"Which system is unowned?"}'::jsonb, '{"requiredEvidenceIds":["sys2"]}'::jsonb),

  ('mission-w64-04-o1-c1', 'mission-w64-04-o1', 1, 'multiple_choice', 'A dataset''s legally mandated retention period expired 14 months ago, and no active business or legal hold applies to it. What''s the correct action?', '{"question":"A dataset''s legally mandated retention period expired 14 months ago, and no active business or legal hold applies to it. What''s the correct action?","options":[{"id":"a","text":"Keep it indefinitely -- more data is always better"},{"id":"b","text":"Securely destroy it according to the documented retention and destruction policy"},{"id":"c","text":"Move it to a public backup for convenience"},{"id":"d","text":"Ignore it -- retention policies are only guidelines"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w64-05-o1-c1', 'mission-w64-05-o1', 1, 'interactive_diagram', 'Which data flow in this merged-systems map was never documented or approved?', '{"hotspots":[{"id":"flow1","label":"Customer records -> billing platform, documented in the data-flow register, approved by legal","explanation":"Fully documented and approved."},{"id":"flow2","label":"Partner-integration gateway -> an external analytics vendor, no entry in the data-flow register, no approval on file","explanation":"Exists in production traffic but appears nowhere in governance records."}],"task":"Which flow is undocumented?"}'::jsonb, '{"correctOrderIds":["flow2"]}'::jsonb),

  ('mission-w64-06-o1-c1', 'mission-w64-06-o1', 1, 'drag_and_drop', 'Select which assets genuinely qualify as critical to the organization''s security strategy.', '{"items":[{"id":"asset1","text":"Customer payment records"},{"id":"asset2","text":"Public marketing brochure"},{"id":"asset3","text":"The unowned legacy partner-integration gateway"},{"id":"asset4","text":"Internal engineering wiki with no sensitive data"}],"targets":[{"id":"critical","label":"Critical -- must drive strategy"},{"id":"not_critical","label":"Not critical"}]}'::jsonb, '{"correctMapping":{"asset1":"critical","asset2":"not_critical","asset3":"critical","asset4":"not_critical"}}'::jsonb),

  ('mission-w64-06-o2-c1', 'mission-w64-06-o2', 1, 'multiple_choice', 'Which data flow must be prioritized in the security strategy?', '{"question":"Which data flow must be prioritized in the security strategy?","options":[{"id":"a","text":"The fully documented, approved billing flow"},{"id":"b","text":"The undocumented flow from the unowned legacy gateway to an external vendor -- unowned, unreviewed, and carrying data nobody has assessed"},{"id":"c","text":"Neither -- both are equally low priority"},{"id":"d","text":"Whichever flow is easiest to fix"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w64-06-o3-c1', 'mission-w64-06-o3', 1, 'boss_encounter', 'Confirm the critical assets and the critical data flow together.', '{"stages":[{"objectiveRef":"mission-w64-06-o1","label":"The critical assets"},{"objectiveRef":"mission-w64-06-o2","label":"The critical data flow"}],"task":"Confirm the critical assets and the critical data flow together."}'::jsonb, '{"requiredObjectiveIds":["mission-w64-06-o1","mission-w64-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w64-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w64-02-o1-c1', 'orientation', 'Ask what would actually happen if each item leaked publicly.', 15, 1),
  ('mission-w64-02-o1-c1', 'solution', 'The brochure is already public, the wiki is routine internal info, payment records are confidential customer data, and pending M&A documents are restricted -- the highest-impact category.', 25, 2),

  ('mission-w64-03-o1-c1', 'orientation', 'Ask which system''s owner field is actually blank, not just which system is old.', 15, 1),
  ('mission-w64-03-o1-c1', 'solution', 'The legacy partner-integration gateway (sys2) has no owner in either organization''s org chart -- the billing platform (sys1) has a confirmed active owner.', 25, 2),

  ('mission-w64-04-o1-c1', 'orientation', 'Ask whether anything is actively preventing destruction right now.', 15, 1),
  ('mission-w64-04-o1-c1', 'solution', 'With the retention period expired and no active hold, the documented policy requires secure destruction -- keeping it indefinitely creates unnecessary risk. Option b.', 25, 2),

  ('mission-w64-05-o1-c1', 'orientation', 'Check the governance record for each flow, not just whether it exists in production.', 15, 1),
  ('mission-w64-05-o1-c1', 'solution', 'The gateway-to-vendor flow (flow2) has no entry anywhere in governance records despite carrying real production traffic -- that''s the undocumented one.', 25, 2),

  ('mission-w64-06-o1-c1', 'orientation', 'Critical means high impact if compromised, not just present in the inventory.', 15, 1),
  ('mission-w64-06-o1-c1', 'solution', 'Payment records and the unowned gateway are both high-impact and under-protected -- the brochure and internal wiki carry comparatively little risk.', 25, 2),

  ('mission-w64-06-o2-c1', 'orientation', 'A documented, approved, well-owned flow is lower risk than one nobody is watching at all.', 15, 1),
  ('mission-w64-06-o2-c1', 'solution', 'The undocumented flow from the unowned gateway is the one that needs immediate attention -- it''s unreviewed, unowned, and already moving real data. Option b.', 25, 2),

  ('mission-w64-06-o3-c1', 'orientation', 'You''ve already identified the critical assets and the critical flow -- combine them.', 20, 1),
  ('mission-w64-06-o3-c1', 'solution', 'Customer payment records and the unowned legacy gateway are the critical assets, and the undocumented gateway-to-vendor flow is the critical data flow that must drive the security strategy.', 35, 2);
