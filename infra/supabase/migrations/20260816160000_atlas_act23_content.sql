-- Atlas Division pathway ("The Silence") Act 23 -- "The Signal"
-- content, under world-atlas-the-signal (already inserted separately).
-- 1 campaign, 2 operations, 12 missions (11 lessons + boss), continuing
-- World VII "The Signal Tower".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- observability artifact here is static seeded text read via `cat`.
-- Two hosts: the reused `atlas-devbox-01`, now hosting an
-- `observability/` directory inside the same `infra-envs` GitOps repo
-- from Act 22 (Prometheus config, ServiceMonitor, Grafana datasource,
-- dashboard JSON, alert rules -- all declared as code, reinforcing
-- Act 22's own lesson), and a new `atlas-observability-01` for live
-- query results (raw and structured log samples, the error-rate query,
-- error analysis). Only "observability vs monitoring" and "metrics"
-- and "metric types" (pure definitions) stay multiple_choice.
--
-- Narrative thread: missions 2-3 (logs, structured logs) contrast the
-- same events as raw text versus structured JSON. Mission 10
-- (dashboards) plants the reveal -- the collector's very first
-- dashboard, created this Act, includes an error-rate panel nobody
-- had ever queried before. The boss confirms the error rate has been
-- sustained for two weeks, identifies the specific legacy-client cause
-- via structured log analysis, then lands on why it was genuinely
-- invisible: the liveness probe only ever checked whether the process
-- was alive, and no alert existed until today.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-the-signal', 'world-atlas-the-signal', 'the-signal', '7B - The Signal', 'Learn observability from first principles -- observability versus monitoring, logs, structured logs, metrics, metric types, Prometheus, scraping, labels, Grafana, dashboards and alerts -- while the fleet''s very first dashboard reveals something two weeks old.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-the-signal-1', 'campaign-atlas-the-signal', 'what-the-fleet-has-been-saying', 'What the Fleet Has Been Saying', 'Observability versus monitoring, logs, structured logs, metrics and metric types.', 1),
  ('operation-atlas-the-signal-2', 'campaign-atlas-the-signal', 'finally-listening', 'Finally Listening', 'Prometheus, scraping, labels, Grafana, dashboards and alerts.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-the-signal-01', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-1', 'observability-vs-monitoring', 'Observability vs Monitoring', 'Cross starts building this fleet''s first real observability stack -- not another check, a way to actually ask it questions.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"observability-vs-monitoring-sim"}'::jsonb, '{"xp":500,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-the-signal-02', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-1', 'logs', 'Logs', 'Confirm what this fleet''s raw logs actually look like right now.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-signal-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"logs-sim"}'::jsonb, '{"xp":500,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-the-signal-03', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-1', 'structured-logs', 'Structured Logs', 'Confirm the exact same events, written a completely different way.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-signal-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"structured-logs-sim"}'::jsonb, '{"xp":510,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-the-signal-04', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-1', 'metrics', 'Metrics', 'Understand what a metric actually is, and why it scales where logs alone cannot.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-signal-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"metrics-sim"}'::jsonb, '{"xp":510,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-the-signal-05', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-1', 'metric-types', 'Metric Types', 'Understand the difference between something that only climbs and something that actually moves both ways.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-signal-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"metric-types-sim"}'::jsonb, '{"xp":520,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-the-signal-06', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-2', 'prometheus', 'Prometheus', 'Confirm what this fleet actually uses to pull and store its own metrics.', 'beginner', ARRAY['cross','rook'], '{"requiredMissionIds":["mission-atlas-the-signal-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"prometheus-sim"}'::jsonb, '{"xp":520,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-the-signal-07', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-2', 'scraping', 'Scraping', 'Confirm exactly which pods actually get scraped, and how often.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-signal-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"scraping-sim"}'::jsonb, '{"xp":530,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-the-signal-08', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-2', 'labels', 'Labels', 'Confirm how the exact same metric gets sliced apart by method, status and region all at once.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-signal-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"labels-sim"}'::jsonb, '{"xp":530,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-the-signal-09', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-2', 'grafana', 'Grafana', 'Confirm what Grafana actually stores, and what it only ever borrows from somewhere else.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-signal-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"grafana-sim"}'::jsonb, '{"xp":540,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-the-signal-10', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-2', 'dashboards', 'Dashboards', 'Confirm what this fleet''s very first dashboard actually includes.', 'beginner', ARRAY['cross','byte'], '{"requiredMissionIds":["mission-atlas-the-signal-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"dashboards-sim"}'::jsonb, '{"xp":540,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-the-signal-11', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-2', 'alerts', 'Alerts', 'Confirm whether an alert like this one has ever actually existed before today.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-the-signal-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"alerts-sim"}'::jsonb, '{"xp":550,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-the-signal-12', 'world-atlas-the-signal', 'campaign-atlas-the-signal', 'operation-atlas-the-signal-2', 'invisible-failure', 'Invisible Failure', 'Everything this Act taught, turned on one dashboard: not to just fix the error and move on, to finally explain how something this real stayed invisible for two straight weeks.', 'boss', ARRAY['cross','byte','rook','leena'], '{"requiredMissionIds":["mission-atlas-the-signal-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"invisible-failure-boss-sim"}'::jsonb, '{"xp":740,"credits":175,"badgeIds":["invisible-failure"],"skillXp":{"cloud_devops_fundamentals":115}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-the-signal-01', 1, 'leena', 'Cross is building this fleet''s first real observability stack -- not another predefined check, a way to actually ask it new questions.'),
  ('mission-atlas-the-signal-01', 2, 'cross', 'Imani Cross. Monitoring watches for failures someone already thought to anticipate. Observability is different -- it means having enough real data about a system that you can ask a question nobody thought to ask in advance, and actually get an answer.'),

  ('mission-atlas-the-signal-02', 1, 'cross', 'Confirm what this fleet''s logs actually look like right now, before anything else changes.'),

  ('mission-atlas-the-signal-03', 1, 'cross', 'The same events, structured as real fields instead of free text, are queryable and aggregatable at a scale plain log lines never could be. Confirm the difference for yourself.'),

  ('mission-atlas-the-signal-04', 1, 'cross', 'A metric is a number tracked over time -- far cheaper to store and query at scale than a full log line for every single event. Understand why that tradeoff actually matters here.'),

  ('mission-atlas-the-signal-05', 1, 'cross', 'A counter only ever goes up. A gauge moves both directions. A histogram buckets a whole distribution of values, like latency, instead of collapsing it into one number. Know which one actually answers your question.'),

  ('mission-atlas-the-signal-06', 1, 'rook', 'Prometheus is what actually pulls and stores this fleet''s metrics, on its own schedule, as real time-series data. Confirm it is configured.'),

  ('mission-atlas-the-signal-07', 1, 'cross', 'Prometheus does not just know what to scrape on its own. Confirm exactly which pods it is actually configured to pull metrics from, and how often.'),

  ('mission-atlas-the-signal-08', 1, 'cross', 'The same metric name, sliced apart by labels like method, status and region, lets one number become a hundred different, genuinely useful questions. Confirm how that actually looks here.'),

  ('mission-atlas-the-signal-09', 1, 'cross', 'Grafana never stores a single data point itself -- it only queries and visualizes whatever Prometheus already collected. Confirm where it is actually pointed.'),

  ('mission-atlas-the-signal-10', 1, 'byte', 'This is the very first dashboard this fleet has ever had. I helped build the queries myself.'),
  ('mission-atlas-the-signal-10', 2, 'cross', 'Confirm exactly what it actually includes -- specifically, confirm whether it can answer the one question nobody has ever been able to ask before today.'),

  ('mission-atlas-the-signal-11', 1, 'cross', 'Confirm whether an alert like this one has ever actually existed on this fleet before today. Be honest about the answer.'),

  ('mission-atlas-the-signal-12', 1, 'leena', 'Everything this Act taught you, on one dashboard. Not to just fix the error and move on -- to finally explain how something this real stayed invisible for two straight weeks.'),
  ('mission-atlas-the-signal-12', 2, 'byte', 'I have the live error-rate query and the structured log breakdown both pulled up together. This has been happening the entire time the dashboard has existed to see it, and almost certainly longer.'),
  ('mission-atlas-the-signal-12', 3, 'rook', 'Nothing about this ever showed up as unhealthy. Not once.'),
  ('mission-atlas-the-signal-12', 4, 'cross', 'Find exactly what has been failing, and explain precisely why nothing here was ever built to notice it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-the-signal-01-o1', 'mission-atlas-the-signal-01', 1, 'Tell observability from monitoring', 'Choose the accurate distinction between observability and monitoring.'),

  ('mission-atlas-the-signal-02-o1', 'mission-atlas-the-signal-02', 1, 'Read the raw logs', 'Read the raw log sample and submit the verification code.'),

  ('mission-atlas-the-signal-03-o1', 'mission-atlas-the-signal-03', 1, 'Read the structured logs', 'Read the structured log sample and submit the verification code.'),

  ('mission-atlas-the-signal-04-o1', 'mission-atlas-the-signal-04', 1, 'Explain metrics', 'Choose the accurate description of what a metric actually is.'),

  ('mission-atlas-the-signal-05-o1', 'mission-atlas-the-signal-05', 1, 'Explain metric types', 'Choose the accurate distinction between a counter, a gauge and a histogram.'),

  ('mission-atlas-the-signal-06-o1', 'mission-atlas-the-signal-06', 1, 'Read the Prometheus config', 'Read the Prometheus configuration and submit the verification code.'),

  ('mission-atlas-the-signal-07-o1', 'mission-atlas-the-signal-07', 1, 'Read the ServiceMonitor', 'Read the ServiceMonitor and submit the verification code.'),

  ('mission-atlas-the-signal-08-o1', 'mission-atlas-the-signal-08', 1, 'Read a labeled metric sample', 'Read the metric sample and submit the verification code.'),

  ('mission-atlas-the-signal-09-o1', 'mission-atlas-the-signal-09', 1, 'Read the Grafana datasource', 'Read the Grafana datasource and submit the verification code.'),

  ('mission-atlas-the-signal-10-o1', 'mission-atlas-the-signal-10', 1, 'Read the dashboard definition', 'Read the dashboard definition and submit the verification code.'),

  ('mission-atlas-the-signal-11-o1', 'mission-atlas-the-signal-11', 1, 'Read the alert rule', 'Read the alert rule and submit the verification code.'),

  ('mission-atlas-the-signal-12-o1', 'mission-atlas-the-signal-12', 1, 'Confirm the sustained error rate', 'Read the error-rate query result and submit the verification code.'),
  ('mission-atlas-the-signal-12-o2', 'mission-atlas-the-signal-12', 2, 'Confirm the actual cause', 'Read the error analysis and submit the verification code.'),
  ('mission-atlas-the-signal-12-o3', 'mission-atlas-the-signal-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why this failure was genuinely invisible until today.'),
  ('mission-atlas-the-signal-12-o4', 'mission-atlas-the-signal-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-the-signal-01-o1-c1', 'mission-atlas-the-signal-01-o1', 1, 'multiple_choice', 'Observability and monitoring actually differ in that...', '{"question":"Observability and monitoring actually differ in that...","options":[{"id":"a","text":"Monitoring watches for failures someone already anticipated; observability means having enough real data to ask a question nobody thought to ask in advance and still get an answer"},{"id":"b","text":"They are identical, just different marketing terms"},{"id":"c","text":"Monitoring only applies to logs, observability only applies to metrics"},{"id":"d","text":"Observability requires no data collection at all"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-signal-02-o1-c1', 'mission-atlas-the-signal-02-o1', 1, 'terminal_simulation', 'Read the raw log sample and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/raw-logs.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/raw-logs.txt":{"type":"file","content":"Aug 16 09:14:02 atlas-collector-7f9 INFO request handled ok\nAug 16 09:14:03 atlas-collector-7f9 ERROR failed to process payload: missing field timestamp\nAug 16 09:14:05 atlas-collector-7f9 INFO request handled ok\n# free-form text -- readable one line at a time, hard to aggregate or query at scale\n# verification LOGS-3312\n"}}}'::jsonb, '{"requiredFlag":"LOGS-3312"}'::jsonb),

  ('mission-atlas-the-signal-03-o1-c1', 'mission-atlas-the-signal-03-o1', 1, 'terminal_simulation', 'Read the structured log sample and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/structured-logs.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/structured-logs.txt":{"type":"file","content":"{\"time\":\"2026-08-16T09:14:03Z\",\"level\":\"error\",\"msg\":\"failed to process payload\",\"field\":\"timestamp\",\"status\":500}\n{\"time\":\"2026-08-16T09:14:05Z\",\"level\":\"info\",\"msg\":\"request handled\",\"status\":200}\n# the same events, as structured JSON -- every field is queryable and aggregatable at scale\n# verification STRUCTUREDLOGS-6602\n"}}}'::jsonb, '{"requiredFlag":"STRUCTUREDLOGS-6602"}'::jsonb),

  ('mission-atlas-the-signal-04-o1-c1', 'mission-atlas-the-signal-04-o1', 1, 'multiple_choice', 'A metric is best described as...', '{"question":"A metric is best described as...","options":[{"id":"a","text":"A numeric measurement tracked over time, far cheaper to store and query at scale than a full log line for every single event"},{"id":"b","text":"A synonym for a full-text log line"},{"id":"c","text":"Only ever a single snapshot value with no history"},{"id":"d","text":"Something that can only be collected once per day"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-signal-05-o1-c1', 'mission-atlas-the-signal-05-o1', 1, 'multiple_choice', 'A counter, a gauge and a histogram actually differ in that...', '{"question":"A counter, a gauge and a histogram actually differ in that...","options":[{"id":"a","text":"A counter only ever increases, a gauge can move up or down, and a histogram buckets a whole distribution of values instead of one number"},{"id":"b","text":"They are all functionally identical, just named differently"},{"id":"c","text":"A gauge can only ever increase, exactly like a counter"},{"id":"d","text":"A histogram can only track exactly one value at a time"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-signal-06-o1-c1', 'mission-atlas-the-signal-06-o1', 1, 'terminal_simulation', 'Read the Prometheus configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/prometheus.yml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/prometheus.yml":{"type":"file","content":"global:\n  scrape_interval: 15s\nscrape_configs:\n  - job_name: atlas-collector\n    kubernetes_sd_configs:\n      - role: pod\n# Prometheus itself -- pulls and stores time-series metrics, on its own schedule\n# verification PROMETHEUS-7714\n"}}}'::jsonb, '{"requiredFlag":"PROMETHEUS-7714"}'::jsonb),

  ('mission-atlas-the-signal-07-o1-c1', 'mission-atlas-the-signal-07-o1', 1, 'terminal_simulation', 'Read the ServiceMonitor and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/servicemonitor.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/servicemonitor.yaml":{"type":"file","content":"apiVersion: monitoring.coreos.com/v1\nkind: ServiceMonitor\nmetadata:\n  name: atlas-collector\nspec:\n  selector:\n    matchLabels:\n      app: collector\n  endpoints:\n    - port: metrics\n      path: /metrics\n      interval: 15s\n# tells Prometheus exactly which pods to scrape, and how often\n# verification SCRAPING-4471\n"}}}'::jsonb, '{"requiredFlag":"SCRAPING-4471"}'::jsonb),

  ('mission-atlas-the-signal-08-o1-c1', 'mission-atlas-the-signal-08-o1', 1, 'terminal_simulation', 'Read the metric sample and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/metric-sample.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/metric-sample.txt":{"type":"file","content":"http_requests_total{method=\"POST\",status=\"200\",region=\"eu-west\"} 184213\nhttp_requests_total{method=\"POST\",status=\"500\",region=\"eu-west\"} 15891\n# labels let the exact same metric be sliced and filtered any number of ways, by status, method, region\n# verification LABELS-8802\n"}}}'::jsonb, '{"requiredFlag":"LABELS-8802"}'::jsonb),

  ('mission-atlas-the-signal-09-o1-c1', 'mission-atlas-the-signal-09-o1', 1, 'terminal_simulation', 'Read the Grafana datasource and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/grafana-datasource.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/grafana-datasource.yaml":{"type":"file","content":"apiVersion: 1\ndatasources:\n  - name: Prometheus\n    type: prometheus\n    url: http://prometheus.atlas-observability:9090\n# Grafana itself stores nothing -- it only queries and visualizes data Prometheus already collected\n# verification GRAFANA-2291\n"}}}'::jsonb, '{"requiredFlag":"GRAFANA-2291"}'::jsonb),

  ('mission-atlas-the-signal-10-o1-c1', 'mission-atlas-the-signal-10-o1', 1, 'terminal_simulation', 'Read the dashboard definition and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/collector-dashboard.json and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/collector-dashboard.json":{"type":"file","content":"{\n  \"title\": \"Atlas Collector Overview\",\n  \"panels\": [\n    { \"title\": \"Request Rate\", \"query\": \"sum(rate(http_requests_total[5m]))\" },\n    { \"title\": \"Error Rate\", \"query\": \"sum(rate(http_requests_total{status=500}[5m])) / sum(rate(http_requests_total[5m]))\" }\n  ]\n}\n# the very first dashboard this cluster has ever had -- created this Act, not before\n# verification DASHBOARD-9012\n"}}}'::jsonb, '{"requiredFlag":"DASHBOARD-9012"}'::jsonb),

  ('mission-atlas-the-signal-11-o1-c1', 'mission-atlas-the-signal-11-o1', 1, 'terminal_simulation', 'Read the alert rule and submit the verification code.', '{"instructions":"Read /repo/infra-envs/observability/alert-rules.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/observability/alert-rules.yaml":{"type":"file","content":"groups:\n  - name: atlas-collector\n    rules:\n      - alert: HighErrorRate\n        expr: sum(rate(http_requests_total{status=500}[5m])) / sum(rate(http_requests_total[5m])) > 0.05\n        for: 10m\n# the first error-rate alert this fleet has ever had -- also created this Act\n# verification ALERTRULE-3390\n"}}}'::jsonb, '{"requiredFlag":"ALERTRULE-3390"}'::jsonb),

  ('mission-atlas-the-signal-12-o1-c1', 'mission-atlas-the-signal-12-o1', 1, 'terminal_simulation', 'Read the error-rate query result and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/error-rate-query.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/error-rate-query.txt":{"type":"file","content":"sum(rate(http_requests_total{status=500}[5m])) / sum(rate(http_requests_total[5m]))\ncurrent: 0.082\n14-day history: steady between 0.076 and 0.091 -- this has been happening the entire time\n# verification ERRORRATE-4471\n"}}}'::jsonb, '{"requiredFlag":"ERRORRATE-4471"}'::jsonb),
  ('mission-atlas-the-signal-12-o2-c1', 'mission-atlas-the-signal-12-o2', 1, 'terminal_simulation', 'Read the error analysis and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/error-analysis.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/error-analysis.txt":{"type":"file","content":"top error, last 14 days: missing field timestamp -- 100% of all 500 responses\nsource: a legacy client integration that has never once sent this field\n# verification ERRORANALYSIS-8802\n"}}}'::jsonb, '{"requiredFlag":"ERRORANALYSIS-8802"}'::jsonb),
  ('mission-atlas-the-signal-12-o3-c1', 'mission-atlas-the-signal-12-o3', 1, 'investigation', 'Which evidence explains why this failure was genuinely invisible until today?', '{"evidence":[{"id":"e1","label":"Error-rate query","detail":"A steady 7.6-9.1% error rate has been happening for at least the last 14 days"},{"id":"e2","label":"Error analysis","detail":"100% of the errors trace to one legacy client never sending a required field"},{"id":"e3","label":"Liveness probe history","detail":"The collector''s liveness probe has passed continuously the entire time -- it only ever checks whether the process is running, never whether requests are succeeding"},{"id":"e4","label":"Alert rule creation date","detail":"The HighErrorRate alert was created today -- no error-rate alert of any kind existed on this fleet before it"}],"question":"Which evidence explains why this failure was genuinely invisible until today?"}'::jsonb, '{"requiredEvidenceIds":["e3","e4"]}'::jsonb),
  ('mission-atlas-the-signal-12-o4-c1', 'mission-atlas-the-signal-12-o4', 1, 'boss_encounter', 'Having confirmed the sustained error rate, the actual cause, and why it was invisible, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-the-signal-12-o1","label":"Confirm the sustained error rate"},{"objectiveRef":"mission-atlas-the-signal-12-o2","label":"Confirm the actual cause"},{"objectiveRef":"mission-atlas-the-signal-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: a legacy client integration has been sending requests missing a required field for at least two weeks, failing roughly 8% of all traffic the entire time, and it stayed genuinely invisible because the liveness probe only ever confirmed the process was alive and no error-rate alert existed until today -- the fix is handling the legacy client''s malformed requests gracefully and keeping this new alert in place so a real failure can never again go two weeks unnoticed."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-the-signal-12-o1","mission-atlas-the-signal-12-o2","mission-atlas-the-signal-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-the-signal-01-o1-c1', 'orientation', 'Think about known failure modes versus questions nobody anticipated.', 10, 1),
  ('mission-atlas-the-signal-01-o1-c1', 'solution', 'Monitoring watches for anticipated failures; observability answers unanticipated questions.', 20, 2),

  ('mission-atlas-the-signal-02-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/raw-logs.txt', 10, 1),
  ('mission-atlas-the-signal-02-o1-c1', 'solution', 'Free-form text, hard to aggregate, verification LOGS-3312. submit LOGS-3312', 20, 2),

  ('mission-atlas-the-signal-03-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/structured-logs.txt', 10, 1),
  ('mission-atlas-the-signal-03-o1-c1', 'solution', 'Structured JSON, every field queryable, verification STRUCTUREDLOGS-6602. submit STRUCTUREDLOGS-6602', 20, 2),

  ('mission-atlas-the-signal-04-o1-c1', 'orientation', 'Think about cost and scale versus a full log line per event.', 10, 1),
  ('mission-atlas-the-signal-04-o1-c1', 'solution', 'A metric is a numeric measurement over time, cheap to store at scale.', 20, 2),

  ('mission-atlas-the-signal-05-o1-c1', 'orientation', 'Think about direction of movement, and single value versus a distribution.', 10, 1),
  ('mission-atlas-the-signal-05-o1-c1', 'solution', 'Counter only rises; gauge moves both ways; histogram buckets a distribution.', 20, 2),

  ('mission-atlas-the-signal-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/prometheus.yml', 10, 1),
  ('mission-atlas-the-signal-06-o1-c1', 'solution', 'It scrapes every 15 seconds, verification PROMETHEUS-7714. submit PROMETHEUS-7714', 20, 2),

  ('mission-atlas-the-signal-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/servicemonitor.yaml', 10, 1),
  ('mission-atlas-the-signal-07-o1-c1', 'solution', 'It targets app=collector every 15s, verification SCRAPING-4471. submit SCRAPING-4471', 20, 2),

  ('mission-atlas-the-signal-08-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/metric-sample.txt', 10, 1),
  ('mission-atlas-the-signal-08-o1-c1', 'solution', 'Labels split the metric by status and method, verification LABELS-8802. submit LABELS-8802', 20, 2),

  ('mission-atlas-the-signal-09-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/grafana-datasource.yaml', 10, 1),
  ('mission-atlas-the-signal-09-o1-c1', 'solution', 'It points at Prometheus, verification GRAFANA-2291. submit GRAFANA-2291', 20, 2),

  ('mission-atlas-the-signal-10-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/collector-dashboard.json', 10, 1),
  ('mission-atlas-the-signal-10-o1-c1', 'solution', 'It includes both a request-rate and an error-rate panel, verification DASHBOARD-9012. submit DASHBOARD-9012', 20, 2),

  ('mission-atlas-the-signal-11-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/observability/alert-rules.yaml', 10, 1),
  ('mission-atlas-the-signal-11-o1-c1', 'solution', 'HighErrorRate fires above 5%, verification ALERTRULE-3390. submit ALERTRULE-3390', 20, 2),

  ('mission-atlas-the-signal-12-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/error-rate-query.txt', 10, 1),
  ('mission-atlas-the-signal-12-o1-c1', 'solution', 'Steady for 14 days, verification ERRORRATE-4471. submit ERRORRATE-4471', 20, 2),
  ('mission-atlas-the-signal-12-o2-c1', 'orientation', 'Try: cat /var/atlas-observability-01/error-analysis.txt', 10, 1),
  ('mission-atlas-the-signal-12-o2-c1', 'solution', 'A legacy client is missing a required field, verification ERRORANALYSIS-8802. submit ERRORANALYSIS-8802', 20, 2),
  ('mission-atlas-the-signal-12-o3-c1', 'orientation', 'The error rate and its cause are both already confirmed. Look for what was actually missing from this fleet''s checks, not what was failing.', 10, 1),
  ('mission-atlas-the-signal-12-o3-c1', 'solution', 'e3 and e4: the liveness probe never checked request success, and no alert existed until today.', 20, 2),
  ('mission-atlas-the-signal-12-o4-c1', 'orientation', 'Combine the sustained error rate, its cause, and why nothing caught it into one sentence.', 15, 1),
  ('mission-atlas-the-signal-12-o4-c1', 'solution', 'A legacy client has been failing roughly 8% of requests for two weeks, invisible because the liveness probe never checked request success and no alert existed until today.', 25, 2);
