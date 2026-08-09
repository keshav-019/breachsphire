-- world-62 ("Advanced Application Security: Edge Cases") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 8 "Zero Day".
-- Mission 1 is cross-world-gated on world-61's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-62a', 'world-62', 'edge-cases', '62A - Edge Cases', 'Small application flaws, each scored low risk on its own, combined into chains no individual scanner finding ever explains.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-62a-1', 'campaign-62a', 'foundations', 'Foundations', 'Request smuggling, race conditions, deserialization and OAuth/SSO chains, learned as composition problems.', 1),
  ('operation-62a-2', 'campaign-62a', 'investigation', 'Investigation', 'Discover a multi-step chain no single finding explains, then break it at multiple layers.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w62-01', 'world-62', 'campaign-62a', 'operation-62a-1', 'nothing-here-scores-high', 'Nothing Here Scores High', 'Every scanner finding on this application is individually low severity. Sentinel-X isn''t exploiting any one of them. It''s exploiting the combination.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w61-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w62-02', 'world-62', 'campaign-62a', 'operation-62a-1', 'two-servers-disagreeing-about-where-a-request-ends', 'Two Servers Disagreeing About Where a Request Ends', 'A front-end proxy and a back-end server, parsing the same request boundary two different ways. That disagreement is a smuggled second request, hidden inside the first.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w62-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"request-smuggling-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w62-03', 'world-62', 'campaign-62a', 'operation-62a-1', 'the-gap-between-check-and-use', 'The Gap Between Check and Use', 'A coupon gets validated, then redeemed, as two separate steps. Fire both at once, many times, and the gap between them is where the bug lives.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w62-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"race-condition-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w62-04', 'world-62', 'campaign-62a', 'operation-62a-2', 'data-that-turns-into-behavior', 'Data That Turns Into Behavior', 'Deserializing untrusted data shouldn''t be able to change what code runs. This endpoint lets it.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w62-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"deserialization-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w62-05', 'world-62', 'campaign-62a', 'operation-62a-2', 'a-redirect-thats-trusted-too-much', 'A Redirect That''s Trusted Too Much', 'An OAuth flow that doesn''t strictly validate its redirect URI hands an attacker a way to walk off with someone else''s token.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w62-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"oauth-chain-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w62-06', 'world-62', 'campaign-62a', 'operation-62a-2', 'edge-cases-boss', 'Edge Cases', 'Discover the multi-step chain that no single scanner finding explains, and break it at every layer it depends on.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w62-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"edge-cases-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["edge-cases"],"skillXp":{"web_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w62-01', 1, 'ava', 'Every scanner finding on this application scores individually low. Sentinel-X isn''t exploiting any one of them -- it''s exploiting the combination.'),
  ('mission-w62-01', 2, 'byte', 'That means the usual approach -- fix the highest-severity finding first -- doesn''t apply here. We have to think in chains, not in isolated bugs.'),
  ('mission-w62-02', 1, 'zayn', 'A front-end proxy and the back-end server, parsing the same request boundary two different ways. That mismatch smuggles a second, hidden request inside the first.'),
  ('mission-w62-03', 1, 'byte', 'Validate, then redeem -- two separate steps. Fire both at once, many times over, and the gap between them is exactly where the bug lives.'),
  ('mission-w62-04', 1, 'zayn', 'Deserializing untrusted data shouldn''t be able to change what code actually runs. This endpoint lets it.'),
  ('mission-w62-05', 1, 'ava', 'An OAuth flow that doesn''t strictly validate its redirect URI hands an attacker a way to walk off with someone else''s token.'),
  ('mission-w62-06', 1, 'zayn', 'Individually, none of these findings would even get triaged as urgent. Chain them. Show exactly how they connect.'),
  ('mission-w62-06', 2, 'byte', '...Chain confirmed. The smuggled request races the coupon redemption to plant a malicious deserialized object, which the OAuth flow''s loose redirect validation then exfiltrates as a token.'),
  ('mission-w62-06', 3, 'ava', 'Break it at every layer, not just the easiest one to patch.'),
  ('mission-w62-06', 4, 'zayn', 'Done. Strict request parsing on both proxy and server, redemption made atomic, deserialization restricted to safe types, redirect URI strictly allow-listed.'),
  ('mission-w62-06', 5, 'byte', 'The deeper question is why this chain worked at all. None of these individual flaws are exotic.'),
  ('mission-w62-06', 6, 'ava', 'Because nobody designing this system ever assumed they''d be combined. That assumption was never written down, and it was never true.');

