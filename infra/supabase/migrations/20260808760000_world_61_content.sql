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

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w61-01', 1, 'ava', 'Guardian researchers just recovered a distributed fuzzing harness. Nobody on the team remembers deploying it -- and it''s been generating results this whole time.'),
  ('mission-w61-01', 2, 'byte', 'Years of crash data, sitting there. Before we ask who built it, we need to know how to actually read what it found.'),
  ('mission-w61-02', 1, 'zayn', 'Mutation flips bytes in existing inputs. Generation builds inputs from a model of the format. Coverage-guided uses code coverage as feedback. Grammar-based respects a format''s actual structure. Different tools, different jobs.'),
  ('mission-w61-03', 1, 'byte', 'A harness is only as good as two things: how cleanly it isolates the target function, and how useful the feedback signal it reads back actually is.'),
  ('mission-w61-04', 1, 'zayn', 'Thousands of crashes overnight. Almost all of them are the same root cause wearing different bytes. Triage means telling those apart from the rare, genuinely unique ones.'),
  ('mission-w61-05', 1, 'ava', 'A 4KB crashing input usually has a handful of bytes actually responsible for the crash. Minimization strips away everything else.'),
  ('mission-w61-06', 1, 'zayn', 'Find something genuinely new in this harness''s output. Not a duplicate of what we''ve already triaged.'),
  ('mission-w61-06', 2, 'byte', '...Found one. A crash cluster with a coverage signature that doesn''t match any bug we''ve already classified.'),
  ('mission-w61-06', 3, 'ava', 'Minimize it. Prove it''s real and reproducible with the smallest possible test case.'),
  ('mission-w61-06', 4, 'zayn', 'Minimal reproducer confirmed. New bug, clean write-up, ready to hand off.'),
  ('mission-w61-06', 5, 'byte', 'One thing about this harness''s configuration bothers me. It wasn''t just finding bugs. It was ranking them.'),
  ('mission-w61-06', 6, 'ava', 'Ranking them by what?'),
  ('mission-w61-06', 7, 'byte', 'Strategic infrastructure impact. This harness was built to know which bugs matter most before a human ever looked at a single one.');

