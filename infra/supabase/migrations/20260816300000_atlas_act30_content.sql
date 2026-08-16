-- Atlas Division pathway ("The Silence") Act 30 -- "Platform" content,
-- under world-atlas-platform (already inserted separately). 1 campaign,
-- 2 operations, 12 missions (11 lessons + boss), opening World IX
-- "Platform City".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- platform artifact here is static seeded text read via `cat`. One new
-- host, `atlas-platform-01`, holds every golden path, template,
-- self-service request, API spec, policy guardrail and metrics report
-- this Act builds -- a genuinely new major system, same justification
-- used for every other new host in this pathway (a real new system, not
-- just more config on an existing one).
--
-- Narrative thread: mission 3 (golden paths) and mission 10 (policy as
-- code) both plant real capability well before the boss needs it. The
-- boss deliberately confirms the platform-metrics report (`e1`) as proof
-- the launch is a genuine broad success, and explicitly treats it as
-- context rather than the explanation for the one team still filing
-- tickets; the actual explanation requires both the ticket-breakdown
-- concentration and that team's own request contents naming a workload
-- type no golden path covers (`e3`+`e4`) -- coverage gaps, not adoption
-- failure, same "a real win, with a real edge it does not reach yet"
-- shape as the world''s own story_reveal.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-platform', 'world-atlas-platform', 'platform', '9A - Platform', 'Learn platform engineering from first principles -- developer experience, golden paths, service templates, self-service infrastructure, platform APIs, provisioning and policy as code -- and build this fleet''s first real internal developer platform.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-platform-1', 'campaign-atlas-platform', 'why-teams-are-waiting', 'Why Teams Are Waiting', 'Why platforms, developer experience, golden paths, internal platforms, service templates and self-service infra.', 1),
  ('operation-atlas-platform-2', 'campaign-atlas-platform', 'building-the-self-service-layer', 'Building the Self-Service Layer', 'Platform APIs, Backstage concepts, provisioning, policy as code, platform metrics and the launch itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-platform-01', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-1', 'why-platforms', 'Why Platforms', 'Every other team still files a manual ticket and waits for ops to hand-provision anything at all. Rook wants to know why that is still true after twenty-nine Acts.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"why-platforms-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-platform-02', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-1', 'developer-experience', 'Developer Experience', 'Confirm exactly how long a new service actually takes to stand up today, and what teams themselves say is the real blocker.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"developer-experience-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-platform-03', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-1', 'golden-paths', 'Golden Paths', 'Confirm exactly what a real golden path actually bakes in by default for any team that uses it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"golden-paths-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-platform-04', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-1', 'internal-platforms', 'Internal Platforms', 'Understand what actually separates a real internal platform from a shared pile of infrastructure and tribal knowledge.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"internal-platforms-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-platform-05', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-1', 'service-templates', 'Service Templates', 'Confirm exactly what a real service template actually scaffolds for a team the moment they use it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"service-templates-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-platform-06', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-1', 'self-service-infra', 'Self-Service Infra', 'Confirm exactly what actually happens now when a team submits a real infrastructure request through the platform instead of a ticket.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"self-service-infra-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-platform-07', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-2', 'platform-apis', 'Platform APIs', 'Confirm exactly which real operations the platform''s own API is actually capable of performing on a team''s behalf.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"platform-apis-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-platform-08', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-2', 'backstage-concepts', 'Backstage Concepts', 'Understand what a real software catalog actually solves that a wiki page never could.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"backstage-concepts-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-platform-09', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-2', 'provisioning', 'Provisioning', 'Confirm exactly how much faster real provisioning actually got, measured against real requests, not a demo.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"provisioning-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-platform-10', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-2', 'policy-as-code', 'Policy as Code', 'Confirm exactly which of this fleet''s own past mistakes -- public buckets, stray secrets, over-broad roles -- self-service now blocks automatically.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"policy-as-code-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-platform-11', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-2', 'platform-metrics', 'Platform Metrics', 'Confirm exactly what the platform''s own dashboard actually shows one month after launch.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-platform-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"platform-metrics-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-platform-12', 'world-atlas-platform', 'campaign-atlas-platform', 'operation-atlas-platform-2', 'ticket-mountain', 'Ticket Mountain', 'Everything this Act taught, turned on one real dashboard: not to just confirm the platform worked, to explain who it still is not working for.', 'boss', ARRAY['rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-platform-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"ticket-mountain-boss-sim"}'::jsonb, '{"xp":830,"credits":200,"badgeIds":["ticket-mountain"],"skillXp":{"cloud_devops_fundamentals":135}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-platform-01', 1, 'leena', 'Every other team still files a manual ticket and waits on ops for anything at all -- a new service, a database, a secret. That has been true since Act 1.'),
  ('mission-atlas-platform-01', 2, 'rook', 'Rook. Twenty-nine Acts of hard-won discipline, and none of it actually reaches anyone outside this fleet. A real internal platform is how that changes -- self-service, with our own guardrails baked in by default, instead of a ticket queue.'),

  ('mission-atlas-platform-02', 1, 'rook', 'Before building anything, confirm exactly how long a new service actually takes to stand up today, and what teams themselves say the real blocker is.'),

  ('mission-atlas-platform-03', 1, 'rook', 'A golden path is not a suggestion. Confirm exactly what it actually bakes in, automatically, for any team that follows it.'),

  ('mission-atlas-platform-04', 1, 'rook', 'A shared pile of infrastructure with a wiki page is not a platform. Understand what actually has to exist for it to be one.'),

  ('mission-atlas-platform-05', 1, 'rook', 'Confirm exactly what a real service template actually scaffolds the moment a team uses it -- not just what it is supposed to.'),

  ('mission-atlas-platform-06', 1, 'rook', 'Confirm exactly what actually happens now when a real request goes through the platform instead of a ticket.'),

  ('mission-atlas-platform-07', 1, 'rook', 'Confirm exactly which real operations the platform''s own API is actually capable of performing on a team''s behalf, end to end.'),

  ('mission-atlas-platform-08', 1, 'rook', 'Understand what a real software catalog actually solves that a wiki page, updated by hand, never reliably could.'),

  ('mission-atlas-platform-09', 1, 'rook', 'Confirm exactly how much faster real provisioning actually got, measured against real historical requests, not a demo.'),

  ('mission-atlas-platform-10', 1, 'rook', 'Confirm exactly which of this fleet''s own past mistakes -- Act 6''s leaked token, Act 8''s never-shrunk image, Act 11''s over-broad role -- self-service now blocks automatically, before they can happen again.'),

  ('mission-atlas-platform-11', 1, 'rook', 'One month after launch. Confirm exactly what the platform''s own dashboard actually shows.'),

  ('mission-atlas-platform-12', 1, 'leena', 'Everything this Act taught you, turned on one real dashboard. Not just to confirm the platform worked -- to explain who it still is not working for.'),
  ('mission-atlas-platform-12', 2, 'byte', 'I have the platform metrics and the ticket breakdown by team both pulled up together. Overall, this is a genuine, measurable win.'),
  ('mission-atlas-platform-12', 3, 'rook', 'Ticket volume is down four-fifths. Median provisioning time is down from days to minutes. That part is not in question.'),
  ('mission-atlas-platform-12', 4, 'leena', 'Then find who is still filing tickets anyway, and why this platform still is not built for them.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-platform-01-o1', 'mission-atlas-platform-01', 1, 'Explain why platforms', 'Choose the accurate description of what an internal platform is actually for.'),

  ('mission-atlas-platform-02-o1', 'mission-atlas-platform-02', 1, 'Read the developer experience survey', 'Read the developer experience survey and submit the verification code.'),

  ('mission-atlas-platform-03-o1', 'mission-atlas-platform-03', 1, 'Read the golden path definition', 'Read the golden path definition and submit the verification code.'),

  ('mission-atlas-platform-04-o1', 'mission-atlas-platform-04', 1, 'Explain internal platforms', 'Choose the accurate description of what actually separates a real internal platform from shared infrastructure.'),

  ('mission-atlas-platform-05-o1', 'mission-atlas-platform-05', 1, 'Read the service template', 'Read the service template manifest and submit the verification code.'),

  ('mission-atlas-platform-06-o1', 'mission-atlas-platform-06', 1, 'Read the self-service request', 'Read the self-service infrastructure request and submit the verification code.'),

  ('mission-atlas-platform-07-o1', 'mission-atlas-platform-07', 1, 'Read the platform API spec', 'Read the platform API specification and submit the verification code.'),

  ('mission-atlas-platform-08-o1', 'mission-atlas-platform-08', 1, 'Explain software catalogs', 'Choose the accurate description of what a real software catalog actually provides.'),

  ('mission-atlas-platform-09-o1', 'mission-atlas-platform-09', 1, 'Read the provisioning log', 'Read the provisioning comparison log and submit the verification code.'),

  ('mission-atlas-platform-10-o1', 'mission-atlas-platform-10', 1, 'Read the policy guardrails', 'Read the policy-as-code guardrails and submit the verification code.'),

  ('mission-atlas-platform-11-o1', 'mission-atlas-platform-11', 1, 'Read the platform metrics', 'Read the platform metrics dashboard export and submit the verification code.'),

  ('mission-atlas-platform-12-o1', 'mission-atlas-platform-12', 1, 'Confirm the platform metrics', 'Read the platform metrics report and submit the verification code.'),
  ('mission-atlas-platform-12-o2', 'mission-atlas-platform-12', 2, 'Confirm the ticket breakdown', 'Read the ticket breakdown by team and submit the verification code.'),
  ('mission-atlas-platform-12-o3', 'mission-atlas-platform-12', 3, 'Identify who the platform still fails', 'Find the evidence that explains why one team is still filing nearly all remaining tickets.'),
  ('mission-atlas-platform-12-o4', 'mission-atlas-platform-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-platform-01-o1-c1', 'mission-atlas-platform-01-o1', 1, 'multiple_choice', 'An internal platform is actually for...', '{"question":"An internal platform is actually for...","options":[{"id":"a","text":"Giving every team this fleet''s own hard-won infrastructure guardrails by default, self-service, without requiring each of them to become infrastructure experts first"},{"id":"b","text":"Replacing the need for any team to understand its own service at all"},{"id":"c","text":"A one-time project that, once launched, never needs further investment"},{"id":"d","text":"Only relevant to organizations with a dedicated platform team already in place"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-platform-02-o1-c1', 'mission-atlas-platform-02-o1', 1, 'terminal_simulation', 'Read the developer experience survey and submit the verification code.', '{"instructions":"Read /var/atlas-platform-01/dx-survey.txt and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-platform-01/dx-survey.txt":{"type":"file","content":"developer experience survey, 40 respondents across 9 teams\nmedian time to stand up a new service: 4.5 days, entirely spent waiting on ops tickets\n73 percent cite waiting on ops as the single biggest blocker to shipping\n# verification DXSURVEY-4471\n"}}}'::jsonb, '{"requiredFlag":"DXSURVEY-4471"}'::jsonb),

  ('mission-atlas-platform-03-o1-c1', 'mission-atlas-platform-03-o1', 1, 'terminal_simulation', 'Read the golden path definition and submit the verification code.', '{"instructions":"Read /repo/infra-envs/platform/golden-path-web-service.yaml and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/platform/golden-path-web-service.yaml":{"type":"file","content":"golden_path: stateless-web-service\nbakes_in_by_default:\n  - CI pipeline (Act 5-7 pattern)\n  - distroless container build (Act 8 pattern)\n  - Kubernetes deployment with resource limits (Act 20 pattern)\n  - observability wired automatically (Act 23 pattern)\n  - least-privilege IAM role, no manual grant needed (Act 11 fix, applied by default)\n# verification GOLDENPATH-8802\n"}}}'::jsonb, '{"requiredFlag":"GOLDENPATH-8802"}'::jsonb),

  ('mission-atlas-platform-04-o1-c1', 'mission-atlas-platform-04-o1', 1, 'multiple_choice', 'A real internal platform is actually separated from shared infrastructure by...', '{"question":"A real internal platform is actually separated from shared infrastructure by...","options":[{"id":"a","text":"Self-service golden paths and APIs that package existing capability safely, instead of requiring every team to learn the underlying infrastructure and ask an expert for help"},{"id":"b","text":"Simply owning more servers than any single team could on its own"},{"id":"c","text":"Nothing meaningful -- the two terms describe exactly the same thing"},{"id":"d","text":"Having a dedicated support team available only during business hours"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-platform-05-o1-c1', 'mission-atlas-platform-05-o1', 1, 'terminal_simulation', 'Read the service template manifest and submit the verification code.', '{"instructions":"Read /repo/infra-envs/platform/service-templates/stateless-web.yaml and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/platform/service-templates/stateless-web.yaml":{"type":"file","content":"template: stateless-web\nscaffolds:\n  - Dockerfile, multi-stage, distroless base\n  - CI pipeline config, wired to the shared runners\n  - Kubernetes deployment and service manifests\n  - README with the golden path''s own guarantees documented\n# verification TEMPLATE-2201\n"}}}'::jsonb, '{"requiredFlag":"TEMPLATE-2201"}'::jsonb),

  ('mission-atlas-platform-06-o1-c1', 'mission-atlas-platform-06-o1', 1, 'terminal_simulation', 'Read the self-service infrastructure request and submit the verification code.', '{"instructions":"Read /repo/infra-envs/platform/self-service-request.yaml and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/platform/self-service-request.yaml":{"type":"file","content":"request: new-postgres-database\nsubmitted_via: platform API, not a ticket\npolicy_checks_run_automatically: yes\nresult: provisioned in 6 minutes, zero human ops involvement\n# verification SELFSERVICE-3387\n"}}}'::jsonb, '{"requiredFlag":"SELFSERVICE-3387"}'::jsonb),

  ('mission-atlas-platform-07-o1-c1', 'mission-atlas-platform-07-o1', 1, 'terminal_simulation', 'Read the platform API specification and submit the verification code.', '{"instructions":"Read /repo/infra-envs/platform/api-spec.yaml and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/platform/api-spec.yaml":{"type":"file","content":"platform_api:\n  POST /services: create a new service from a golden path template\n  POST /databases: provision a database with backups and RPO/RTO defaults applied\n  POST /secrets: create a secret directly in the secrets manager, never in plaintext\n  every endpoint: runs policy-as-code checks automatically before provisioning\n# verification PLATFORMAPI-6650\n"}}}'::jsonb, '{"requiredFlag":"PLATFORMAPI-6650"}'::jsonb),

  ('mission-atlas-platform-08-o1-c1', 'mission-atlas-platform-08-o1', 1, 'multiple_choice', 'A real software catalog actually provides...', '{"question":"A real software catalog actually provides...","options":[{"id":"a","text":"A single, self-updating map of every service, its owner, its docs and its golden-path status, so nobody has to ask around to find out what exists"},{"id":"b","text":"A replacement for owning and operating any of the actual infrastructure"},{"id":"c","text":"A one-time snapshot, accurate only on the day it was written"},{"id":"d","text":"Something only useful for organizations with fewer than ten services"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-platform-09-o1-c1', 'mission-atlas-platform-09-o1', 1, 'terminal_simulation', 'Read the provisioning comparison log and submit the verification code.', '{"instructions":"Read /var/atlas-platform-01/provisioning-log.txt and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-platform-01/provisioning-log.txt":{"type":"file","content":"sample of 30 real requests, before and after platform launch\nbefore: median 4.5 days, all via manual ticket\nafter: median 6 minutes, via the platform API\n# verification PROVISIONING-9012\n"}}}'::jsonb, '{"requiredFlag":"PROVISIONING-9012"}'::jsonb),

  ('mission-atlas-platform-10-o1-c1', 'mission-atlas-platform-10-o1', 1, 'terminal_simulation', 'Read the policy-as-code guardrails and submit the verification code.', '{"instructions":"Read /repo/infra-envs/platform/policy-guardrails.yaml and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/platform/policy-guardrails.yaml":{"type":"file","content":"policy_guardrails, enforced automatically on every request:\n  - deny any storage bucket created as publicly readable\n  - deny any secret submitted outside the secrets manager\n  - deny any IAM role request without an explicit least-privilege boundary\n  - deny any resource created without an owning team tag\n# directly encodes the real mistakes from Act 6, Act 8 and Act 11\n# verification POLICY-7714\n"}}}'::jsonb, '{"requiredFlag":"POLICY-7714"}'::jsonb),

  ('mission-atlas-platform-11-o1-c1', 'mission-atlas-platform-11-o1', 1, 'terminal_simulation', 'Read the platform metrics dashboard export and submit the verification code.', '{"instructions":"Read /var/atlas-platform-01/platform-metrics.txt and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-platform-01/platform-metrics.txt":{"type":"file","content":"one month after launch:\ninfrastructure tickets filed: 62, down from 340 the month before\nteams onboarded to the platform: 84 percent\nmedian provisioning time: 6 minutes, down from 4.5 days\n# verification METRICS-1187\n"}}}'::jsonb, '{"requiredFlag":"METRICS-1187"}'::jsonb),

  ('mission-atlas-platform-12-o1-c1', 'mission-atlas-platform-12-o1', 1, 'terminal_simulation', 'Read the platform metrics report and submit the verification code.', '{"instructions":"Read /var/atlas-platform-01/boss-platform-metrics.txt and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-platform-01/boss-platform-metrics.txt":{"type":"file","content":"tickets filed this month: 62, down from 340\nteams onboarded: 84 percent\nmedian provisioning time: 6 minutes, down from 4.5 days\nconclusion: the platform launch is a genuine, broad success\n# verification BOSSMETRICS-6631\n"}}}'::jsonb, '{"requiredFlag":"BOSSMETRICS-6631"}'::jsonb),
  ('mission-atlas-platform-12-o2-c1', 'mission-atlas-platform-12-o2', 1, 'terminal_simulation', 'Read the ticket breakdown by team and submit the verification code.', '{"instructions":"Read /var/atlas-platform-01/ticket-breakdown.txt and submit the verification code with: submit CODE","hostname":"atlas-platform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-platform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-platform-01/ticket-breakdown.txt":{"type":"file","content":"62 tickets filed this month\nteam data-pipelines: 56 tickets (90 percent of the total)\nall other 8 teams combined: 6 tickets\nevery data-pipelines ticket requests the same thing: provisioning a stateful, long-running batch workload\n# verification BREAKDOWN-7742\n"}}}'::jsonb, '{"requiredFlag":"BREAKDOWN-7742"}'::jsonb),
  ('mission-atlas-platform-12-o3-c1', 'mission-atlas-platform-12-o3', 1, 'investigation', 'Which evidence explains why one team is still filing nearly all remaining tickets?', '{"evidence":[{"id":"e1","label":"Platform metrics report","detail":"Tickets down 82 percent overall, 84 percent of teams onboarded, provisioning time down from 4.5 days to 6 minutes"},{"id":"e2","label":"Ticket breakdown by team","detail":"One team, data-pipelines, files 90 percent of all remaining tickets"},{"id":"e3","label":"Data-pipelines team request contents","detail":"Every one of their tickets asks for the same thing: a stateful, long-running batch processing workload"},{"id":"e4","label":"Golden path catalog","detail":"The platform currently offers golden paths for stateless web services and databases, but no golden path exists yet for a stateful, long-running batch workload"}],"question":"Which evidence explains why one team is still filing nearly all remaining tickets?"}'::jsonb, '{"requiredEvidenceIds":["e3","e4"]}'::jsonb),
  ('mission-atlas-platform-12-o4-c1', 'mission-atlas-platform-12-o4', 1, 'boss_encounter', 'Having confirmed the platform metrics, the ticket breakdown, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-platform-12-o1","label":"Confirm the platform metrics"},{"objectiveRef":"mission-atlas-platform-12-o2","label":"Confirm the ticket breakdown"},{"objectiveRef":"mission-atlas-platform-12-o3","label":"Identify who the platform still fails"}],"task":"State the diagnosis in one sentence: the platform launch is a genuine, broad success -- tickets down four-fifths, provisioning time down from days to minutes, most teams fully onboarded -- so adoption was never the problem, but the data-pipelines team keeps filing tickets because every one of them requests a stateful, long-running batch workload that no golden path currently covers, and a platform''s coverage has to keep growing to match what teams are actually trying to build, or it just becomes a smaller ticket queue for whoever it left out."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-platform-12-o1","mission-atlas-platform-12-o2","mission-atlas-platform-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-platform-01-o1-c1', 'orientation', 'Think about giving guardrails away by default, versus keeping them locked inside one team.', 10, 1),
  ('mission-atlas-platform-01-o1-c1', 'solution', 'Self-service guardrails by default, without requiring every team to become an infra expert.', 20, 2),

  ('mission-atlas-platform-02-o1-c1', 'orientation', 'Try: cat /var/atlas-platform-01/dx-survey.txt', 10, 1),
  ('mission-atlas-platform-02-o1-c1', 'solution', '4.5 days median, waiting on ops is the top blocker, verification DXSURVEY-4471. submit DXSURVEY-4471', 20, 2),

  ('mission-atlas-platform-03-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/platform/golden-path-web-service.yaml', 10, 1),
  ('mission-atlas-platform-03-o1-c1', 'solution', 'CI, distroless build, k8s, observability and least-privilege IAM, all by default, verification GOLDENPATH-8802. submit GOLDENPATH-8802', 20, 2),

  ('mission-atlas-platform-04-o1-c1', 'orientation', 'Think about self-service packaging versus just owning more servers.', 10, 1),
  ('mission-atlas-platform-04-o1-c1', 'solution', 'Self-service golden paths and APIs, not just shared ownership.', 20, 2),

  ('mission-atlas-platform-05-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/platform/service-templates/stateless-web.yaml', 10, 1),
  ('mission-atlas-platform-05-o1-c1', 'solution', 'Dockerfile, CI config, k8s manifests and README, verification TEMPLATE-2201. submit TEMPLATE-2201', 20, 2),

  ('mission-atlas-platform-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/platform/self-service-request.yaml', 10, 1),
  ('mission-atlas-platform-06-o1-c1', 'solution', 'Provisioned in 6 minutes, zero human ops involvement, verification SELFSERVICE-3387. submit SELFSERVICE-3387', 20, 2),

  ('mission-atlas-platform-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/platform/api-spec.yaml', 10, 1),
  ('mission-atlas-platform-07-o1-c1', 'solution', 'Services, databases, and secrets, each with automatic policy checks, verification PLATFORMAPI-6650. submit PLATFORMAPI-6650', 20, 2),

  ('mission-atlas-platform-08-o1-c1', 'orientation', 'Think about a self-updating map versus a wiki page someone forgot to edit.', 10, 1),
  ('mission-atlas-platform-08-o1-c1', 'solution', 'A single self-updating map of every service, owner, and docs.', 20, 2),

  ('mission-atlas-platform-09-o1-c1', 'orientation', 'Try: cat /var/atlas-platform-01/provisioning-log.txt', 10, 1),
  ('mission-atlas-platform-09-o1-c1', 'solution', '4.5 days down to 6 minutes, verification PROVISIONING-9012. submit PROVISIONING-9012', 20, 2),

  ('mission-atlas-platform-10-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/platform/policy-guardrails.yaml', 10, 1),
  ('mission-atlas-platform-10-o1-c1', 'solution', 'Public buckets, stray secrets, over-broad roles and missing owner tags, all denied automatically, verification POLICY-7714. submit POLICY-7714', 20, 2),

  ('mission-atlas-platform-11-o1-c1', 'orientation', 'Try: cat /var/atlas-platform-01/platform-metrics.txt', 10, 1),
  ('mission-atlas-platform-11-o1-c1', 'solution', '62 tickets down from 340, 84 percent onboarded, verification METRICS-1187. submit METRICS-1187', 20, 2),

  ('mission-atlas-platform-12-o1-c1', 'orientation', 'Try: cat /var/atlas-platform-01/boss-platform-metrics.txt', 10, 1),
  ('mission-atlas-platform-12-o1-c1', 'solution', 'A genuine, broad success overall, verification BOSSMETRICS-6631. submit BOSSMETRICS-6631', 20, 2),
  ('mission-atlas-platform-12-o2-c1', 'orientation', 'Try: cat /var/atlas-platform-01/ticket-breakdown.txt', 10, 1),
  ('mission-atlas-platform-12-o2-c1', 'solution', 'data-pipelines files 90 percent of what remains, verification BREAKDOWN-7742. submit BREAKDOWN-7742', 20, 2),
  ('mission-atlas-platform-12-o3-c1', 'orientation', 'The overall metrics are confirmed clean and are context, not the explanation. Compare that one team''s actual requests against the golden path catalog.', 10, 1),
  ('mission-atlas-platform-12-o3-c1', 'solution', 'e3 and e4: every ticket asks for a stateful batch workload, and no golden path covers that yet.', 20, 2),
  ('mission-atlas-platform-12-o4-c1', 'orientation', 'Combine the overall success, the coverage gap, and the fix into one sentence.', 15, 1),
  ('mission-atlas-platform-12-o4-c1', 'solution', 'The platform succeeded broadly; one team''s workload type has no golden path yet, and coverage has to keep growing to match real usage.', 25, 2);
