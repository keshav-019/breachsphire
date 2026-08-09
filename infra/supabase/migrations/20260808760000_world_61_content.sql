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

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w61-01-o1', 'mission-w61-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to work through years of accumulated crash data.'),
  ('mission-w61-02-o1', 'mission-w61-02', 1, 'Match each fuzzing strategy to its description', 'Match mutation, generation, coverage-guided and grammar-based fuzzing to what each one does.'),
  ('mission-w61-03-o1', 'mission-w61-03', 1, 'Identify what a good harness needs', 'Choose the harness design that gives the fuzzer a clean, useful feedback signal.'),
  ('mission-w61-04-o1', 'mission-w61-04', 1, 'Triage duplicate crashes', 'Identify which crashes share the same root cause versus which are genuinely unique.'),
  ('mission-w61-05-o1', 'mission-w61-05', 1, 'Minimize a crashing input', 'Choose the correctly minimized version of the crashing input.'),
  ('mission-w61-06-o1', 'mission-w61-06', 1, 'Identify the new bug', 'Determine which crash cluster represents a genuinely new, previously unclassified bug.'),
  ('mission-w61-06-o2', 'mission-w61-06', 2, 'Produce the minimal reproducer', 'Choose the correctly minimized test case for the new bug.'),
  ('mission-w61-06-o3', 'mission-w61-06', 3, 'Confirm the discovery', 'Confirm the new bug and its minimal reproducer together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w61-01-o1-c1', 'mission-w61-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"Years of unread crash data. Ready to make sense of it?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w61-02-o1-c1', 'mission-w61-02-o1', 1, 'drag_and_drop', 'Match each fuzzing strategy to what it actually does.', '{"items":[{"id":"s1","text":"Mutation fuzzing"},{"id":"s2","text":"Generation fuzzing"},{"id":"s3","text":"Coverage-guided fuzzing"},{"id":"s4","text":"Grammar-based fuzzing"}],"targets":[{"id":"t1","label":"Randomly flips bits and bytes in existing sample inputs"},{"id":"t2","label":"Builds entirely new inputs from a model of the expected format"},{"id":"t3","label":"Uses code coverage feedback to favor inputs that reach new execution paths"},{"id":"t4","label":"Generates inputs that respect a format''s formal structure, useful for highly structured formats"}]}'::jsonb, '{"correctMapping":{"s1":"t1","s2":"t2","s3":"t3","s4":"t4"}}'::jsonb),

  ('mission-w61-03-o1-c1', 'mission-w61-03-o1', 1, 'multiple_choice', 'Which harness design gives the fuzzer the most useful feedback signal?', '{"question":"Which harness design gives the fuzzer the most useful feedback signal?","options":[{"id":"a","text":"Fuzzing the entire application through its full UI, with no direct signal beyond \"did the whole app crash\""},{"id":"b","text":"Calling the target parsing function directly, in-process, with compiled-in coverage instrumentation reporting exactly which code paths each input reached"},{"id":"c","text":"Manually running the program once per input and checking the exit code by hand"},{"id":"d","text":"Fuzzing with completely random bytes and no target function isolation at all"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w61-04-o1-c1', 'mission-w61-04-o1', 1, 'investigation', 'Which of these crashes share the same root cause?', '{"evidence":[{"id":"c1","label":"Crash 1","detail":"Stack trace: parse_header -> copy_field -> SIGSEGV, identical coverage signature to 400 other crashes"},{"id":"c2","label":"Crash 2","detail":"Stack trace: parse_header -> copy_field -> SIGSEGV, identical coverage signature to 400 other crashes"},{"id":"c3","label":"Crash 3","detail":"Stack trace: parse_footer -> validate_checksum -> divide-by-zero, unique coverage signature, no other crash matches it"}],"question":"Which crashes are duplicates, and which is unique?"}'::jsonb, '{"requiredEvidenceIds":["c3"]}'::jsonb),

  ('mission-w61-05-o1-c1', 'mission-w61-05-o1', 1, 'multiple_choice', 'A 4KB crashing input still triggers the exact same crash when reduced to 12 specific bytes. What''s the correctly minimized reproducer?', '{"question":"A 4KB crashing input still triggers the exact same crash when reduced to 12 specific bytes. What''s the correctly minimized reproducer?","options":[{"id":"a","text":"Keep the full 4KB input -- smaller might miss something"},{"id":"b","text":"The 12-byte input, confirmed to still reliably trigger the identical crash"},{"id":"c","text":"A completely different input that also happens to crash the program"},{"id":"d","text":"An empty input"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w61-06-o1-c1', 'mission-w61-06-o1', 1, 'investigation', 'Which crash cluster represents a genuinely new, previously unclassified bug?', '{"evidence":[{"id":"cluster1","label":"Cluster A","detail":"1,200 crashes, coverage signature matches the already-documented header-overflow bug exactly"},{"id":"cluster2","label":"Cluster B","detail":"3 crashes, coverage signature reaches a code path in the footer checksum validator never seen in any previously triaged bug, stack trace doesn''t match anything on file"}],"question":"Which cluster is the new bug?"}'::jsonb, '{"requiredEvidenceIds":["cluster2"]}'::jsonb),

  ('mission-w61-06-o2-c1', 'mission-w61-06-o2', 1, 'multiple_choice', 'Cluster B''s smallest crashing sample is 900 bytes. Reducing it byte-by-byte, a 6-byte footer still reliably reproduces the crash. What is the correct minimal reproducer?', '{"question":"Cluster B''s smallest crashing sample is 900 bytes. Reducing it byte-by-byte, a 6-byte footer still reliably reproduces the crash. What is the correct minimal reproducer?","options":[{"id":"a","text":"The original 900-byte sample"},{"id":"b","text":"The reduced 6-byte footer, confirmed to still reliably trigger the identical crash"},{"id":"c","text":"A random 6-byte input that has never been tested"},{"id":"d","text":"The 1,200 crashes from Cluster A instead, since there are more of them"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w61-06-o3-c1', 'mission-w61-06-o3', 1, 'boss_encounter', 'Confirm the new bug and its minimal reproducer together.', '{"stages":[{"objectiveRef":"mission-w61-06-o1","label":"The new bug"},{"objectiveRef":"mission-w61-06-o2","label":"The minimal reproducer"}],"task":"Confirm the new bug and its minimal reproducer together."}'::jsonb, '{"requiredObjectiveIds":["mission-w61-06-o1","mission-w61-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w61-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w61-02-o1-c1', 'orientation', 'Ask what each strategy starts from -- an existing input, a format model, coverage data, or a grammar.', 15, 1),
  ('mission-w61-02-o1-c1', 'solution', 'Mutation flips bytes in existing samples, generation builds from a format model, coverage-guided chases new code paths, grammar-based respects formal structure.', 25, 2),

  ('mission-w61-03-o1-c1', 'orientation', 'Ask which option gives the fuzzer the most precise, fastest feedback loop.', 15, 1),
  ('mission-w61-03-o1-c1', 'solution', 'Calling the target function directly with coverage instrumentation gives fast, precise, per-input feedback -- fuzzing through a full UI or checking exit codes by hand gives almost none. Option b.', 25, 2),

  ('mission-w61-04-o1-c1', 'orientation', 'Compare stack traces and coverage signatures, not just whether something crashed.', 15, 1),
  ('mission-w61-04-o1-c1', 'solution', 'Crashes 1 and 2 share an identical stack trace and coverage signature with 400 others -- duplicates of the same bug. Crash 3 has a completely different trace and no match anywhere -- the unique one.', 25, 2),

  ('mission-w61-05-o1-c1', 'orientation', 'A correct minimization keeps only what''s actually necessary to still trigger the crash.', 15, 1),
  ('mission-w61-05-o1-c1', 'solution', 'The confirmed 12-byte input that still reliably reproduces the identical crash is the correct minimized reproducer -- smaller isn''t automatically better unless it still triggers the same bug.', 25, 2),

  ('mission-w61-06-o1-c1', 'orientation', 'A duplicate matches something already on file. A new bug doesn''t match anything.', 15, 1),
  ('mission-w61-06-o1-c1', 'solution', 'Cluster A matches an already-documented bug exactly. Cluster B reaches an unseen code path with no match on file -- that''s the genuinely new bug, even with far fewer crashes.', 25, 2),

  ('mission-w61-06-o2-c1', 'orientation', 'Apply the same minimization principle from earlier -- smallest input that still reliably reproduces it.', 15, 1),
  ('mission-w61-06-o2-c1', 'solution', 'The confirmed 6-byte footer that still reliably triggers Cluster B''s crash is the correct minimal reproducer for the new bug.', 25, 2),

  ('mission-w61-06-o3-c1', 'orientation', 'You''ve already identified the new bug and minimized it -- combine them.', 20, 1),
  ('mission-w61-06-o3-c1', 'solution', 'Cluster B is the new bug -- a previously unseen footer-checksum code path -- and its minimal reproducer is the confirmed 6-byte footer that reliably triggers the identical crash.', 35, 2);
