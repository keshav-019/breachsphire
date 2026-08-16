-- Atlas Division pathway ("The Silence") Act 7 -- "Continuous Delivery"
-- content, under world-atlas-continuous-delivery (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), closing World II "The Factory" (Acts 4-7) and the entire
-- v12.1.0 arc running since Act 4.
--
-- Same terminal-engine constraint as Acts 4-6 -- every CD artifact here
-- (environment config, approval record, canary status, feature flag
-- config, migration-safety review, rollback runbook, release metrics)
-- is static seeded filesystem content read via `cat`. Purely
-- conceptual topics with no natural artifact (delivery vs deployment,
-- rolling, blue-green, progressive delivery) stay multiple_choice --
-- roughly even split with Act 2's ratio, since half this Act's topics
-- are release *strategies* (best taught conceptually) and half are
-- records of one specific release actually happening (best taught via
-- terminal_simulation).
--
-- Narrative thread: the leaked token from Act 6 is revoked, the
-- pipeline reruns clean, and this Act walks the resulting real artifact
-- through environments, approval, a canary rollout, and verified
-- release metrics -- finally landing v12.1.0 on metrics-collector-01
-- for real, closing the loop Act 3 opened. Second host introduced:
-- `atlas-deploy-01` (the deployment controller for this specific
-- release), alongside `atlas-devbox-01` (repo-side config, reused from
-- Acts 4-6).

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-continuous-delivery', 'world-atlas-continuous-delivery', 'continuous-delivery', '2D - Continuous Delivery', 'Learn how a proven artifact safely reaches production -- delivery versus deployment, environments, approvals, rolling, blue-green and canary releases, feature flags, migration safety, rollback, progressive delivery and release metrics -- while Rook and the team finally deliver v12.1.0, on a Friday.', 4);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-continuous-delivery-1', 'campaign-atlas-continuous-delivery', 'getting-an-artifact-there-safely', 'Getting an Artifact There Safely', 'Delivery versus deployment, environments, approvals, rolling, blue-green and canary releases.', 1),
  ('operation-atlas-continuous-delivery-2', 'campaign-atlas-continuous-delivery', 'proving-it-was-safe', 'Proving It Was Safe', 'Feature flags, migration safety, rollback, progressive delivery and release metrics.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-continuous-delivery-01', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-1', 'delivery-vs-deployment', 'Delivery vs Deployment', 'The token is revoked. The pipeline reruns clean -- for the first time in this whole story, a real signed artifact for v12.1.0 exists. It is also Friday afternoon.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"delivery-vs-deployment-sim"}'::jsonb, '{"xp":200,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-continuous-delivery-02', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-1', 'environments', 'Environments', 'A releasable artifact does not go straight to production. Confirm exactly where v12.1.0 already is, and where it still is not.', 'beginner', ARRAY['rook','vey'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"environments-sim"}'::jsonb, '{"xp":200,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-continuous-delivery-03', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-1', 'approvals', 'Approvals', 'Staging has been healthy for 48 hours. Confirm production is actually cleared to proceed, and by whom.', 'beginner', ARRAY['rook','leena'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"approvals-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-continuous-delivery-04', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-1', 'rolling', 'Rolling', 'One strategy for actually cutting over: replace instances gradually, not all at once.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"rolling-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-continuous-delivery-05', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-1', 'blue-green', 'Blue-Green', 'A second strategy: two complete environments, one live, one standing by, switched all at once.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"blue-green-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-continuous-delivery-06', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-1', 'canary', 'Canary', 'For a release this important, the team is not choosing all-at-once or gradual-by-instance. Confirm what they actually chose instead.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"canary-sim"}'::jsonb, '{"xp":220,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-continuous-delivery-07', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-2', 'feature-flags', 'Feature Flags', 'Confirm what lets the resized image take effect without needing an entirely new deployment if anything looks wrong.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"feature-flags-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-continuous-delivery-08', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-2', 'migration-safety', 'Migration Safety', 'Before anything ships, confirm this change can actually be undone cleanly if it has to be.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"migration-safety-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-continuous-delivery-09', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-2', 'rollback', 'Rollback', 'Confirm a rollback target actually exists and has already been tested, before this ever reaches 100% traffic.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"rollback-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-continuous-delivery-10', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-2', 'progressive-delivery', 'Progressive Delivery', 'Canary, flags and rollback are not three separate safety nets used one at a time. Understand how they work as one continuous strategy.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"progressive-delivery-sim"}'::jsonb, '{"xp":240,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-continuous-delivery-11', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-2', 'release-metrics', 'Release Metrics', 'The canary has been live a while now. Confirm what the collector''s own metrics actually say.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"release-metrics-sim"}'::jsonb, '{"xp":250,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-continuous-delivery-12', 'world-atlas-continuous-delivery', 'campaign-atlas-continuous-delivery', 'operation-atlas-continuous-delivery-2', 'friday-deployment', 'Friday Deployment', 'Everything this World taught, on the one day everyone is afraid to ship. Not to rush it, to finally prove what actually makes a deployment safe -- and complete the fix that started with a dying host four Acts ago.', 'boss', ARRAY['rook','leena','cross','byte'], '{"requiredMissionIds":["mission-atlas-continuous-delivery-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"friday-deployment-boss-sim"}'::jsonb, '{"xp":480,"credits":110,"badgeIds":["friday-deployment"],"skillXp":{"cloud_devops_fundamentals":80}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-continuous-delivery-01', 1, 'leena', 'The token is revoked. The pipeline reran clean -- build, lint, test, security, all of it. For the first time in this entire story, a real signed artifact for v12.1.0 exists.'),
  ('mission-atlas-continuous-delivery-01', 2, 'rook', 'And it is Friday afternoon, and I can already feel everyone deciding this should wait until Monday out of habit.'),
  ('mission-atlas-continuous-delivery-01', 3, 'rook', 'Delivery and deployment are not the same claim. Delivery means this artifact is proven, tested and ready to release at any moment. Deployment is the separate, deliberate act of actually putting it somewhere live. Having one does not obligate you to rush the other -- but it does mean waiting is a choice now, not a necessity.'),

  ('mission-atlas-continuous-delivery-02', 1, 'vey', 'Tomas Vey. I have not had a reason to be back since Act 2 -- but environments are squarely mine. Confirm exactly where this artifact already lives before anyone talks about production.'),
  ('mission-atlas-continuous-delivery-02', 2, 'rook', 'A releasable artifact does not jump straight to production. It moves through environments in order -- dev, staging, then production -- each one a closer approximation of the real thing.'),

  ('mission-atlas-continuous-delivery-03', 1, 'rook', 'Staging being healthy is not the same as production being cleared. Someone still has to actually approve this specific release for this specific environment.'),
  ('mission-atlas-continuous-delivery-03', 2, 'leena', 'That someone is me, and I already have. Confirm it.'),

  ('mission-atlas-continuous-delivery-04', 1, 'rook', 'A rolling deployment replaces running instances gradually, a few at a time, until every one is on the new version. No full outage, but old and new versions do briefly serve traffic side by side.'),

  ('mission-atlas-continuous-delivery-05', 1, 'rook', 'Blue-green keeps two complete environments instead -- one fully live, one fully idle and ready. Releasing means starting the idle one up completely, then switching all traffic over in one move, with the old one still standing by as an instant way back.'),

  ('mission-atlas-continuous-delivery-06', 1, 'cross', 'Imani Cross. For something this important, gradual-by-instance or all-at-once are both too coarse. Confirm what the team actually chose.'),
  ('mission-atlas-continuous-delivery-06', 2, 'rook', 'A canary release sends the change to a small slice of real traffic first, watches it, and only expands if it stays healthy. Small blast radius, real signal, before anyone commits to the rest.'),

  ('mission-atlas-continuous-delivery-07', 1, 'rook', 'A feature flag decouples releasing code from releasing behavior. The resized config can already be deployed everywhere and still be toggled off instantly, without a new deployment, if anything looks wrong.'),

  ('mission-atlas-continuous-delivery-08', 1, 'rook', 'Nothing ships without confirming it can be undone. This particular change has no schema to worry about -- but confirm that in writing before assuming it.'),

  ('mission-atlas-continuous-delivery-09', 1, 'cross', 'A rollback plan that has never actually been tested is a guess, not a plan. Confirm a real target exists and has actually been exercised.'),

  ('mission-atlas-continuous-delivery-10', 1, 'rook', 'Canary, flags and rollback are not three separate safety nets you reach for one at a time. Progressive delivery is running all of them together, continuously, with automated metrics deciding whether to keep expanding or pull back -- not a person eyeballing a dashboard and hoping.'),

  ('mission-atlas-continuous-delivery-11', 1, 'cross', 'The canary has been live a while now. Confirm what the collector''s own numbers actually say, not what anyone expects them to say.'),

  ('mission-atlas-continuous-delivery-12', 1, 'leena', 'Everything this World taught you, on the one day everyone is afraid to ship. Not to rush it -- to finally prove what actually makes a deployment safe, and finish what started with a dying host four Acts ago.'),
  ('mission-atlas-continuous-delivery-12', 2, 'byte', 'I have the canary status, the collector''s live metrics and the tested rollback runbook all pulled up together. Every safeguard this World taught you is already sitting in place.'),
  ('mission-atlas-continuous-delivery-12', 3, 'cross', 'Fear of Friday was never really about the calendar. It was fear of deploying without any of this. Confirm whether that fear still applies here.'),
  ('mission-atlas-continuous-delivery-12', 4, 'rook', 'Complete the rollout, and say plainly what actually made it safe to do today.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-continuous-delivery-01-o1', 'mission-atlas-continuous-delivery-01', 1, 'Tell delivery from deployment', 'Choose the accurate distinction between continuous delivery and deployment.'),

  ('mission-atlas-continuous-delivery-02-o1', 'mission-atlas-continuous-delivery-02', 1, 'Check environment status', 'Read the environments file and submit the verification code.'),

  ('mission-atlas-continuous-delivery-03-o1', 'mission-atlas-continuous-delivery-03', 1, 'Confirm the production approval', 'Read the approval record and submit the verification code.'),

  ('mission-atlas-continuous-delivery-04-o1', 'mission-atlas-continuous-delivery-04', 1, 'Explain rolling deployment', 'Choose the accurate description of a rolling deployment.'),

  ('mission-atlas-continuous-delivery-05-o1', 'mission-atlas-continuous-delivery-05', 1, 'Explain blue-green deployment', 'Choose the accurate description of a blue-green deployment.'),

  ('mission-atlas-continuous-delivery-06-o1', 'mission-atlas-continuous-delivery-06', 1, 'Check the canary rollout', 'Read the canary status and submit the verification code.'),

  ('mission-atlas-continuous-delivery-07-o1', 'mission-atlas-continuous-delivery-07', 1, 'Check the feature flag', 'Read the feature flag configuration and submit the verification code.'),

  ('mission-atlas-continuous-delivery-08-o1', 'mission-atlas-continuous-delivery-08', 1, 'Check the migration-safety review', 'Read the migration-safety review and submit the verification code.'),

  ('mission-atlas-continuous-delivery-09-o1', 'mission-atlas-continuous-delivery-09', 1, 'Check the rollback runbook', 'Read the rollback runbook and submit the verification code.'),

  ('mission-atlas-continuous-delivery-10-o1', 'mission-atlas-continuous-delivery-10', 1, 'Explain progressive delivery', 'Choose the accurate description of progressive delivery.'),

  ('mission-atlas-continuous-delivery-11-o1', 'mission-atlas-continuous-delivery-11', 1, 'Check release metrics', 'Read the release metrics and submit the verification code.'),

  ('mission-atlas-continuous-delivery-12-o1', 'mission-atlas-continuous-delivery-12', 1, 'Confirm the canary is complete', 'Read the canary status and submit the verification code.'),
  ('mission-atlas-continuous-delivery-12-o2', 'mission-atlas-continuous-delivery-12', 2, 'Confirm the collector is healthy', 'Read the release metrics and submit the verification code.'),
  ('mission-atlas-continuous-delivery-12-o3', 'mission-atlas-continuous-delivery-12', 3, 'Identify what actually makes this safe', 'Find the evidence that explains why deploying today is safe, regardless of the day of the week.'),
  ('mission-atlas-continuous-delivery-12-o4', 'mission-atlas-continuous-delivery-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually made this deployment safe.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-continuous-delivery-01-o1-c1', 'mission-atlas-continuous-delivery-01-o1', 1, 'multiple_choice', 'Continuous delivery and continuous deployment differ in that...', '{"question":"Continuous delivery and continuous deployment differ in that...","options":[{"id":"a","text":"Delivery means every change is kept in an always-releasable state; deployment is the separate, deliberate act of actually putting a specific release into a running environment"},{"id":"b","text":"They are identical terms for the same process"},{"id":"c","text":"Delivery only applies to mobile apps, deployment only applies to servers"},{"id":"d","text":"Deployment always happens before delivery"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-continuous-delivery-02-o1-c1', 'mission-atlas-continuous-delivery-02-o1', 1, 'terminal_simulation', 'Read the environments file and submit the verification code.', '{"instructions":"Read /repo/environments.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/environments.txt":{"type":"file","content":"dev          image=atlas-image-v12.1.0       auto-deploy=true\nstaging      image=atlas-image-v12.1.0       auto-deploy=true (after dev healthy)\nproduction   image=atlas-image-v12.0.0-test  auto-deploy=false (requires approval)\n# verification ENV-3341\n"}}}'::jsonb, '{"requiredFlag":"ENV-3341"}'::jsonb),

  ('mission-atlas-continuous-delivery-03-o1-c1', 'mission-atlas-continuous-delivery-03-o1', 1, 'terminal_simulation', 'Read the approval record and submit the verification code.', '{"instructions":"Read /var/atlas-deploy/approvals.txt and submit the verification code with: submit CODE","hostname":"atlas-deploy-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-deploy-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-deploy/approvals.txt":{"type":"file","content":"production approval required for: atlas-image-v12.1.0 -> metrics-collector-01\napprover: leena  decision: APPROVED\nnote: \"staging has been healthy for 48h, cleared to proceed\"\n# verification APPROVAL-7712\n"}}}'::jsonb, '{"requiredFlag":"APPROVAL-7712"}'::jsonb),

  ('mission-atlas-continuous-delivery-04-o1-c1', 'mission-atlas-continuous-delivery-04-o1', 1, 'multiple_choice', 'A rolling deployment is best described as...', '{"question":"A rolling deployment is best described as...","options":[{"id":"a","text":"Replacing running instances gradually, a few at a time, with old and new versions briefly serving traffic side by side until every instance is updated"},{"id":"b","text":"Deleting all instances at once, then starting new ones"},{"id":"c","text":"Keeping a second complete idle environment on standby"},{"id":"d","text":"Sending traffic to a single small slice of new instances only"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-continuous-delivery-05-o1-c1', 'mission-atlas-continuous-delivery-05-o1', 1, 'multiple_choice', 'A blue-green deployment is best described as...', '{"question":"A blue-green deployment is best described as...","options":[{"id":"a","text":"Keeping two complete environments, only one live at a time, and switching all traffic to the new one at once while the old one stands by as an instant rollback"},{"id":"b","text":"Replacing instances one at a time until every one is updated"},{"id":"c","text":"Sending 5% of traffic to the new version first and expanding gradually"},{"id":"d","text":"A synonym for a rolling deployment"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-continuous-delivery-06-o1-c1', 'mission-atlas-continuous-delivery-06-o1', 1, 'terminal_simulation', 'Read the canary status and submit the verification code.', '{"instructions":"Read /var/atlas-deploy/canary-status.txt and submit the verification code with: submit CODE","hostname":"atlas-deploy-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-deploy-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-deploy/canary-status.txt":{"type":"file","content":"canary rollout: atlas-image-v12.1.0 -> metrics-collector-01\nstage 1: 5% of traffic   status=healthy  duration=15m\nstage 2: 25% of traffic  status=healthy  duration=15m\nstage 3: 100% of traffic status=in-progress\n# verification CANARY-2291\n"}}}'::jsonb, '{"requiredFlag":"CANARY-2291"}'::jsonb),

  ('mission-atlas-continuous-delivery-07-o1-c1', 'mission-atlas-continuous-delivery-07-o1', 1, 'terminal_simulation', 'Read the feature flag configuration and submit the verification code.', '{"instructions":"Read /repo/feature-flags.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/feature-flags.txt":{"type":"file","content":"flag: resized-image-tier\n  enabled: true\n  scope: metrics-collector-01\n  note: lets the resize take effect independently of the deployment itself -- can be disabled instantly without a new deployment if something looks wrong\n# verification FLAG-6603\n"}}}'::jsonb, '{"requiredFlag":"FLAG-6603"}'::jsonb),

  ('mission-atlas-continuous-delivery-08-o1-c1', 'mission-atlas-continuous-delivery-08-o1', 1, 'terminal_simulation', 'Read the migration-safety review and submit the verification code.', '{"instructions":"Read /repo/migration-plan.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/migration-plan.txt":{"type":"file","content":"migration-safety review for v12.1.0:\n  schema changes: none\n  config changes: cpu_limit 1->2, memory_limit_mb 512->2048 (additive, backward compatible)\n  rollback-safe: yes -- v12.0.0-test can resume immediately with no data loss\n# verification MIGRATE-4471\n"}}}'::jsonb, '{"requiredFlag":"MIGRATE-4471"}'::jsonb),

  ('mission-atlas-continuous-delivery-09-o1-c1', 'mission-atlas-continuous-delivery-09-o1', 1, 'terminal_simulation', 'Read the rollback runbook and submit the verification code.', '{"instructions":"Read /var/atlas-deploy/rollback-runbook.txt and submit the verification code with: submit CODE","hostname":"atlas-deploy-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-deploy-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-deploy/rollback-runbook.txt":{"type":"file","content":"rollback target: atlas-image-v12.0.0-test.tar.gz  (signed, checksummed, still stored)\nrollback procedure: repoint desiredImageTag to v12.0.0-test, redeploy -- tested in staging, completes in under 90 seconds\n# verification ROLLBACK-8814\n"}}}'::jsonb, '{"requiredFlag":"ROLLBACK-8814"}'::jsonb),

  ('mission-atlas-continuous-delivery-10-o1-c1', 'mission-atlas-continuous-delivery-10-o1', 1, 'multiple_choice', 'Progressive delivery is best described as...', '{"question":"Progressive delivery is best described as...","options":[{"id":"a","text":"Running canary rollout, feature flags and rollback readiness together continuously, with metrics automatically deciding whether to keep expanding or pull back"},{"id":"b","text":"A synonym for continuous integration"},{"id":"c","text":"Deploying to 100% of traffic immediately and monitoring afterward"},{"id":"d","text":"Manually watching a dashboard and deciding by feel"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-continuous-delivery-11-o1-c1', 'mission-atlas-continuous-delivery-11-o1', 1, 'terminal_simulation', 'Read the release metrics and submit the verification code.', '{"instructions":"Read /var/atlas-deploy/release-metrics.txt and submit the verification code with: submit CODE","hostname":"atlas-deploy-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-deploy-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-deploy/release-metrics.txt":{"type":"file","content":"metrics-collector-01, canary traffic, atlas-image-v12.1.0:\n  cpu: 34%    (was 97%+ under v12.0.0-test)\n  memory: 41% (was 91%+ under v12.0.0-test)\n  disk growth: normal\n  error rate: 0.0%\n# verification METRICS-9021\n"}}}'::jsonb, '{"requiredFlag":"METRICS-9021"}'::jsonb),

  ('mission-atlas-continuous-delivery-12-o1-c1', 'mission-atlas-continuous-delivery-12-o1', 1, 'terminal_simulation', 'Read the canary status and submit the verification code.', '{"instructions":"Read /var/atlas-deploy/canary-status.txt and submit the verification code with: submit CODE","hostname":"atlas-deploy-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-deploy-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-deploy/canary-status.txt":{"type":"file","content":"canary rollout: atlas-image-v12.1.0 -> metrics-collector-01\nstage 1: 5% of traffic   status=healthy  duration=15m\nstage 2: 25% of traffic  status=healthy  duration=15m\nstage 3: 100% of traffic status=healthy  duration=15m\nrollout: COMPLETE\n# verification CANARY-9981\n"}}}'::jsonb, '{"requiredFlag":"CANARY-9981"}'::jsonb),
  ('mission-atlas-continuous-delivery-12-o2-c1', 'mission-atlas-continuous-delivery-12-o2', 1, 'terminal_simulation', 'Read the release metrics and submit the verification code.', '{"instructions":"Read /var/atlas-deploy/release-metrics.txt and submit the verification code with: submit CODE","hostname":"atlas-deploy-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-deploy-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-deploy/release-metrics.txt":{"type":"file","content":"metrics-collector-01, 100% traffic, atlas-image-v12.1.0:\n  cpu: 31%    (was 97%+ under v12.0.0-test)\n  memory: 39% (was 91%+ under v12.0.0-test)\n  disk growth: normal\n  error rate: 0.0%\n# verification METRICS-4471\n"}}}'::jsonb, '{"requiredFlag":"METRICS-4471"}'::jsonb),
  ('mission-atlas-continuous-delivery-12-o3-c1', 'mission-atlas-continuous-delivery-12-o3', 1, 'investigation', 'Which evidence explains why deploying today is actually safe, regardless of the day of the week?', '{"evidence":[{"id":"e1","label":"Canary rollout status","detail":"Traffic was expanded gradually in three stages, each confirmed healthy before the next, rather than released all at once"},{"id":"e2","label":"Rollback runbook","detail":"A tested rollback target already exists and completes in under 90 seconds if anything goes wrong"},{"id":"e3","label":"Calendar","detail":"Today is Friday"},{"id":"e4","label":"Release metrics","detail":"CPU, memory and error rate are all healthy at 100% traffic, confirming the fix actually works under real load"}],"question":"Which evidence explains why deploying today is actually safe, regardless of the day of the week?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2","e4"]}'::jsonb),
  ('mission-atlas-continuous-delivery-12-o4-c1', 'mission-atlas-continuous-delivery-12-o4', 1, 'boss_encounter', 'Having confirmed the canary is complete, the collector is healthy, and what actually makes this safe, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-continuous-delivery-12-o1","label":"Confirm the canary is complete"},{"objectiveRef":"mission-atlas-continuous-delivery-12-o2","label":"Confirm the collector is healthy"},{"objectiveRef":"mission-atlas-continuous-delivery-12-o3","label":"Identify what actually makes this safe"}],"task":"State the diagnosis in one sentence: nothing about Friday itself was ever the real danger -- a gradual canary rollout, a tested rollback runbook, and real metrics confirming the collector is healthy under full load are what actually make any deployment safe, and with all three in place, v12.1.0 has finally, safely reached metrics-collector-01, completing the exact resize that should have happened back in Act 3."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-continuous-delivery-12-o1","mission-atlas-continuous-delivery-12-o2","mission-atlas-continuous-delivery-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-continuous-delivery-01-o1-c1', 'orientation', 'Think about "ready to ship" versus "actually shipped."', 10, 1),
  ('mission-atlas-continuous-delivery-01-o1-c1', 'solution', 'Delivery is always-releasable; deployment is the separate act of actually releasing.', 20, 2),

  ('mission-atlas-continuous-delivery-02-o1-c1', 'orientation', 'Try: cat /repo/environments.txt', 10, 1),
  ('mission-atlas-continuous-delivery-02-o1-c1', 'solution', 'Production is still on the old image, verification ENV-3341. submit ENV-3341', 20, 2),

  ('mission-atlas-continuous-delivery-03-o1-c1', 'orientation', 'Try: cat /var/atlas-deploy/approvals.txt', 10, 1),
  ('mission-atlas-continuous-delivery-03-o1-c1', 'solution', 'Leena approved it, verification APPROVAL-7712. submit APPROVAL-7712', 20, 2),

  ('mission-atlas-continuous-delivery-04-o1-c1', 'orientation', 'Think about instances being replaced a few at a time, not all together.', 10, 1),
  ('mission-atlas-continuous-delivery-04-o1-c1', 'solution', 'Rolling replaces instances gradually, old and new briefly coexisting.', 20, 2),

  ('mission-atlas-continuous-delivery-05-o1-c1', 'orientation', 'Think about two full environments and one switch.', 10, 1),
  ('mission-atlas-continuous-delivery-05-o1-c1', 'solution', 'Blue-green keeps two complete environments and switches all traffic at once.', 20, 2),

  ('mission-atlas-continuous-delivery-06-o1-c1', 'orientation', 'Try: cat /var/atlas-deploy/canary-status.txt', 10, 1),
  ('mission-atlas-continuous-delivery-06-o1-c1', 'solution', 'Stage 3 (100%) is in progress, verification CANARY-2291. submit CANARY-2291', 20, 2),

  ('mission-atlas-continuous-delivery-07-o1-c1', 'orientation', 'Try: cat /repo/feature-flags.txt', 10, 1),
  ('mission-atlas-continuous-delivery-07-o1-c1', 'solution', 'The flag is enabled and instantly toggleable, verification FLAG-6603. submit FLAG-6603', 20, 2),

  ('mission-atlas-continuous-delivery-08-o1-c1', 'orientation', 'Try: cat /repo/migration-plan.txt', 10, 1),
  ('mission-atlas-continuous-delivery-08-o1-c1', 'solution', 'No schema changes, rollback-safe, verification MIGRATE-4471. submit MIGRATE-4471', 20, 2),

  ('mission-atlas-continuous-delivery-09-o1-c1', 'orientation', 'Try: cat /var/atlas-deploy/rollback-runbook.txt', 10, 1),
  ('mission-atlas-continuous-delivery-09-o1-c1', 'solution', 'A tested target exists, verification ROLLBACK-8814. submit ROLLBACK-8814', 20, 2),

  ('mission-atlas-continuous-delivery-10-o1-c1', 'orientation', 'Think about canary, flags and rollback working together automatically, not one at a time by hand.', 10, 1),
  ('mission-atlas-continuous-delivery-10-o1-c1', 'solution', 'Progressive delivery combines them continuously with automated metrics-based gating.', 20, 2),

  ('mission-atlas-continuous-delivery-11-o1-c1', 'orientation', 'Try: cat /var/atlas-deploy/release-metrics.txt', 10, 1),
  ('mission-atlas-continuous-delivery-11-o1-c1', 'solution', 'CPU and memory are both healthy, verification METRICS-9021. submit METRICS-9021', 20, 2),

  ('mission-atlas-continuous-delivery-12-o1-c1', 'orientation', 'Try: cat /var/atlas-deploy/canary-status.txt', 10, 1),
  ('mission-atlas-continuous-delivery-12-o1-c1', 'solution', 'The rollout is complete, verification CANARY-9981. submit CANARY-9981', 20, 2),
  ('mission-atlas-continuous-delivery-12-o2-c1', 'orientation', 'Try: cat /var/atlas-deploy/release-metrics.txt', 10, 1),
  ('mission-atlas-continuous-delivery-12-o2-c1', 'solution', 'CPU, memory and error rate are all healthy at full traffic, verification METRICS-4471. submit METRICS-4471', 20, 2),
  ('mission-atlas-continuous-delivery-12-o3-c1', 'orientation', 'The calendar date is not evidence of anything. Look for what was actually engineered to make this safe.', 10, 1),
  ('mission-atlas-continuous-delivery-12-o3-c1', 'solution', 'e1, e2 and e4: gradual canary rollout, a tested rollback, and confirmed-healthy metrics -- not the day of the week.', 20, 2),
  ('mission-atlas-continuous-delivery-12-o4-c1', 'orientation', 'Combine the completed canary, the healthy metrics, and what actually made it safe into one sentence.', 15, 1),
  ('mission-atlas-continuous-delivery-12-o4-c1', 'solution', 'A gradual canary rollout, a tested rollback runbook and confirmed-healthy metrics under full load are what made this safe -- not the calendar -- and v12.1.0 has finally, safely reached metrics-collector-01.', 25, 2);
