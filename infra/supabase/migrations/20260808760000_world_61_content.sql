-- world-61 ("Fuzzing: Crash Lab") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 8 "Zero Day". Mission 1 is
-- cross-world-gated on world-60's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-61a', 'world-61', 'crash-lab', '61A - Crash Lab', 'A distributed fuzzing harness, recovered from Guardian infrastructure, that appears to have been running quietly for years.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-61a-1', 'campaign-61a', 'foundations', 'Foundations', 'Fuzzing strategies, harness design and crash triage, learned by turning noisy failures into actionable bugs.', 1),
  ('operation-61a-2', 'campaign-61a', 'investigation', 'Investigation', 'Discover a new bug in a deliberately vulnerable parser and produce a minimal reproducible test case.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w61-01', 'world-61', 'campaign-61a', 'operation-61a-1', 'a-harness-thats-been-running-for-years', 'A Harness That''s Been Running for Years', 'Guardian researchers recover a distributed fuzzing harness. Nobody remembers deploying it, and it''s been generating results the whole time.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w60-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w61-02', 'world-61', 'campaign-61a', 'operation-61a-1', 'four-ways-to-generate-chaos', 'Four Ways to Generate Chaos', 'Mutation, generation, coverage-guided, grammar-based -- four different strategies for producing inputs a program has never seen before.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w61-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"fuzzing-strategy-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w61-03', 'world-61', 'campaign-61a', 'operation-61a-1', 'a-target-worth-fuzzing', 'A Target Worth Fuzzing', 'A fuzzing harness is only as good as the target it isolates and the feedback signal it reads back.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w61-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"harness-design-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w61-04', 'world-61', 'campaign-61a', 'operation-61a-2', 'ten-thousand-crashes-one-bug', 'Ten Thousand Crashes, One Bug', 'The harness produced thousands of crashing inputs overnight. Almost all of them are the exact same root cause, dressed differently.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w61-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"crash-triage-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w61-05', 'world-61', 'campaign-61a', 'operation-61a-2', 'cutting-away-everything-that-doesnt-matter', 'Cutting Away Everything That Doesn''t Matter', 'A 4KB crashing input almost always has a tiny handful of bytes actually responsible. Minimization finds exactly which ones.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w61-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"minimization-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w61-06', 'world-61', 'campaign-61a', 'operation-61a-2', 'crash-lab-boss', 'Crash Lab', 'Discover a genuinely new bug in a deliberately vulnerable parser using the recovered harness''s output, and produce a minimal reproducible test case for it.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w61-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"crash-lab-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["crash-lab"],"skillXp":{"programming":50}}'::jsonb, true, 6);

