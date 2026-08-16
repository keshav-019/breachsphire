-- Atlas Division pathway ("The Silence") Act 13 -- "Serverless
-- Frontier" content, under world-atlas-serverless-frontier (already
-- inserted separately). 1 campaign, 2 operations, 12 missions (11
-- lessons + boss), closing World IV "Cloudreach" (Acts 10-13).
--
-- Same terminal-engine constraint as Acts 4-12 -- every serverless
-- artifact here is static seeded Terraform/config-style text read via
-- `cat`. Two hosts: the reused `atlas-devbox-01` for declared
-- infrastructure-as-code, and the reused `atlas-aws-live-01` (first
-- introduced in Act 12) for live invocation metrics, cost data and the
-- execution log that drives the boss's reveal. Purely conceptual
-- topics with no natural artifact (functions, cold starts, API
-- gateways, event buses, statelessness) stay multiple_choice.
--
-- Narrative thread: Act 12's undeployed `region_guard_remediate`
-- finally goes live. Missions 3, 9 and 10 plant the two facts the boss
-- needs -- the trigger really is applied this time (mission 3), the
-- account has plenty of spare concurrency so that is not the
-- bottleneck (mission 9, a deliberate red herring), and the retry
-- policy has no maximum attempts and no dead-letter queue configured
-- (mission 10, the actual mechanism of the storm). The boss's
-- execution-log evidence reveals the root trigger for that storm: the
-- Act 11 least-privilege IAM role, scoped correctly for what was
-- understood at design time, was never actually extended to cover the
-- specific Route 53 and load-balancer permissions this remediation
-- needs -- a genuine tension between least privilege (Act 11) and
-- operational completeness, not a mistake either Act made in isolation.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-serverless-frontier', 'world-atlas-serverless-frontier', 'serverless-frontier', '4D - Serverless Frontier', 'Learn serverless from first principles -- functions, cold starts, triggers, API gateways, queues, event buses, object events, statelessness, concurrency, retries and dead-letter queues, and cost -- while region_guard_remediate finally goes live and immediately floods itself with failed invocations.', 4);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-serverless-frontier-1', 'campaign-atlas-serverless-frontier', 'code-with-no-server-under-it', 'Code With No Server Under It', 'Functions, cold starts, triggers, API gateways, queues and event buses.', 1),
  ('operation-atlas-serverless-frontier-2', 'campaign-atlas-serverless-frontier', 'what-happens-when-it-fails', 'What Happens When It Fails', 'Object events, statelessness, concurrency, retries and dead-letter queues, and cost.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-serverless-frontier-01', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-1', 'functions', 'Functions', 'The Act 12 fix lands for real: region_guard_remediate is finally deployed. Within the hour, its invocation count has climbed past four thousand.', 'beginner', ARRAY['leena','vey'], null, null, '{"type":"simulation","simulationId":"functions-sim"}'::jsonb, '{"xp":240,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-serverless-frontier-02', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-1', 'cold-starts', 'Cold Starts', 'Understand why the first invocation after any period of idle time is never the fastest one.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"cold-starts-sim"}'::jsonb, '{"xp":240,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-serverless-frontier-03', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-1', 'triggers', 'Triggers', 'Confirm the trigger from Act 12 is not just declared this time -- confirm it is actually applied.', 'beginner', ARRAY['vey','rook'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"triggers-sim"}'::jsonb, '{"xp":250,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-serverless-frontier-04', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-1', 'api-gateways', 'API Gateways', 'Understand what turns a plain function into something a client can actually call over HTTP.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"api-gateways-sim"}'::jsonb, '{"xp":250,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-serverless-frontier-05', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-1', 'queues', 'Queues', 'Confirm how a completely different function draws work from a queue instead of reacting to a single event.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"queues-sim"}'::jsonb, '{"xp":260,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-serverless-frontier-06', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-1', 'event-buses', 'Event Buses', 'Understand what changes once one event needs to reach several unrelated functions at once.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"event-buses-sim"}'::jsonb, '{"xp":260,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-serverless-frontier-07', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-2', 'object-events', 'Object Events', 'Confirm what actually fires the moment a new build artifact lands in the Act 5 bucket.', 'beginner', ARRAY['vey','rook'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"object-events-sim"}'::jsonb, '{"xp":260,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-serverless-frontier-08', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-2', 'statelessness', 'Statelessness', 'Understand why a function can never assume anything it stored in memory will still be there next time.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"statelessness-sim"}'::jsonb, '{"xp":270,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-serverless-frontier-09', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-2', 'concurrency', 'Concurrency', 'Rule out one possible explanation for the climbing invocation count before assuming anything else.', 'beginner', ARRAY['vey','cross'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"concurrency-sim"}'::jsonb, '{"xp":270,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-serverless-frontier-10', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-2', 'retries-dlqs', 'Retries and DLQs', 'Confirm exactly how many times a failed invocation of this function is actually allowed to retry.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"retries-dlqs-sim"}'::jsonb, '{"xp":280,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-serverless-frontier-11', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-2', 'cost', 'Cost', 'Confirm what four thousand failed invocations in one hour is actually costing right now.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"cost-sim"}'::jsonb, '{"xp":280,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-serverless-frontier-12', 'world-atlas-serverless-frontier', 'campaign-atlas-serverless-frontier', 'operation-atlas-serverless-frontier-2', 'invocation-storm', 'Invocation Storm', 'Everything this Act taught, turned on one function: not to just add a retry limit, to finally explain how one missing permission became thousands of invocations entirely on its own.', 'boss', ARRAY['vey','cross','rook','leena'], '{"requiredMissionIds":["mission-atlas-serverless-frontier-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"invocation-storm-boss-sim"}'::jsonb, '{"xp":540,"credits":125,"badgeIds":["invocation-storm"],"skillXp":{"cloud_devops_fundamentals":95}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-serverless-frontier-01', 1, 'leena', 'The Act 12 fix landed for real this time. region_guard_remediate is deployed, its trigger applied, live for the first time in this whole story.'),
  ('mission-atlas-serverless-frontier-01', 2, 'vey', 'And within the hour, its invocation count has already climbed past four thousand and is still climbing.'),
  ('mission-atlas-serverless-frontier-01', 3, 'vey', 'A function is one deployable unit of code, invoked per event, with the provider managing the runtime entirely -- no server to patch, size, or keep running when nothing is happening. That last part is exactly what makes this number so strange.'),

  ('mission-atlas-serverless-frontier-02', 1, 'vey', 'The very first invocation after any idle period pays a cost the rest do not -- initializing a fresh execution environment before your code even runs. A cold start. It explains latency spikes. It does not explain four thousand invocations.'),

  ('mission-atlas-serverless-frontier-03', 1, 'rook', 'Confirm the trigger actually applied this time -- not just declared in code the way it was last Act.'),
  ('mission-atlas-serverless-frontier-03', 2, 'vey', 'It did. The function is genuinely live. That is not in question anymore -- what it is doing once invoked is.'),

  ('mission-atlas-serverless-frontier-04', 1, 'vey', 'An API gateway is what turns a plain function into something a client can call directly over HTTP, with routing, authentication and rate limiting handled in front of it. region_guard_remediate has none of that -- it only ever responds to the SNS trigger, never a direct call.'),

  ('mission-atlas-serverless-frontier-05', 1, 'vey', 'A completely different function here draws its work from a queue instead -- pulling a batch of messages at a time, rather than reacting to one event immediately. Confirm how that one is actually wired.'),

  ('mission-atlas-serverless-frontier-06', 1, 'vey', 'An event bus lets one event fan out to several unrelated functions at once, each deciding independently whether it cares. A direct SNS subscription, like this one, only ever reaches the one function listening to it.'),

  ('mission-atlas-serverless-frontier-07', 1, 'rook', 'This is the same S3 bucket from Act 5, still replicating build artifacts. Confirm what actually fires the moment a new one lands in it.'),

  ('mission-atlas-serverless-frontier-08', 1, 'vey', 'A function must never assume anything it stored in memory locally will still be there on the next invocation -- it could easily run on a completely fresh instance every single time. Whatever needs to persist has to live somewhere else entirely.'),

  ('mission-atlas-serverless-frontier-09', 1, 'cross', 'Imani Cross. Before assuming anything exotic, rule out the boring explanation first -- confirm whether this function is actually hitting a concurrency limit.'),
  ('mission-atlas-serverless-frontier-09', 2, 'vey', 'It is nowhere close. Whatever is driving this number, it is not that.'),

  ('mission-atlas-serverless-frontier-10', 1, 'cross', 'Confirm exactly how many times a single failed invocation of this function is actually allowed to retry, and what happens to it if it keeps failing.'),

  ('mission-atlas-serverless-frontier-11', 1, 'vey', 'Confirm what four thousand failed invocations in one hour is actually costing right now, while we are still figuring out why.'),

  ('mission-atlas-serverless-frontier-12', 1, 'leena', 'Everything this Act taught you, on one function. Not to just cap the retries and move on -- to finally explain how one missing permission became thousands of invocations entirely on its own.'),
  ('mission-atlas-serverless-frontier-12', 2, 'byte', 'I have the live invocation metrics and the function''s own execution log both pulled up together. Every single invocation has failed with the exact same error.'),
  ('mission-atlas-serverless-frontier-12', 3, 'rook', 'The Act 11 role was scoped for exactly what anyone understood this function would need at the time. Nobody ever finished specifying what remediation itself actually required.'),
  ('mission-atlas-serverless-frontier-12', 4, 'vey', 'Find the one permission gap underneath all four thousand invocations, and explain how a retry policy with no limit turned it into a storm.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-serverless-frontier-01-o1', 'mission-atlas-serverless-frontier-01', 1, 'Define a function', 'Choose the accurate description of what a serverless function actually is.'),

  ('mission-atlas-serverless-frontier-02-o1', 'mission-atlas-serverless-frontier-02', 1, 'Explain cold starts', 'Choose the accurate description of what a cold start actually is.'),

  ('mission-atlas-serverless-frontier-03-o1', 'mission-atlas-serverless-frontier-03', 1, 'Confirm the trigger is applied', 'Read the trigger configuration and submit the verification code.'),

  ('mission-atlas-serverless-frontier-04-o1', 'mission-atlas-serverless-frontier-04', 1, 'Explain API gateways', 'Choose the accurate description of what an API gateway actually provides.'),

  ('mission-atlas-serverless-frontier-05-o1', 'mission-atlas-serverless-frontier-05', 1, 'Check the queue-driven function', 'Read the queue-triggered function definition and submit the verification code.'),

  ('mission-atlas-serverless-frontier-06-o1', 'mission-atlas-serverless-frontier-06', 1, 'Explain event buses', 'Choose the accurate description of what an event bus actually provides.'),

  ('mission-atlas-serverless-frontier-07-o1', 'mission-atlas-serverless-frontier-07', 1, 'Check the object event notification', 'Read the S3 event notification and submit the verification code.'),

  ('mission-atlas-serverless-frontier-08-o1', 'mission-atlas-serverless-frontier-08', 1, 'Explain statelessness', 'Choose the accurate description of what statelessness actually requires.'),

  ('mission-atlas-serverless-frontier-09-o1', 'mission-atlas-serverless-frontier-09', 1, 'Rule out concurrency', 'Read the concurrency settings and submit the verification code.'),

  ('mission-atlas-serverless-frontier-10-o1', 'mission-atlas-serverless-frontier-10', 1, 'Check the retry policy', 'Read the retry policy and submit the verification code.'),

  ('mission-atlas-serverless-frontier-11-o1', 'mission-atlas-serverless-frontier-11', 1, 'Check the cost report', 'Read the cost report and submit the verification code.'),

  ('mission-atlas-serverless-frontier-12-o1', 'mission-atlas-serverless-frontier-12', 1, 'Confirm the invocation storm', 'Read the live invocation metrics and submit the verification code.'),
  ('mission-atlas-serverless-frontier-12-o2', 'mission-atlas-serverless-frontier-12', 2, 'Confirm the actual failure', 'Read the execution log and submit the verification code.'),
  ('mission-atlas-serverless-frontier-12-o3', 'mission-atlas-serverless-frontier-12', 3, 'Identify what actually explains this', 'Find the evidence that explains how one failure became a storm.'),
  ('mission-atlas-serverless-frontier-12-o4', 'mission-atlas-serverless-frontier-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-serverless-frontier-01-o1-c1', 'mission-atlas-serverless-frontier-01-o1', 1, 'multiple_choice', 'A serverless function is best described as...', '{"question":"A serverless function is best described as...","options":[{"id":"a","text":"One deployable unit of code, invoked per event, with the provider managing the runtime entirely -- no server to patch, size, or keep running when idle"},{"id":"b","text":"A virtual machine that starts automatically whenever traffic arrives"},{"id":"c","text":"A container that must be manually restarted after every invocation"},{"id":"d","text":"A synonym for a load balancer target"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-serverless-frontier-02-o1-c1', 'mission-atlas-serverless-frontier-02-o1', 1, 'multiple_choice', 'A cold start is best described as...', '{"question":"A cold start is best described as...","options":[{"id":"a","text":"The extra latency of the first invocation after idle time, spent initializing a fresh execution environment before the code itself runs"},{"id":"b","text":"A function that has been permanently disabled"},{"id":"c","text":"The billing period reset at the start of each month"},{"id":"d","text":"A synonym for a failed invocation"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-serverless-frontier-03-o1-c1', 'mission-atlas-serverless-frontier-03-o1', 1, 'terminal_simulation', 'Read the trigger configuration and submit the verification code.', '{"instructions":"Read /repo/infra/aws/serverless/trigger.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/serverless/trigger.txt":{"type":"file","content":"resource \"aws_lambda_permission\" \"allow_sns\" {\n  action = \"lambda:InvokeFunction\"\n  function_name = aws_lambda_function.region_guard_remediate.function_name\n  principal = \"sns.amazonaws.com\"\n  source_arn = aws_sns_topic.atlas_region_guard_topic.arn\n}\n# this time it is actually applied -- terraform apply confirmed, function live\n# verification TRIGGER-3312\n"}}}'::jsonb, '{"requiredFlag":"TRIGGER-3312"}'::jsonb),

  ('mission-atlas-serverless-frontier-04-o1-c1', 'mission-atlas-serverless-frontier-04-o1', 1, 'multiple_choice', 'An API gateway is best described as...', '{"question":"An API gateway is best described as...","options":[{"id":"a","text":"The layer that turns a plain function into something a client can call directly over HTTP, handling routing, authentication and rate limiting in front of it"},{"id":"b","text":"A synonym for a function''s own runtime"},{"id":"c","text":"Required for every function regardless of how it is triggered"},{"id":"d","text":"A type of database connection pool"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-serverless-frontier-05-o1-c1', 'mission-atlas-serverless-frontier-05-o1', 1, 'terminal_simulation', 'Read the queue-triggered function definition and submit the verification code.', '{"instructions":"Read /repo/infra/aws/serverless/queue-function.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/serverless/queue-function.txt":{"type":"file","content":"resource \"aws_lambda_event_source_mapping\" \"order_queue\" {\n  event_source_arn = aws_sqs_queue.atlas_orders.arn\n  function_name = aws_lambda_function.process_order.function_name\n  batch_size = 10\n}\n# a separate function, unrelated to region-guard -- polls the queue in batches rather than reacting to one event at a time\n# verification QUEUE-6602\n"}}}'::jsonb, '{"requiredFlag":"QUEUE-6602"}'::jsonb),

  ('mission-atlas-serverless-frontier-06-o1-c1', 'mission-atlas-serverless-frontier-06-o1', 1, 'multiple_choice', 'An event bus is best described as...', '{"question":"An event bus is best described as...","options":[{"id":"a","text":"A system that lets one event fan out to several unrelated targets at once, each deciding independently whether it cares"},{"id":"b","text":"A direct, one-to-one subscription between exactly one publisher and one function"},{"id":"c","text":"A synonym for a load balancer"},{"id":"d","text":"Only usable for scheduled, time-based invocations"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-serverless-frontier-07-o1-c1', 'mission-atlas-serverless-frontier-07-o1', 1, 'terminal_simulation', 'Read the S3 event notification and submit the verification code.', '{"instructions":"Read /repo/infra/aws/serverless/s3-events.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/serverless/s3-events.txt":{"type":"file","content":"resource \"aws_s3_bucket_notification\" \"artifact_uploaded\" {\n  bucket = aws_s3_bucket.atlas_eu_west_artifacts.id\n  lambda_function {\n    events = [\"s3:ObjectCreated:*\"]\n    lambda_function_arn = aws_lambda_function.notify_new_artifact.arn\n  }\n}\n# fires notify-new-artifact automatically the moment a build artifact lands in the Act 5 bucket\n# verification S3EVENT-7714\n"}}}'::jsonb, '{"requiredFlag":"S3EVENT-7714"}'::jsonb),

  ('mission-atlas-serverless-frontier-08-o1-c1', 'mission-atlas-serverless-frontier-08-o1', 1, 'multiple_choice', 'Statelessness in a serverless function means...', '{"question":"Statelessness in a serverless function means...","options":[{"id":"a","text":"Nothing stored locally in memory or on disk is guaranteed to survive to the next invocation, since it could run on an entirely fresh instance every time"},{"id":"b","text":"The function can never accept any input parameters"},{"id":"c","text":"The function must always run on the exact same physical machine"},{"id":"d","text":"State can be safely stored in a local file as long as the function does not crash"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-serverless-frontier-09-o1-c1', 'mission-atlas-serverless-frontier-09-o1', 1, 'terminal_simulation', 'Read the concurrency settings and submit the verification code.', '{"instructions":"Read /repo/infra/aws/serverless/concurrency.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/serverless/concurrency.txt":{"type":"file","content":"region_guard_remediate concurrency settings:\n  reserved_concurrency: unset (uses the shared account-wide pool)\n  account concurrency limit: 1000\n  currently in use: 40 of 1000\n# nowhere near the limit -- concurrency is not the bottleneck here\n# verification CONCURRENCY-4471\n"}}}'::jsonb, '{"requiredFlag":"CONCURRENCY-4471"}'::jsonb),

  ('mission-atlas-serverless-frontier-10-o1-c1', 'mission-atlas-serverless-frontier-10-o1', 1, 'terminal_simulation', 'Read the retry policy and submit the verification code.', '{"instructions":"Read /repo/infra/aws/serverless/retry-policy.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/serverless/retry-policy.txt":{"type":"file","content":"region_guard_remediate retry configuration:\n  maximum_retry_attempts: unset (defaults to the provider maximum)\n  dead_letter_queue: none configured\n# a failed invocation here has nowhere to go except retry again\n# verification RETRY-8802\n"}}}'::jsonb, '{"requiredFlag":"RETRY-8802"}'::jsonb),

  ('mission-atlas-serverless-frontier-11-o1-c1', 'mission-atlas-serverless-frontier-11-o1', 1, 'terminal_simulation', 'Read the cost report and submit the verification code.', '{"instructions":"Read /var/atlas-aws-live/cost-report.txt and submit the verification code with: submit CODE","hostname":"atlas-aws-live-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-aws-live-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-aws-live/cost-report.txt":{"type":"file","content":"region_guard_remediate invocation cost:\n  yesterday: 12 invocations, $0.00\n  today: 4,812 invocations, $1.94 and climbing\n# verification COST-2291\n"}}}'::jsonb, '{"requiredFlag":"COST-2291"}'::jsonb),

  ('mission-atlas-serverless-frontier-12-o1-c1', 'mission-atlas-serverless-frontier-12-o1', 1, 'terminal_simulation', 'Read the live invocation metrics and submit the verification code.', '{"instructions":"Read /var/atlas-aws-live/invocation-metrics.txt and submit the verification code with: submit CODE","hostname":"atlas-aws-live-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-aws-live-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-aws-live/invocation-metrics.txt":{"type":"file","content":"region_guard_remediate invocations, last 1h: 4,812\nerror rate: 100% -- every single invocation has failed\n# verification INVOKE-9012\n"}}}'::jsonb, '{"requiredFlag":"INVOKE-9012"}'::jsonb),
  ('mission-atlas-serverless-frontier-12-o2-c1', 'mission-atlas-serverless-frontier-12-o2', 1, 'terminal_simulation', 'Read the execution log and submit the verification code.', '{"instructions":"Read /var/atlas-aws-live/execution-log.txt and submit the verification code with: submit CODE","hostname":"atlas-aws-live-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-aws-live-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-aws-live/execution-log.txt":{"type":"file","content":"region_guard_remediate execution log (representative entry, repeated 4,812 times):\nAccessDeniedException: user is not authorized to perform route53:ChangeResourceRecordSets\n# verification EXECLOG-4471\n"}}}'::jsonb, '{"requiredFlag":"EXECLOG-4471"}'::jsonb),
  ('mission-atlas-serverless-frontier-12-o3-c1', 'mission-atlas-serverless-frontier-12-o3', 1, 'investigation', 'Which evidence explains how one failure became a storm?', '{"evidence":[{"id":"e1","label":"IAM role (from Act 12)","detail":"The role attached to region_guard_remediate only grants ec2:Describe* and s3:GetObject -- it was never extended to include route53 or elbv2 permissions"},{"id":"e2","label":"Retry policy","detail":"No maximum retry attempts and no dead-letter queue are configured, so a failed invocation simply retries again with nowhere else to go"},{"id":"e3","label":"Concurrency settings","detail":"Only 40 of 1000 available concurrency slots are in use -- nowhere near the account limit"},{"id":"e4","label":"Cost report","detail":"The invocation cost is climbing, currently $1.94 and rising"}],"question":"Which evidence explains how one failure became a storm?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-serverless-frontier-12-o4-c1', 'mission-atlas-serverless-frontier-12-o4', 1, 'boss_encounter', 'Having confirmed the storm, the actual failure, and what explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-serverless-frontier-12-o1","label":"Confirm the invocation storm"},{"objectiveRef":"mission-atlas-serverless-frontier-12-o2","label":"Confirm the actual failure"},{"objectiveRef":"mission-atlas-serverless-frontier-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: the Act 11 role was scoped correctly for everything anyone understood region_guard_remediate would need, but was never actually extended to cover the Route 53 and load-balancer permissions the remediation itself requires -- and with no maximum retry attempts and no dead-letter queue configured, that one missing permission did not fail once, it failed and retried thousands of times entirely on its own, and the fix requires both extending the role and bounding the retries with a dead-letter queue."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-serverless-frontier-12-o1","mission-atlas-serverless-frontier-12-o2","mission-atlas-serverless-frontier-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-serverless-frontier-01-o1-c1', 'orientation', 'Think about who manages the runtime, and when it actually runs.', 10, 1),
  ('mission-atlas-serverless-frontier-01-o1-c1', 'solution', 'One unit of code invoked per event, with the provider managing the runtime.', 20, 2),

  ('mission-atlas-serverless-frontier-02-o1-c1', 'orientation', 'Think about what has to happen before your own code even starts running.', 10, 1),
  ('mission-atlas-serverless-frontier-02-o1-c1', 'solution', 'It is the extra latency of initializing a fresh execution environment after idle time.', 20, 2),

  ('mission-atlas-serverless-frontier-03-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/serverless/trigger.txt', 10, 1),
  ('mission-atlas-serverless-frontier-03-o1-c1', 'solution', 'The trigger is applied, verification TRIGGER-3312. submit TRIGGER-3312', 20, 2),

  ('mission-atlas-serverless-frontier-04-o1-c1', 'orientation', 'Think about what stands between a raw function and a client calling it over HTTP.', 10, 1),
  ('mission-atlas-serverless-frontier-04-o1-c1', 'solution', 'It handles routing, authentication and rate limiting in front of the function.', 20, 2),

  ('mission-atlas-serverless-frontier-05-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/serverless/queue-function.txt', 10, 1),
  ('mission-atlas-serverless-frontier-05-o1-c1', 'solution', 'It polls the queue in batches, verification QUEUE-6602. submit QUEUE-6602', 20, 2),

  ('mission-atlas-serverless-frontier-06-o1-c1', 'orientation', 'Think about one event reaching several independent listeners at once.', 10, 1),
  ('mission-atlas-serverless-frontier-06-o1-c1', 'solution', 'An event bus fans one event out to several unrelated targets.', 20, 2),

  ('mission-atlas-serverless-frontier-07-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/serverless/s3-events.txt', 10, 1),
  ('mission-atlas-serverless-frontier-07-o1-c1', 'solution', 'ObjectCreated fires notify-new-artifact, verification S3EVENT-7714. submit S3EVENT-7714', 20, 2),

  ('mission-atlas-serverless-frontier-08-o1-c1', 'orientation', 'Think about whether the same physical instance is guaranteed to serve the next call.', 10, 1),
  ('mission-atlas-serverless-frontier-08-o1-c1', 'solution', 'Nothing stored locally is guaranteed to survive to the next invocation.', 20, 2),

  ('mission-atlas-serverless-frontier-09-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/serverless/concurrency.txt', 10, 1),
  ('mission-atlas-serverless-frontier-09-o1-c1', 'solution', 'Only 40 of 1000 slots used, verification CONCURRENCY-4471. submit CONCURRENCY-4471', 20, 2),

  ('mission-atlas-serverless-frontier-10-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/serverless/retry-policy.txt', 10, 1),
  ('mission-atlas-serverless-frontier-10-o1-c1', 'solution', 'No maximum attempts, no DLQ, verification RETRY-8802. submit RETRY-8802', 20, 2),

  ('mission-atlas-serverless-frontier-11-o1-c1', 'orientation', 'Try: cat /var/atlas-aws-live/cost-report.txt', 10, 1),
  ('mission-atlas-serverless-frontier-11-o1-c1', 'solution', '4,812 invocations and climbing, verification COST-2291. submit COST-2291', 20, 2),

  ('mission-atlas-serverless-frontier-12-o1-c1', 'orientation', 'Try: cat /var/atlas-aws-live/invocation-metrics.txt', 10, 1),
  ('mission-atlas-serverless-frontier-12-o1-c1', 'solution', '100% error rate, verification INVOKE-9012. submit INVOKE-9012', 20, 2),
  ('mission-atlas-serverless-frontier-12-o2-c1', 'orientation', 'Try: cat /var/atlas-aws-live/execution-log.txt', 10, 1),
  ('mission-atlas-serverless-frontier-12-o2-c1', 'solution', 'AccessDeniedException on route53, verification EXECLOG-4471. submit EXECLOG-4471', 20, 2),
  ('mission-atlas-serverless-frontier-12-o3-c1', 'orientation', 'Concurrency and cost are both symptoms, not causes. Look for the permission gap and what let a single failure repeat forever.', 10, 1),
  ('mission-atlas-serverless-frontier-12-o3-c1', 'solution', 'e1 and e2: a missing route53/elbv2 permission plus an unbounded retry policy with no dead-letter queue.', 20, 2),
  ('mission-atlas-serverless-frontier-12-o4-c1', 'orientation', 'Combine the missing permission, the unbounded retries, and what has to change into one sentence.', 15, 1),
  ('mission-atlas-serverless-frontier-12-o4-c1', 'solution', 'The role was never extended to cover the permissions this remediation actually needs, and with no retry limit or dead-letter queue, one missing permission became thousands of invocations on its own -- both the role and the retry policy need fixing.', 25, 2);
