-- Atlas Division pathway ("The Silence") Act 20 -- "Keep Them Alive"
-- content, under world-atlas-keep-them-alive (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), continuing World VI "The Cluster Sea".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- reliability artifact here is static seeded text read via `cat`. Two
-- hosts, both reused: `atlas-devbox-01` for declared YAML manifests
-- and `atlas-k8s-01` for live cluster state (OOM events, fleet-wide
-- pod status). Concept-only missions (liveness, readiness, CPU
-- throttling, rolling updates) stay multiple_choice; everything else
-- has a real manifest or status output behind it.
--
-- Narrative thread: mission 5 (Limits) plants the entire payoff --
-- 512Mi, presented without comment at first. The boss is this
-- pathway's biggest full-circle callback: cross-references that exact
-- value directly against Act 3's original test-tier image manifest
-- (memory_limit_mb=512, before Act 3's own fix resized it to 2048 for
-- the original VM) via the investigation evidence, landing on the
-- reveal that Act 3's fix never actually carried forward into the
-- Kubernetes Deployment created six Worlds later. HPA itself is
-- explicitly ruled out as working correctly -- the autoscaler is not
-- the bug, it is faithfully multiplying one nineteen-Act-old mistake.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-keep-them-alive', 'world-atlas-keep-them-alive', 'keep-them-alive', '6D - Keep Them Alive', 'Learn what actually keeps Kubernetes workloads alive and healthy -- liveness, readiness and startup probes, requests, limits, CPU throttling, OOMKilled, HPA, PodDisruptionBudgets, rolling updates and termination -- while real load finally proves whether this fleet was ever actually sized correctly.', 4);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-keep-them-alive-1', 'campaign-atlas-keep-them-alive', 'proving-a-pod-is-actually-fine', 'Proving a Pod Is Actually Fine', 'Liveness, readiness, startup probes, requests and limits.', 1),
  ('operation-atlas-keep-them-alive-2', 'campaign-atlas-keep-them-alive', 'what-happens-under-real-load', 'What Happens Under Real Load', 'CPU throttling, OOMKilled, HPA, PDB, rolling updates and termination.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-keep-them-alive-01', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-1', 'liveness', 'Liveness', 'Real load finally hits the collector fleet, and the autoscaler does exactly what it is supposed to.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"liveness-sim"}'::jsonb, '{"xp":380,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-keep-them-alive-02', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-1', 'readiness', 'Readiness', 'Understand the difference between a container that should be killed and one that should just stop receiving traffic.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"readiness-sim"}'::jsonb, '{"xp":380,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-keep-them-alive-03', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-1', 'startup-probes', 'Startup Probes', 'Understand why a slow-starting container should never be judged by the same clock as a fully warmed-up one.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"startup-probes-sim"}'::jsonb, '{"xp":390,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-keep-them-alive-04', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-1', 'requests', 'Requests', 'Confirm what the scheduler actually guarantees this container before it is even placed anywhere.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"requests-sim"}'::jsonb, '{"xp":390,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-keep-them-alive-05', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-1', 'limits', 'Limits', 'Confirm the actual ceiling this container is never allowed to cross.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"limits-sim"}'::jsonb, '{"xp":400,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-keep-them-alive-06', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-2', 'cpu-throttling', 'CPU Throttling', 'Understand what actually happens when a container tries to use more CPU than it is allowed.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"cpu-throttling-sim"}'::jsonb, '{"xp":400,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-keep-them-alive-07', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-2', 'oomkilled', 'OOMKilled', 'Confirm that memory works completely differently -- there is no throttling, only a hard stop.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"oomkilled-sim"}'::jsonb, '{"xp":410,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-keep-them-alive-08', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-2', 'hpa', 'HPA', 'Confirm exactly how the fleet is actually scaling in response to load.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"hpa-sim"}'::jsonb, '{"xp":410,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-keep-them-alive-09', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-2', 'pdb', 'PDB', 'Confirm what actually stops a voluntary node drain from taking down every replica at once.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"pdb-sim"}'::jsonb, '{"xp":410,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-keep-them-alive-10', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-2', 'rolling-updates', 'Rolling Updates', 'Understand how a Deployment actually replaces every pod without ever taking the whole fleet down at once.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"rolling-updates-sim"}'::jsonb, '{"xp":420,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-keep-them-alive-11', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-2', 'termination', 'Termination', 'Confirm exactly how long a container actually gets to shut down gracefully before it is killed outright.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"termination-sim"}'::jsonb, '{"xp":420,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-keep-them-alive-12', 'world-atlas-keep-them-alive', 'campaign-atlas-keep-them-alive', 'operation-atlas-keep-them-alive-2', 'crashloop-city', 'CrashLoop City', 'Everything this Act taught, turned on seventeen replicas at once: not to blame the autoscaler, to finally explain how the pathway''s very first bug just resurfaced at cluster scale.', 'boss', ARRAY['cross','rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-keep-them-alive-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"crashloop-city-boss-sim"}'::jsonb, '{"xp":680,"credits":160,"badgeIds":["crashloop-city"],"skillXp":{"cloud_devops_fundamentals":110}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-keep-them-alive-01', 1, 'leena', 'Real load has finally hit the collector fleet, and the autoscaler is doing exactly what it is supposed to -- scaling from 2 replicas to 17 within minutes. Every single new one is entering CrashLoopBackOff within seconds.'),
  ('mission-atlas-keep-them-alive-01', 2, 'cross', 'Imani Cross. A liveness probe checks whether a container is still actually working. Fail it enough times, and Kubernetes kills the container and starts a fresh one. Confirm what this fleet''s probe is actually checking.'),

  ('mission-atlas-keep-them-alive-02', 1, 'cross', 'A readiness probe asks a completely different question -- not "is this broken," but "is this ready for traffic right now." Failing it only pulls the pod out of Service endpoints. It does not kill anything.'),

  ('mission-atlas-keep-them-alive-03', 1, 'cross', 'A container that takes 40 seconds to start should never be judged by a liveness check built for one that starts in 2. A startup probe buys it that time before liveness or readiness even begin evaluating it.'),

  ('mission-atlas-keep-them-alive-04', 1, 'rook', 'A resource request is a promise made before scheduling even happens -- the amount of CPU and memory the scheduler guarantees this container when deciding where to place it. Confirm what this one actually asks for.'),

  ('mission-atlas-keep-them-alive-05', 1, 'rook', 'A limit is the ceiling this container is never allowed to cross, whatever it actually requested. Confirm exactly what that ceiling is set to right now.'),

  ('mission-atlas-keep-them-alive-06', 1, 'rook', 'CPU is elastic. Try to use more than the limit allows, and the container is not killed -- it is simply throttled, slowed down, forced to share less time on the CPU than it wants.'),

  ('mission-atlas-keep-them-alive-07', 1, 'cross', 'Memory does not work like that at all. There is no throttling -- cross the memory limit even once, and the container is terminated immediately. Confirm what that actually looks like.'),

  ('mission-atlas-keep-them-alive-08', 1, 'rook', 'A HorizontalPodAutoscaler watches a metric like CPU utilization and adjusts the replica count automatically. Confirm exactly how this fleet is actually configured to scale.'),

  ('mission-atlas-keep-them-alive-09', 1, 'cross', 'A voluntary disruption, like a node drain, could take down every replica on that node at once if nothing stops it. A PodDisruptionBudget guarantees a minimum number stay available no matter what. Confirm this fleet actually has one.'),

  ('mission-atlas-keep-them-alive-10', 1, 'rook', 'A Deployment never takes the whole fleet down to update it -- it replaces pods gradually, a few at a time, always keeping enough of the old version running until the new ones prove themselves.'),

  ('mission-atlas-keep-them-alive-11', 1, 'rook', 'Termination is not instant either. SIGTERM goes out first, and the container gets a real window to shut down cleanly before anything forces it to stop. Confirm how long that window actually is.'),

  ('mission-atlas-keep-them-alive-12', 1, 'leena', 'Everything this Act taught you, on seventeen replicas at once. Not to blame the autoscaler -- to finally explain how the very first bug this whole story ever found just resurfaced, at cluster scale, six Worlds later.'),
  ('mission-atlas-keep-them-alive-12', 2, 'byte', 'I have the full fleet status and every OOM event from the last ten minutes pulled up together. Every single replica died the exact same way.'),
  ('mission-atlas-keep-them-alive-12', 3, 'cross', 'The autoscaler is not guilty of anything. It is doing precisely what it was built to do -- creating more replicas because the fleet genuinely needs them.'),
  ('mission-atlas-keep-them-alive-12', 4, 'rook', 'Then find what every one of those replicas actually has in common, and where that number has actually been sitting, untouched, this whole time.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-keep-them-alive-01-o1', 'mission-atlas-keep-them-alive-01', 1, 'Explain liveness probes', 'Choose the accurate description of what a liveness probe actually determines.'),

  ('mission-atlas-keep-them-alive-02-o1', 'mission-atlas-keep-them-alive-02', 1, 'Explain readiness probes', 'Choose the accurate description of what a readiness probe actually determines.'),

  ('mission-atlas-keep-them-alive-03-o1', 'mission-atlas-keep-them-alive-03', 1, 'Read the startup probe', 'Read the startup probe configuration and submit the verification code.'),

  ('mission-atlas-keep-them-alive-04-o1', 'mission-atlas-keep-them-alive-04', 1, 'Read the resource requests', 'Read the resource requests and submit the verification code.'),

  ('mission-atlas-keep-them-alive-05-o1', 'mission-atlas-keep-them-alive-05', 1, 'Read the resource limits', 'Read the resource limits and submit the verification code.'),

  ('mission-atlas-keep-them-alive-06-o1', 'mission-atlas-keep-them-alive-06', 1, 'Explain CPU throttling', 'Choose the accurate description of what actually happens when a container exceeds its CPU limit.'),

  ('mission-atlas-keep-them-alive-07-o1', 'mission-atlas-keep-them-alive-07', 1, 'Read the OOMKilled event', 'Read the OOM event and submit the verification code.'),

  ('mission-atlas-keep-them-alive-08-o1', 'mission-atlas-keep-them-alive-08', 1, 'Read the HPA definition', 'Read the HorizontalPodAutoscaler definition and submit the verification code.'),

  ('mission-atlas-keep-them-alive-09-o1', 'mission-atlas-keep-them-alive-09', 1, 'Read the PodDisruptionBudget', 'Read the PodDisruptionBudget and submit the verification code.'),

  ('mission-atlas-keep-them-alive-10-o1', 'mission-atlas-keep-them-alive-10', 1, 'Explain rolling updates', 'Choose the accurate description of how a rolling update actually replaces pods.'),

  ('mission-atlas-keep-them-alive-11-o1', 'mission-atlas-keep-them-alive-11', 1, 'Read the termination grace period', 'Read the termination configuration and submit the verification code.'),

  ('mission-atlas-keep-them-alive-12-o1', 'mission-atlas-keep-them-alive-12', 1, 'Confirm the fleet-wide crash loop', 'Read the fleet status and submit the verification code.'),
  ('mission-atlas-keep-them-alive-12-o2', 'mission-atlas-keep-them-alive-12', 2, 'Confirm the OOM cause', 'Read the fleet OOM summary and submit the verification code.'),
  ('mission-atlas-keep-them-alive-12-o3', 'mission-atlas-keep-them-alive-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why every replica is dying the same way.'),
  ('mission-atlas-keep-them-alive-12-o4', 'mission-atlas-keep-them-alive-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-keep-them-alive-01-o1-c1', 'mission-atlas-keep-them-alive-01-o1', 1, 'multiple_choice', 'A liveness probe actually determines...', '{"question":"A liveness probe actually determines...","options":[{"id":"a","text":"Whether a container is still working at all -- failing it enough times causes Kubernetes to kill and restart the container"},{"id":"b","text":"Whether a container should receive traffic right now, without ever killing it"},{"id":"c","text":"How much CPU a container is allowed to use"},{"id":"d","text":"Whether a container has finished its startup sequence, permanently"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-keep-them-alive-02-o1-c1', 'mission-atlas-keep-them-alive-02-o1', 1, 'multiple_choice', 'A readiness probe actually determines...', '{"question":"A readiness probe actually determines...","options":[{"id":"a","text":"Whether a container should currently receive traffic -- failing it only removes the pod from Service endpoints, without killing anything"},{"id":"b","text":"Whether the container should be killed and restarted"},{"id":"c","text":"The container''s memory limit"},{"id":"d","text":"A synonym for a liveness probe"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-keep-them-alive-03-o1-c1', 'mission-atlas-keep-them-alive-03-o1', 1, 'terminal_simulation', 'Read the startup probe configuration and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-probes.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-probes.yaml":{"type":"file","content":"startupProbe:\n  httpGet:\n    path: /healthz\n    port: 9090\n  failureThreshold: 30\n  periodSeconds: 2\n# gives the container up to 60 seconds to start before liveness or readiness begin evaluating it at all\n# verification STARTUP-3312\n"}}}'::jsonb, '{"requiredFlag":"STARTUP-3312"}'::jsonb),

  ('mission-atlas-keep-them-alive-04-o1-c1', 'mission-atlas-keep-them-alive-04-o1', 1, 'terminal_simulation', 'Read the resource requests and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-deployment-resources.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-deployment-resources.yaml":{"type":"file","content":"resources:\n  requests:\n    cpu: 250m\n    memory: 256Mi\n  limits:\n    cpu: 500m\n    memory: 512Mi\n# requests are what the scheduler guarantees this container when placing it on a node\n# verification REQUESTS-6602\n"}}}'::jsonb, '{"requiredFlag":"REQUESTS-6602"}'::jsonb),

  ('mission-atlas-keep-them-alive-05-o1-c1', 'mission-atlas-keep-them-alive-05-o1', 1, 'terminal_simulation', 'Read the resource limits and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-deployment-resources.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-deployment-resources.yaml":{"type":"file","content":"resources:\n  requests:\n    cpu: 250m\n    memory: 256Mi\n  limits:\n    cpu: 500m\n    memory: 512Mi\n# 512Mi -- this container is never allowed to use more memory than that\n# verification LIMITS-7714\n"}}}'::jsonb, '{"requiredFlag":"LIMITS-7714"}'::jsonb),

  ('mission-atlas-keep-them-alive-06-o1-c1', 'mission-atlas-keep-them-alive-06-o1', 1, 'multiple_choice', 'When a container tries to use more CPU than its limit allows, it is...', '{"question":"When a container tries to use more CPU than its limit allows, it is...","options":[{"id":"a","text":"Throttled -- slowed down, forced to share less CPU time, but never killed for it"},{"id":"b","text":"Killed and restarted immediately, exactly like exceeding a memory limit"},{"id":"c","text":"Automatically granted more CPU regardless of the limit"},{"id":"d","text":"Moved to a different node with more available CPU"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-keep-them-alive-07-o1-c1', 'mission-atlas-keep-them-alive-07-o1', 1, 'terminal_simulation', 'Read the OOM event and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/oom-event.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/oom-event.txt":{"type":"file","content":"$ kubectl describe pod atlas-collector-7f9-abcde\nLast State: Terminated\nReason: OOMKilled\nExit Code: 137\n# memory limits are a hard kill, not a throttle -- exceed it even once, and the container is terminated immediately\n# verification OOMKILLED-8802\n"}}}'::jsonb, '{"requiredFlag":"OOMKILLED-8802"}'::jsonb),

  ('mission-atlas-keep-them-alive-08-o1-c1', 'mission-atlas-keep-them-alive-08-o1', 1, 'terminal_simulation', 'Read the HorizontalPodAutoscaler definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-hpa.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-hpa.yaml":{"type":"file","content":"apiVersion: autoscaling/v2\nkind: HorizontalPodAutoscaler\nmetadata:\n  name: atlas-collector-hpa\nspec:\n  minReplicas: 2\n  maxReplicas: 20\n  metrics:\n    - type: Resource\n      resource:\n        name: cpu\n        target:\n          averageUtilization: 70\n# scales the collector fleet automatically as real load increases\n# verification HPA-9012\n"}}}'::jsonb, '{"requiredFlag":"HPA-9012"}'::jsonb),

  ('mission-atlas-keep-them-alive-09-o1-c1', 'mission-atlas-keep-them-alive-09-o1', 1, 'terminal_simulation', 'Read the PodDisruptionBudget and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-pdb.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-pdb.yaml":{"type":"file","content":"apiVersion: policy/v1\nkind: PodDisruptionBudget\nmetadata:\n  name: atlas-collector-pdb\nspec:\n  minAvailable: 2\n  selector:\n    matchLabels:\n      app: collector\n# guarantees at least 2 replicas stay available even during a voluntary node drain\n# verification PDB-2291\n"}}}'::jsonb, '{"requiredFlag":"PDB-2291"}'::jsonb),

  ('mission-atlas-keep-them-alive-10-o1-c1', 'mission-atlas-keep-them-alive-10-o1', 1, 'multiple_choice', 'A rolling update actually replaces pods by...', '{"question":"A rolling update actually replaces pods by...","options":[{"id":"a","text":"Gradually replacing them a few at a time, keeping enough of the old version running until the new ones prove healthy"},{"id":"b","text":"Deleting every old pod first, then creating all the new ones at once"},{"id":"c","text":"Never actually restarting any pod, only changing the Service"},{"id":"d","text":"Requiring the entire cluster to be taken offline first"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-keep-them-alive-11-o1-c1', 'mission-atlas-keep-them-alive-11-o1', 1, 'terminal_simulation', 'Read the termination configuration and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-termination.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-termination.yaml":{"type":"file","content":"spec:\n  terminationGracePeriodSeconds: 30\n# SIGTERM goes out first; the container has 30 seconds to shut down cleanly before SIGKILL\n# verification TERMINATION-4471\n"}}}'::jsonb, '{"requiredFlag":"TERMINATION-4471"}'::jsonb),

  ('mission-atlas-keep-them-alive-12-o1-c1', 'mission-atlas-keep-them-alive-12-o1', 1, 'terminal_simulation', 'Read the fleet status and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/collector-fleet-status.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/collector-fleet-status.txt":{"type":"file","content":"NAME                        READY   STATUS             RESTARTS   AGE\natlas-collector-7f9-a1b2c   0/1     CrashLoopBackOff   14         22m\natlas-collector-7f9-d3e4f   0/1     CrashLoopBackOff   13         21m\natlas-collector-7f9-g5h6i   0/1     CrashLoopBackOff   12         19m\n(17 replicas total, all in CrashLoopBackOff)\n# HPA scaled up to 17 replicas under real load -- every single one is crash-looping\n# verification FLEETCRASH-3312\n"}}}'::jsonb, '{"requiredFlag":"FLEETCRASH-3312"}'::jsonb),
  ('mission-atlas-keep-them-alive-12-o2-c1', 'mission-atlas-keep-them-alive-12-o2', 1, 'terminal_simulation', 'Read the fleet OOM summary and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/fleet-oom-summary.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/fleet-oom-summary.txt":{"type":"file","content":"$ kubectl get events --field-selector reason=OOMKilling -n atlas-metrics\n17 OOMKilled events in the last 10 minutes -- one per replica, all citing the same 512Mi memory limit\n# verification FLEETOOM-6602\n"}}}'::jsonb, '{"requiredFlag":"FLEETOOM-6602"}'::jsonb),
  ('mission-atlas-keep-them-alive-12-o3-c1', 'mission-atlas-keep-them-alive-12-o3', 1, 'investigation', 'Which evidence explains why every replica is dying the same way?', '{"evidence":[{"id":"e1","label":"Fleet status","detail":"All 17 replicas are stuck in CrashLoopBackOff"},{"id":"e2","label":"Fleet OOM summary","detail":"17 OOMKilled events in 10 minutes, every one citing the same 512Mi memory limit"},{"id":"e3","label":"Deployment resource limits","detail":"The memory limit is 512Mi -- the exact same value from Act 3''s original test-tier image manifest, before Act 3''s own fix resized it to 2048Mi for the original VM"},{"id":"e4","label":"HPA configuration","detail":"The autoscaler is correctly configured and scaling exactly as designed in response to real CPU load"}],"question":"Which evidence explains why every replica is dying the same way?"}'::jsonb, '{"requiredEvidenceIds":["e2","e3"]}'::jsonb),
  ('mission-atlas-keep-them-alive-12-o4-c1', 'mission-atlas-keep-them-alive-12-o4', 1, 'boss_encounter', 'Having confirmed the fleet-wide crash loop, the OOM cause, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-keep-them-alive-12-o1","label":"Confirm the fleet-wide crash loop"},{"objectiveRef":"mission-atlas-keep-them-alive-12-o2","label":"Confirm the OOM cause"},{"objectiveRef":"mission-atlas-keep-them-alive-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: the autoscaler is working perfectly, correctly creating more replicas as real load increases, but every single one inherits the same 512Mi memory limit -- the exact untouched number from Act 3''s original test-tier image, before Act 3''s own fix resized it to 2048Mi for the original VM, a fix that apparently never carried forward into this Kubernetes Deployment -- and the fix is updating the memory limit to match real modern requirements, not blaming the autoscaler for faithfully multiplying a nineteen-Act-old mistake."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-keep-them-alive-12-o1","mission-atlas-keep-them-alive-12-o2","mission-atlas-keep-them-alive-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-keep-them-alive-01-o1-c1', 'orientation', 'Think about what happens after enough consecutive failures.', 10, 1),
  ('mission-atlas-keep-them-alive-01-o1-c1', 'solution', 'A liveness probe failing enough times causes a kill and restart.', 20, 2),

  ('mission-atlas-keep-them-alive-02-o1-c1', 'orientation', 'Think about traffic versus the container''s own lifecycle.', 10, 1),
  ('mission-atlas-keep-them-alive-02-o1-c1', 'solution', 'A readiness probe only controls whether traffic is sent, never kills anything.', 20, 2),

  ('mission-atlas-keep-them-alive-03-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-probes.yaml', 10, 1),
  ('mission-atlas-keep-them-alive-03-o1-c1', 'solution', 'Up to 60 seconds before other probes evaluate, verification STARTUP-3312. submit STARTUP-3312', 20, 2),

  ('mission-atlas-keep-them-alive-04-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-deployment-resources.yaml', 10, 1),
  ('mission-atlas-keep-them-alive-04-o1-c1', 'solution', 'Requests are 250m CPU, 256Mi memory, verification REQUESTS-6602. submit REQUESTS-6602', 20, 2),

  ('mission-atlas-keep-them-alive-05-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-deployment-resources.yaml', 10, 1),
  ('mission-atlas-keep-them-alive-05-o1-c1', 'solution', 'The memory limit is 512Mi, verification LIMITS-7714. submit LIMITS-7714', 20, 2),

  ('mission-atlas-keep-them-alive-06-o1-c1', 'orientation', 'Think about whether CPU is a hard ceiling or something more elastic.', 10, 1),
  ('mission-atlas-keep-them-alive-06-o1-c1', 'solution', 'Exceeding a CPU limit throttles the container; it is never killed for it.', 20, 2),

  ('mission-atlas-keep-them-alive-07-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/oom-event.txt', 10, 1),
  ('mission-atlas-keep-them-alive-07-o1-c1', 'solution', 'OOMKilled, exit code 137, verification OOMKILLED-8802. submit OOMKILLED-8802', 20, 2),

  ('mission-atlas-keep-them-alive-08-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-hpa.yaml', 10, 1),
  ('mission-atlas-keep-them-alive-08-o1-c1', 'solution', 'It scales on 70% CPU utilization, verification HPA-9012. submit HPA-9012', 20, 2),

  ('mission-atlas-keep-them-alive-09-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-pdb.yaml', 10, 1),
  ('mission-atlas-keep-them-alive-09-o1-c1', 'solution', 'minAvailable is 2, verification PDB-2291. submit PDB-2291', 20, 2),

  ('mission-atlas-keep-them-alive-10-o1-c1', 'orientation', 'Think about whether old and new pods ever coexist during the update.', 10, 1),
  ('mission-atlas-keep-them-alive-10-o1-c1', 'solution', 'Pods are replaced gradually, keeping enough of the old version running throughout.', 20, 2),

  ('mission-atlas-keep-them-alive-11-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-termination.yaml', 10, 1),
  ('mission-atlas-keep-them-alive-11-o1-c1', 'solution', '30 seconds before SIGKILL, verification TERMINATION-4471. submit TERMINATION-4471', 20, 2),

  ('mission-atlas-keep-them-alive-12-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/collector-fleet-status.txt', 10, 1),
  ('mission-atlas-keep-them-alive-12-o1-c1', 'solution', 'All 17 replicas are crash-looping, verification FLEETCRASH-3312. submit FLEETCRASH-3312', 20, 2),
  ('mission-atlas-keep-them-alive-12-o2-c1', 'orientation', 'Try: cat /var/atlas-k8s/fleet-oom-summary.txt', 10, 1),
  ('mission-atlas-keep-them-alive-12-o2-c1', 'solution', 'All 17 cite the same 512Mi limit, verification FLEETOOM-6602. submit FLEETOOM-6602', 20, 2),
  ('mission-atlas-keep-them-alive-12-o3-c1', 'orientation', 'The fleet status is a symptom, and the HPA is innocent. Look at the OOM summary and the actual limit value together.', 10, 1),
  ('mission-atlas-keep-them-alive-12-o3-c1', 'solution', 'e2 and e3: every replica OOMKilled at the exact same 512Mi limit that traces straight back to Act 3.', 20, 2),
  ('mission-atlas-keep-them-alive-12-o4-c1', 'orientation', 'Combine the crash loop, the OOM cause, and where 512Mi actually came from into one sentence.', 15, 1),
  ('mission-atlas-keep-them-alive-12-o4-c1', 'solution', 'Every replica OOMKills at the same 512Mi limit copied forward from Act 3''s original, never-updated image spec -- the fix is raising the limit, not blaming the autoscaler.', 25, 2);
