-- Atlas Division pathway ("The Silence") Act 28 -- "Chaos" content,
-- under world-atlas-chaos (already inserted separately). 1 campaign,
-- 2 operations, 12 missions (11 lessons + boss), continuing World VIII
-- "The Failure Zone".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- chaos-engineering artifact here is static seeded text read via `cat`.
-- Two hosts, both reused: `atlas-devbox-01`, now also hosting a new
-- `chaos/` directory inside the Act 22 `infra-envs` GitOps repo
-- (hypotheses, the toolkit config, and every experiment result), and
-- `atlas-observability-01` for the region-wide game day itself (the
-- execution log and the resilience-check result). Concept-only topics
-- with no natural single artifact (chaos principles, game days) stay
-- multiple_choice.
--
-- Narrative thread: mission 8 (zone failure) plants the actual gap as a
-- plain fact in the game day plan -- atlas-metrics-db is single-AZ, no
-- replica -- well before the boss frames it as a problem. The boss
-- deliberately confirms the resilience-check result (`e2`) as proof every
-- Act 27 pattern worked, and explicitly rules it out as the explanation
-- for the database itself staying down; the actual explanation requires
-- both the missing cross-AZ replica and the fact that only a slow restore
-- exists as a fallback (`e3` + `e4`) -- the same "the pattern worked,
-- something underneath it was never built" shape as the world''s own
-- story_reveal.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-chaos', 'world-atlas-chaos', 'chaos', '8C - Chaos', 'Learn chaos engineering from first principles -- hypotheses, failure injection, killing instances, latency, packet loss, dependency failure, zone failure, backup tests and restore drills -- and run this fleet''s first region-wide game day to find out whether Act 27''s resilience patterns actually hold under real, deliberately injected failure.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-chaos-1', 'campaign-atlas-chaos', 'break-it-on-purpose', 'Break It On Purpose', 'Chaos principles, hypotheses, failure injection, kill instances, latency and packet loss.', 1),
  ('operation-atlas-chaos-2', 'campaign-atlas-chaos', 'prove-it-under-real-failure', 'Prove It Under Real Failure', 'Dependency failure, zone failure, backup tests, restore drills, game days and the region-wide game day itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-chaos-01', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-1', 'chaos-principles', 'Chaos Principles', 'Every resilience pattern this fleet built in Act 27 has only ever been tested on paper. Cross wants to test it for real.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"chaos-principles-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-chaos-02', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-1', 'hypotheses', 'Hypotheses', 'Confirm what a real chaos experiment actually has to state, in writing, before anything gets broken on purpose.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-chaos-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"hypotheses-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-chaos-03', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-1', 'failure-injection', 'Failure Injection', 'Confirm exactly which real faults this fleet''s own chaos toolkit is actually capable of injecting.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-chaos-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"failure-injection-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-chaos-04', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-1', 'kill-instances', 'Kill Instances', 'Confirm what actually happened when the first real experiment terminated a live collector instance on purpose.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-chaos-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"kill-instances-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-chaos-05', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-1', 'latency', 'Latency', 'Confirm what actually happened when a real dependency call was made artificially, deliberately slow.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-chaos-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"latency-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-chaos-06', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-1', 'packet-loss', 'Packet Loss', 'Confirm exactly how much dropped traffic this fleet can actually absorb before it starts to show.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-chaos-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"packet-loss-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-chaos-07', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-2', 'dependency-failure', 'Dependency Failure', 'Confirm what actually happened when every call to atlas-metrics-db was blocked outright, on purpose, for a full experiment.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-chaos-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"dependency-failure-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-chaos-08', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-2', 'zone-failure', 'Zone Failure', 'Confirm exactly what the plan for this fleet''s first region-wide game day actually commits to failing.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-chaos-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"zone-failure-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-chaos-09', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-2', 'backup-tests', 'Backup Tests', 'Confirm that atlas-metrics-db''s backups actually exist, are actually scheduled, and are actually valid.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-chaos-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"backup-tests-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-chaos-10', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-2', 'restore-drills', 'Restore Drills', 'Confirm how long an actual restore from that backup actually took, start to finish, with nothing assumed.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-chaos-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"restore-drills-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-chaos-11', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-2', 'game-days', 'Game Days', 'Understand what actually separates a real game day from one engineer breaking things alone with no one watching.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-chaos-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"game-days-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-chaos-12', 'world-atlas-chaos', 'campaign-atlas-chaos', 'operation-atlas-chaos-2', 'burn-the-region', 'Burn the Region', 'Everything this Act taught, turned on one entire availability zone: not to just confirm the resilience patterns held, to explain what stayed broken anyway.', 'boss', ARRAY['cross','rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-chaos-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"burn-the-region-boss-sim"}'::jsonb, '{"xp":830,"credits":200,"badgeIds":["burn-the-region"],"skillXp":{"cloud_devops_fundamentals":130}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-chaos-01', 1, 'leena', 'Every resilience pattern this fleet built in Act 27 has only ever been tested on paper. Nobody has actually broken anything on purpose to find out if it holds.'),
  ('mission-atlas-chaos-01', 2, 'cross', 'Imani Cross. That is exactly the gap chaos engineering exists to close -- injecting real failure, deliberately and carefully, specifically to build confidence a system survives what it claims to survive. Not recklessness. The opposite of it.'),

  ('mission-atlas-chaos-02', 1, 'cross', 'Before anything gets broken on purpose, confirm what a real hypothesis for one of these experiments actually has to state in writing first.'),

  ('mission-atlas-chaos-03', 1, 'cross', 'Confirm exactly which real faults this fleet''s own chaos toolkit is actually capable of injecting before picking one to run.'),

  ('mission-atlas-chaos-04', 1, 'rook', 'The first real experiment terminated one live collector instance on purpose, mid-traffic. Confirm what the fleet actually did about it.'),

  ('mission-atlas-chaos-05', 1, 'cross', 'This time the experiment did not remove a dependency -- it just made one call artificially, deliberately slow. Confirm what actually happened.'),

  ('mission-atlas-chaos-06', 1, 'cross', 'Confirm exactly how much dropped traffic this fleet can actually absorb before it starts to visibly degrade.'),

  ('mission-atlas-chaos-07', 1, 'rook', 'Every call to atlas-metrics-db was blocked outright this time, on purpose, for the full length of one experiment -- not just slowed down. Confirm what the collector actually did about it.'),

  ('mission-atlas-chaos-08', 1, 'rook', 'The next experiment is not one dependency anymore. It is an entire availability zone. Confirm exactly what the plan actually commits this fleet to failing on purpose.'),

  ('mission-atlas-chaos-09', 1, 'rook', 'Before failing an entire zone on purpose, confirm atlas-metrics-db''s own backups actually exist, are actually scheduled, and are actually valid -- not just assumed to be.'),

  ('mission-atlas-chaos-10', 1, 'rook', 'A backup that has never actually been restored is still just an assumption. Confirm how long a real restore from it actually took, start to finish.'),

  ('mission-atlas-chaos-11', 1, 'cross', 'A real game day is scheduled, cross-team, has a defined blast radius and a rollback plan, and runs with people actually watching live -- not one engineer quietly breaking things alone.'),

  ('mission-atlas-chaos-12', 1, 'leena', 'Everything this Act taught you, turned on one entire availability zone. Not just to confirm the resilience patterns held -- to explain what stayed broken anyway.'),
  ('mission-atlas-chaos-12', 2, 'byte', 'I have the full game day execution log and the resilience-check result both pulled up together. Every Act 27 pattern is confirmed working, start to finish.'),
  ('mission-atlas-chaos-12', 3, 'cross', 'The circuit breaker, the bulkheads, the graceful degradation -- all of it held for the full ninety minutes. That was never the failure here.'),
  ('mission-atlas-chaos-12', 4, 'rook', 'Then find what actually stayed down the entire time anyway, and why nothing built so far was ever going to fix it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-chaos-01-o1', 'mission-atlas-chaos-01', 1, 'Explain chaos engineering', 'Choose the accurate description of what chaos engineering actually is.'),

  ('mission-atlas-chaos-02-o1', 'mission-atlas-chaos-02', 1, 'Read the hypothesis log', 'Read the chaos experiment hypothesis and submit the verification code.'),

  ('mission-atlas-chaos-03-o1', 'mission-atlas-chaos-03', 1, 'Read the toolkit config', 'Read the chaos toolkit configuration and submit the verification code.'),

  ('mission-atlas-chaos-04-o1', 'mission-atlas-chaos-04', 1, 'Read the kill-instance result', 'Read the kill-instance experiment result and submit the verification code.'),

  ('mission-atlas-chaos-05-o1', 'mission-atlas-chaos-05', 1, 'Read the latency result', 'Read the latency-injection experiment result and submit the verification code.'),

  ('mission-atlas-chaos-06-o1', 'mission-atlas-chaos-06', 1, 'Read the packet-loss result', 'Read the packet-loss experiment result and submit the verification code.'),

  ('mission-atlas-chaos-07-o1', 'mission-atlas-chaos-07', 1, 'Read the dependency-failure result', 'Read the dependency-failure experiment result and submit the verification code.'),

  ('mission-atlas-chaos-08-o1', 'mission-atlas-chaos-08', 1, 'Read the zone-failure plan', 'Read the region-wide game day plan and submit the verification code.'),

  ('mission-atlas-chaos-09-o1', 'mission-atlas-chaos-09', 1, 'Read the backup verification', 'Read the backup verification log and submit the verification code.'),

  ('mission-atlas-chaos-10-o1', 'mission-atlas-chaos-10', 1, 'Read the restore drill result', 'Read the restore drill result and submit the verification code.'),

  ('mission-atlas-chaos-11-o1', 'mission-atlas-chaos-11', 1, 'Explain game days', 'Choose the accurate description of what actually separates a real game day from an unplanned experiment.'),

  ('mission-atlas-chaos-12-o1', 'mission-atlas-chaos-12', 1, 'Confirm the game day execution log', 'Read the game day execution log and submit the verification code.'),
  ('mission-atlas-chaos-12-o2', 'mission-atlas-chaos-12', 2, 'Confirm the resilience-check result', 'Read the resilience-check result and submit the verification code.'),
  ('mission-atlas-chaos-12-o3', 'mission-atlas-chaos-12', 3, 'Identify what actually stayed down', 'Find the evidence that explains why atlas-metrics-db stayed unreachable for the entire game day.'),
  ('mission-atlas-chaos-12-o4', 'mission-atlas-chaos-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-chaos-01-o1-c1', 'mission-atlas-chaos-01-o1', 1, 'multiple_choice', 'Chaos engineering actually means...', '{"question":"Chaos engineering actually means...","options":[{"id":"a","text":"Deliberately injecting real failure into a system, under controlled conditions with a hypothesis and a rollback plan, to build confidence it survives what it claims to survive"},{"id":"b","text":"Randomly breaking production systems with no plan, to see what happens"},{"id":"c","text":"A purely theoretical practice that is never actually run against real infrastructure"},{"id":"d","text":"A one-time audit that replaces the need for any other kind of testing"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-chaos-02-o1-c1', 'mission-atlas-chaos-02-o1', 1, 'terminal_simulation', 'Read the chaos experiment hypothesis and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/hypothesis-log.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/hypothesis-log.yaml":{"type":"file","content":"experiment: kill-one-collector-instance\nsteady_state_metric: p99 latency under 400ms, error rate under 1 percent\nhypothesis: killing one collector instance on purpose has no visible effect on the steady state, because the fleet runs behind a load balancer with health checks\nblast_radius: single instance, staging first, then production\nrollback: instance is auto-replaced by the autoscaling group within 90 seconds\n# a hypothesis states what should stay the same, not just what is being tested\n# verification HYPOTHESIS-5510\n"}}}'::jsonb, '{"requiredFlag":"HYPOTHESIS-5510"}'::jsonb),

  ('mission-atlas-chaos-03-o1-c1', 'mission-atlas-chaos-03-o1', 1, 'terminal_simulation', 'Read the chaos toolkit configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/toolkit-config.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/toolkit-config.yaml":{"type":"file","content":"supported_faults:\n  - instance-termination\n  - latency-injection\n  - packet-loss\n  - dependency-block\n  - availability-zone-failure\napproval_required: yes, for any fault above single-instance scope\n# verification FAULTLIST-7714\n"}}}'::jsonb, '{"requiredFlag":"FAULTLIST-7714"}'::jsonb),

  ('mission-atlas-chaos-04-o1-c1', 'mission-atlas-chaos-04-o1', 1, 'terminal_simulation', 'Read the kill-instance experiment result and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/experiments/kill-instance-result.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/experiments/kill-instance-result.txt":{"type":"file","content":"experiment: kill-one-collector-instance\nresult: hypothesis confirmed\np99 latency during experiment: 380ms (within steady state)\nautoscaling group launched a replacement instance in 74 seconds\nno error rate increase observed\n# verification KILLINSTANCE-2201\n"}}}'::jsonb, '{"requiredFlag":"KILLINSTANCE-2201"}'::jsonb),

  ('mission-atlas-chaos-05-o1-c1', 'mission-atlas-chaos-05-o1', 1, 'terminal_simulation', 'Read the latency-injection experiment result and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/experiments/latency-result.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/experiments/latency-result.txt":{"type":"file","content":"experiment: inject-6-second-delay-on-one-dependency-call\nresult: hypothesis confirmed\nthe Act 27 timeout (5s) fired before the injected delay (6s) completed, exactly as configured\ncaller received a timeout error instead of hanging indefinitely\n# verification LATENCYRESULT-3387\n"}}}'::jsonb, '{"requiredFlag":"LATENCYRESULT-3387"}'::jsonb),

  ('mission-atlas-chaos-06-o1-c1', 'mission-atlas-chaos-06-o1', 1, 'terminal_simulation', 'Read the packet-loss experiment result and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/experiments/packet-loss-result.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/experiments/packet-loss-result.txt":{"type":"file","content":"experiment: inject-packet-loss-at-increasing-rates\n2 percent loss: no visible effect\n10 percent loss: retries absorbed it completely, no visible effect\n25 percent loss: error rate began rising, degradation became visible to users\nthreshold where retries stop fully absorbing loss: between 10 and 25 percent\n# verification PACKETLOSS-6650\n"}}}'::jsonb, '{"requiredFlag":"PACKETLOSS-6650"}'::jsonb),

  ('mission-atlas-chaos-07-o1-c1', 'mission-atlas-chaos-07-o1', 1, 'terminal_simulation', 'Read the dependency-failure experiment result and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/experiments/dependency-failure-result.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/experiments/dependency-failure-result.txt":{"type":"file","content":"experiment: block-every-call-to-atlas-metrics-db-for-10-minutes\nresult: hypothesis confirmed\ncircuit breaker tripped after 5 consecutive failures, exactly per its Act 27 configuration\ncollector served last-known-good cached responses, flagged stale, for the full 10 minutes\nno cascade to ingestion-api or any other dependent service\n# verification DEPFAILRESULT-4415\n"}}}'::jsonb, '{"requiredFlag":"DEPFAILRESULT-4415"}'::jsonb),

  ('mission-atlas-chaos-08-o1-c1', 'mission-atlas-chaos-08-o1', 1, 'terminal_simulation', 'Read the region-wide game day plan and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/zone-failure-plan.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/zone-failure-plan.yaml":{"type":"file","content":"game_day: burn-the-region\nscope: terminate every instance in availability zone us-east-1a, simultaneously\nservices confirmed multi-AZ: collector, ingestion-api\nopen question, flagged before the drill: atlas-metrics-db is deployed single-AZ in us-east-1a, no read replica in any other zone\nduration: 90 minutes\n# verification ZONEPLAN-8823\n"}}}'::jsonb, '{"requiredFlag":"ZONEPLAN-8823"}'::jsonb),

  ('mission-atlas-chaos-09-o1-c1', 'mission-atlas-chaos-09-o1', 1, 'terminal_simulation', 'Read the backup verification log and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/backup-verification.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/backup-verification.txt":{"type":"file","content":"atlas-metrics-db: daily automated snapshot, taken 02:00 UTC\nlast 7 snapshots: all completed, all checksums valid\nnote: a valid snapshot confirms backups exist -- it does not, on its own, confirm how long restoring one actually takes\n# verification BACKUPCHECK-1187\n"}}}'::jsonb, '{"requiredFlag":"BACKUPCHECK-1187"}'::jsonb),

  ('mission-atlas-chaos-10-o1-c1', 'mission-atlas-chaos-10-o1', 1, 'terminal_simulation', 'Read the restore drill result and submit the verification code.', '{"instructions":"Read /repo/infra-envs/chaos/restore-drill-result.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/chaos/restore-drill-result.txt":{"type":"file","content":"drill: restore atlas-metrics-db from yesterday''s snapshot to a scratch instance\nresult: restore succeeded\ntotal wall-clock time: 47 minutes\nno documented target exists anywhere for how long this restore is actually supposed to take\n# verification RESTOREDRILL-9034\n"}}}'::jsonb, '{"requiredFlag":"RESTOREDRILL-9034"}'::jsonb),

  ('mission-atlas-chaos-11-o1-c1', 'mission-atlas-chaos-11-o1', 1, 'multiple_choice', 'A real chaos engineering game day actually is...', '{"question":"A real chaos engineering game day actually is...","options":[{"id":"a","text":"A scheduled, cross-team exercise with a defined blast radius and a rollback plan, injecting a real failure while stakeholders watch live -- not one engineer quietly breaking things alone"},{"id":"b","text":"Any unannounced outage, regardless of whether it was intentional"},{"id":"c","text":"A purely tabletop discussion with no failure actually injected"},{"id":"d","text":"A one-person task that never needs sign-off from anyone else"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-chaos-12-o1-c1', 'mission-atlas-chaos-12-o1', 1, 'terminal_simulation', 'Read the game day execution log and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/game-day-execution-log.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/game-day-execution-log.txt":{"type":"file","content":"08:00:00 - game day begins: every instance in availability zone us-east-1a terminated simultaneously\n08:00:05 - collector: unaffected, traffic already routed to us-east-1b instances\n08:00:10 - ingestion-api: unaffected, same failover\n08:00:12 - atlas-metrics-db: unreachable, every connection fails\n08:00:17 - collector: circuit breaker for atlas-metrics-db trips after 5 consecutive failures\n08:00:17 through 09:30:00 - atlas-metrics-db: remains unreachable for the entire 90-minute window\n09:30:00 - game day ends, us-east-1a instances restored\n09:30:45 - atlas-metrics-db: still unreachable -- it was never deployed anywhere but that one zone\n# verification GAMEDAY-6631\n"}}}'::jsonb, '{"requiredFlag":"GAMEDAY-6631"}'::jsonb),
  ('mission-atlas-chaos-12-o2-c1', 'mission-atlas-chaos-12-o2', 1, 'terminal_simulation', 'Read the resilience-check result and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/resilience-check-result.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/resilience-check-result.txt":{"type":"file","content":"circuit_breaker: tripped correctly after 5 consecutive failures, collector never blocked waiting on the database again after that\ngraceful_degradation: collector served cached, stale-flagged responses for every database-dependent request, for the full 90 minutes\nbulkhead: the exhausted database dependency never affected calls to any other service\nconclusion: every resilience pattern built in Act 27 performed exactly as designed\n# verification RESCHECK-7742\n"}}}'::jsonb, '{"requiredFlag":"RESCHECK-7742"}'::jsonb),
  ('mission-atlas-chaos-12-o3-c1', 'mission-atlas-chaos-12-o3', 1, 'investigation', 'Which evidence explains why atlas-metrics-db stayed unreachable for the entire game day?', '{"evidence":[{"id":"e1","label":"Game day execution log","detail":"atlas-metrics-db was unreachable from 08:00:12 through the end of the 90-minute window, and stayed unreachable even after the zone was restored"},{"id":"e2","label":"Resilience-check result","detail":"The circuit breaker, graceful degradation and bulkheads all performed exactly as designed for the full 90 minutes"},{"id":"e3","label":"Zone-failure plan","detail":"atlas-metrics-db is deployed single-AZ in us-east-1a with no read replica or standby in any other zone"},{"id":"e4","label":"Restore drill result","detail":"The only path back for atlas-metrics-db is a manual restore from snapshot, which took 47 minutes in the last drill, with no documented target time"}],"question":"Which evidence explains why atlas-metrics-db stayed unreachable for the entire game day?"}'::jsonb, '{"requiredEvidenceIds":["e3","e4"]}'::jsonb),
  ('mission-atlas-chaos-12-o4-c1', 'mission-atlas-chaos-12-o4', 1, 'boss_encounter', 'Having confirmed the game day execution log, the resilience-check result, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-chaos-12-o1","label":"Confirm the game day execution log"},{"objectiveRef":"mission-atlas-chaos-12-o2","label":"Confirm the resilience-check result"},{"objectiveRef":"mission-atlas-chaos-12-o3","label":"Identify what actually stayed down"}],"task":"State the diagnosis in one sentence: every resilience pattern built in Act 27 -- the circuit breaker, the bulkheads, graceful degradation -- performed exactly as designed for the full 90-minute game day, so the application layer was never the problem, but atlas-metrics-db itself was never deployed anywhere but the one zone that got taken down, has no cross-AZ replica, and its only path back is a manual restore with no defined time target -- the fix is not another application-layer pattern, it is giving the database real infrastructure to fail over to."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-chaos-12-o1","mission-atlas-chaos-12-o2","mission-atlas-chaos-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-chaos-01-o1-c1', 'orientation', 'Think about whether this is about recklessness, or about deliberately building confidence.', 10, 1),
  ('mission-atlas-chaos-01-o1-c1', 'solution', 'Controlled, hypothesis-driven failure injection, to build confidence a system survives what it claims to.', 20, 2),

  ('mission-atlas-chaos-02-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/hypothesis-log.yaml', 10, 1),
  ('mission-atlas-chaos-02-o1-c1', 'solution', 'States the steady state that should not change, verification HYPOTHESIS-5510. submit HYPOTHESIS-5510', 20, 2),

  ('mission-atlas-chaos-03-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/toolkit-config.yaml', 10, 1),
  ('mission-atlas-chaos-03-o1-c1', 'solution', 'Five supported fault types, verification FAULTLIST-7714. submit FAULTLIST-7714', 20, 2),

  ('mission-atlas-chaos-04-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/experiments/kill-instance-result.txt', 10, 1),
  ('mission-atlas-chaos-04-o1-c1', 'solution', 'Hypothesis confirmed, replaced in 74 seconds, verification KILLINSTANCE-2201. submit KILLINSTANCE-2201', 20, 2),

  ('mission-atlas-chaos-05-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/experiments/latency-result.txt', 10, 1),
  ('mission-atlas-chaos-05-o1-c1', 'solution', 'The Act 27 timeout fired before the injected delay finished, verification LATENCYRESULT-3387. submit LATENCYRESULT-3387', 20, 2),

  ('mission-atlas-chaos-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/experiments/packet-loss-result.txt', 10, 1),
  ('mission-atlas-chaos-06-o1-c1', 'solution', 'Absorbed fully up to 10 percent, visible by 25 percent, verification PACKETLOSS-6650. submit PACKETLOSS-6650', 20, 2),

  ('mission-atlas-chaos-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/experiments/dependency-failure-result.txt', 10, 1),
  ('mission-atlas-chaos-07-o1-c1', 'solution', 'Circuit breaker tripped, degraded gracefully, no cascade, verification DEPFAILRESULT-4415. submit DEPFAILRESULT-4415', 20, 2),

  ('mission-atlas-chaos-08-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/zone-failure-plan.yaml', 10, 1),
  ('mission-atlas-chaos-08-o1-c1', 'solution', 'Entire us-east-1a, flagged single-AZ database, verification ZONEPLAN-8823. submit ZONEPLAN-8823', 20, 2),

  ('mission-atlas-chaos-09-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/backup-verification.txt', 10, 1),
  ('mission-atlas-chaos-09-o1-c1', 'solution', 'Daily snapshots, all valid, verification BACKUPCHECK-1187. submit BACKUPCHECK-1187', 20, 2),

  ('mission-atlas-chaos-10-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/chaos/restore-drill-result.txt', 10, 1),
  ('mission-atlas-chaos-10-o1-c1', 'solution', '47 minutes, no documented target, verification RESTOREDRILL-9034. submit RESTOREDRILL-9034', 20, 2),

  ('mission-atlas-chaos-11-o1-c1', 'orientation', 'Think about what makes it different from one person quietly breaking something alone.', 10, 1),
  ('mission-atlas-chaos-11-o1-c1', 'solution', 'Scheduled, cross-team, defined blast radius, rollback plan, watched live.', 20, 2),

  ('mission-atlas-chaos-12-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/game-day-execution-log.txt', 10, 1),
  ('mission-atlas-chaos-12-o1-c1', 'solution', 'Database unreachable for the full 90 minutes, verification GAMEDAY-6631. submit GAMEDAY-6631', 20, 2),
  ('mission-atlas-chaos-12-o2-c1', 'orientation', 'Try: cat /var/atlas-observability-01/resilience-check-result.txt', 10, 1),
  ('mission-atlas-chaos-12-o2-c1', 'solution', 'Every Act 27 pattern held, verification RESCHECK-7742. submit RESCHECK-7742', 20, 2),
  ('mission-atlas-chaos-12-o3-c1', 'orientation', 'The resilience-check result is confirmed clean and ruled out as the explanation. Compare the zone plan against the restore drill.', 10, 1),
  ('mission-atlas-chaos-12-o3-c1', 'solution', 'e3 and e4: no cross-AZ replica at all, and the only fallback is a slow, undefined-target restore.', 20, 2),
  ('mission-atlas-chaos-12-o4-c1', 'orientation', 'Combine the resilience patterns holding, the missing replica, and the fix into one sentence.', 15, 1),
  ('mission-atlas-chaos-12-o4-c1', 'solution', 'The application layer proved itself completely; the database underneath it needs real cross-AZ infrastructure, not another resilience pattern.', 25, 2);
