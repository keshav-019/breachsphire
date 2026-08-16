-- Atlas Division pathway ("The Silence") Act 8 -- "Containment"
-- content, under world-atlas-containment (already inserted separately).
-- 1 campaign, 2 operations, 12 missions (11 lessons + boss), opening
-- World III "Container Docks" (Acts 8-9).
--
-- Same terminal-engine constraint as Acts 4-7 -- no docker-specific
-- commands exist in the engine -- so every artifact here (Dockerfile
-- drafts, build logs, .dockerignore, context reports, compose file,
-- optimization report, push log) is static seeded filesystem content
-- read via `cat`. Only "images vs containers" (a pure definition, no
-- natural artifact) stays multiple_choice; every other topic has a
-- genuine file or log behind it. Two hosts reused from Acts 4-7:
-- `atlas-devbox-01` (repo-side files) and `atlas-ci-runner-04` (build
-- and push logs, same runner that ran CI in Act 6).
--
-- Narrative thread: Rook's first Dockerfile for atlas-metrics-agent is
-- a direct copy of VM-image habits -- full build toolchain left in the
-- final image, no .dockerignore, one giant layer -- producing a
-- bloated, slow-to-push image. Fixing it (multi-stage build, a scoped
-- build context, a minimal runtime stage) is the Act's actual arc,
-- landing on a genuine win: a 97% size reduction, closing the loop on
-- Act 3's "nobody resized the image" root cause by proving an image can
-- be built lean from the very first line, deliberately not staged as
-- another incident.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-containment', 'world-atlas-containment', 'containment', '3A - Containment', 'Learn Docker from first principles -- images versus containers, Dockerfiles, layers, build context, volumes, networks, environment variables, Compose, multi-stage builds, optimization and registries -- while Rook fixes a genuinely bloated first attempt at containerizing the collector.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-containment-1', 'campaign-atlas-containment', 'a-container-that-actually-runs', 'A Container That Actually Runs', 'Images versus containers, Dockerfiles, layers, build context, volumes and networks.', 1),
  ('operation-atlas-containment-2', 'campaign-atlas-containment', 'a-container-built-to-ship', 'A Container Built to Ship', 'Environment variables, Compose, multi-stage builds, optimization and registries.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-containment-01', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-1', 'images-vs-containers', 'Images vs Containers', 'v12.1.0 is stable. Rook''s next project: containerize atlas-metrics-agent, so no image ever sits unresized in production again.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"images-vs-containers-sim"}'::jsonb, '{"xp":200,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-containment-02', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-1', 'dockerfile', 'Dockerfile', 'Confirm exactly what Rook''s first draft actually instructs the build to do.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"dockerfile-sim"}'::jsonb, '{"xp":200,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-containment-03', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-1', 'layers', 'Layers', 'The build finished. Confirm exactly which layer made it this large.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"layers-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-containment-04', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-1', 'build-context', 'Build Context', 'The layers are not the whole story. Confirm what actually got sent to the build daemon before a single instruction even ran.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"build-context-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-containment-05', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-1', 'volumes', 'Volumes', 'Confirm what actually happens to the collector''s data if this container is ever removed.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"volumes-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-containment-06', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-1', 'networks', 'Networks', 'Confirm how the agent is actually supposed to reach its database once both are containers.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"networks-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 6),
  ('mission-atlas-containment-07', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-2', 'environment', 'Environment', 'This lesson again -- but this time, confirm the token is actually injected the right way, not written into anything.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-containment-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"environment-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-containment-08', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-2', 'compose', 'Compose', 'Confirm how the agent and its database are actually meant to run together for local development.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"compose-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-containment-09', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-2', 'multi-stage-builds', 'Multi-Stage Builds', 'Confirm what Rook actually changed to stop shipping the entire build toolchain to production.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"multi-stage-builds-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-containment-10', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-2', 'optimization', 'Optimization', 'Confirm exactly how much smaller the fixed image actually is.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"optimization-sim"}'::jsonb, '{"xp":240,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-containment-11', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-2', 'registries', 'Registries', 'Confirm how much faster the fixed image actually pushes.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-containment-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"registries-docker-sim"}'::jsonb, '{"xp":250,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-containment-12', 'world-atlas-containment', 'campaign-atlas-containment', 'operation-atlas-containment-2', 'container-escape-velocity', 'Container Escape Velocity', 'Everything this Act taught, turned on one image: not to patch it once, to prove the exact same gravity that produced Act 3''s dying host can be escaped on purpose, every single time.', 'boss', ARRAY['rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-containment-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"container-escape-velocity-boss-sim"}'::jsonb, '{"xp":480,"credits":110,"badgeIds":["container-escape-velocity"],"skillXp":{"cloud_devops_fundamentals":80}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-containment-01', 1, 'leena', 'v12.1.0 has been stable in production for a week. Rook''s next project starts now: containerize atlas-metrics-agent, on purpose, so an image nobody resizes for months is never the reason something breaks again.'),
  ('mission-atlas-containment-01', 2, 'rook', 'An image is a built, immutable template -- everything a container needs, frozen at build time. A container is a running instance of that image, the same way a process is a running instance of a program. Confuse the two and nothing after this makes sense.'),

  ('mission-atlas-containment-02', 1, 'rook', 'Here is my first draft. Before judging it, read exactly what it actually tells the build to do.'),

  ('mission-atlas-containment-03', 1, 'rook', 'Every instruction in a Dockerfile creates its own layer, cached independently. Confirm which one is actually responsible for most of this image''s size.'),

  ('mission-atlas-containment-04', 1, 'rook', 'Before a single instruction even runs, the entire build context gets sent to the daemon. If nothing is excluded, that includes everything in the directory -- git history, dependencies, logs, all of it.'),

  ('mission-atlas-containment-05', 1, 'rook', 'A container''s own filesystem disappears the moment the container is removed. A volume is how data is supposed to survive that -- confirm whether this one actually has one.'),

  ('mission-atlas-containment-06', 1, 'rook', 'Two separate containers do not share a filesystem or a process list, but they can share a network. On a user-defined network, one container reaches another by name, not by guessing an IP.'),

  ('mission-atlas-containment-07', 1, 'cross', 'Imani Cross. After Act 6, I am checking this on every service now, containerized or not: confirm that token is never written into anything, not even by accident.'),
  ('mission-atlas-containment-07', 2, 'rook', 'It is not. It is injected at container start from the same secrets manager we already fixed this to use.'),

  ('mission-atlas-containment-08', 1, 'rook', 'Running the agent and its database by hand, separately, every time, does not scale past one developer''s laptop. Compose defines both as one unit and starts them together.'),

  ('mission-atlas-containment-09', 1, 'rook', 'This is the actual fix. A multi-stage build uses one stage with the full toolchain to compile the binary, then copies only that finished binary into a second, much smaller final stage. The compiler never ships. Confirm what that second stage now looks like.'),

  ('mission-atlas-containment-10', 1, 'rook', 'Confirm the number. I want to see it as plainly as everyone else is about to.'),

  ('mission-atlas-containment-11', 1, 'rook', 'Confirm the push. A smaller image does not just save disk -- it changes how fast this can actually ship.'),

  ('mission-atlas-containment-12', 1, 'leena', 'Everything this Act taught you, on one image. Not to patch it once -- to prove the exact gravity that produced Act 3''s dying host can be escaped on purpose, every time, starting from the very first line of a Dockerfile.'),
  ('mission-atlas-containment-12', 2, 'byte', 'I have the optimization report and the push log both pulled up. Same service. Same functionality. One number changed by 97%.'),
  ('mission-atlas-containment-12', 3, 'rook', 'Find what actually caused that -- not just that it happened, but which specific changes are responsible.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-containment-01-o1', 'mission-atlas-containment-01', 1, 'Tell an image from a container', 'Choose the accurate distinction between a Docker image and a Docker container.'),

  ('mission-atlas-containment-02-o1', 'mission-atlas-containment-02', 1, 'Read the first draft Dockerfile', 'Read the Dockerfile and submit the verification code.'),

  ('mission-atlas-containment-03-o1', 'mission-atlas-containment-03', 1, 'Identify the largest layer', 'Read the layer breakdown and submit the verification code.'),

  ('mission-atlas-containment-04-o1', 'mission-atlas-containment-04', 1, 'Check the build context', 'Read the build context report and submit the verification code.'),

  ('mission-atlas-containment-05-o1', 'mission-atlas-containment-05', 1, 'Check the volume mount', 'Read the volume definition and submit the verification code.'),

  ('mission-atlas-containment-06-o1', 'mission-atlas-containment-06', 1, 'Check the network definition', 'Read the network definition and submit the verification code.'),

  ('mission-atlas-containment-07-o1', 'mission-atlas-containment-07', 1, 'Confirm the environment injection', 'Read the environment configuration and submit the verification code.'),

  ('mission-atlas-containment-08-o1', 'mission-atlas-containment-08', 1, 'Read the compose file', 'Read the Compose file and submit the verification code.'),

  ('mission-atlas-containment-09-o1', 'mission-atlas-containment-09', 1, 'Read the fixed Dockerfile', 'Read the multi-stage Dockerfile and submit the verification code.'),

  ('mission-atlas-containment-10-o1', 'mission-atlas-containment-10', 1, 'Confirm the size reduction', 'Read the optimization report and submit the verification code.'),

  ('mission-atlas-containment-11-o1', 'mission-atlas-containment-11', 1, 'Confirm the registry push', 'Read the push log and submit the verification code.'),

  ('mission-atlas-containment-12-o1', 'mission-atlas-containment-12', 1, 'Confirm the final image size', 'Read the optimization report and submit the verification code.'),
  ('mission-atlas-containment-12-o2', 'mission-atlas-containment-12', 2, 'Confirm the fast push', 'Read the push log and submit the verification code.'),
  ('mission-atlas-containment-12-o3', 'mission-atlas-containment-12', 3, 'Identify what actually caused the improvement', 'Find the evidence that explains what specifically made this image small and fast.'),
  ('mission-atlas-containment-12-o4', 'mission-atlas-containment-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually changed and why it matters.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-containment-01-o1-c1', 'mission-atlas-containment-01-o1', 1, 'multiple_choice', 'A Docker image and a Docker container differ in that...', '{"question":"A Docker image and a Docker container differ in that...","options":[{"id":"a","text":"An image is a built, immutable template; a container is a running instance of that image"},{"id":"b","text":"They are identical terms for the same thing"},{"id":"c","text":"A container can exist without ever being built from an image"},{"id":"d","text":"An image is only ever used for storage, never for running anything"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-containment-02-o1-c1', 'mission-atlas-containment-02-o1', 1, 'terminal_simulation', 'Read the Dockerfile and submit the verification code.', '{"instructions":"Read /repo/Dockerfile and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/Dockerfile":{"type":"file","content":"FROM ubuntu:22.04\nRUN apt-get update && apt-get install -y build-essential git curl python3 golang nodejs npm\nCOPY . .\nRUN make build\nCMD [\"./atlas-metrics-agent\"]\n# verification DOCKERFILE-3301\n"}}}'::jsonb, '{"requiredFlag":"DOCKERFILE-3301"}'::jsonb),

  ('mission-atlas-containment-03-o1-c1', 'mission-atlas-containment-03-o1', 1, 'terminal_simulation', 'Read the layer breakdown and submit the verification code.', '{"instructions":"Read /var/atlas-ci/docker-build-4471/layers.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/docker-build-4471/layers.txt":{"type":"file","content":"layer 1: FROM ubuntu:22.04                                    72MB\nlayer 2: RUN apt-get install build-essential git ... nodejs    850MB\nlayer 3: COPY . .                                             140MB\nlayer 4: RUN make build                                        60MB\ntotal image size: 1122MB\n# verification LAYERS-6602\n"}}}'::jsonb, '{"requiredFlag":"LAYERS-6602"}'::jsonb),

  ('mission-atlas-containment-04-o1-c1', 'mission-atlas-containment-04-o1', 1, 'terminal_simulation', 'Read the build context report and submit the verification code.', '{"instructions":"Read /var/atlas-ci/docker-build-4471/context-report.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/docker-build-4471/context-report.txt":{"type":"file","content":"build context sent to daemon: 640MB\nincludes: .git/ (210MB), node_modules/ (300MB), *.log (40MB)\nno .dockerignore found\n# verification CONTEXT-7714\n"}}}'::jsonb, '{"requiredFlag":"CONTEXT-7714"}'::jsonb),

  ('mission-atlas-containment-05-o1-c1', 'mission-atlas-containment-05-o1', 1, 'terminal_simulation', 'Read the volume definition and submit the verification code.', '{"instructions":"Read /repo/volumes.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/volumes.txt":{"type":"file","content":"volume: atlas-metrics-data -> /var/lib/atlas-metrics\npersists independently of the container''s own lifecycle -- removing the container does not remove this data\n# verification VOLUME-4471\n"}}}'::jsonb, '{"requiredFlag":"VOLUME-4471"}'::jsonb),

  ('mission-atlas-containment-06-o1-c1', 'mission-atlas-containment-06-o1', 1, 'terminal_simulation', 'Read the network definition and submit the verification code.', '{"instructions":"Read /repo/networks.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/networks.txt":{"type":"file","content":"network: atlas-metrics-net (user-defined bridge)\nmembers: atlas-metrics-agent, atlas-metrics-db\natlas-metrics-agent reaches the database at atlas-metrics-db:5432 -- by name, not by IP\n# verification NETWORK-8802\n"}}}'::jsonb, '{"requiredFlag":"NETWORK-8802"}'::jsonb),

  ('mission-atlas-containment-07-o1-c1', 'mission-atlas-containment-07-o1', 1, 'terminal_simulation', 'Read the environment configuration and submit the verification code.', '{"instructions":"Read /repo/env-config.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/env-config.txt":{"type":"file","content":"atlas-metrics-agent environment:\n  AUTH_TOKEN=${ATLAS_AUTH_TOKEN}   # resolved from the secrets manager at container start, never a literal value\n# verification ENVVAR-2291\n"}}}'::jsonb, '{"requiredFlag":"ENVVAR-2291"}'::jsonb),

  ('mission-atlas-containment-08-o1-c1', 'mission-atlas-containment-08-o1', 1, 'terminal_simulation', 'Read the Compose file and submit the verification code.', '{"instructions":"Read /repo/docker-compose.yml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/docker-compose.yml":{"type":"file","content":"services:\n  atlas-metrics-agent:\n    build: .\n    depends_on: [atlas-metrics-db]\n  atlas-metrics-db:\n    image: postgres:15\n# verification COMPOSE-5541\n"}}}'::jsonb, '{"requiredFlag":"COMPOSE-5541"}'::jsonb),

  ('mission-atlas-containment-09-o1-c1', 'mission-atlas-containment-09-o1', 1, 'terminal_simulation', 'Read the multi-stage Dockerfile and submit the verification code.', '{"instructions":"Read /repo/Dockerfile.v2 and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/Dockerfile.v2":{"type":"file","content":"FROM golang:1.22 AS build\nWORKDIR /src\nCOPY . .\nRUN go build -o atlas-metrics-agent\n\nFROM gcr.io/distroless/base\nCOPY --from=build /src/atlas-metrics-agent /atlas-metrics-agent\nCMD [\"/atlas-metrics-agent\"]\n# verification MULTISTAGE-9012\n"}}}'::jsonb, '{"requiredFlag":"MULTISTAGE-9012"}'::jsonb),

  ('mission-atlas-containment-10-o1-c1', 'mission-atlas-containment-10-o1', 1, 'terminal_simulation', 'Read the optimization report and submit the verification code.', '{"instructions":"Read /var/atlas-ci/docker-build-4472/optimization-report.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/docker-build-4472/optimization-report.txt":{"type":"file","content":"before (single-stage, full build toolchain): 1122MB\nafter (multi-stage, distroless runtime):       31MB\nreduction: 97%\n# verification OPTIMIZE-3390\n"}}}'::jsonb, '{"requiredFlag":"OPTIMIZE-3390"}'::jsonb),

  ('mission-atlas-containment-11-o1-c1', 'mission-atlas-containment-11-o1', 1, 'terminal_simulation', 'Read the push log and submit the verification code.', '{"instructions":"Read /var/atlas-ci/docker-build-4472/push-log.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/docker-build-4472/push-log.txt":{"type":"file","content":"pushing atlas-images/atlas-metrics-agent:v13.0.0 to registry...\n31MB pushed in 2.1s (was 1122MB / 94s before optimization)\npush succeeded\n# verification PUSH-4471\n"}}}'::jsonb, '{"requiredFlag":"PUSH-4471"}'::jsonb),

  ('mission-atlas-containment-12-o1-c1', 'mission-atlas-containment-12-o1', 1, 'terminal_simulation', 'Read the optimization report and submit the verification code.', '{"instructions":"Read /var/atlas-ci/docker-build-4472/optimization-report.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/docker-build-4472/optimization-report.txt":{"type":"file","content":"before (single-stage, full build toolchain): 1122MB\nafter (multi-stage, distroless runtime):       31MB\nreduction: 97%\n# verification OPTIMIZE-3390\n"}}}'::jsonb, '{"requiredFlag":"OPTIMIZE-3390"}'::jsonb),
  ('mission-atlas-containment-12-o2-c1', 'mission-atlas-containment-12-o2', 1, 'terminal_simulation', 'Read the push log and submit the verification code.', '{"instructions":"Read /var/atlas-ci/docker-build-4472/push-log.txt and submit the verification code with: submit CODE","hostname":"atlas-ci-runner-04","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ci-runner-04\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ci/docker-build-4472/push-log.txt":{"type":"file","content":"pushing atlas-images/atlas-metrics-agent:v13.0.0 to registry...\n31MB pushed in 2.1s (was 1122MB / 94s before optimization)\npush succeeded\n# verification PUSH-4471\n"}}}'::jsonb, '{"requiredFlag":"PUSH-4471"}'::jsonb),
  ('mission-atlas-containment-12-o3-c1', 'mission-atlas-containment-12-o3', 1, 'investigation', 'Which evidence explains what actually made this image small and fast?', '{"evidence":[{"id":"e1","label":"Multi-stage Dockerfile","detail":"The build toolchain (golang:1.22) only exists in the first stage; only the compiled binary is copied into the minimal distroless final stage"},{"id":"e2","label":"Build context report","detail":"The original build sent 640MB of context to the daemon, including .git history and node_modules, before a single instruction ran"},{"id":"e3","label":"Compose file","detail":"The agent and its database are defined and started together as one unit for local development"},{"id":"e4","label":"Network definition","detail":"Both containers communicate over a user-defined bridge network, reachable by name"}],"question":"Which evidence explains what actually made this image small and fast?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-containment-12-o4-c1', 'mission-atlas-containment-12-o4', 1, 'boss_encounter', 'Having confirmed the final size, the fast push, and what actually caused the improvement, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-containment-12-o1","label":"Confirm the final image size"},{"objectiveRef":"mission-atlas-containment-12-o2","label":"Confirm the fast push"},{"objectiveRef":"mission-atlas-containment-12-o3","label":"Identify what actually caused the improvement"}],"task":"State the diagnosis in one sentence: separating the build toolchain into its own stage and scoping the build context down both attacked the same root cause -- carrying VM-image habits into a container -- and together they took the same service from 1.1 gigabytes and a 94-second push down to 31 megabytes and 2 seconds, proving an image can escape that gravity on purpose, every time, starting from the very first line of a Dockerfile."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-containment-12-o1","mission-atlas-containment-12-o2","mission-atlas-containment-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-containment-01-o1-c1', 'orientation', 'Think about "built once" versus "running right now."', 10, 1),
  ('mission-atlas-containment-01-o1-c1', 'solution', 'An image is the built template; a container is a running instance of it.', 20, 2),

  ('mission-atlas-containment-02-o1-c1', 'orientation', 'Try: cat /repo/Dockerfile', 10, 1),
  ('mission-atlas-containment-02-o1-c1', 'solution', 'The file ends with verification DOCKERFILE-3301. submit DOCKERFILE-3301', 20, 2),

  ('mission-atlas-containment-03-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/docker-build-4471/layers.txt', 10, 1),
  ('mission-atlas-containment-03-o1-c1', 'solution', 'The apt-get install layer alone is 850MB, verification LAYERS-6602. submit LAYERS-6602', 20, 2),

  ('mission-atlas-containment-04-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/docker-build-4471/context-report.txt', 10, 1),
  ('mission-atlas-containment-04-o1-c1', 'solution', '640MB of context, no .dockerignore, verification CONTEXT-7714. submit CONTEXT-7714', 20, 2),

  ('mission-atlas-containment-05-o1-c1', 'orientation', 'Try: cat /repo/volumes.txt', 10, 1),
  ('mission-atlas-containment-05-o1-c1', 'solution', 'The volume persists independently, verification VOLUME-4471. submit VOLUME-4471', 20, 2),

  ('mission-atlas-containment-06-o1-c1', 'orientation', 'Try: cat /repo/networks.txt', 10, 1),
  ('mission-atlas-containment-06-o1-c1', 'solution', 'Reachable by container name, verification NETWORK-8802. submit NETWORK-8802', 20, 2),

  ('mission-atlas-containment-07-o1-c1', 'orientation', 'Try: cat /repo/env-config.txt', 10, 1),
  ('mission-atlas-containment-07-o1-c1', 'solution', 'The token is resolved from the secrets manager, verification ENVVAR-2291. submit ENVVAR-2291', 20, 2),

  ('mission-atlas-containment-08-o1-c1', 'orientation', 'Try: cat /repo/docker-compose.yml', 10, 1),
  ('mission-atlas-containment-08-o1-c1', 'solution', 'Both services are defined together, verification COMPOSE-5541. submit COMPOSE-5541', 20, 2),

  ('mission-atlas-containment-09-o1-c1', 'orientation', 'Try: cat /repo/Dockerfile.v2', 10, 1),
  ('mission-atlas-containment-09-o1-c1', 'solution', 'Only the compiled binary is copied into the final stage, verification MULTISTAGE-9012. submit MULTISTAGE-9012', 20, 2),

  ('mission-atlas-containment-10-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/docker-build-4472/optimization-report.txt', 10, 1),
  ('mission-atlas-containment-10-o1-c1', 'solution', '97% smaller, verification OPTIMIZE-3390. submit OPTIMIZE-3390', 20, 2),

  ('mission-atlas-containment-11-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/docker-build-4472/push-log.txt', 10, 1),
  ('mission-atlas-containment-11-o1-c1', 'solution', '2.1 seconds instead of 94, verification PUSH-4471. submit PUSH-4471', 20, 2),

  ('mission-atlas-containment-12-o1-c1', 'orientation', 'Try: cat /var/atlas-ci/docker-build-4472/optimization-report.txt', 10, 1),
  ('mission-atlas-containment-12-o1-c1', 'solution', 'verification OPTIMIZE-3390. submit OPTIMIZE-3390', 20, 2),
  ('mission-atlas-containment-12-o2-c1', 'orientation', 'Try: cat /var/atlas-ci/docker-build-4472/push-log.txt', 10, 1),
  ('mission-atlas-containment-12-o2-c1', 'solution', 'verification PUSH-4471. submit PUSH-4471', 20, 2),
  ('mission-atlas-containment-12-o3-c1', 'orientation', 'Compose and networking did not change size or push speed at all. Look for what actually attacked the bloat itself.', 10, 1),
  ('mission-atlas-containment-12-o3-c1', 'solution', 'e1 and e2: the multi-stage split and the scoped build context are what actually shrank and sped up the image.', 20, 2),
  ('mission-atlas-containment-12-o4-c1', 'orientation', 'Combine the final size, the fast push, and the two real causes into one sentence.', 15, 1),
  ('mission-atlas-containment-12-o4-c1', 'solution', 'A multi-stage build and a scoped build context together took the same service from 1.1GB and a 94-second push to 31MB and 2 seconds -- proof an image can be built lean on purpose, not patched small after the fact.', 25, 2);
