-- Atlas Division pathway ("The Silence") Act 6 -- "The Pipeline"
-- content, under world-atlas-the-pipeline (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), continuing World II "The Factory" (Acts 4-7).
--
-- Same terminal-engine constraint as Acts 4-5 (no CI-specific commands
-- exist in the engine) -- every pipeline artifact here (pipeline
-- definition, runner registry, per-stage logs, run status, cache
-- report, parallel schedule, the leaked credential file) is static
-- seeded filesystem content read via `cat`. Only "why CI" (no natural
-- artifact) stays multiple_choice; every other topic has a genuine log
-- or config file behind it, so this Act's mix leans terminal-heavy,
-- similar to Act 1's ratio.
--
-- Narrative thread: Act 5 diagnosed the dead pre-push hook as the exact
-- reason the pipeline never ran. This Act is where Rook wires it up and
-- the pipeline finally executes for the first time against v12.1.0 --
-- build, lint and test all pass, but the security-check stage finds a
-- live, unrevoked auth token hardcoded directly into the same fix,
-- something no earlier human step (the developer's own local test in
-- Act 5, Rook's own PR review in Act 4) was ever capable of catching.
-- Two consistent hosts throughout: `atlas-devbox-01` (repo-side config,
-- reused from Acts 4-5) and a new `atlas-ci-runner-04` (the actual
-- runner executing run-4471).

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-the-pipeline', 'world-atlas-the-pipeline', 'the-pipeline', '2C - The Pipeline', 'Learn why CI exists and how a real pipeline is built -- anatomy, runners, build, lint, tests, security checks, artifacts, dependency caching, parallel jobs and pipeline secrets -- while Rook finally wires up the dead hook and watches v12.1.0''s first real pipeline run go red.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-the-pipeline-1', 'campaign-atlas-the-pipeline', 'a-pipeline-that-actually-runs', 'A Pipeline That Actually Runs', 'Why CI, pipeline anatomy, runners, build, lint and tests.', 1),
  ('operation-atlas-the-pipeline-2', 'campaign-atlas-the-pipeline', 'what-only-a-pipeline-catches', 'What Only a Pipeline Catches', 'Security checks, artifacts, dependency caching, parallel jobs and pipeline secrets.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-the-pipeline-01', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-1', 'why-ci', 'Why CI', 'The dead hook is a five-minute fix. Rook wires it up and pushes the v12.1.0 tag again -- for the first time, a real pipeline is about to run.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"why-ci-sim"}'::jsonb, '{"xp":190,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-the-pipeline-02', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-1', 'pipeline-anatomy', 'Pipeline Anatomy', 'Confirm exactly what stages this pipeline is actually defined to run, in what order.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-pipeline-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"pipeline-anatomy-sim"}'::jsonb, '{"xp":190,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-the-pipeline-03', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-1', 'runners', 'Runners', 'Something has to actually execute each stage. Confirm which runner picked up this run.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-pipeline-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"runners-sim"}'::jsonb, '{"xp":200,"credits":35}'::jsonb, false, 3),
  ('mission-atlas-the-pipeline-04', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-1', 'build', 'Build', 'The pipeline''s build stage is running against v12.1.0 for the very first time. Confirm it actually succeeded.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-pipeline-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"build-stage-sim"}'::jsonb, '{"xp":200,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-the-pipeline-05', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-1', 'lint', 'Lint', 'Confirm the lint stage''s result.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-pipeline-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"lint-stage-sim"}'::jsonb, '{"xp":200,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-the-pipeline-06', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-1', 'tests', 'Tests', 'Confirm the test stage''s result.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-pipeline-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"test-stage-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 6),
  ('mission-atlas-the-pipeline-07', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-2', 'security-checks', 'Security Checks', 'Build, lint and tests all passed. The security stage did not. Confirm exactly what it found.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-the-pipeline-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"security-stage-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-the-pipeline-08', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-2', 'artifacts', 'Artifacts', 'Confirm what actually happened to the artifact stage once security failed.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-pipeline-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"artifacts-stage-sim"}'::jsonb, '{"xp":220,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-the-pipeline-09', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-2', 'dependency-caching', 'Dependency Caching', 'This run was fast, despite everything. Confirm why.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-pipeline-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"dependency-caching-sim"}'::jsonb, '{"xp":220,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-the-pipeline-10', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-2', 'parallel-jobs', 'Parallel Jobs', 'Confirm how lint, test and security actually overlapped in this run.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-pipeline-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"parallel-jobs-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 10),
  ('mission-atlas-the-pipeline-11', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-2', 'pipeline-secrets', 'Pipeline Secrets', 'Confirm exactly what got committed, and what should have been there instead.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-the-pipeline-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"pipeline-secrets-sim"}'::jsonb, '{"xp":240,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-the-pipeline-12', 'world-atlas-the-pipeline', 'campaign-atlas-the-pipeline', 'operation-atlas-the-pipeline-2', 'red-build', 'Red Build', 'Everything this Act taught, turned on one run: not to force it green, to finally explain why this exact check exists and what happens before v12.1.0 can go anywhere near production.', 'boss', ARRAY['rook','cross','leena','byte'], '{"requiredMissionIds":["mission-atlas-the-pipeline-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"red-build-boss-sim"}'::jsonb, '{"xp":470,"credits":100,"badgeIds":["red-build"],"skillXp":{"cloud_devops_fundamentals":75}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-the-pipeline-01', 1, 'leena', 'The dead hook was always a five-minute fix once someone actually found it. Rook has wired it up and pushed the v12.1.0 tag again.'),
  ('mission-atlas-the-pipeline-01', 2, 'rook', 'For the first time in this entire story, a real pipeline is about to run against this fix. Not a local build, not a review, not a tag by itself -- the same automated checks every change is supposed to survive.'),
  ('mission-atlas-the-pipeline-01', 3, 'rook', 'CI exists for exactly one reason: to run the same checks, the same way, on every single change, regardless of who wrote it or what they remembered to run themselves. A human being consistent by habit is not the same guarantee.'),

  ('mission-atlas-the-pipeline-02', 1, 'rook', 'Before watching it run, know what it is actually defined to do. Every pipeline has an anatomy -- a fixed sequence of stages and whatever triggers them.'),

  ('mission-atlas-the-pipeline-03', 1, 'rook', 'A pipeline definition is instructions. A runner is the actual machine that carries them out. Confirm which one picked up run-4471.'),

  ('mission-atlas-the-pipeline-04', 1, 'rook', 'Build is always first -- nothing downstream means anything if the source will not even compile.'),

  ('mission-atlas-the-pipeline-05', 1, 'rook', 'Lint catches what compiles fine but was never going to be maintainable or consistent. Confirm it.'),

  ('mission-atlas-the-pipeline-06', 1, 'rook', 'Tests confirm the thing actually behaves the way it claims to, not just that it builds. Confirm it.'),

  ('mission-atlas-the-pipeline-07', 1, 'cross', 'Imani Cross. I got pulled in the moment this stage failed -- a failed security check on a production-bound artifact is exactly my alert.'),
  ('mission-atlas-the-pipeline-07', 2, 'rook', 'Build passed. Lint passed. Tests passed. This is the first stage in the whole story that did not.'),

  ('mission-atlas-the-pipeline-08', 1, 'rook', 'A failed stage does not just fail quietly on its own. Confirm what actually happened to everything downstream of it.'),

  ('mission-atlas-the-pipeline-09', 1, 'rook', 'Even with a fresh pipeline running for the first time on this tag, the dependency step still finished in seconds. Confirm why.'),

  ('mission-atlas-the-pipeline-10', 1, 'rook', 'Lint, tests and the security scan do not have to wait on each other -- none of them depend on each other''s output. Confirm how this run actually scheduled them.'),

  ('mission-atlas-the-pipeline-11', 1, 'cross', 'A security scan flagging a pattern is not proof by itself. Go read exactly what got committed.'),
  ('mission-atlas-the-pipeline-11', 2, 'rook', 'A secret should never exist as a literal value in source at all -- only ever as a reference the pipeline resolves at run time, from a secrets manager, injected and masked. Confirm what should have been there instead.'),

  ('mission-atlas-the-pipeline-12', 1, 'rook', 'Everything this Act taught you, on one run. Not to force it green -- to finally explain why this exact check exists, and what has to happen before this fix is allowed anywhere near production.'),
  ('mission-atlas-the-pipeline-12', 2, 'byte', 'I have the full stage-by-stage run, the flagged file and every earlier human check that already happened on this exact commit pulled up together.'),
  ('mission-atlas-the-pipeline-12', 3, 'cross', 'A live token sitting in git history is not a maybe. Until it is revoked, treat it as already compromised -- that is not optional, and it is not this pipeline''s job to decide otherwise.'),
  ('mission-atlas-the-pipeline-12', 4, 'rook', 'Find what none of the earlier steps could have caught, and explain why that gap is exactly what a pipeline is for.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-the-pipeline-01-o1', 'mission-atlas-the-pipeline-01', 1, 'Explain why CI exists', 'Choose the accurate description of what CI is actually for.'),

  ('mission-atlas-the-pipeline-02-o1', 'mission-atlas-the-pipeline-02', 1, 'Read the pipeline definition', 'Read the pipeline definition and submit the verification code.'),

  ('mission-atlas-the-pipeline-03-o1', 'mission-atlas-the-pipeline-03', 1, 'Identify the runner', 'Read the runner registry and submit the verification code.'),

  ('mission-atlas-the-pipeline-04-o1', 'mission-atlas-the-pipeline-04', 1, 'Confirm the build stage', 'Read the build stage log and submit the verification code.'),

  ('mission-atlas-the-pipeline-05-o1', 'mission-atlas-the-pipeline-05', 1, 'Confirm the lint stage', 'Read the lint stage log and submit the verification code.'),

  ('mission-atlas-the-pipeline-06-o1', 'mission-atlas-the-pipeline-06', 1, 'Confirm the test stage', 'Read the test stage log and submit the verification code.'),

  ('mission-atlas-the-pipeline-07-o1', 'mission-atlas-the-pipeline-07', 1, 'Confirm the security stage', 'Read the security stage log and submit the verification code.'),

  ('mission-atlas-the-pipeline-08-o1', 'mission-atlas-the-pipeline-08', 1, 'Confirm the artifact stage outcome', 'Read the run status and submit the verification code.'),

  ('mission-atlas-the-pipeline-09-o1', 'mission-atlas-the-pipeline-09', 1, 'Confirm the cache result', 'Read the cache report and submit the verification code.'),

  ('mission-atlas-the-pipeline-10-o1', 'mission-atlas-the-pipeline-10', 1, 'Confirm the parallel schedule', 'Read the run schedule and submit the verification code.'),

  ('mission-atlas-the-pipeline-11-o1', 'mission-atlas-the-pipeline-11', 1, 'Read the flagged file', 'Read the file that leaked the token and submit its verification code.'),

  ('mission-atlas-the-pipeline-12-o1', 'mission-atlas-the-pipeline-12', 1, 'Confirm the security stage failure', 'Read the security stage log and submit the verification code.'),
  ('mission-atlas-the-pipeline-12-o2', 'mission-atlas-the-pipeline-12', 2, 'Confirm the leaked credential', 'Read the flagged file and submit its verification code.'),
  ('mission-atlas-the-pipeline-12-o3', 'mission-atlas-the-pipeline-12', 3, 'Identify what only this stage could catch', 'Find the evidence that explains why no earlier check could have caught this.'),
  ('mission-atlas-the-pipeline-12-o4', 'mission-atlas-the-pipeline-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what a pipeline is actually for and what has to happen next.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-the-pipeline-01-o1-c1', 'mission-atlas-the-pipeline-01-o1', 1, 'multiple_choice', 'CI exists primarily to...', '{"question":"CI exists primarily to...","options":[{"id":"a","text":"Run the same set of automated checks, the same way, on every single change, regardless of who wrote it or what they remembered to run locally"},{"id":"b","text":"Replace the need for any human code review"},{"id":"c","text":"Automatically deploy every commit straight to production"},{"id":"d","text":"Speed up typing for developers"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-pipeline-02-o1-c1', 'mission-atlas-the-pipeline-02-o1', 1, 'terminal_simulation', 'Read the pipeline definition and submit the verification code.', '{"instructions":"Read /repo/.atlas-ci.yml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/.atlas-ci.yml":{"type":"file","content":"stages:\n  - build\n  - lint\n  - test\n  - security\n  - package\ntrigger: tag push matching v*\n# verification ANATOMY-3312\n"}}}'::jsonb, '{"requiredFlag":"ANATOMY-3312"}'::jsonb),

  ('mission-atlas-the-pipeline-03-o1-c1', 'mission-atlas-the-pipeline-03-o1', 1, 'terminal_simulation', 'Read the runner registry and submit the verification code.', '{"instructions":"Read /var/atlas-ci/runners.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/runners.txt":{"type":"file","content":"runner-01  status=idle    labels=linux,x86_64\nrunner-04  status=busy    labels=linux,x86_64  running=run-4471\nrunner-07  status=idle    labels=linux,arm64\n# verification RUNNER-8801\n"}}}'::jsonb, '{"requiredFlag":"RUNNER-8801"}'::jsonb),

  ('mission-atlas-the-pipeline-04-o1-c1', 'mission-atlas-the-pipeline-04-o1', 1, 'terminal_simulation', 'Read the build stage log and submit the verification code.', '{"instructions":"Read /var/atlas-ci/run-4471/build.log and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/run-4471/build.log":{"type":"file","content":"[build] compiling atlas-metrics-agent v12.1.0...\n[build] resolved locked dependencies from lockfile.txt\n[build] build succeeded\n# verification BUILD-4471\n"}}}'::jsonb, '{"requiredFlag":"BUILD-4471"}'::jsonb),

  ('mission-atlas-the-pipeline-05-o1-c1', 'mission-atlas-the-pipeline-05-o1', 1, 'terminal_simulation', 'Read the lint stage log and submit the verification code.', '{"instructions":"Read /var/atlas-ci/run-4471/lint.log and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/run-4471/lint.log":{"type":"file","content":"[lint] running static analysis...\n[lint] 0 errors, 0 warnings\n[lint] lint passed\n# verification LINT-4471\n"}}}'::jsonb, '{"requiredFlag":"LINT-4471"}'::jsonb),

  ('mission-atlas-the-pipeline-06-o1-c1', 'mission-atlas-the-pipeline-06-o1', 1, 'terminal_simulation', 'Read the test stage log and submit the verification code.', '{"instructions":"Read /var/atlas-ci/run-4471/test.log and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/run-4471/test.log":{"type":"file","content":"[test] running test suite...\n[test] 42 passed, 0 failed\n[test] tests passed\n# verification TEST-4471\n"}}}'::jsonb, '{"requiredFlag":"TEST-4471"}'::jsonb),

  ('mission-atlas-the-pipeline-07-o1-c1', 'mission-atlas-the-pipeline-07-o1', 1, 'terminal_simulation', 'Read the security stage log and submit the verification code.', '{"instructions":"Read /var/atlas-ci/run-4471/security.log and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/run-4471/security.log":{"type":"file","content":"[security] scanning for hardcoded secrets...\n[security] FAIL: possible live credential detected in config/collector-auth.yaml\n[security] pattern matched: AUTH_TOKEN=atl_live_9f2ac83e...\n[security] pipeline halted\n# verification SECURITY-4471\n"}}}'::jsonb, '{"requiredFlag":"SECURITY-4471"}'::jsonb),

  ('mission-atlas-the-pipeline-08-o1-c1', 'mission-atlas-the-pipeline-08-o1', 1, 'terminal_simulation', 'Read the run status and submit the verification code.', '{"instructions":"Read /var/atlas-ci/run-4471/status.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/run-4471/status.txt":{"type":"file","content":"run-4471 status:\n  build: PASS\n  lint: PASS\n  test: PASS\n  security: FAIL\n  package (artifact): SKIPPED -- blocked by failed security stage\n# verification STATUS-4471\n"}}}'::jsonb, '{"requiredFlag":"STATUS-4471"}'::jsonb),

  ('mission-atlas-the-pipeline-09-o1-c1', 'mission-atlas-the-pipeline-09-o1', 1, 'terminal_simulation', 'Read the cache report and submit the verification code.', '{"instructions":"Read /var/atlas-ci/run-4471/cache-report.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/run-4471/cache-report.txt":{"type":"file","content":"dependency cache: HIT (libatlas-collect, atlas-auth-sdk, json-shim all restored from cache)\ncache key: sha256 of lockfile.txt contents\ndependency step time: 4s (would be 61s on a cold cache)\n# verification CACHE-5541\n"}}}'::jsonb, '{"requiredFlag":"CACHE-5541"}'::jsonb),

  ('mission-atlas-the-pipeline-10-o1-c1', 'mission-atlas-the-pipeline-10-o1', 1, 'terminal_simulation', 'Read the run schedule and submit the verification code.', '{"instructions":"Read /var/atlas-ci/run-4471/parallel-schedule.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/run-4471/parallel-schedule.txt":{"type":"file","content":"schedule for run-4471:\n  build     00:00-00:04  (sequential, must finish first)\n  lint      00:04-00:06  (parallel, starts same moment as test/security)\n  test      00:04-00:11  (parallel, starts same moment as lint/security)\n  security  00:04-00:09  (parallel, starts same moment as lint/test)\n  package   blocked -- security failed\n# verification PARALLEL-2207\n"}}}'::jsonb, '{"requiredFlag":"PARALLEL-2207"}'::jsonb),

  ('mission-atlas-the-pipeline-11-o1-c1', 'mission-atlas-the-pipeline-11-o1', 1, 'terminal_simulation', 'Read the file that leaked the token and submit its verification code.', '{"instructions":"Read /repo/config/collector-auth.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/config/collector-auth.yaml":{"type":"file","content":"service: atlas-metrics-agent\nauth_token: atl_live_9f2ac83e7d41\n# NOTE: this should reference the Atlas secrets manager instead of a literal value\n# verification SECRET-9931\n"}}}'::jsonb, '{"requiredFlag":"SECRET-9931"}'::jsonb),

  ('mission-atlas-the-pipeline-12-o1-c1', 'mission-atlas-the-pipeline-12-o1', 1, 'terminal_simulation', 'Read the security stage log and submit the verification code.', '{"instructions":"Read /var/atlas-ci/run-4471/security.log and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/run-4471/security.log":{"type":"file","content":"[security] scanning for hardcoded secrets...\n[security] FAIL: possible live credential detected in config/collector-auth.yaml\n[security] pattern matched: AUTH_TOKEN=atl_live_9f2ac83e...\n[security] pipeline halted\n# verification SECURITY-4471\n"}}}'::jsonb, '{"requiredFlag":"SECURITY-4471"}'::jsonb),
  ('mission-atlas-the-pipeline-12-o2-c1', 'mission-atlas-the-pipeline-12-o2', 1, 'terminal_simulation', 'Read the flagged file and submit its verification code.', '{"instructions":"Read /repo/config/collector-auth.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/config/collector-auth.yaml":{"type":"file","content":"service: atlas-metrics-agent\nauth_token: atl_live_9f2ac83e7d41\n# NOTE: this should reference the Atlas secrets manager instead of a literal value\n# verification SECRET-9931\n"}}}'::jsonb, '{"requiredFlag":"SECRET-9931"}'::jsonb),
  ('mission-atlas-the-pipeline-12-o3-c1', 'mission-atlas-the-pipeline-12-o3', 1, 'investigation', 'Which evidence explains why no earlier check could have caught this?', '{"evidence":[{"id":"e1","label":"Local dev build log (Act 5)","detail":"The developer''s local build only ran the test suite -- no security scanning ever runs locally"},{"id":"e2","label":"PR review record (Act 4)","detail":"Rook''s review confirmed the image sizing was correct -- it did not include scanning file contents for credential patterns"},{"id":"e3","label":"Security stage log","detail":"An automated secret-pattern scan, which only runs as part of the pipeline itself, flagged a live token in config/collector-auth.yaml"},{"id":"e4","label":"Build and lint stage logs","detail":"Both passed cleanly -- the code compiles and is well-formed, which has nothing to do with whether it contains a secret"}],"question":"Which evidence explains why no earlier check could have caught this?"}'::jsonb, '{"requiredEvidenceIds":["e3"]}'::jsonb),
  ('mission-atlas-the-pipeline-12-o4-c1', 'mission-atlas-the-pipeline-12-o4', 1, 'boss_encounter', 'Having confirmed the security failure, the leaked credential, and why no earlier step could have caught it, explain what a pipeline is for and what has to happen next.', '{"stages":[{"objectiveRef":"mission-atlas-the-pipeline-12-o1","label":"Confirm the security stage failure"},{"objectiveRef":"mission-atlas-the-pipeline-12-o2","label":"Confirm the leaked credential"},{"objectiveRef":"mission-atlas-the-pipeline-12-o3","label":"Identify what only this stage could catch"}],"task":"State the diagnosis in one sentence: the pipeline is not wrong to be red -- its security stage caught a live, unrevoked authentication token hardcoded into the exact commit that fixed the image config, something no local build and no human review was ever capable of catching, and until that token is revoked and removed, v12.1.0 is not allowed anywhere near production, red build and all."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-the-pipeline-12-o1","mission-atlas-the-pipeline-12-o2","mission-atlas-the-pipeline-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-the-pipeline-01-o1-c1', 'orientation', 'Think about consistency across every change, not any one specific check.', 10, 1),
  ('mission-atlas-the-pipeline-01-o1-c1', 'solution', 'CI runs the same automated checks the same way on every change, regardless of who wrote it.', 20, 2),

  ('mission-atlas-the-pipeline-02-o1-c1', 'orientation', 'Try: cat /repo/.atlas-ci.yml', 10, 1),
  ('mission-atlas-the-pipeline-02-o1-c1', 'solution', 'The file ends with verification ANATOMY-3312. submit ANATOMY-3312', 20, 2),

  ('mission-atlas-the-pipeline-03-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/runners.txt', 10, 1),
  ('mission-atlas-the-pipeline-03-o1-c1', 'solution', 'runner-04 is running run-4471, verification RUNNER-8801. submit RUNNER-8801', 20, 2),

  ('mission-atlas-the-pipeline-04-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/run-4471/build.log', 10, 1),
  ('mission-atlas-the-pipeline-04-o1-c1', 'solution', 'The build succeeded, verification BUILD-4471. submit BUILD-4471', 20, 2),

  ('mission-atlas-the-pipeline-05-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/run-4471/lint.log', 10, 1),
  ('mission-atlas-the-pipeline-05-o1-c1', 'solution', 'Lint passed, verification LINT-4471. submit LINT-4471', 20, 2),

  ('mission-atlas-the-pipeline-06-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/run-4471/test.log', 10, 1),
  ('mission-atlas-the-pipeline-06-o1-c1', 'solution', 'All 42 tests passed, verification TEST-4471. submit TEST-4471', 20, 2),

  ('mission-atlas-the-pipeline-07-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/run-4471/security.log', 10, 1),
  ('mission-atlas-the-pipeline-07-o1-c1', 'solution', 'A live credential pattern was matched, verification SECURITY-4471. submit SECURITY-4471', 20, 2),

  ('mission-atlas-the-pipeline-08-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/run-4471/status.txt', 10, 1),
  ('mission-atlas-the-pipeline-08-o1-c1', 'solution', 'Package was skipped, blocked by the failed security stage, verification STATUS-4471. submit STATUS-4471', 20, 2),

  ('mission-atlas-the-pipeline-09-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/run-4471/cache-report.txt', 10, 1),
  ('mission-atlas-the-pipeline-09-o1-c1', 'solution', 'Dependencies were restored from cache, verification CACHE-5541. submit CACHE-5541', 20, 2),

  ('mission-atlas-the-pipeline-10-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/run-4471/parallel-schedule.txt', 10, 1),
  ('mission-atlas-the-pipeline-10-o1-c1', 'solution', 'Lint, test and security all start at the same timestamp, verification PARALLEL-2207. submit PARALLEL-2207', 20, 2),

  ('mission-atlas-the-pipeline-11-o1-c1', 'orientation', 'Try: cat /repo/config/collector-auth.yaml', 10, 1),
  ('mission-atlas-the-pipeline-11-o1-c1', 'solution', 'The file ends with verification SECRET-9931. submit SECRET-9931', 20, 2),

  ('mission-atlas-the-pipeline-12-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/run-4471/security.log', 10, 1),
  ('mission-atlas-the-pipeline-12-o1-c1', 'solution', 'verification SECURITY-4471. submit SECURITY-4471', 20, 2),
  ('mission-atlas-the-pipeline-12-o2-c1', 'orientation', 'Try: cat /repo/config/collector-auth.yaml', 10, 1),
  ('mission-atlas-the-pipeline-12-o2-c1', 'solution', 'verification SECRET-9931. submit SECRET-9931', 20, 2),
  ('mission-atlas-the-pipeline-12-o3-c1', 'orientation', 'Every earlier human step already happened on this exact commit. What kind of check was never one of them?', 10, 1),
  ('mission-atlas-the-pipeline-12-o3-c1', 'solution', 'e3: only the automated security scan, which runs solely inside the pipeline, was ever capable of catching a hardcoded secret.', 20, 2),
  ('mission-atlas-the-pipeline-12-o4-c1', 'orientation', 'Combine the failure, the credential, and why nothing earlier could have caught it into one sentence.', 15, 1),
  ('mission-atlas-the-pipeline-12-o4-c1', 'solution', 'The pipeline is right to be red -- it caught a live token no local build or human review could have, and that token has to be revoked before v12.1.0 is allowed anywhere near production.', 25, 2);
