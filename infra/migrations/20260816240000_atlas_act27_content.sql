-- Atlas Division pathway ("The Silence") Act 27 -- "Failure Is Normal"
-- content, under world-atlas-failure-is-normal (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), continuing World VIII "The Failure Zone".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- resilience artifact here is static seeded text read via `cat`. Two
-- hosts: the reused `atlas-devbox-01`, still hosting an `sre/`
-- resilience directory inside the Act 22 `infra-envs` GitOps repo
-- (timeout, retry/backoff, circuit breaker, bulkhead, load-shedding,
-- degradation and dependency-budget configs), and the reused
-- `atlas-observability-01` for live cascade data (the incident
-- timeline, the DB slowdown event itself). Concept-only topics with no
-- natural artifact (partial failure, jitter, bulkheads, backpressure)
-- stay multiple_choice.
--
-- Narrative thread: mission 2 (timeouts) plants the actual gap as a
-- plain fact -- no timeout is configured on the collector''s database
-- client -- well before the boss frames it as a problem. The boss
-- deliberately treats the DB''s own brief slow query (`e2`) as a normal,
-- expected partial failure, not a root cause on its own; the retry/
-- backoff config (`e4`) is confirmed correctly configured and
-- explicitly ruled out as the cause. The actual explanation requires
-- both the routine trigger and the missing timeout together (`e2` +
-- `e3`) -- the same "small event, missing containment" shape as the
-- world''s own story_reveal.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-failure-is-normal', 'world-atlas-failure-is-normal', 'failure-is-normal', '8B - Failure Is Normal', 'Learn resilience patterns from first principles -- partial failure, timeouts, retries, backoff, jitter, circuit breakers, bulkheads, load shedding, backpressure, graceful degradation and dependency budgets -- while one routine, minor database slowdown takes down every service that depends on the collector.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-failure-is-normal-1', 'campaign-atlas-failure-is-normal', 'expecting-it-to-break', 'Expecting It to Break', 'Partial failure, timeouts, retries, backoff, jitter and circuit breakers.', 1),
  ('operation-atlas-failure-is-normal-2', 'campaign-atlas-failure-is-normal', 'containing-it-when-it-does', 'Containing It When It Does', 'Bulkheads, load shedding, backpressure, graceful degradation and dependency budgets.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-failure-is-normal-01', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-1', 'partial-failure', 'Partial Failure', 'atlas-metrics-db has one brief, routine slow query. It resolves in under two minutes. Within that same window, half the fleet goes unresponsive.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"partial-failure-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-failure-is-normal-02', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-1', 'timeouts', 'Timeouts', 'Confirm exactly how long the collector''s own database client is actually willing to wait.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"timeouts-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-failure-is-normal-03', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-1', 'retries', 'Retries', 'Understand why simply trying again is never automatically the safe choice on its own.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"retries-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-failure-is-normal-04', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-1', 'backoff', 'Backoff', 'Confirm how long the fleet actually waits between one retry and the next.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"backoff-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-failure-is-normal-05', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-1', 'jitter', 'Jitter', 'Understand what actually happens when a hundred clients all back off by the exact same amount at once.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"jitter-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-failure-is-normal-06', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-1', 'circuit-breakers', 'Circuit Breakers', 'Confirm what actually happens after enough consecutive calls to the same dependency fail.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"circuit-breakers-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-failure-is-normal-07', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-2', 'bulkheads', 'Bulkheads', 'Understand why one slow dependency should never be able to starve calls to a completely healthy one.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"bulkheads-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-failure-is-normal-08', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-2', 'load-shedding', 'Load Shedding', 'Confirm what this fleet actually does with requests once it is already overloaded.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"load-shedding-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-failure-is-normal-09', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-2', 'backpressure', 'Backpressure', 'Understand how a system downstream actually tells everything upstream to slow down, instead of just quietly falling further behind.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"backpressure-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-failure-is-normal-10', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-2', 'graceful-degradation', 'Graceful Degradation', 'Confirm what the collector actually returns when one of its own dependencies is genuinely unavailable.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"graceful-degradation-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-failure-is-normal-11', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-2', 'dependency-budgets', 'Dependency Budgets', 'Confirm how much of the fleet''s own error budget one single dependency is actually allowed to spend.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"dependency-budgets-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-failure-is-normal-12', 'world-atlas-failure-is-normal', 'campaign-atlas-failure-is-normal', 'operation-atlas-failure-is-normal-2', 'cascade', 'Cascade', 'Everything this Act taught, turned on one small, ordinary slowdown: not to just blame the database, to finally explain how one routine hiccup became a fleet-wide outage.', 'boss', ARRAY['cross','rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-failure-is-normal-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"cascade-boss-sim"}'::jsonb, '{"xp":820,"credits":195,"badgeIds":["cascade"],"skillXp":{"cloud_devops_fundamentals":125}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-failure-is-normal-01', 1, 'leena', 'atlas-metrics-db had one brief, routine slow query. It resolved on its own in under two minutes. In that exact same window, half the fleet went unresponsive.'),
  ('mission-atlas-failure-is-normal-01', 2, 'cross', 'Imani Cross. In any distributed system, something is always degraded somewhere. Partial failure is not the exception to design around -- it is the actual normal condition. The real question is never whether something will fail. It is whether the rest of the system notices, or falls over with it.'),

  ('mission-atlas-failure-is-normal-02', 1, 'cross', 'Confirm exactly how long the collector is actually willing to wait on one database call before giving up on it.'),

  ('mission-atlas-failure-is-normal-03', 1, 'cross', 'Retrying a failed call sounds harmless. Retried blindly, without any limit, it just adds more load onto a dependency that is already struggling -- the opposite of helping.'),

  ('mission-atlas-failure-is-normal-04', 1, 'cross', 'Backoff means waiting longer between each retry, not the same fixed gap every time. Confirm how this fleet actually spaces its own retries out.'),

  ('mission-atlas-failure-is-normal-05', 1, 'cross', 'A hundred clients all backing off by the exact same fixed amount just means a hundred clients all retrying again at the exact same instant. Jitter adds real randomness specifically to prevent that.'),

  ('mission-atlas-failure-is-normal-06', 1, 'rook', 'After enough consecutive failures, a circuit breaker stops calling a struggling dependency entirely for a cooldown period -- failing fast on purpose, instead of piling up waiting for something that keeps not answering.'),

  ('mission-atlas-failure-is-normal-07', 1, 'rook', 'A bulkhead keeps resource pools separate per dependency -- one slow dependency exhausting its own pool should never be able to starve calls to a completely different, healthy one.'),

  ('mission-atlas-failure-is-normal-08', 1, 'cross', 'Once a system is already overloaded, accepting every incoming request anyway just guarantees all of them get worse together. Load shedding rejects some, cheaply and on purpose, so the rest can actually succeed.'),

  ('mission-atlas-failure-is-normal-09', 1, 'cross', 'Backpressure is how a downstream system can actually tell everything calling it to slow down, explicitly, instead of just silently falling further and further behind until it collapses.'),

  ('mission-atlas-failure-is-normal-10', 1, 'cross', 'When a real dependency genuinely is not available, returning something reduced, cached, or default is still a real answer. Confirm whether the collector is actually capable of that, or whether it only knows how to fail completely.'),

  ('mission-atlas-failure-is-normal-11', 1, 'cross', 'The same error-budget math from Act 25 applies here too, per dependency -- confirm exactly how much of the collector''s own budget one single dependency is actually allowed to spend before it gets isolated.'),

  ('mission-atlas-failure-is-normal-12', 1, 'leena', 'Everything this Act taught you, on one small, ordinary slowdown. Not to just blame the database -- to finally explain how one routine hiccup became a fleet-wide outage.'),
  ('mission-atlas-failure-is-normal-12', 2, 'byte', 'I have the full cascade timeline and the database''s own slowdown event both pulled up together. The database part of this was over in under two minutes.'),
  ('mission-atlas-failure-is-normal-12', 3, 'cross', 'The retry and backoff configuration checked out completely clean. That was never the problem here.'),
  ('mission-atlas-failure-is-normal-12', 4, 'rook', 'Then find what actually let two minutes of a normal, expected hiccup turn into this.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-failure-is-normal-01-o1', 'mission-atlas-failure-is-normal-01', 1, 'Explain partial failure', 'Choose the accurate description of what partial failure actually means in a distributed system.'),

  ('mission-atlas-failure-is-normal-02-o1', 'mission-atlas-failure-is-normal-02', 1, 'Read the timeout configuration', 'Read the database client timeout configuration and submit the verification code.'),

  ('mission-atlas-failure-is-normal-03-o1', 'mission-atlas-failure-is-normal-03', 1, 'Read the retry configuration', 'Read the retry configuration and submit the verification code.'),

  ('mission-atlas-failure-is-normal-04-o1', 'mission-atlas-failure-is-normal-04', 1, 'Read the backoff configuration', 'Read the backoff configuration and submit the verification code.'),

  ('mission-atlas-failure-is-normal-05-o1', 'mission-atlas-failure-is-normal-05', 1, 'Explain jitter', 'Choose the accurate description of what jitter actually prevents.'),

  ('mission-atlas-failure-is-normal-06-o1', 'mission-atlas-failure-is-normal-06', 1, 'Read the circuit breaker configuration', 'Read the circuit breaker configuration and submit the verification code.'),

  ('mission-atlas-failure-is-normal-07-o1', 'mission-atlas-failure-is-normal-07', 1, 'Explain bulkheads', 'Choose the accurate description of what a bulkhead actually isolates.'),

  ('mission-atlas-failure-is-normal-08-o1', 'mission-atlas-failure-is-normal-08', 1, 'Read the load-shedding configuration', 'Read the load-shedding configuration and submit the verification code.'),

  ('mission-atlas-failure-is-normal-09-o1', 'mission-atlas-failure-is-normal-09', 1, 'Explain backpressure', 'Choose the accurate description of what backpressure actually signals.'),

  ('mission-atlas-failure-is-normal-10-o1', 'mission-atlas-failure-is-normal-10', 1, 'Read the degradation behavior', 'Read the graceful degradation configuration and submit the verification code.'),

  ('mission-atlas-failure-is-normal-11-o1', 'mission-atlas-failure-is-normal-11', 1, 'Read the dependency budget', 'Read the dependency budget and submit the verification code.'),

  ('mission-atlas-failure-is-normal-12-o1', 'mission-atlas-failure-is-normal-12', 1, 'Confirm the cascade timeline', 'Read the cascade timeline and submit the verification code.'),
  ('mission-atlas-failure-is-normal-12-o2', 'mission-atlas-failure-is-normal-12', 2, 'Confirm the database slowdown was brief', 'Read the database slowdown event and submit the verification code.'),
  ('mission-atlas-failure-is-normal-12-o3', 'mission-atlas-failure-is-normal-12', 3, 'Identify what actually explains the cascade', 'Find the evidence that explains how a two-minute hiccup became a fleet-wide outage.'),
  ('mission-atlas-failure-is-normal-12-o4', 'mission-atlas-failure-is-normal-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-failure-is-normal-01-o1-c1', 'mission-atlas-failure-is-normal-01-o1', 1, 'multiple_choice', 'Partial failure in a distributed system actually means...', '{"question":"Partial failure in a distributed system actually means...","options":[{"id":"a","text":"Something is always degraded somewhere -- the real design question is whether the rest of the system notices and contains it, not whether it happens at all"},{"id":"b","text":"A rare event that a well-built system should never actually experience"},{"id":"c","text":"Only relevant to systems with a single point of failure"},{"id":"d","text":"Something that only happens during a deliberate chaos experiment"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-failure-is-normal-02-o1-c1', 'mission-atlas-failure-is-normal-02-o1', 1, 'terminal_simulation', 'Read the database client timeout configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/db-client-timeout.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/db-client-timeout.yaml":{"type":"file","content":"db_client:\n  connection_timeout: 5s\n  query_timeout: none\n# no timeout at all is configured for an actual query in flight -- once one starts, the caller waits indefinitely\n# verification TIMEOUT-3312\n"}}}'::jsonb, '{"requiredFlag":"TIMEOUT-3312"}'::jsonb),

  ('mission-atlas-failure-is-normal-03-o1-c1', 'mission-atlas-failure-is-normal-03-o1', 1, 'terminal_simulation', 'Read the retry configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/retry-policy.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/retry-policy.yaml":{"type":"file","content":"retry_policy:\n  max_attempts: 3\n  retry_on: connection_error, timeout\n# bounded, not unlimited -- retries stop after 3 attempts rather than continuing forever\n# verification RETRY-6602\n"}}}'::jsonb, '{"requiredFlag":"RETRY-6602"}'::jsonb),

  ('mission-atlas-failure-is-normal-04-o1-c1', 'mission-atlas-failure-is-normal-04-o1', 1, 'terminal_simulation', 'Read the backoff configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/backoff-policy.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/backoff-policy.yaml":{"type":"file","content":"backoff:\n  type: exponential\n  base: 200ms\n  multiplier: 2\n# each retry waits roughly twice as long as the one before it\n# verification BACKOFF-4471\n"}}}'::jsonb, '{"requiredFlag":"BACKOFF-4471"}'::jsonb),

  ('mission-atlas-failure-is-normal-05-o1-c1', 'mission-atlas-failure-is-normal-05-o1', 1, 'multiple_choice', 'Jitter actually prevents...', '{"question":"Jitter actually prevents...","options":[{"id":"a","text":"Many clients backing off by the exact same fixed amount and then all retrying again at the exact same instant, overwhelming the dependency all over again"},{"id":"b","text":"Any retry from ever happening at all"},{"id":"c","text":"A dependency from ever failing in the first place"},{"id":"d","text":"Circuit breakers from ever opening"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-failure-is-normal-06-o1-c1', 'mission-atlas-failure-is-normal-06-o1', 1, 'terminal_simulation', 'Read the circuit breaker configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/circuit-breaker.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/circuit-breaker.yaml":{"type":"file","content":"circuit_breaker:\n  failure_threshold: 5 consecutive failures\n  cooldown: 30s\n  behavior: fail fast, skip the call entirely, during cooldown\n# verification BREAKER-8802\n"}}}'::jsonb, '{"requiredFlag":"BREAKER-8802"}'::jsonb),

  ('mission-atlas-failure-is-normal-07-o1-c1', 'mission-atlas-failure-is-normal-07-o1', 1, 'multiple_choice', 'A bulkhead actually isolates...', '{"question":"A bulkhead actually isolates...","options":[{"id":"a","text":"Resource pools per dependency, so one slow dependency exhausting its own pool cannot starve calls to a completely different, healthy one"},{"id":"b","text":"Only network traffic, never resources like threads or connections"},{"id":"c","text":"A synonym for a circuit breaker with no functional difference"},{"id":"d","text":"Nothing -- it only applies to physical infrastructure, not software"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-failure-is-normal-08-o1-c1', 'mission-atlas-failure-is-normal-08-o1', 1, 'terminal_simulation', 'Read the load-shedding configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/load-shedding.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/load-shedding.yaml":{"type":"file","content":"load_shedding:\n  queue_depth_threshold: 500\n  behavior: reject new requests immediately once the threshold is crossed, rather than queuing them\n# verification SHEDDING-9012\n"}}}'::jsonb, '{"requiredFlag":"SHEDDING-9012"}'::jsonb),

  ('mission-atlas-failure-is-normal-09-o1-c1', 'mission-atlas-failure-is-normal-09-o1', 1, 'multiple_choice', 'Backpressure actually signals...', '{"question":"Backpressure actually signals...","options":[{"id":"a","text":"An explicit message from a downstream system telling everything upstream to slow down, instead of silently queuing and falling further behind"},{"id":"b","text":"That a service should immediately shut down entirely"},{"id":"c","text":"Only relevant to synchronous HTTP calls, never queues or streams"},{"id":"d","text":"A guarantee that no request will ever be dropped"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-failure-is-normal-10-o1-c1', 'mission-atlas-failure-is-normal-10-o1', 1, 'terminal_simulation', 'Read the graceful degradation configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/graceful-degradation.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/graceful-degradation.yaml":{"type":"file","content":"degradation:\n  on_dependency_unavailable: serve last-known-good cached response, flagged as stale\n# a reduced, honest answer instead of a complete failure\n# verification DEGRADE-2291\n"}}}'::jsonb, '{"requiredFlag":"DEGRADE-2291"}'::jsonb),

  ('mission-atlas-failure-is-normal-11-o1-c1', 'mission-atlas-failure-is-normal-11-o1', 1, 'terminal_simulation', 'Read the dependency budget and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/dependency-budget.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/dependency-budget.yaml":{"type":"file","content":"dependency: atlas-metrics-db\nmax share of collector error budget: 20%\n# beyond this share, the dependency gets isolated rather than allowed to keep spending the collector''s own budget\n# verification DEPBUDGET-3390\n"}}}'::jsonb, '{"requiredFlag":"DEPBUDGET-3390"}'::jsonb),

  ('mission-atlas-failure-is-normal-12-o1-c1', 'mission-atlas-failure-is-normal-12-o1', 1, 'terminal_simulation', 'Read the cascade timeline and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/cascade-timeline.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/cascade-timeline.txt":{"type":"file","content":"09:00:00 - atlas-metrics-db: query latency spikes\n09:00:15 - collector: request threads begin piling up, waiting on the database\n09:02:40 - collector: thread pool exhausted, stops responding to any request\n09:03:10 - ingestion-api: degraded, its own calls to the collector now hanging too\n09:04:00 - load balancer: marks the collector unhealthy, removes it from rotation\n# four services degraded in sequence, in under four minutes\n# verification CASCADE-4471\n"}}}'::jsonb, '{"requiredFlag":"CASCADE-4471"}'::jsonb),
  ('mission-atlas-failure-is-normal-12-o2-c1', 'mission-atlas-failure-is-normal-12-o2', 1, 'terminal_simulation', 'Read the database slowdown event and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/db-slowdown-event.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/db-slowdown-event.txt":{"type":"file","content":"atlas-metrics-db: one query ran long due to a routine autovacuum cycle\nduration: 108 seconds\nresolved on its own, no manual intervention, no data affected\n# a small, ordinary, expected event on its own\n# verification DBSLOWDOWN-8802\n"}}}'::jsonb, '{"requiredFlag":"DBSLOWDOWN-8802"}'::jsonb),
  ('mission-atlas-failure-is-normal-12-o3-c1', 'mission-atlas-failure-is-normal-12-o3', 1, 'investigation', 'Which evidence explains how a two-minute hiccup became a fleet-wide outage?', '{"evidence":[{"id":"e1","label":"Cascade timeline","detail":"Four services degraded in sequence within four minutes"},{"id":"e2","label":"Database slowdown event","detail":"A single query ran long for 108 seconds due to a routine autovacuum cycle, then resolved on its own with no data affected"},{"id":"e3","label":"Database client timeout config","detail":"No query timeout is configured at all -- a slow query blocks the calling thread indefinitely"},{"id":"e4","label":"Retry and backoff configuration","detail":"Both are correctly configured -- bounded retries with exponential backoff, confirmed working as intended"}],"question":"Which evidence explains how a two-minute hiccup became a fleet-wide outage?"}'::jsonb, '{"requiredEvidenceIds":["e2","e3"]}'::jsonb),
  ('mission-atlas-failure-is-normal-12-o4-c1', 'mission-atlas-failure-is-normal-12-o4', 1, 'boss_encounter', 'Having confirmed the cascade timeline, the database slowdown, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-failure-is-normal-12-o1","label":"Confirm the cascade timeline"},{"objectiveRef":"mission-atlas-failure-is-normal-12-o2","label":"Confirm the database slowdown was brief"},{"objectiveRef":"mission-atlas-failure-is-normal-12-o3","label":"Identify what actually explains the cascade"}],"task":"State the diagnosis in one sentence: atlas-metrics-db''s own slowdown was a small, ordinary, expected partial failure that resolved itself in under two minutes, but the collector''s database client has no query timeout configured at all, so every thread waiting on that one slow query never came back, exhausting the collector''s entire capacity and cascading outward to every service that depends on it -- the fix is a real timeout, paired with the circuit breaker already built this Act, so one routine, contained failure can never again become an outage for everything downstream of it."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-failure-is-normal-12-o1","mission-atlas-failure-is-normal-12-o2","mission-atlas-failure-is-normal-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-failure-is-normal-01-o1-c1', 'orientation', 'Think about whether something failing is the exception, or the actual normal state.', 10, 1),
  ('mission-atlas-failure-is-normal-01-o1-c1', 'solution', 'Something is always degraded somewhere; the real question is containment.', 20, 2),

  ('mission-atlas-failure-is-normal-02-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/db-client-timeout.yaml', 10, 1),
  ('mission-atlas-failure-is-normal-02-o1-c1', 'solution', 'query_timeout is set to none, verification TIMEOUT-3312. submit TIMEOUT-3312', 20, 2),

  ('mission-atlas-failure-is-normal-03-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/retry-policy.yaml', 10, 1),
  ('mission-atlas-failure-is-normal-03-o1-c1', 'solution', 'Capped at 3 attempts, verification RETRY-6602. submit RETRY-6602', 20, 2),

  ('mission-atlas-failure-is-normal-04-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/backoff-policy.yaml', 10, 1),
  ('mission-atlas-failure-is-normal-04-o1-c1', 'solution', 'Exponential, doubling each time, verification BACKOFF-4471. submit BACKOFF-4471', 20, 2),

  ('mission-atlas-failure-is-normal-05-o1-c1', 'orientation', 'Think about many clients retrying at the exact same moment.', 10, 1),
  ('mission-atlas-failure-is-normal-05-o1-c1', 'solution', 'Jitter prevents synchronized retries from all hitting at once.', 20, 2),

  ('mission-atlas-failure-is-normal-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/circuit-breaker.yaml', 10, 1),
  ('mission-atlas-failure-is-normal-06-o1-c1', 'solution', '5 consecutive failures trips it, verification BREAKER-8802. submit BREAKER-8802', 20, 2),

  ('mission-atlas-failure-is-normal-07-o1-c1', 'orientation', 'Think about one dependency''s resource pool versus another''s.', 10, 1),
  ('mission-atlas-failure-is-normal-07-o1-c1', 'solution', 'Bulkheads isolate resource pools per dependency.', 20, 2),

  ('mission-atlas-failure-is-normal-08-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/load-shedding.yaml', 10, 1),
  ('mission-atlas-failure-is-normal-08-o1-c1', 'solution', 'Rejects new requests past a queue depth threshold, verification SHEDDING-9012. submit SHEDDING-9012', 20, 2),

  ('mission-atlas-failure-is-normal-09-o1-c1', 'orientation', 'Think about an explicit slow-down signal versus silent queuing.', 10, 1),
  ('mission-atlas-failure-is-normal-09-o1-c1', 'solution', 'Backpressure explicitly tells upstream callers to slow down.', 20, 2),

  ('mission-atlas-failure-is-normal-10-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/graceful-degradation.yaml', 10, 1),
  ('mission-atlas-failure-is-normal-10-o1-c1', 'solution', 'Serves a stale cached response, verification DEGRADE-2291. submit DEGRADE-2291', 20, 2),

  ('mission-atlas-failure-is-normal-11-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/dependency-budget.yaml', 10, 1),
  ('mission-atlas-failure-is-normal-11-o1-c1', 'solution', 'Capped at 20% of the collector''s budget, verification DEPBUDGET-3390. submit DEPBUDGET-3390', 20, 2),

  ('mission-atlas-failure-is-normal-12-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/cascade-timeline.txt', 10, 1),
  ('mission-atlas-failure-is-normal-12-o1-c1', 'solution', 'Four services degraded in sequence, verification CASCADE-4471. submit CASCADE-4471', 20, 2),
  ('mission-atlas-failure-is-normal-12-o2-c1', 'orientation', 'Try: cat /var/atlas-observability-01/db-slowdown-event.txt', 10, 1),
  ('mission-atlas-failure-is-normal-12-o2-c1', 'solution', '108 seconds, resolved on its own, verification DBSLOWDOWN-8802. submit DBSLOWDOWN-8802', 20, 2),
  ('mission-atlas-failure-is-normal-12-o3-c1', 'orientation', 'The retry and backoff config is confirmed clean and irrelevant here. Compare the brief slowdown against what the timeout config actually allows.', 10, 1),
  ('mission-atlas-failure-is-normal-12-o3-c1', 'solution', 'e2 and e3: a brief, ordinary slowdown, combined with no query timeout at all to contain it.', 20, 2),
  ('mission-atlas-failure-is-normal-12-o4-c1', 'orientation', 'Combine the brief database event, the missing timeout, and the fix into one sentence.', 15, 1),
  ('mission-atlas-failure-is-normal-12-o4-c1', 'solution', 'A routine 108-second database slowdown cascaded into a fleet-wide outage only because no query timeout existed to contain it -- add one, alongside the circuit breaker.', 25, 2);
