-- Atlas Division pathway ("The Silence") Act 24 -- "The Trace"
-- content, under world-atlas-the-trace (already inserted separately).
-- 1 campaign, 2 operations, 12 missions (11 lessons + boss), continuing
-- World VII "The Signal Tower".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- tracing artifact here is static seeded text read via `cat`. Two
-- hosts, both reused: `atlas-devbox-01`, still hosting the
-- `observability/` directory inside the Act 22 `infra-envs` GitOps
-- repo (OpenTelemetry collector config, instrumentation notes,
-- pipeline definition, sampling config), and `atlas-observability-01`
-- for live data (a sample trace, correlated logs, the trace-coverage
-- report driving the boss). Concept-only topics with no natural
-- artifact (tracing, sampling, cardinality) stay multiple_choice.
--
-- Narrative thread: mission 6 (sampling) plants the flat 5% head-based
-- rate as a plain fact, without yet framing it as a problem. The boss
-- asks for every error trace from the last 24 hours and finds only 71
-- of roughly 1,400 expected -- landing on the actual lesson: sampling
-- decided before a request's outcome is known cannot prioritize the
-- requests that turn out to matter most. This is presented as a real
-- design gap in the sampling *strategy*, not a pipeline failure or a
-- cost-driven decision (the cost report is a deliberate ruled-out
-- distractor in the investigation).

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-the-trace', 'world-atlas-the-trace', 'the-trace', '7C - The Trace', 'Learn distributed tracing from first principles -- tracing, spans, trace context, OpenTelemetry, instrumentation, sampling, correlation IDs, telemetry correlation, cardinality, pipelines and cost -- while Cross discovers the fleet''s own sampling strategy has been discarding the exact evidence needed most.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-the-trace-1', 'campaign-atlas-the-trace', 'following-one-request-everywhere', 'Following One Request Everywhere', 'Tracing, spans, trace context, OpenTelemetry and instrumentation.', 1),
  ('operation-atlas-the-trace-2', 'campaign-atlas-the-trace', 'what-actually-gets-kept', 'What Actually Gets Kept', 'Sampling, correlation IDs, telemetry correlation, cardinality, pipelines and cost.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-the-trace-01', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-1', 'tracing', 'Tracing', 'Cross instruments the fleet for distributed tracing, to finally see exactly why the legacy client keeps failing, not just that it does.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"tracing-sim"}'::jsonb, '{"xp":560,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-the-trace-02', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-1', 'spans', 'Spans', 'Confirm exactly how one request actually breaks down into individual, timed pieces of work.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-trace-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"spans-sim"}'::jsonb, '{"xp":560,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-the-trace-03', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-1', 'trace-context', 'Trace Context', 'Understand what actually ties every span across every service back into the same single trace.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-trace-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"trace-context-sim"}'::jsonb, '{"xp":570,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-the-trace-04', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-1', 'opentelemetry', 'OpenTelemetry', 'Confirm what actually collects this fleet''s traces, in a way that is not locked to any one vendor.', 'beginner', ARRAY['cross','rook'], '{"requiredMissionIds":["mission-atlas-the-trace-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"opentelemetry-sim"}'::jsonb, '{"xp":570,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-the-trace-05', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-1', 'instrumentation', 'Instrumentation', 'Confirm exactly which services are actually emitting spans right now, and which still are not.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-trace-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"instrumentation-sim"}'::jsonb, '{"xp":580,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-the-trace-06', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-2', 'sampling', 'Sampling', 'Confirm exactly what fraction of requests this fleet actually keeps a trace for.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-trace-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"sampling-sim"}'::jsonb, '{"xp":580,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-the-trace-07', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-2', 'correlation-ids', 'Correlation IDs', 'Confirm how one specific log line actually gets tied back to the exact trace it happened inside of.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-trace-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"correlation-ids-sim"}'::jsonb, '{"xp":590,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-the-trace-08', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-2', 'telemetry-correlation', 'Telemetry Correlation', 'Understand why a metric spike, a log line and a trace all need to point back to each other, not just exist separately.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-trace-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"telemetry-correlation-sim"}'::jsonb, '{"xp":590,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-the-trace-09', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-2', 'cardinality', 'Cardinality', 'Understand why the exact same kind of unique ID that is fine on a trace would break a metric completely.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-trace-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"cardinality-sim"}'::jsonb, '{"xp":600,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-the-trace-10', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-2', 'pipelines', 'Pipelines', 'Confirm exactly how a trace actually gets from the running application to somewhere it can be queried later.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-trace-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"pipelines-sim"}'::jsonb, '{"xp":600,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-the-trace-11', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-2', 'cost', 'Cost', 'Confirm what tracing everything, all the time, would actually cost this fleet.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-trace-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"cost-sim"}'::jsonb, '{"xp":600,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-the-trace-12', 'world-atlas-the-trace', 'campaign-atlas-the-trace', 'operation-atlas-the-trace-2', 'the-five-percent', 'The Five Percent', 'Everything this Act taught, turned on one missing set of traces: not to just crank sampling up and hope, to finally explain why the exact evidence this fleet needed most was the evidence it never kept.', 'boss', ARRAY['cross','byte','rook','leena'], '{"requiredMissionIds":["mission-atlas-the-trace-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"five-percent-boss-sim"}'::jsonb, '{"xp":760,"credits":180,"badgeIds":["the-five-percent"],"skillXp":{"cloud_devops_fundamentals":120}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-the-trace-01', 1, 'leena', 'Cross is instrumenting the fleet for distributed tracing, to finally see exactly why the legacy client keeps failing, not just that it does.'),
  ('mission-atlas-the-trace-01', 2, 'cross', 'Imani Cross. A trace follows one single request across every service it actually touches, end to end -- exactly the question a metric or an isolated log line was never built to answer on its own.'),

  ('mission-atlas-the-trace-02', 1, 'cross', 'A trace is made of spans -- one span per unit of work, each with its own start time, end time and parent. Confirm how one request actually breaks down.'),

  ('mission-atlas-the-trace-03', 1, 'cross', 'Every span carries the same trace ID as every other span from the same request, propagated forward automatically across every service boundary. That is the only reason they can ever be reassembled into one trace afterward.'),

  ('mission-atlas-the-trace-04', 1, 'rook', 'OpenTelemetry is what actually collects this. A vendor-neutral standard, so switching backends later never means re-instrumenting every service from scratch.'),

  ('mission-atlas-the-trace-05', 1, 'cross', 'Confirm exactly which services are actually emitting spans right now. Assume nothing is instrumented just because it should be.'),

  ('mission-atlas-the-trace-06', 1, 'cross', 'Tracing every single request forever would be enormous. Confirm exactly what fraction of requests actually get kept right now.'),

  ('mission-atlas-the-trace-07', 1, 'cross', 'A correlation ID is what actually ties one specific log line back to the exact trace it happened inside of -- without it, a log and a trace are just two separate stories about the same request.'),

  ('mission-atlas-the-trace-08', 1, 'cross', 'A metric spike alone tells you something changed. A trace alone tells you what one request did. Correlated together, by the same IDs, they tell you what changed and exactly which requests actually explain it.'),

  ('mission-atlas-the-trace-09', 1, 'cross', 'A unique trace ID on a trace is completely fine -- traces are looked up individually, one at a time. That exact same uniqueness as a metric label would multiply the number of distinct time series without bound. Understand why the two cases are not the same.'),

  ('mission-atlas-the-trace-10', 1, 'rook', 'A span does not teleport from the application straight into a query dashboard. Confirm the actual pipeline it travels through to get there.'),

  ('mission-atlas-the-trace-11', 1, 'cross', 'Confirm what tracing everything, all the time, would actually cost. That number is exactly why sampling exists in the first place.'),

  ('mission-atlas-the-trace-12', 1, 'leena', 'Everything this Act taught you, on one missing set of traces. Not to just crank sampling up and hope -- to finally explain why the exact evidence this fleet needed most was the evidence it never kept.'),
  ('mission-atlas-the-trace-12', 2, 'byte', 'I asked for every trace tied to a failed request in the last 24 hours. Based on the known error rate, there should be roughly 1,400. There are 71.'),
  ('mission-atlas-the-trace-12', 3, 'cross', 'The pipeline is not broken. Nothing was lost by accident.'),
  ('mission-atlas-the-trace-12', 4, 'rook', 'Then find exactly what decided which 5% got kept, and explain why it was never going to be the right 5%.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-the-trace-01-o1', 'mission-atlas-the-trace-01', 1, 'Explain tracing', 'Choose the accurate description of what distributed tracing actually follows.'),

  ('mission-atlas-the-trace-02-o1', 'mission-atlas-the-trace-02', 1, 'Read a sample trace', 'Read the sample trace and submit the verification code.'),

  ('mission-atlas-the-trace-03-o1', 'mission-atlas-the-trace-03', 1, 'Explain trace context', 'Choose the accurate description of what actually ties spans together into one trace.'),

  ('mission-atlas-the-trace-04-o1', 'mission-atlas-the-trace-04', 1, 'Read the OpenTelemetry collector config', 'Read the collector configuration and submit the verification code.'),

  ('mission-atlas-the-trace-05-o1', 'mission-atlas-the-trace-05', 1, 'Read the instrumentation coverage', 'Read the instrumentation notes and submit the verification code.'),

  ('mission-atlas-the-trace-06-o1', 'mission-atlas-the-trace-06', 1, 'Read the sampling config', 'Read the sampling configuration and submit the verification code.'),

  ('mission-atlas-the-trace-07-o1', 'mission-atlas-the-trace-07', 1, 'Read the correlated log', 'Read the correlated log entry and submit the verification code.'),

  ('mission-atlas-the-trace-08-o1', 'mission-atlas-the-trace-08', 1, 'Explain telemetry correlation', 'Choose the accurate description of why logs, metrics and traces need to be correlated together.'),

  ('mission-atlas-the-trace-09-o1', 'mission-atlas-the-trace-09', 1, 'Explain cardinality', 'Choose the accurate description of why a unique ID is safe on a trace but dangerous as a metric label.'),

  ('mission-atlas-the-trace-10-o1', 'mission-atlas-the-trace-10', 1, 'Read the pipeline definition', 'Read the observability pipeline and submit the verification code.'),

  ('mission-atlas-the-trace-11-o1', 'mission-atlas-the-trace-11', 1, 'Read the cost report', 'Read the tracing cost report and submit the verification code.'),

  ('mission-atlas-the-trace-12-o1', 'mission-atlas-the-trace-12', 1, 'Confirm the sampling rate', 'Read the sampling configuration and submit the verification code.'),
  ('mission-atlas-the-trace-12-o2', 'mission-atlas-the-trace-12', 2, 'Confirm the missing error traces', 'Read the trace coverage report and submit the verification code.'),
  ('mission-atlas-the-trace-12-o3', 'mission-atlas-the-trace-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why the exact traces needed most were never kept.'),
  ('mission-atlas-the-trace-12-o4', 'mission-atlas-the-trace-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-the-trace-01-o1-c1', 'mission-atlas-the-trace-01-o1', 1, 'multiple_choice', 'Distributed tracing actually follows...', '{"question":"Distributed tracing actually follows...","options":[{"id":"a","text":"One single request end to end, across every service it actually touches, showing the full call path and where time was spent"},{"id":"b","text":"The total CPU usage of a single node over time"},{"id":"c","text":"Only requests that eventually fail"},{"id":"d","text":"A synonym for a structured log line"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-trace-02-o1-c1', 'mission-atlas-the-trace-02-o1', 1, 'terminal_simulation', 'Read the sample trace and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/sample-trace.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/sample-trace.txt":{"type":"file","content":"trace 7a1b2c: POST /ingest\n  span: collector.receive        0-4ms\n  span: collector.validate       4-6ms\n  span: db.write                 6-19ms\n# one request, three spans, each timed and nested under the request as a whole\n# verification SPANS-3312\n"}}}'::jsonb, '{"requiredFlag":"SPANS-3312"}'::jsonb),

  ('mission-atlas-the-trace-03-o1-c1', 'mission-atlas-the-trace-03-o1', 1, 'multiple_choice', 'Trace context actually ties spans together by...', '{"question":"Trace context actually ties spans together by...","options":[{"id":"a","text":"Propagating the same trace ID forward automatically across every service boundary a request crosses"},{"id":"b","text":"Matching spans that happen to have similar response times"},{"id":"c","text":"Requiring every service to share the exact same log file"},{"id":"d","text":"Assigning a new, unrelated ID at every service boundary"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-trace-04-o1-c1', 'mission-atlas-the-trace-04-o1', 1, 'terminal_simulation', 'Read the collector configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/otel-collector.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/otel-collector.yaml":{"type":"file","content":"receivers:\n  otlp:\n    protocols:\n      grpc:\nexporters:\n  prometheus:\n  otlphttp:\nservice:\n  pipelines:\n    traces:\n      receivers: [otlp]\n      exporters: [otlphttp]\n# vendor-neutral -- the same collector works regardless of which backend actually stores the data\n# verification OTEL-6602\n"}}}'::jsonb, '{"requiredFlag":"OTEL-6602"}'::jsonb),

  ('mission-atlas-the-trace-05-o1-c1', 'mission-atlas-the-trace-05-o1', 1, 'terminal_simulation', 'Read the instrumentation notes and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/instrumentation-status.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/instrumentation-status.txt":{"type":"file","content":"atlas-metrics-agent: instrumented (auto-instrumentation, OpenTelemetry SDK)\natlas-metrics-db: instrumented (query spans)\nlegacy-client-gateway: NOT instrumented\n# verification INSTRUMENT-7714\n"}}}'::jsonb, '{"requiredFlag":"INSTRUMENT-7714"}'::jsonb),

  ('mission-atlas-the-trace-06-o1-c1', 'mission-atlas-the-trace-06-o1', 1, 'terminal_simulation', 'Read the sampling configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/sampling-config.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/sampling-config.yaml":{"type":"file","content":"sampler: probabilistic\nsampling_rate: 0.05\nstrategy: head-based\n# decided randomly, the instant a request starts, with no way yet to know whether it will fail\n# verification SAMPLING-4471\n"}}}'::jsonb, '{"requiredFlag":"SAMPLING-4471"}'::jsonb),

  ('mission-atlas-the-trace-07-o1-c1', 'mission-atlas-the-trace-07-o1', 1, 'terminal_simulation', 'Read the correlated log entry and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/correlated-log.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/correlated-log.txt":{"type":"file","content":"{\"time\":\"2026-08-16T09:14:03Z\",\"level\":\"error\",\"msg\":\"failed to process payload\",\"trace_id\":\"7a1b2c\",\"status\":500}\n# this exact log line can now be looked up as part of trace 7a1b2c, not read in isolation\n# verification CORRELATION-8802\n"}}}'::jsonb, '{"requiredFlag":"CORRELATION-8802"}'::jsonb),

  ('mission-atlas-the-trace-08-o1-c1', 'mission-atlas-the-trace-08-o1', 1, 'multiple_choice', 'Logs, metrics and traces need to be correlated together because...', '{"question":"Logs, metrics and traces need to be correlated together because...","options":[{"id":"a","text":"A metric spike alone only shows something changed; correlating it with traces and logs sharing the same IDs shows exactly which requests explain it"},{"id":"b","text":"Only one of the three is ever actually necessary"},{"id":"c","text":"Correlation is only useful for successful requests, never failures"},{"id":"d","text":"Metrics and traces can never share any identifying information"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-trace-09-o1-c1', 'mission-atlas-the-trace-09-o1', 1, 'multiple_choice', 'A unique ID is safe as a trace identifier but dangerous as a metric label because...', '{"question":"A unique ID is safe as a trace identifier but dangerous as a metric label because...","options":[{"id":"a","text":"Traces are looked up individually one at a time, while a metric label creates a brand-new time series for every distinct value, multiplying storage and query cost without bound"},{"id":"b","text":"Trace IDs are actually less unique than metric labels"},{"id":"c","text":"Metrics can never have more than one label at all"},{"id":"d","text":"There is no real difference between the two cases"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-trace-10-o1-c1', 'mission-atlas-the-trace-10-o1', 1, 'terminal_simulation', 'Read the observability pipeline and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/pipeline.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/pipeline.txt":{"type":"file","content":"application (OpenTelemetry SDK)\n  -> otel-collector (batches, samples)\n    -> trace backend (stored, queryable)\n# a span travels this exact path before anyone can ever query it\n# verification PIPELINE-9012\n"}}}'::jsonb, '{"requiredFlag":"PIPELINE-9012"}'::jsonb),

  ('mission-atlas-the-trace-11-o1-c1', 'mission-atlas-the-trace-11-o1', 1, 'terminal_simulation', 'Read the tracing cost report and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/tracing-cost-report.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/tracing-cost-report.txt":{"type":"file","content":"tracing at 100% of all traffic: estimated 40x current storage volume\ntracing at current 5% sample rate: well within budget\n# verification COST-3390\n"}}}'::jsonb, '{"requiredFlag":"COST-3390"}'::jsonb),

  ('mission-atlas-the-trace-12-o1-c1', 'mission-atlas-the-trace-12-o1', 1, 'terminal_simulation', 'Read the sampling configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/sampling-config.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/sampling-config.yaml":{"type":"file","content":"sampler: probabilistic\nsampling_rate: 0.05\nstrategy: head-based\n# decided randomly, the instant a request starts, with no way yet to know whether it will fail\n# verification SAMPLING-4471\n"}}}'::jsonb, '{"requiredFlag":"SAMPLING-4471"}'::jsonb),
  ('mission-atlas-the-trace-12-o2-c1', 'mission-atlas-the-trace-12-o2', 1, 'terminal_simulation', 'Read the trace coverage report and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/trace-coverage-report.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/trace-coverage-report.txt":{"type":"file","content":"requested: traces for all 500-status requests in the last 24h\nexpected (based on the known 8% error rate): approximately 1,400 error requests\nactually captured: 71 traces\n# verification COVERAGE-4471\n"}}}'::jsonb, '{"requiredFlag":"COVERAGE-4471"}'::jsonb),
  ('mission-atlas-the-trace-12-o3-c1', 'mission-atlas-the-trace-12-o3', 1, 'investigation', 'Which evidence explains why the exact traces needed most were never kept?', '{"evidence":[{"id":"e1","label":"Sampling configuration","detail":"Sampling is probabilistic, head-based, decided randomly at 5% before a request''s outcome is known"},{"id":"e2","label":"Trace coverage report","detail":"Only 71 of roughly 1,400 expected error traces from the last 24 hours were actually captured"},{"id":"e3","label":"Pipeline definition","detail":"The collector-to-backend pipeline is functioning correctly and delivering every trace it is given"},{"id":"e4","label":"Tracing cost report","detail":"Tracing at the current 5% sample rate is well within budget; 100% sampling would cost roughly 40x more"}],"question":"Which evidence explains why the exact traces needed most were never kept?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-the-trace-12-o4-c1', 'mission-atlas-the-trace-12-o4', 1, 'boss_encounter', 'Having confirmed the sampling rate, the missing traces, and what actually explains this, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-the-trace-12-o1","label":"Confirm the sampling rate"},{"objectiveRef":"mission-atlas-the-trace-12-o2","label":"Confirm the missing error traces"},{"objectiveRef":"mission-atlas-the-trace-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: nothing about the pipeline or the cost budget is the problem -- head-based, probabilistic sampling decides randomly at request start, with no way yet to know whether that request is about to fail, so a flat 5% rate kept only 71 of roughly 1,400 real error traces from the last 24 hours, and the fix is switching to tail-based sampling that keeps every error trace at 100% while still sampling routine successful traffic at a low rate, so the evidence that actually matters is never left to chance again."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-the-trace-12-o1","mission-atlas-the-trace-12-o2","mission-atlas-the-trace-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-the-trace-01-o1-c1', 'orientation', 'Think about a single request crossing multiple services, not just one machine.', 10, 1),
  ('mission-atlas-the-trace-01-o1-c1', 'solution', 'Tracing follows one request end to end across every service it touches.', 20, 2),

  ('mission-atlas-the-trace-02-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/sample-trace.txt', 10, 1),
  ('mission-atlas-the-trace-02-o1-c1', 'solution', 'Three nested, timed spans, verification SPANS-3312. submit SPANS-3312', 20, 2),

  ('mission-atlas-the-trace-03-o1-c1', 'orientation', 'Think about what has to be the same across every span from one request.', 10, 1),
  ('mission-atlas-the-trace-03-o1-c1', 'solution', 'The same trace ID is propagated automatically across every service boundary.', 20, 2),

  ('mission-atlas-the-trace-04-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/otel-collector.yaml', 10, 1),
  ('mission-atlas-the-trace-04-o1-c1', 'solution', 'It is vendor-neutral, verification OTEL-6602. submit OTEL-6602', 20, 2),

  ('mission-atlas-the-trace-05-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/instrumentation-status.txt', 10, 1),
  ('mission-atlas-the-trace-05-o1-c1', 'solution', 'The legacy client gateway is not instrumented, verification INSTRUMENT-7714. submit INSTRUMENT-7714', 20, 2),

  ('mission-atlas-the-trace-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/sampling-config.yaml', 10, 1),
  ('mission-atlas-the-trace-06-o1-c1', 'solution', '5%, head-based, random, verification SAMPLING-4471. submit SAMPLING-4471', 20, 2),

  ('mission-atlas-the-trace-07-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/correlated-log.txt', 10, 1),
  ('mission-atlas-the-trace-07-o1-c1', 'solution', 'It carries a trace_id field, verification CORRELATION-8802. submit CORRELATION-8802', 20, 2),

  ('mission-atlas-the-trace-08-o1-c1', 'orientation', 'Think about what a metric alone cannot tell you that a correlated trace can.', 10, 1),
  ('mission-atlas-the-trace-08-o1-c1', 'solution', 'Correlated telemetry shows exactly which requests explain a change, not just that one happened.', 20, 2),

  ('mission-atlas-the-trace-09-o1-c1', 'orientation', 'Think about how each is actually queried afterward.', 10, 1),
  ('mission-atlas-the-trace-09-o1-c1', 'solution', 'Traces are looked up individually; a unique metric label multiplies time series without bound.', 20, 2),

  ('mission-atlas-the-trace-10-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/pipeline.txt', 10, 1),
  ('mission-atlas-the-trace-10-o1-c1', 'solution', 'App to collector to backend, verification PIPELINE-9012. submit PIPELINE-9012', 20, 2),

  ('mission-atlas-the-trace-11-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/tracing-cost-report.txt', 10, 1),
  ('mission-atlas-the-trace-11-o1-c1', 'solution', '100% sampling would cost roughly 40x more, verification COST-3390. submit COST-3390', 20, 2),

  ('mission-atlas-the-trace-12-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/sampling-config.yaml', 10, 1),
  ('mission-atlas-the-trace-12-o1-c1', 'solution', 'verification SAMPLING-4471. submit SAMPLING-4471', 20, 2),
  ('mission-atlas-the-trace-12-o2-c1', 'orientation', 'Try: cat /var/atlas-observability-01/trace-coverage-report.txt', 10, 1),
  ('mission-atlas-the-trace-12-o2-c1', 'solution', 'Only 71 of roughly 1,400 expected, verification COVERAGE-4471. submit COVERAGE-4471', 20, 2),
  ('mission-atlas-the-trace-12-o3-c1', 'orientation', 'The pipeline and the cost budget are both fine and irrelevant to why the evidence is missing. Look at how sampling decides, and what actually got kept.', 10, 1),
  ('mission-atlas-the-trace-12-o3-c1', 'solution', 'e1 and e2: random head-based sampling at 5% has no way to prioritize the requests that turn out to fail.', 20, 2),
  ('mission-atlas-the-trace-12-o4-c1', 'orientation', 'Combine the sampling strategy, the missing traces, and what should replace it into one sentence.', 15, 1),
  ('mission-atlas-the-trace-12-o4-c1', 'solution', 'Random head-based sampling at 5% cannot prioritize failures -- switch to tail-based sampling that keeps every error trace while still sampling routine traffic lightly.', 25, 2);
