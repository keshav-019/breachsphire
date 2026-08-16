-- Atlas Division pathway ("The Silence") Act 31 -- "The Service Mesh"
-- content, under world-atlas-service-mesh (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), continuing World IX "Platform City".
--
-- Same terminal-engine constraint as every prior Atlas Act. One new
-- host, `atlas-mesh-01`, holds every mesh config and the mesh's own
-- observability output; the boss reuses `atlas-observability-01` for
-- the real incident data, and directly references Act 27's existing
-- `atlas-devbox-01` retry-policy.yaml (unchanged, read again here to
-- prove it was never touched) rather than duplicating it.
--
-- Narrative thread: mission 6 (retries) plants the mesh-level retry
-- policy as a plain, independently-correct fact, with an explicit note
-- that it is not designed to know about any application-level retry
-- logic. The boss deliberately confirms both the mesh retry config
-- (`e2`) and the untouched Act 27 app-level retry config (`e3`) as
-- individually correct and rules both out on their own; the actual
-- explanation is the interaction test showing retries compounding
-- multiplicatively across the two layers (`e4`) -- the same "each piece
-- worked, nobody designed the seam between them" shape running through
-- this whole late stretch of the pathway.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-service-mesh', 'world-atlas-service-mesh', 'service-mesh', '9B - The Service Mesh', 'Learn cloud-native networking from first principles -- east-west traffic, sidecars, mTLS, traffic policy, retries, circuit breaking, traffic splitting and mesh observability -- and find out what happens when a new resilience layer is added without checking what already exists underneath it.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-service-mesh-1', 'campaign-atlas-service-mesh', 'centralizing-east-west-traffic', 'Centralizing East-West Traffic', 'East-west traffic, sidecars, mesh concepts, mTLS, traffic policy and retries.', 1),
  ('operation-atlas-service-mesh-2', 'campaign-atlas-service-mesh', 'two-layers-that-never-talked', 'Two Layers That Never Talked', 'Circuit breaking, traffic splitting, mesh observability, Istio concepts, when not to mesh, and the retry storm itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-service-mesh-01', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-1', 'east-west-traffic', 'East-West Traffic', 'Every service still handles its own retries, TLS and traffic policy by hand, inconsistently. Vey wants one real layer for how services actually talk to each other.', 'beginner', ARRAY['leena','vey'], null, null, '{"type":"simulation","simulationId":"east-west-traffic-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-service-mesh-02', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-1', 'sidecars', 'Sidecars', 'Confirm exactly how every pod on this fleet now actually gets its own dedicated proxy, without any service needing to change its own code.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-service-mesh-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"sidecars-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-service-mesh-03', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-1', 'mesh-concepts', 'Mesh Concepts', 'Confirm exactly how the mesh''s own control plane and every sidecar''s data plane actually divide the work between them.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-service-mesh-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"mesh-concepts-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-service-mesh-04', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-1', 'mtls', 'mTLS', 'Confirm exactly how every service-to-service call on this fleet is now actually encrypted, automatically, without any service managing its own certificates.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-service-mesh-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"mtls-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-service-mesh-05', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-1', 'traffic-policy', 'Traffic Policy', 'Confirm exactly what load-balancing and timeout defaults the mesh now actually applies to every service, uniformly.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-service-mesh-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"traffic-policy-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-service-mesh-06', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-1', 'retries', 'Retries', 'Confirm exactly what the mesh''s own retry policy actually does, independently of any retry logic already written inside a service itself.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-service-mesh-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"mesh-retries-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-service-mesh-07', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-2', 'circuit-breaking', 'Circuit Breaking', 'Confirm exactly how the mesh''s own circuit breaking actually complements the application-level one Act 27 already built.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-service-mesh-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"circuit-breaking-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-service-mesh-08', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-2', 'traffic-splitting', 'Traffic Splitting', 'Confirm exactly how a canary rollout, first built by hand back in Act 7, now actually happens at the mesh layer instead.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-service-mesh-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"traffic-splitting-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-service-mesh-09', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-2', 'mesh-observability', 'Mesh Observability', 'Confirm exactly what the mesh now actually reports automatically, for every service pair, without any manual instrumentation.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-service-mesh-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"mesh-observability-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-service-mesh-10', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-2', 'istio-concepts', 'Istio Concepts', 'Understand exactly what a mesh control plane actually does, and does not do, in the real path of a single request.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-service-mesh-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"istio-concepts-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-service-mesh-11', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-2', 'when-not-to-mesh', 'When Not to Mesh', 'Understand exactly when adopting a full service mesh actually costs more in real operational overhead than it is worth.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-service-mesh-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"when-not-to-mesh-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-service-mesh-12', 'world-atlas-service-mesh', 'campaign-atlas-service-mesh', 'operation-atlas-service-mesh-2', 'proxy-maze', 'Proxy Maze', 'Everything this Act taught, turned on one real retry storm: not to just confirm each retry layer worked on its own, to explain what happened when both ran at once.', 'boss', ARRAY['vey','cross','rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-service-mesh-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"proxy-maze-boss-sim"}'::jsonb, '{"xp":840,"credits":205,"badgeIds":["proxy-maze"],"skillXp":{"cloud_devops_fundamentals":140}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-service-mesh-01', 1, 'leena', 'Every service on this fleet still handles its own retries, TLS and traffic policy by hand. Every one of them a little differently.'),
  ('mission-atlas-service-mesh-01', 2, 'vey', 'Tomas Vey. East-west traffic -- service to service, inside the fleet -- deserves the same real infrastructure as anything user-facing. A mesh is how that gets centralized instead of duplicated everywhere.'),

  ('mission-atlas-service-mesh-02', 1, 'vey', 'Confirm exactly how every pod now actually gets its own dedicated proxy, transparently, without a single service changing its own code.'),

  ('mission-atlas-service-mesh-03', 1, 'vey', 'Confirm exactly how the mesh''s own control plane and every sidecar''s data plane actually divide the work.'),

  ('mission-atlas-service-mesh-04', 1, 'vey', 'Confirm exactly how every service-to-service call is now actually encrypted, automatically, with certificates neither service ever has to manage itself.'),

  ('mission-atlas-service-mesh-05', 1, 'vey', 'Confirm exactly what load-balancing and timeout defaults the mesh now actually applies uniformly, to every service, whether that service asked for them or not.'),

  ('mission-atlas-service-mesh-06', 1, 'vey', 'Confirm exactly what the mesh''s own retry policy actually does. It has no awareness at all of whatever retry logic already exists inside a service itself.'),

  ('mission-atlas-service-mesh-07', 1, 'rook', 'Confirm exactly how the mesh''s own circuit breaking actually complements the application-level one Cross already built in Act 27, rather than replacing it.'),

  ('mission-atlas-service-mesh-08', 1, 'rook', 'A canary rollout used to mean custom load balancer config, built by hand in Act 7. Confirm exactly how the mesh now handles that instead.'),

  ('mission-atlas-service-mesh-09', 1, 'vey', 'Confirm exactly what the mesh now actually reports automatically, for every service pair, with nobody having to add a single line of instrumentation.'),

  ('mission-atlas-service-mesh-10', 1, 'vey', 'Understand exactly what the mesh control plane actually does -- and confirm that it is never actually in the path of a single real request.'),

  ('mission-atlas-service-mesh-11', 1, 'vey', 'A mesh is real operational overhead, not a free upgrade. Understand exactly when that overhead is not actually worth paying yet.'),

  ('mission-atlas-service-mesh-12', 1, 'leena', 'Everything this Act taught you, turned on one real retry storm. Not just to confirm each retry layer worked on its own -- to explain what happened the moment both ran at once.'),
  ('mission-atlas-service-mesh-12', 2, 'byte', 'I have the incident traffic log pulled up. Retry volume spiked far past what either retry policy should have produced alone.'),
  ('mission-atlas-service-mesh-12', 3, 'vey', 'The mesh''s own retry policy is exactly as configured. Tested alone, it behaves perfectly.'),
  ('mission-atlas-service-mesh-12', 4, 'cross', 'So is the application-level retry policy I built back in Act 27. Untouched, still exactly as configured. Neither one is broken on its own.'),
  ('mission-atlas-service-mesh-12', 5, 'rook', 'Then find what happens the moment they both fire on the exact same failure, at the exact same time.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-service-mesh-01-o1', 'mission-atlas-service-mesh-01', 1, 'Explain east-west traffic', 'Choose the accurate description of what east-west traffic actually refers to.'),

  ('mission-atlas-service-mesh-02-o1', 'mission-atlas-service-mesh-02', 1, 'Read the sidecar config', 'Read the sidecar injection configuration and submit the verification code.'),

  ('mission-atlas-service-mesh-03-o1', 'mission-atlas-service-mesh-03', 1, 'Read the mesh architecture overview', 'Read the mesh architecture overview and submit the verification code.'),

  ('mission-atlas-service-mesh-04-o1', 'mission-atlas-service-mesh-04', 1, 'Read the mTLS policy', 'Read the mTLS policy and submit the verification code.'),

  ('mission-atlas-service-mesh-05-o1', 'mission-atlas-service-mesh-05', 1, 'Read the traffic policy', 'Read the mesh traffic policy and submit the verification code.'),

  ('mission-atlas-service-mesh-06-o1', 'mission-atlas-service-mesh-06', 1, 'Read the mesh retry policy', 'Read the mesh retry policy and submit the verification code.'),

  ('mission-atlas-service-mesh-07-o1', 'mission-atlas-service-mesh-07', 1, 'Read the mesh circuit breaking config', 'Read the mesh circuit breaking configuration and submit the verification code.'),

  ('mission-atlas-service-mesh-08-o1', 'mission-atlas-service-mesh-08', 1, 'Read the traffic split config', 'Read the traffic splitting configuration and submit the verification code.'),

  ('mission-atlas-service-mesh-09-o1', 'mission-atlas-service-mesh-09', 1, 'Read the mesh golden signals', 'Read the mesh observability output and submit the verification code.'),

  ('mission-atlas-service-mesh-10-o1', 'mission-atlas-service-mesh-10', 1, 'Explain the mesh control plane', 'Choose the accurate description of what a mesh control plane actually does.'),

  ('mission-atlas-service-mesh-11-o1', 'mission-atlas-service-mesh-11', 1, 'Explain when not to mesh', 'Choose the accurate description of when a service mesh is not actually worth adopting yet.'),

  ('mission-atlas-service-mesh-12-o1', 'mission-atlas-service-mesh-12', 1, 'Confirm the incident traffic log', 'Read the Proxy Maze incident traffic log and submit the verification code.'),
  ('mission-atlas-service-mesh-12-o2', 'mission-atlas-service-mesh-12', 2, 'Confirm both retry policies in isolation', 'Read the isolated retry policy test results and submit the verification code.'),
  ('mission-atlas-service-mesh-12-o3', 'mission-atlas-service-mesh-12', 3, 'Identify what actually caused the storm', 'Find the evidence that explains the retry storm when both layers ran together.'),
  ('mission-atlas-service-mesh-12-o4', 'mission-atlas-service-mesh-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-service-mesh-01-o1-c1', 'mission-atlas-service-mesh-01-o1', 1, 'multiple_choice', 'East-west traffic actually refers to...', '{"question":"East-west traffic actually refers to...","options":[{"id":"a","text":"Traffic between services inside the fleet itself, as opposed to north-south traffic entering from or leaving to the outside world"},{"id":"b","text":"Traffic that only crosses between two different cloud regions"},{"id":"c","text":"A synonym for any traffic handled by a load balancer"},{"id":"d","text":"Traffic that only exists during a deployment"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-service-mesh-02-o1-c1', 'mission-atlas-service-mesh-02-o1', 1, 'terminal_simulation', 'Read the sidecar injection configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/mesh/sidecar-config.yaml and submit the verification code with: submit CODE","hostname":"atlas-mesh-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-mesh-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/mesh/sidecar-config.yaml":{"type":"file","content":"sidecar_injection: automatic, on every pod in the mesh namespace\nproxy: Envoy\nall inbound and outbound traffic: transparently routed through the sidecar, no application code changes required\n# verification SIDECAR-4471\n"}}}'::jsonb, '{"requiredFlag":"SIDECAR-4471"}'::jsonb),

  ('mission-atlas-service-mesh-03-o1-c1', 'mission-atlas-service-mesh-03-o1', 1, 'terminal_simulation', 'Read the mesh architecture overview and submit the verification code.', '{"instructions":"Read /repo/infra-envs/mesh/architecture-overview.yaml and submit the verification code with: submit CODE","hostname":"atlas-mesh-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-mesh-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/mesh/architecture-overview.yaml":{"type":"file","content":"data_plane: every sidecar proxy, handling the actual traffic for every real request\ncontrol_plane: pushes configuration to every sidecar, never sits in the path of a single request itself\n# verification MESHARCH-8802\n"}}}'::jsonb, '{"requiredFlag":"MESHARCH-8802"}'::jsonb),

  ('mission-atlas-service-mesh-04-o1-c1', 'mission-atlas-service-mesh-04-o1', 1, 'terminal_simulation', 'Read the mTLS policy and submit the verification code.', '{"instructions":"Read /repo/infra-envs/mesh/mtls-policy.yaml and submit the verification code with: submit CODE","hostname":"atlas-mesh-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-mesh-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/mesh/mtls-policy.yaml":{"type":"file","content":"mtls: strict, mesh-wide\ncertificate_issuance: automatic, rotated every 24 hours\nplaintext service-to-service traffic: no longer possible within the mesh\n# verification MTLS-2201\n"}}}'::jsonb, '{"requiredFlag":"MTLS-2201"}'::jsonb),

  ('mission-atlas-service-mesh-05-o1-c1', 'mission-atlas-service-mesh-05-o1', 1, 'terminal_simulation', 'Read the mesh traffic policy and submit the verification code.', '{"instructions":"Read /repo/infra-envs/mesh/traffic-policy.yaml and submit the verification code with: submit CODE","hostname":"atlas-mesh-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-mesh-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/mesh/traffic-policy.yaml":{"type":"file","content":"load_balancing: least-request, applied to every service by default\ndefault_timeout: 5 seconds, applied mesh-wide unless a service explicitly overrides it\n# verification TRAFFICPOLICY-3387\n"}}}'::jsonb, '{"requiredFlag":"TRAFFICPOLICY-3387"}'::jsonb),

  ('mission-atlas-service-mesh-06-o1-c1', 'mission-atlas-service-mesh-06-o1', 1, 'terminal_simulation', 'Read the mesh retry policy and submit the verification code.', '{"instructions":"Read /repo/infra-envs/mesh/retry-policy.yaml and submit the verification code with: submit CODE","hostname":"atlas-mesh-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-mesh-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/mesh/retry-policy.yaml":{"type":"file","content":"mesh_retry_policy:\n  max_attempts: 3\n  retry_on: 5xx, connect-failure\n  applies_at: every network hop, independently of any application-level retry logic\n# this policy has no visibility into whatever retry logic a service already implements itself\n# verification MESHRETRY-6602\n"}}}'::jsonb, '{"requiredFlag":"MESHRETRY-6602"}'::jsonb),

  ('mission-atlas-service-mesh-07-o1-c1', 'mission-atlas-service-mesh-07-o1', 1, 'terminal_simulation', 'Read the mesh circuit breaking configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/mesh/circuit-breaking.yaml and submit the verification code with: submit CODE","hostname":"atlas-mesh-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-mesh-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/mesh/circuit-breaking.yaml":{"type":"file","content":"mesh_circuit_breaking:\n  outlier_detection: eject an endpoint after 5 consecutive 5xx responses\n  connection_pool_limits: capped per destination\n# operates at the network level, complementing rather than replacing the Act 27 application-level circuit breaker\n# verification MESHBREAKER-9034\n"}}}'::jsonb, '{"requiredFlag":"MESHBREAKER-9034"}'::jsonb),

  ('mission-atlas-service-mesh-08-o1-c1', 'mission-atlas-service-mesh-08-o1', 1, 'terminal_simulation', 'Read the traffic splitting configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/mesh/traffic-split.yaml and submit the verification code with: submit CODE","hostname":"atlas-mesh-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-mesh-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/mesh/traffic-split.yaml":{"type":"file","content":"traffic_split:\n  collector-v-stable: 95 percent\n  collector-v-canary: 5 percent\n  managed_by: mesh routing rules, no custom load balancer config required anymore\n# verification SPLIT-7714\n"}}}'::jsonb, '{"requiredFlag":"SPLIT-7714"}'::jsonb),

  ('mission-atlas-service-mesh-09-o1-c1', 'mission-atlas-service-mesh-09-o1', 1, 'terminal_simulation', 'Read the mesh observability output and submit the verification code.', '{"instructions":"Read /var/atlas-mesh-01/mesh-golden-signals.txt and submit the verification code with: submit CODE","hostname":"atlas-mesh-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-mesh-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-mesh-01/mesh-golden-signals.txt":{"type":"file","content":"emitted automatically for every service pair, no manual instrumentation required:\nlatency, traffic volume, error rate, and saturation\nsource: sidecar proxies, aggregated by the mesh control plane\n# verification MESHOBS-1187\n"}}}'::jsonb, '{"requiredFlag":"MESHOBS-1187"}'::jsonb),

  ('mission-atlas-service-mesh-10-o1-c1', 'mission-atlas-service-mesh-10-o1', 1, 'multiple_choice', 'A mesh control plane actually does...', '{"question":"A mesh control plane actually does...","options":[{"id":"a","text":"Pushes configuration to every sidecar proxy, but never sits in the actual data path of a single real request"},{"id":"b","text":"Handles every real request directly, in place of the sidecars"},{"id":"c","text":"Only runs during a deployment and is otherwise idle"},{"id":"d","text":"Replaces the need for DNS entirely"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-service-mesh-11-o1-c1', 'mission-atlas-service-mesh-11-o1', 1, 'multiple_choice', 'A service mesh is not actually worth adopting yet when...', '{"question":"A service mesh is not actually worth adopting yet when...","options":[{"id":"a","text":"A small number of services with simple traffic patterns do not justify the real operational overhead of running a mesh control plane and sidecars everywhere"},{"id":"b","text":"Any system has more than one service talking to another"},{"id":"c","text":"mTLS is required anywhere in the system"},{"id":"d","text":"A mesh never has any real operational cost at all, so this never actually applies"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-service-mesh-12-o1-c1', 'mission-atlas-service-mesh-12-o1', 1, 'terminal_simulation', 'Read the Proxy Maze incident traffic log and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/proxy-maze-traffic-log.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/proxy-maze-traffic-log.txt":{"type":"file","content":"incident: sustained request volume to atlas-metrics-db reached up to 9x the actual number of real client requests\nneither the mesh retry policy (max 3) nor the application retry policy (max 3) alone explains a 9x multiplier\n3 times 3 does, if both fire independently on the exact same underlying failure\n# verification PROXYMAZE-6631\n"}}}'::jsonb, '{"requiredFlag":"PROXYMAZE-6631"}'::jsonb),
  ('mission-atlas-service-mesh-12-o2-c1', 'mission-atlas-service-mesh-12-o2', 1, 'terminal_simulation', 'Read the isolated retry policy test results and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/isolated-retry-tests.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/isolated-retry-tests.txt":{"type":"file","content":"test 1, mesh retry policy only, application retries disabled: exactly 3 attempts per failure, as configured\ntest 2, application retry policy only, mesh retries disabled: exactly 3 attempts per failure, as configured\nboth layers, tested in isolation, behave exactly as designed\n# verification ISOLATEDTEST-7742\n"}}}'::jsonb, '{"requiredFlag":"ISOLATEDTEST-7742"}'::jsonb),
  ('mission-atlas-service-mesh-12-o3-c1', 'mission-atlas-service-mesh-12-o3', 1, 'investigation', 'Which evidence explains the retry storm when both layers ran together?', '{"evidence":[{"id":"e1","label":"Proxy Maze incident traffic log","detail":"Request volume reached up to 9x real client requests during the incident"},{"id":"e2","label":"Mesh retry policy","detail":"Configured for exactly 3 attempts per failure, confirmed correct on its own"},{"id":"e3","label":"Application-level retry policy (Act 27, unchanged)","detail":"Also configured for exactly 3 attempts per failure, confirmed correct and untouched since Act 27"},{"id":"e4","label":"Combined-load interaction test","detail":"With both layers active, each application-level retry independently triggers its own full set of mesh-level retries underneath it -- 3 times 3, not 3 plus 3"}],"question":"Which evidence explains the retry storm when both layers ran together?"}'::jsonb, '{"requiredEvidenceIds":["e4"]}'::jsonb),
  ('mission-atlas-service-mesh-12-o4-c1', 'mission-atlas-service-mesh-12-o4', 1, 'boss_encounter', 'Having confirmed the incident traffic log, both isolated retry tests, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-service-mesh-12-o1","label":"Confirm the incident traffic log"},{"objectiveRef":"mission-atlas-service-mesh-12-o2","label":"Confirm both retry policies in isolation"},{"objectiveRef":"mission-atlas-service-mesh-12-o3","label":"Identify what actually caused the storm"}],"task":"State the diagnosis in one sentence: the mesh retry policy and the application-level retry policy from Act 27 are each individually correct and were never the problem in isolation, but with both active at once, every application-level retry independently triggers its own full set of mesh-level retries on the same underlying failure, multiplying three attempts into as many as nine -- the fix is coordinating the two layers explicitly, either by disabling retries at one layer for calls the other layer already covers, or by budgeting total attempts across both together, because two individually correct resilience layers were never designed to know about each other."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-service-mesh-12-o1","mission-atlas-service-mesh-12-o2","mission-atlas-service-mesh-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-service-mesh-01-o1-c1', 'orientation', 'Think about traffic staying inside the fleet versus traffic crossing its edge.', 10, 1),
  ('mission-atlas-service-mesh-01-o1-c1', 'solution', 'Service-to-service traffic inside the fleet, as opposed to north-south.', 20, 2),

  ('mission-atlas-service-mesh-02-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/mesh/sidecar-config.yaml', 10, 1),
  ('mission-atlas-service-mesh-02-o1-c1', 'solution', 'Automatic Envoy sidecar injection, verification SIDECAR-4471. submit SIDECAR-4471', 20, 2),

  ('mission-atlas-service-mesh-03-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/mesh/architecture-overview.yaml', 10, 1),
  ('mission-atlas-service-mesh-03-o1-c1', 'solution', 'Data plane handles traffic, control plane pushes config, verification MESHARCH-8802. submit MESHARCH-8802', 20, 2),

  ('mission-atlas-service-mesh-04-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/mesh/mtls-policy.yaml', 10, 1),
  ('mission-atlas-service-mesh-04-o1-c1', 'solution', 'Strict mesh-wide mTLS, rotated every 24 hours, verification MTLS-2201. submit MTLS-2201', 20, 2),

  ('mission-atlas-service-mesh-05-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/mesh/traffic-policy.yaml', 10, 1),
  ('mission-atlas-service-mesh-05-o1-c1', 'solution', 'Least-request balancing, 5 second default timeout, verification TRAFFICPOLICY-3387. submit TRAFFICPOLICY-3387', 20, 2),

  ('mission-atlas-service-mesh-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/mesh/retry-policy.yaml', 10, 1),
  ('mission-atlas-service-mesh-06-o1-c1', 'solution', '3 attempts, independent of any application-level retry logic, verification MESHRETRY-6602. submit MESHRETRY-6602', 20, 2),

  ('mission-atlas-service-mesh-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/mesh/circuit-breaking.yaml', 10, 1),
  ('mission-atlas-service-mesh-07-o1-c1', 'solution', 'Ejects after 5 consecutive 5xx, complements the app-level breaker, verification MESHBREAKER-9034. submit MESHBREAKER-9034', 20, 2),

  ('mission-atlas-service-mesh-08-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/mesh/traffic-split.yaml', 10, 1),
  ('mission-atlas-service-mesh-08-o1-c1', 'solution', '95/5 split, managed by mesh routing rules, verification SPLIT-7714. submit SPLIT-7714', 20, 2),

  ('mission-atlas-service-mesh-09-o1-c1', 'orientation', 'Try: cat /var/atlas-mesh-01/mesh-golden-signals.txt', 10, 1),
  ('mission-atlas-service-mesh-09-o1-c1', 'solution', 'Latency, traffic, errors and saturation, automatically, verification MESHOBS-1187. submit MESHOBS-1187', 20, 2),

  ('mission-atlas-service-mesh-10-o1-c1', 'orientation', 'Think about pushing configuration versus handling a real request directly.', 10, 1),
  ('mission-atlas-service-mesh-10-o1-c1', 'solution', 'Pushes config to sidecars, never in the actual request path.', 20, 2),

  ('mission-atlas-service-mesh-11-o1-c1', 'orientation', 'Think about a handful of simple services versus a mesh control plane''s real overhead.', 10, 1),
  ('mission-atlas-service-mesh-11-o1-c1', 'solution', 'Simple traffic patterns at small scale rarely justify the overhead.', 20, 2),

  ('mission-atlas-service-mesh-12-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/proxy-maze-traffic-log.txt', 10, 1),
  ('mission-atlas-service-mesh-12-o1-c1', 'solution', 'Up to 9x real request volume, verification PROXYMAZE-6631. submit PROXYMAZE-6631', 20, 2),
  ('mission-atlas-service-mesh-12-o2-c1', 'orientation', 'Try: cat /var/atlas-observability-01/isolated-retry-tests.txt', 10, 1),
  ('mission-atlas-service-mesh-12-o2-c1', 'solution', 'Both layers correct in isolation, 3 attempts each, verification ISOLATEDTEST-7742. submit ISOLATEDTEST-7742', 20, 2),
  ('mission-atlas-service-mesh-12-o3-c1', 'orientation', 'Both retry configs are confirmed clean alone. Think about what happens when one retry triggers the other underneath it.', 10, 1),
  ('mission-atlas-service-mesh-12-o3-c1', 'solution', 'e4: each app-level retry independently triggers its own mesh-level retries -- 3 times 3, not 3 plus 3.', 20, 2),
  ('mission-atlas-service-mesh-12-o4-c1', 'orientation', 'Combine both correct-alone configs, the multiplicative interaction, and the fix into one sentence.', 15, 1),
  ('mission-atlas-service-mesh-12-o4-c1', 'solution', 'Two individually correct retry layers multiplied instead of adding; the fix is coordinating a shared retry budget across both.', 25, 2);
