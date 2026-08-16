-- Atlas Division pathway ("The Silence") Act 9 -- "Container
-- Production" content, under world-atlas-container-production (already
-- inserted separately). 1 campaign, 2 operations, 12 missions (11
-- lessons + boss), closing World III "Container Docks" (Acts 8-9).
--
-- Same terminal-engine constraint as Acts 4-8 -- every artifact here
-- (signal log, shutdown spec, health status, resource limits, the
-- updated Dockerfile, a vulnerability scan, a promotion log, fleet
-- logs, distroless notes) is static seeded filesystem content read via
-- `cat`. Three hosts in play, all reused from prior Acts: `atlas-devbox-01`
-- (repo files), `atlas-ci-runner-04` (build/scan output), plus a new
-- `atlas-fleet-01` (live fleet monitoring across replicas).
--
-- Narrative thread: Act 8's distroless win gets a genuine, non-punitive
-- complication -- distroless has no init system, and the compiled
-- binary running as PID 1 was never built to reap the small
-- health-check helper subprocess it spawns every five minutes. Health
-- checks, resource limits and the image scan are all deliberately
-- clean (ruled out one by one) so the boss's investigation has to land
-- on the actual cause: PID 1 responsibilities plus the missing init
-- system, not a security incident or a resource problem.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-container-production', 'world-atlas-container-production', 'container-production', '3B - Container Production', 'Learn what changes once a container is actually running in production -- PID 1, signals, graceful shutdown, health checks, resource limits, non-root, image security, registry workflows, logging, networking and distroless concepts -- while Rook traces a slow, quiet zombie-process leak across the whole fleet.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-container-production-1', 'campaign-atlas-container-production', 'a-container-that-behaves', 'A Container That Behaves', 'PID 1, signals, graceful shutdown, health checks, resource limits and non-root.', 1),
  ('operation-atlas-container-production-2', 'campaign-atlas-container-production', 'what-the-clean-checks-missed', 'What the Clean Checks Missed', 'Image security, registry workflows, logging, networking and distroless concepts.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-container-production-01', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-1', 'pid-1', 'PID 1', 'A routine fleet audit finds it almost by accident: every replica of the newly optimized collector has been quietly accumulating zombie processes.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"pid-1-sim"}'::jsonb, '{"xp":210,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-container-production-02', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-1', 'signals', 'Signals', 'Confirm exactly what happens when the orchestrator actually tries to stop one of these containers.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-container-production-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"signals-sim"}'::jsonb, '{"xp":210,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-container-production-03', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-1', 'graceful-shutdown', 'Graceful Shutdown', 'Confirm what the collector itself is actually supposed to do the moment it receives that signal.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-container-production-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"graceful-shutdown-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-container-production-04', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-1', 'health-checks', 'Health Checks', 'Confirm exactly what this fleet''s health check does and does not actually verify.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-container-production-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"health-checks-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-container-production-05', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-1', 'resource-limits', 'Resource Limits', 'Confirm whether the fleet''s CPU and memory limits caught any of this.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-container-production-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"resource-limits-sim"}'::jsonb, '{"xp":230,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-container-production-06', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-1', 'non-root', 'Non-Root', 'Confirm the container is not running with more privilege than it needs -- rule this out before ruling anything else in.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-container-production-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"non-root-sim"}'::jsonb, '{"xp":230,"credits":40}'::jsonb, false, 6),
  ('mission-atlas-container-production-07', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-2', 'image-security', 'Image Security', 'Confirm this image was never actually compromised in the first place.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-container-production-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"image-security-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-container-production-08', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-2', 'registry-workflows', 'Registry Workflows', 'Confirm the exact same image is what actually reached every environment, with nothing rebuilt in between.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-container-production-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"registry-workflows-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-container-production-09', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-2', 'logging', 'Logging', 'Everything checked so far is clean. Confirm what the collector''s own logs actually say.', 'beginner', ARRAY['rook','byte'], '{"requiredMissionIds":["mission-atlas-container-production-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"logging-sim"}'::jsonb, '{"xp":250,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-container-production-10', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-2', 'networking', 'Networking', 'Confirm the fleet''s production networking is not itself part of the problem.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-container-production-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"networking-prod-sim"}'::jsonb, '{"xp":250,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-container-production-11', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-2', 'distroless-concepts', 'Distroless Concepts', 'Everything else has been ruled out. Confirm what a distroless base image actually does and does not give you.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-container-production-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"distroless-concepts-sim"}'::jsonb, '{"xp":260,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-container-production-12', 'world-atlas-container-production', 'campaign-atlas-container-production', 'operation-atlas-container-production-2', 'the-zombie-fleet', 'The Zombie Fleet', 'Everything this Act taught, turned on one fleet: not to patch it once, to finally explain how a genuinely correct, lean image still let zombies pile up unnoticed for days.', 'boss', ARRAY['rook','leena','cross','byte'], '{"requiredMissionIds":["mission-atlas-container-production-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"zombie-fleet-boss-sim"}'::jsonb, '{"xp":490,"credits":110,"badgeIds":["the-zombie-fleet"],"skillXp":{"cloud_devops_fundamentals":85}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-container-production-01', 1, 'leena', 'A routine fleet audit found it almost by accident. Every replica of the newly optimized collector has been quietly accumulating zombie processes for days.'),
  ('mission-atlas-container-production-02', 1, 'rook', 'Nothing crashed. Health checks are green. Resource usage looks fine. And the process table keeps growing anyway.'),
  ('mission-atlas-container-production-01', 2, 'rook', 'The first process in a container is PID 1, and it inherits responsibilities most programs are never designed for -- above all, reaping its own orphaned child processes. Normal systems have an init process to do that automatically. A container does not, unless something is specifically built or added to be one.'),

  ('mission-atlas-container-production-02', 2, 'rook', 'Confirm what actually happens when the orchestrator tries to stop one of these -- what signal it sends, and what the container does with it.'),

  ('mission-atlas-container-production-03', 1, 'rook', 'A graceful shutdown means the process itself reacts to that signal on purpose -- stop taking new work, finish what is in flight, then exit cleanly, all inside whatever grace period it is given.'),

  ('mission-atlas-container-production-04', 1, 'cross', 'Imani Cross. A health check answering "yes" is not the same claim as "everything about this process is fine." Confirm exactly what this one actually asks.'),

  ('mission-atlas-container-production-05', 1, 'cross', 'Resource limits catch a process using too much. They were never going to catch a handful of exited-but-unreaped processes sitting at nearly zero usage. Confirm that for yourself before ruling it out.'),

  ('mission-atlas-container-production-06', 1, 'rook', 'Before chasing anything more exotic, confirm the basics still hold -- this container should not be running as root, and if it somehow is, that changes everything about how seriously to take this.'),

  ('mission-atlas-container-production-07', 1, 'rook', 'A zombie process pileup could, in theory, be a symptom of something worse. Rule out a compromised image before assuming this is purely a process-management bug.'),

  ('mission-atlas-container-production-08', 1, 'rook', 'And rule out image drift too -- confirm the exact same artifact that passed every check actually reached every environment, with nothing quietly rebuilt along the way.'),

  ('mission-atlas-container-production-09', 1, 'byte', 'Health checks clean. Resource limits clean. Image scan clean. Registry history clean. I am running out of clean things to check.'),
  ('mission-atlas-container-production-09', 2, 'rook', 'Then stop checking systems and start reading what the process itself has actually been saying the whole time.'),

  ('mission-atlas-container-production-10', 1, 'rook', 'Confirm the fleet''s networking is behaving normally too -- it should be, but this is exactly the moment to actually check instead of assuming.'),

  ('mission-atlas-container-production-11', 1, 'rook', 'Every other system just checked out clean. That leaves one thing this Act has not directly looked at yet: what a distroless base image actually is, and specifically, what it does not include.'),

  ('mission-atlas-container-production-12', 1, 'leena', 'Everything this Act taught you, on one fleet. Not to patch it once -- to finally explain how a genuinely correct, lean image still let zombies pile up unnoticed for days.'),
  ('mission-atlas-container-production-12', 2, 'byte', 'I have the current health status and the collector''s own logs both pulled up together. Every other system already checked out clean.'),
  ('mission-atlas-container-production-12', 3, 'cross', 'Clean does not mean irrelevant. It means the cause is somewhere none of those systems were ever built to look.'),
  ('mission-atlas-container-production-12', 4, 'rook', 'Find what actually explains a process count that only ever grows, and say what has to be added to stop it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-container-production-01-o1', 'mission-atlas-container-production-01', 1, 'Explain PID 1 responsibilities', 'Choose the accurate description of what makes PID 1 different from any other process.'),

  ('mission-atlas-container-production-02-o1', 'mission-atlas-container-production-02', 1, 'Check the signal log', 'Read the signal log and submit the verification code.'),

  ('mission-atlas-container-production-03-o1', 'mission-atlas-container-production-03', 1, 'Check the shutdown spec', 'Read the shutdown specification and submit the verification code.'),

  ('mission-atlas-container-production-04-o1', 'mission-atlas-container-production-04', 1, 'Check the health status', 'Read the health status and submit the verification code.'),

  ('mission-atlas-container-production-05-o1', 'mission-atlas-container-production-05', 1, 'Check the resource limits', 'Read the resource limits report and submit the verification code.'),

  ('mission-atlas-container-production-06-o1', 'mission-atlas-container-production-06', 1, 'Check the container user', 'Read the Dockerfile and submit the verification code.'),

  ('mission-atlas-container-production-07-o1', 'mission-atlas-container-production-07', 1, 'Check the vulnerability scan', 'Read the vulnerability scan and submit the verification code.'),

  ('mission-atlas-container-production-08-o1', 'mission-atlas-container-production-08', 1, 'Check the promotion log', 'Read the registry promotion log and submit the verification code.'),

  ('mission-atlas-container-production-09-o1', 'mission-atlas-container-production-09', 1, 'Check the collector logs', 'Read the collector logs and submit the verification code.'),

  ('mission-atlas-container-production-10-o1', 'mission-atlas-container-production-10', 1, 'Explain production container networking', 'Choose the accurate description of how containers reach each other in production.'),

  ('mission-atlas-container-production-11-o1', 'mission-atlas-container-production-11', 1, 'Check the distroless notes', 'Read the distroless notes and submit the verification code.'),

  ('mission-atlas-container-production-12-o1', 'mission-atlas-container-production-12', 1, 'Confirm the current zombie count', 'Read the health status and submit the verification code.'),
  ('mission-atlas-container-production-12-o2', 'mission-atlas-container-production-12', 2, 'Confirm the spawn pattern', 'Read the collector logs and submit the verification code.'),
  ('mission-atlas-container-production-12-o3', 'mission-atlas-container-production-12', 3, 'Identify what actually explains the leak', 'Find the evidence that explains why zombie processes keep accumulating.'),
  ('mission-atlas-container-production-12-o4', 'mission-atlas-container-production-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what has to be added to stop this.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-container-production-01-o1-c1', 'mission-atlas-container-production-01-o1', 1, 'multiple_choice', 'PID 1 inside a container is different from any other process because...', '{"question":"PID 1 inside a container is different from any other process because...","options":[{"id":"a","text":"It is responsible for reaping orphaned child processes -- a job a normal system''s init process handles automatically, but a container has none unless one is specifically added"},{"id":"b","text":"It is always run as the root user regardless of the Dockerfile"},{"id":"c","text":"It cannot receive any signals at all"},{"id":"d","text":"It is automatically restarted every time it exits, with no configuration needed"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-container-production-02-o1-c1', 'mission-atlas-container-production-02-o1', 1, 'terminal_simulation', 'Read the signal log and submit the verification code.', '{"instructions":"Read /var/atlas-fleet/signal-log.txt and submit the verification code with: submit CODE","hostname":"atlas-fleet-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-fleet-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-fleet/signal-log.txt":{"type":"file","content":"docker stop metrics-collector-07: sent SIGTERM\nmetrics-collector-07: no response after 10s grace period\ndocker stop metrics-collector-07: sent SIGKILL\n# verification SIGNAL-3312\n"}}}'::jsonb, '{"requiredFlag":"SIGNAL-3312"}'::jsonb),

  ('mission-atlas-container-production-03-o1-c1', 'mission-atlas-container-production-03-o1', 1, 'terminal_simulation', 'Read the shutdown specification and submit the verification code.', '{"instructions":"Read /repo/shutdown-spec.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/shutdown-spec.txt":{"type":"file","content":"on SIGTERM: stop accepting new connections, finish in-flight requests (max 8s), exit 0\ngrace period allotted by orchestrator: 10s\n# verification SHUTDOWN-6602\n"}}}'::jsonb, '{"requiredFlag":"SHUTDOWN-6602"}'::jsonb),

  ('mission-atlas-container-production-04-o1-c1', 'mission-atlas-container-production-04-o1', 1, 'terminal_simulation', 'Read the health status and submit the verification code.', '{"instructions":"Read /var/atlas-fleet/health-status.txt and submit the verification code with: submit CODE","hostname":"atlas-fleet-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-fleet-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-fleet/health-status.txt":{"type":"file","content":"metrics-collector-07  HEALTHCHECK: curl -f http://localhost:9090/healthz  status=healthy (last 200 checks, 100% pass)\nprocess table: 1 running, 47 defunct (zombie)\n# verification HEALTH-7714\n"}}}'::jsonb, '{"requiredFlag":"HEALTH-7714"}'::jsonb),

  ('mission-atlas-container-production-05-o1-c1', 'mission-atlas-container-production-05-o1', 1, 'terminal_simulation', 'Read the resource limits report and submit the verification code.', '{"instructions":"Read /var/atlas-fleet/resource-limits.txt and submit the verification code with: submit CODE","hostname":"atlas-fleet-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-fleet-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-fleet/resource-limits.txt":{"type":"file","content":"metrics-collector-07 cgroup limits: cpu=2, memory=2048MB\ncurrent usage: cpu=12%, memory=38%\nzombie (defunct) processes consume near-zero CPU and memory -- invisible to limit-based alerting\n# verification LIMITS-4471\n"}}}'::jsonb, '{"requiredFlag":"LIMITS-4471"}'::jsonb),

  ('mission-atlas-container-production-06-o1-c1', 'mission-atlas-container-production-06-o1', 1, 'terminal_simulation', 'Read the Dockerfile and submit the verification code.', '{"instructions":"Read /repo/Dockerfile.v3 and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/Dockerfile.v3":{"type":"file","content":"FROM golang:1.22 AS build\nWORKDIR /src\nCOPY . .\nRUN go build -o atlas-metrics-agent\n\nFROM gcr.io/distroless/base\nCOPY --from=build /src/atlas-metrics-agent /atlas-metrics-agent\nUSER nonroot:nonroot\nCMD [\"/atlas-metrics-agent\"]\n# verification NONROOT-9012\n"}}}'::jsonb, '{"requiredFlag":"NONROOT-9012"}'::jsonb),

  ('mission-atlas-container-production-07-o1-c1', 'mission-atlas-container-production-07-o1', 1, 'terminal_simulation', 'Read the vulnerability scan and submit the verification code.', '{"instructions":"Read /var/atlas-ci/docker-build-4472/scan-report.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/docker-build-4472/scan-report.txt":{"type":"file","content":"image vulnerability scan: atlas-images/atlas-metrics-agent:v13.0.0\ncritical: 0  high: 0  medium: 0  low: 1 (informational)\nscan: PASS\n# verification SCAN-2291\n"}}}'::jsonb, '{"requiredFlag":"SCAN-2291"}'::jsonb),

  ('mission-atlas-container-production-08-o1-c1', 'mission-atlas-container-production-08-o1', 1, 'terminal_simulation', 'Read the registry promotion log and submit the verification code.', '{"instructions":"Read /var/atlas-deploy/promotion-log.txt and submit the verification code with: submit CODE","hostname":"atlas-deploy-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-deploy-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-deploy/promotion-log.txt":{"type":"file","content":"atlas-metrics-agent:v13.0.0\n  dev -> staging: promoted 2026-08-10, digest sha256:9f2ac83e...\n  staging -> production: promoted 2026-08-12, digest sha256:9f2ac83e...\nidentical digest at every stage -- no rebuild, no drift\n# verification PROMO-5541\n"}}}'::jsonb, '{"requiredFlag":"PROMO-5541"}'::jsonb),

  ('mission-atlas-container-production-09-o1-c1', 'mission-atlas-container-production-09-o1', 1, 'terminal_simulation', 'Read the collector logs and submit the verification code.', '{"instructions":"Read /var/atlas-fleet/collector-07.log and submit the verification code with: submit CODE","hostname":"atlas-fleet-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-fleet-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-fleet/collector-07.log":{"type":"file","content":"09:00:01 spawning healthcheck-helper subprocess (pid 812)\n09:00:02 healthcheck-helper exited\n09:05:01 spawning healthcheck-helper subprocess (pid 933)\n09:05:02 healthcheck-helper exited\n09:10:01 spawning healthcheck-helper subprocess (pid 1054)\n09:10:02 healthcheck-helper exited\n(pattern repeats every 5 minutes -- no reap or waitpid entry ever appears)\n# verification LOG-8814\n"}}}'::jsonb, '{"requiredFlag":"LOG-8814"}'::jsonb),

  ('mission-atlas-container-production-10-o1-c1', 'mission-atlas-container-production-10-o1', 1, 'multiple_choice', 'In production, containers typically reach each other by...', '{"question":"In production, containers typically reach each other by...","options":[{"id":"a","text":"Service discovery over the orchestrator''s own network, using stable service names rather than any one container''s own IP, which can change on every restart"},{"id":"b","text":"Hardcoding each container''s current IP address into every other container"},{"id":"c","text":"They cannot communicate with each other at all inside an orchestrator"},{"id":"d","text":"Physically cabling each host together"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-container-production-11-o1-c1', 'mission-atlas-container-production-11-o1', 1, 'terminal_simulation', 'Read the distroless notes and submit the verification code.', '{"instructions":"Read /repo/distroless-notes.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/distroless-notes.txt":{"type":"file","content":"distroless base images contain no shell, no package manager, and critically, no init system.\nRunning a compiled binary directly as PID 1 means that binary alone is responsible for reaping its own zombie children -- distroless does not do this automatically.\n# verification DISTROLESS-3390\n"}}}'::jsonb, '{"requiredFlag":"DISTROLESS-3390"}'::jsonb),

  ('mission-atlas-container-production-12-o1-c1', 'mission-atlas-container-production-12-o1', 1, 'terminal_simulation', 'Read the health status and submit the verification code.', '{"instructions":"Read /var/atlas-fleet/health-status.txt and submit the verification code with: submit CODE","hostname":"atlas-fleet-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-fleet-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-fleet/health-status.txt":{"type":"file","content":"metrics-collector-07  HEALTHCHECK: curl -f http://localhost:9090/healthz  status=healthy (last 200 checks, 100% pass)\nprocess table: 1 running, 47 defunct (zombie)\n# verification HEALTH-7714\n"}}}'::jsonb, '{"requiredFlag":"HEALTH-7714"}'::jsonb),
  ('mission-atlas-container-production-12-o2-c1', 'mission-atlas-container-production-12-o2', 1, 'terminal_simulation', 'Read the collector logs and submit the verification code.', '{"instructions":"Read /var/atlas-fleet/collector-07.log and submit the verification code with: submit CODE","hostname":"atlas-fleet-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-fleet-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-fleet/collector-07.log":{"type":"file","content":"09:00:01 spawning healthcheck-helper subprocess (pid 812)\n09:00:02 healthcheck-helper exited\n09:05:01 spawning healthcheck-helper subprocess (pid 933)\n09:05:02 healthcheck-helper exited\n09:10:01 spawning healthcheck-helper subprocess (pid 1054)\n09:10:02 healthcheck-helper exited\n(pattern repeats every 5 minutes -- no reap or waitpid entry ever appears)\n# verification LOG-8814\n"}}}'::jsonb, '{"requiredFlag":"LOG-8814"}'::jsonb),
  ('mission-atlas-container-production-12-o3-c1', 'mission-atlas-container-production-12-o3', 1, 'investigation', 'Which evidence explains why zombie processes keep accumulating?', '{"evidence":[{"id":"e1","label":"PID 1 responsibilities","detail":"The compiled binary runs directly as PID 1, making it solely responsible for reaping its own orphaned children -- a job a normal init process would otherwise handle"},{"id":"e2","label":"Distroless notes","detail":"The distroless base image has no shell, no package manager, and no init system of any kind"},{"id":"e3","label":"Vulnerability scan","detail":"The image scan is completely clean -- zero critical, high or medium findings"},{"id":"e4","label":"Registry promotion log","detail":"The exact same image digest was promoted unchanged through every environment"}],"question":"Which evidence explains why zombie processes keep accumulating?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-container-production-12-o4-c1', 'mission-atlas-container-production-12-o4', 1, 'boss_encounter', 'Having confirmed the zombie count, the spawn pattern, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-container-production-12-o1","label":"Confirm the current zombie count"},{"objectiveRef":"mission-atlas-container-production-12-o2","label":"Confirm the spawn pattern"},{"objectiveRef":"mission-atlas-container-production-12-o3","label":"Identify what actually explains the leak"}],"task":"State the diagnosis in one sentence: the collector runs as PID 1 inside a distroless image with no init system, so every health-check helper subprocess it spawns every five minutes is left unreaped once it exits, and the fix is not a bigger image or a stricter health check -- it is adding a minimal init process (such as tini) as the actual PID 1, so the collector''s own binary is no longer solely responsible for reaping what it spawns."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-container-production-12-o1","mission-atlas-container-production-12-o2","mission-atlas-container-production-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-container-production-01-o1-c1', 'orientation', 'Think about what a normal operating system''s init process does that a container might not have at all.', 10, 1),
  ('mission-atlas-container-production-01-o1-c1', 'solution', 'PID 1 must reap orphaned children; a container has no init process for this unless one is added.', 20, 2),

  ('mission-atlas-container-production-02-o1-c1', 'orientation', 'Try: cat /var/atlas-fleet/signal-log.txt', 10, 1),
  ('mission-atlas-container-production-02-o1-c1', 'solution', 'SIGTERM got no response, then SIGKILL followed, verification SIGNAL-3312. submit SIGNAL-3312', 20, 2),

  ('mission-atlas-container-production-03-o1-c1', 'orientation', 'Try: cat /repo/shutdown-spec.txt', 10, 1),
  ('mission-atlas-container-production-03-o1-c1', 'solution', 'It should finish in-flight work within 8s, verification SHUTDOWN-6602. submit SHUTDOWN-6602', 20, 2),

  ('mission-atlas-container-production-04-o1-c1', 'orientation', 'Try: cat /var/atlas-fleet/health-status.txt', 10, 1),
  ('mission-atlas-container-production-04-o1-c1', 'solution', '47 defunct processes despite a healthy status, verification HEALTH-7714. submit HEALTH-7714', 20, 2),

  ('mission-atlas-container-production-05-o1-c1', 'orientation', 'Try: cat /var/atlas-fleet/resource-limits.txt', 10, 1),
  ('mission-atlas-container-production-05-o1-c1', 'solution', 'Zombies use near-zero resources, verification LIMITS-4471. submit LIMITS-4471', 20, 2),

  ('mission-atlas-container-production-06-o1-c1', 'orientation', 'Try: cat /repo/Dockerfile.v3', 10, 1),
  ('mission-atlas-container-production-06-o1-c1', 'solution', 'USER nonroot is set, verification NONROOT-9012. submit NONROOT-9012', 20, 2),

  ('mission-atlas-container-production-07-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/docker-build-4472/scan-report.txt', 10, 1),
  ('mission-atlas-container-production-07-o1-c1', 'solution', 'Zero critical or high findings, verification SCAN-2291. submit SCAN-2291', 20, 2),

  ('mission-atlas-container-production-08-o1-c1', 'orientation', 'Try: cat /var/atlas-deploy/promotion-log.txt', 10, 1),
  ('mission-atlas-container-production-08-o1-c1', 'solution', 'Identical digest at every stage, verification PROMO-5541. submit PROMO-5541', 20, 2),

  ('mission-atlas-container-production-09-o1-c1', 'orientation', 'Try: cat /var/atlas-fleet/collector-07.log', 10, 1),
  ('mission-atlas-container-production-09-o1-c1', 'solution', 'Spawns repeat every 5 minutes with no reap entry, verification LOG-8814. submit LOG-8814', 20, 2),

  ('mission-atlas-container-production-10-o1-c1', 'orientation', 'Think about names that stay stable versus IPs that do not.', 10, 1),
  ('mission-atlas-container-production-10-o1-c1', 'solution', 'Service discovery over the orchestrator network, using stable names, not raw IPs.', 20, 2),

  ('mission-atlas-container-production-11-o1-c1', 'orientation', 'Try: cat /repo/distroless-notes.txt', 10, 1),
  ('mission-atlas-container-production-11-o1-c1', 'solution', 'No init system at all, verification DISTROLESS-3390. submit DISTROLESS-3390', 20, 2),

  ('mission-atlas-container-production-12-o1-c1', 'orientation', 'Try: cat /var/atlas-fleet/health-status.txt', 10, 1),
  ('mission-atlas-container-production-12-o1-c1', 'solution', 'verification HEALTH-7714. submit HEALTH-7714', 20, 2),
  ('mission-atlas-container-production-12-o2-c1', 'orientation', 'Try: cat /var/atlas-fleet/collector-07.log', 10, 1),
  ('mission-atlas-container-production-12-o2-c1', 'solution', 'verification LOG-8814. submit LOG-8814', 20, 2),
  ('mission-atlas-container-production-12-o3-c1', 'orientation', 'The scan and the promotion log are both clean and irrelevant to this specific bug. Look for what actually connects PID 1 to the missing init system.', 10, 1),
  ('mission-atlas-container-production-12-o3-c1', 'solution', 'e1 and e2: running as PID 1 inside a distroless image with no init system is exactly why nothing ever reaps these children.', 20, 2),
  ('mission-atlas-container-production-12-o4-c1', 'orientation', 'Combine the zombie count, the spawn pattern, and the missing init system into one sentence.', 15, 1),
  ('mission-atlas-container-production-12-o4-c1', 'solution', 'PID 1 in a distroless image with no init system never reaps the health-check helper it spawns every five minutes -- the fix is adding a minimal init process like tini as the real PID 1.', 25, 2);
