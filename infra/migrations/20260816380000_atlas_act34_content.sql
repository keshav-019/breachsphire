-- Atlas Division pathway ("The Silence") Act 34 -- "Multi-Region"
-- content, under world-atlas-multi-region (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), continuing World X "Atlas".
--
-- Same terminal-engine constraint as every prior Atlas Act. One new
-- host, `atlas-global-01`, holds every global routing, residency and
-- capacity artifact this Act builds; the boss reuses
-- `atlas-observability-01` for the residency audit and the replication
-- pipeline confirmation, directly referencing Act 29's existing
-- replication-config.yaml rather than duplicating it.
--
-- Narrative thread: mission 8 (data residency) plants the actual policy
-- as a plain fact well before the boss needs it. The boss deliberately
-- confirms the replication pipeline (`e2`) as functioning exactly as
-- Act 29 designed it, and rules it out as a malfunction; the actual
-- explanation requires both the residency policy and the replication
-- scope having no region-aware exception (`e3`+`e4`) -- a system built
-- correctly for one purpose, never checked against a second requirement
-- nobody connected it to, the clearest version yet of this stretch''s
-- recurring shape.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-multi-region', 'world-atlas-multi-region', 'multi-region', '10B - Multi-Region', 'Learn global infrastructure from first principles -- global DNS, CDN/edge, regional isolation, multi-region apps, global DB concepts, traffic steering, failover, data residency, latency, consistency and capacity -- and find out where a disaster-recovery pipeline built for resilience has actually been sending customer data.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-multi-region-1', 'campaign-atlas-multi-region', 'a-real-second-continent', 'A Real Second Continent', 'Global DNS, CDN/edge, regional isolation, multi-region apps, global DB concepts and traffic steering.', 1),
  ('operation-atlas-multi-region-2', 'campaign-atlas-multi-region', 'where-data-is-allowed-to-live', 'Where Data Is Allowed to Live', 'Failover, data residency, latency, consistency, capacity and the audit itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-multi-region-01', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-1', 'global-dns', 'Global DNS', 'This fleet still runs from a single home region, on a single continent. Vey wants EU customers routed somewhere actually close to them.', 'beginner', ARRAY['leena','vey'], null, null, '{"type":"simulation","simulationId":"global-dns-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-multi-region-02', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-1', 'cdn-edge', 'CDN/Edge', 'Confirm exactly what this fleet''s new edge layer actually serves directly, without a request ever reaching a real region at all.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"cdn-edge-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-multi-region-03', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-1', 'regional-isolation', 'Regional Isolation', 'Confirm exactly what actually keeps one region''s failure from ever being able to take down another.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"regional-isolation-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-multi-region-04', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-1', 'multi-region-apps', 'Multi-Region Apps', 'Confirm exactly how this fleet''s services are now actually deployed across three real regions instead of one.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"multi-region-apps-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-multi-region-05', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-1', 'global-db-concepts', 'Global DB Concepts', 'Understand exactly what real tradeoff this fleet actually accepted choosing regional read replicas over a single global write target.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"global-db-concepts-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-multi-region-06', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-1', 'traffic-steering', 'Traffic Steering', 'Confirm exactly how a real request now actually gets routed to its nearest healthy region, automatically.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"traffic-steering-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-multi-region-07', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-2', 'failover', 'Failover', 'Confirm exactly how Act 29''s two-region disaster recovery plan actually extends now that a real third region exists.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"failover-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-multi-region-08', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-2', 'data-residency', 'Data Residency', 'Confirm exactly what this fleet has actually committed to, in writing, about where EU customer data is legally allowed to live.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-multi-region-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"data-residency-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-multi-region-09', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-2', 'latency', 'Latency', 'Confirm exactly how much real latency EU customers actually saved once traffic stopped crossing an ocean for every request.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"global-latency-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-multi-region-10', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-2', 'consistency', 'Consistency', 'Understand exactly what real tradeoff this fleet accepted allowing regional reads to occasionally lag behind the true global state.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"consistency-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-multi-region-11', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-2', 'capacity', 'Capacity', 'Confirm exactly how much real capacity each region now actually needs to carry the others'' load if either one goes down.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-multi-region-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"global-capacity-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-multi-region-12', 'world-atlas-multi-region', 'campaign-atlas-multi-region', 'operation-atlas-multi-region-2', 'two-continents', 'Two Continents', 'Everything this Act taught, turned on one real audit finding: not to just confirm the replication pipeline is broken, to explain why it never should have applied here unchanged.', 'boss', ARRAY['vey','leena','byte'], '{"requiredMissionIds":["mission-atlas-multi-region-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"two-continents-boss-sim"}'::jsonb, '{"xp":850,"credits":210,"badgeIds":["two-continents"],"skillXp":{"cloud_devops_fundamentals":145}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-multi-region-01', 1, 'leena', 'This fleet still runs from a single home region, on a single continent, after everything else this pathway has built.'),
  ('mission-atlas-multi-region-01', 2, 'vey', 'Tomas Vey. A real EU region fixes two problems at once -- real latency for EU customers, and finally, somewhere legally correct for their data to actually live.'),

  ('mission-atlas-multi-region-02', 1, 'vey', 'Confirm exactly what the new edge layer actually serves directly now, without a single request needing to reach a real region at all.'),

  ('mission-atlas-multi-region-03', 1, 'vey', 'Confirm exactly what actually keeps one region''s failure contained, so it can never take another one down with it.'),

  ('mission-atlas-multi-region-04', 1, 'vey', 'Confirm exactly how this fleet''s services are now actually deployed across three real regions, not one with two backups.'),

  ('mission-atlas-multi-region-05', 1, 'vey', 'A single global write target is simple and slow. Regional read replicas are fast and eventually consistent. Understand exactly which tradeoff this fleet actually accepted.'),

  ('mission-atlas-multi-region-06', 1, 'vey', 'Confirm exactly how a real request now actually gets routed to its nearest healthy region, automatically, with no manual DNS change required.'),

  ('mission-atlas-multi-region-07', 1, 'vey', 'Confirm exactly how Act 29''s original two-region disaster recovery plan actually extends now that a real third region exists.'),

  ('mission-atlas-multi-region-08', 1, 'leena', 'Confirm exactly what this fleet has actually committed to, in writing, about where EU customer data is legally required to stay.'),

  ('mission-atlas-multi-region-09', 1, 'vey', 'Confirm exactly how much real latency EU customers actually saved, now that their traffic no longer crosses an ocean for every request.'),

  ('mission-atlas-multi-region-10', 1, 'vey', 'Understand exactly what this fleet accepted letting a regional read occasionally lag a few seconds behind the true global state.'),

  ('mission-atlas-multi-region-11', 1, 'vey', 'Confirm exactly how much real spare capacity each region now actually needs to absorb the others'' load if either one goes down.'),

  ('mission-atlas-multi-region-12', 1, 'leena', 'Everything this Act taught you, turned on one real audit finding. Not just to confirm the replication pipeline is broken -- to explain why it never should have applied here unchanged.'),
  ('mission-atlas-multi-region-12', 2, 'byte', 'I have the residency audit pulled up. EU customer records are present in the us-west-2 replica, and have been since Act 29.'),
  ('mission-atlas-multi-region-12', 3, 'vey', 'The replication pipeline itself is not malfunctioning. It is doing exactly what Act 29 built it to do.'),
  ('mission-atlas-multi-region-12', 4, 'leena', 'Then find what it was never actually built to know, and fix that instead of blaming the pipeline.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-multi-region-01-o1', 'mission-atlas-multi-region-01', 1, 'Read the global DNS routing config', 'Read the global DNS routing configuration and submit the verification code.'),

  ('mission-atlas-multi-region-02-o1', 'mission-atlas-multi-region-02', 1, 'Read the CDN/edge config', 'Read the CDN and edge configuration and submit the verification code.'),

  ('mission-atlas-multi-region-03-o1', 'mission-atlas-multi-region-03', 1, 'Read the regional isolation config', 'Read the regional isolation configuration and submit the verification code.'),

  ('mission-atlas-multi-region-04-o1', 'mission-atlas-multi-region-04', 1, 'Read the multi-region deployment topology', 'Read the multi-region deployment topology and submit the verification code.'),

  ('mission-atlas-multi-region-05-o1', 'mission-atlas-multi-region-05', 1, 'Explain global DB concepts', 'Choose the accurate description of the tradeoff behind regional read replicas.'),

  ('mission-atlas-multi-region-06-o1', 'mission-atlas-multi-region-06', 1, 'Read the traffic steering config', 'Read the traffic steering configuration and submit the verification code.'),

  ('mission-atlas-multi-region-07-o1', 'mission-atlas-multi-region-07', 1, 'Read the extended failover plan', 'Read the extended three-region failover plan and submit the verification code.'),

  ('mission-atlas-multi-region-08-o1', 'mission-atlas-multi-region-08', 1, 'Read the data residency policy', 'Read the data residency policy and submit the verification code.'),

  ('mission-atlas-multi-region-09-o1', 'mission-atlas-multi-region-09', 1, 'Read the latency comparison', 'Read the global latency comparison and submit the verification code.'),

  ('mission-atlas-multi-region-10-o1', 'mission-atlas-multi-region-10', 1, 'Explain consistency tradeoffs', 'Choose the accurate description of the consistency tradeoff this fleet accepted.'),

  ('mission-atlas-multi-region-11-o1', 'mission-atlas-multi-region-11', 1, 'Read the regional capacity plan', 'Read the regional capacity plan and submit the verification code.'),

  ('mission-atlas-multi-region-12-o1', 'mission-atlas-multi-region-12', 1, 'Confirm the residency audit', 'Read the data residency audit and submit the verification code.'),
  ('mission-atlas-multi-region-12-o2', 'mission-atlas-multi-region-12', 2, 'Confirm the replication pipeline is working as designed', 'Read the replication pipeline confirmation and submit the verification code.'),
  ('mission-atlas-multi-region-12-o3', 'mission-atlas-multi-region-12', 3, 'Identify what actually explains the violation', 'Find the evidence that explains why EU customer data ended up in the US region.'),
  ('mission-atlas-multi-region-12-o4', 'mission-atlas-multi-region-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-multi-region-01-o1-c1', 'mission-atlas-multi-region-01-o1', 1, 'terminal_simulation', 'Read the global DNS routing configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/global/global-dns.yaml and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/global/global-dns.yaml":{"type":"file","content":"global_dns:\n  routing_policy: latency-based, per real DNS resolver location\n  regions: us-east-1 (primary), us-west-2 (DR standby), eu-west-1 (new)\n# verification GLOBALDNS-4471\n"}}}'::jsonb, '{"requiredFlag":"GLOBALDNS-4471"}'::jsonb),

  ('mission-atlas-multi-region-02-o1-c1', 'mission-atlas-multi-region-02-o1', 1, 'terminal_simulation', 'Read the CDN and edge configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/global/cdn-edge.yaml and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/global/cdn-edge.yaml":{"type":"file","content":"cdn_edge:\n  serves_directly, no region ever reached: static assets, cached API responses under 60 seconds old\n  everything else: forwarded to the nearest healthy region\n# verification CDNEDGE-8802\n"}}}'::jsonb, '{"requiredFlag":"CDNEDGE-8802"}'::jsonb),

  ('mission-atlas-multi-region-03-o1-c1', 'mission-atlas-multi-region-03-o1', 1, 'terminal_simulation', 'Read the regional isolation configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/global/regional-isolation.yaml and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/global/regional-isolation.yaml":{"type":"file","content":"regional_isolation:\n  each region: its own independent control plane, its own independent capacity, no shared single point of failure across regions\n  a full failure in one region: never reduces capacity available in any other\n# verification REGIONALISO-2201\n"}}}'::jsonb, '{"requiredFlag":"REGIONALISO-2201"}'::jsonb),

  ('mission-atlas-multi-region-04-o1-c1', 'mission-atlas-multi-region-04-o1', 1, 'terminal_simulation', 'Read the multi-region deployment topology and submit the verification code.', '{"instructions":"Read /repo/infra-envs/global/deployment-topology.yaml and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/global/deployment-topology.yaml":{"type":"file","content":"deployment_topology:\n  us-east-1: primary, full stateless and stateful footprint\n  us-west-2: DR standby, full stateless footprint, passive database replica\n  eu-west-1: full stateless footprint, its own regional database, serving EU traffic directly\n# verification TOPOLOGY-3387\n"}}}'::jsonb, '{"requiredFlag":"TOPOLOGY-3387"}'::jsonb),

  ('mission-atlas-multi-region-05-o1-c1', 'mission-atlas-multi-region-05-o1', 1, 'multiple_choice', 'Choosing regional read replicas over a single global write target actually accepts...', '{"question":"Choosing regional read replicas over a single global write target actually accepts...","options":[{"id":"a","text":"Faster regional reads, in exchange for those reads occasionally lagging slightly behind the true, most current global state"},{"id":"b","text":"No tradeoff at all -- regional replicas are strictly better in every measurable way"},{"id":"c","text":"Giving up the ability to read data from more than one region at a time"},{"id":"d","text":"Guaranteed zero replication lag, by definition"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-multi-region-06-o1-c1', 'mission-atlas-multi-region-06-o1', 1, 'terminal_simulation', 'Read the traffic steering configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/global/traffic-steering.yaml and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/global/traffic-steering.yaml":{"type":"file","content":"traffic_steering:\n  method: latency-based routing, continuously re-evaluated per resolver\n  health_checks: automatic, unhealthy regions removed from rotation within seconds\n# verification STEERING-6602\n"}}}'::jsonb, '{"requiredFlag":"STEERING-6602"}'::jsonb),

  ('mission-atlas-multi-region-07-o1-c1', 'mission-atlas-multi-region-07-o1', 1, 'terminal_simulation', 'Read the extended three-region failover plan and submit the verification code.', '{"instructions":"Read /repo/infra-envs/global/failover-plan.yaml and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/global/failover-plan.yaml":{"type":"file","content":"failover_plan, extends Act 29:\n  us-east-1 lost: us-west-2 promoted, per the original Act 29 plan, unchanged\n  eu-west-1 lost: EU traffic temporarily served from us-east-1, until eu-west-1 recovers\n  both US regions lost simultaneously: eu-west-1 becomes the sole global primary\n# verification FAILOVERPLAN-9034\n"}}}'::jsonb, '{"requiredFlag":"FAILOVERPLAN-9034"}'::jsonb),

  ('mission-atlas-multi-region-08-o1-c1', 'mission-atlas-multi-region-08-o1', 1, 'terminal_simulation', 'Read the data residency policy and submit the verification code.', '{"instructions":"Read /repo/infra-envs/global/data-residency-policy.yaml and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/global/data-residency-policy.yaml":{"type":"file","content":"data_residency_policy:\n  EU customer records: must not be stored or replicated outside EU region boundaries\n  effective: as of the eu-west-1 launch\n  compliance owner: legal, enforced technically by the platform team\n# verification RESIDENCY-7714\n"}}}'::jsonb, '{"requiredFlag":"RESIDENCY-7714"}'::jsonb),

  ('mission-atlas-multi-region-09-o1-c1', 'mission-atlas-multi-region-09-o1', 1, 'terminal_simulation', 'Read the global latency comparison and submit the verification code.', '{"instructions":"Read /var/atlas-global-01/latency-comparison.txt and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-global-01/latency-comparison.txt":{"type":"file","content":"EU customer median request latency\nbefore eu-west-1 (served from us-east-1): 210ms\nafter eu-west-1 launch: 38ms\n# verification LATENCYCOMP-1187\n"}}}'::jsonb, '{"requiredFlag":"LATENCYCOMP-1187"}'::jsonb),

  ('mission-atlas-multi-region-10-o1-c1', 'mission-atlas-multi-region-10-o1', 1, 'multiple_choice', 'The consistency tradeoff this fleet accepted actually means...', '{"question":"The consistency tradeoff this fleet accepted actually means...","options":[{"id":"a","text":"A regional read can occasionally return data that is a few seconds behind the true global state, in exchange for much lower read latency"},{"id":"b","text":"Every read from any region always returns the exact same instant of truth, with zero exceptions"},{"id":"c","text":"Writes are never actually durable until every region confirms them"},{"id":"d","text":"Consistency only matters for reads, never for writes"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-multi-region-11-o1-c1', 'mission-atlas-multi-region-11-o1', 1, 'terminal_simulation', 'Read the regional capacity plan and submit the verification code.', '{"instructions":"Read /var/atlas-global-01/regional-capacity-plan.txt and submit the verification code with: submit CODE","hostname":"atlas-global-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-global-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-global-01/regional-capacity-plan.txt":{"type":"file","content":"each region provisioned at 150 percent of its own normal peak load\nreason: so any single region can absorb another region''s full traffic during a failover without becoming the next bottleneck\n# verification CAPACITYPLAN-2201\n"}}}'::jsonb, '{"requiredFlag":"CAPACITYPLAN-2201"}'::jsonb),

  ('mission-atlas-multi-region-12-o1-c1', 'mission-atlas-multi-region-12-o1', 1, 'terminal_simulation', 'Read the data residency audit and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/residency-audit.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/residency-audit.txt":{"type":"file","content":"data residency audit, first run after eu-west-1 launch\nEU customer records found present in the us-west-2 replica: yes, all of them\ntimeline: present since Act 29''s replication pipeline first launched, long before eu-west-1 existed\n# verification RESIDENCYAUDIT-6631\n"}}}'::jsonb, '{"requiredFlag":"RESIDENCYAUDIT-6631"}'::jsonb),
  ('mission-atlas-multi-region-12-o2-c1', 'mission-atlas-multi-region-12-o2', 1, 'terminal_simulation', 'Read the replication pipeline confirmation and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/replication-pipeline-confirmation.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/replication-pipeline-confirmation.txt":{"type":"file","content":"Act 29 replication pipeline, re-verified\nbehavior: replicates every customer record uniformly, us-east-1 to us-west-2, for disaster recovery\nno region-aware filtering logic exists anywhere in this pipeline, and none was ever requested when it was built\nconclusion: functioning exactly as designed\n# verification REPLCONFIRM-7742\n"}}}'::jsonb, '{"requiredFlag":"REPLCONFIRM-7742"}'::jsonb),
  ('mission-atlas-multi-region-12-o3-c1', 'mission-atlas-multi-region-12-o3', 1, 'investigation', 'Which evidence explains why EU customer data ended up in the US region?', '{"evidence":[{"id":"e1","label":"Data residency audit","detail":"EU customer records have been present in the us-west-2 replica since Act 29''s replication pipeline first launched"},{"id":"e2","label":"Replication pipeline confirmation","detail":"The pipeline replicates every record uniformly for disaster recovery, functioning exactly as designed -- not a malfunction"},{"id":"e3","label":"Data residency policy","detail":"EU customer records must not be stored or replicated outside EU region boundaries, effective as of the eu-west-1 launch"},{"id":"e4","label":"Replication pipeline scope","detail":"No region-aware filtering logic exists in the pipeline, and none was ever requested when it was originally built in Act 29"}],"question":"Which evidence explains why EU customer data ended up in the US region?"}'::jsonb, '{"requiredEvidenceIds":["e3","e4"]}'::jsonb),
  ('mission-atlas-multi-region-12-o4-c1', 'mission-atlas-multi-region-12-o4', 1, 'boss_encounter', 'Having confirmed the residency audit, the replication pipeline confirmation, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-multi-region-12-o1","label":"Confirm the residency audit"},{"objectiveRef":"mission-atlas-multi-region-12-o2","label":"Confirm the replication pipeline is working as designed"},{"objectiveRef":"mission-atlas-multi-region-12-o3","label":"Identify what actually explains the violation"}],"task":"State the diagnosis in one sentence: Act 29''s replication pipeline is not broken -- it replicates every customer record uniformly for disaster recovery, exactly as it was designed to, and no region-aware exception was ever requested because the data residency requirement did not exist until the eu-west-1 launch -- the fix is adding explicit region-scoping to the replication pipeline so EU customer records never leave EU boundaries, because a system built correctly for one purpose is not automatically compliant with a requirement nobody had connected to it yet."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-multi-region-12-o1","mission-atlas-multi-region-12-o2","mission-atlas-multi-region-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-multi-region-01-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/global/global-dns.yaml', 10, 1),
  ('mission-atlas-multi-region-01-o1-c1', 'solution', 'Latency-based routing, three regions, verification GLOBALDNS-4471. submit GLOBALDNS-4471', 20, 2),

  ('mission-atlas-multi-region-02-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/global/cdn-edge.yaml', 10, 1),
  ('mission-atlas-multi-region-02-o1-c1', 'solution', 'Static assets and fresh cached responses served at the edge, verification CDNEDGE-8802. submit CDNEDGE-8802', 20, 2),

  ('mission-atlas-multi-region-03-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/global/regional-isolation.yaml', 10, 1),
  ('mission-atlas-multi-region-03-o1-c1', 'solution', 'Independent control planes and capacity per region, verification REGIONALISO-2201. submit REGIONALISO-2201', 20, 2),

  ('mission-atlas-multi-region-04-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/global/deployment-topology.yaml', 10, 1),
  ('mission-atlas-multi-region-04-o1-c1', 'solution', 'Three regions, eu-west-1 with its own regional database, verification TOPOLOGY-3387. submit TOPOLOGY-3387', 20, 2),

  ('mission-atlas-multi-region-05-o1-c1', 'orientation', 'Think about faster local reads versus perfectly current ones.', 10, 1),
  ('mission-atlas-multi-region-05-o1-c1', 'solution', 'Faster reads, in exchange for occasional replication lag.', 20, 2),

  ('mission-atlas-multi-region-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/global/traffic-steering.yaml', 10, 1),
  ('mission-atlas-multi-region-06-o1-c1', 'solution', 'Latency-based, continuously re-evaluated, verification STEERING-6602. submit STEERING-6602', 20, 2),

  ('mission-atlas-multi-region-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/global/failover-plan.yaml', 10, 1),
  ('mission-atlas-multi-region-07-o1-c1', 'solution', 'Extends Act 29 with a third region and a combined-loss case, verification FAILOVERPLAN-9034. submit FAILOVERPLAN-9034', 20, 2),

  ('mission-atlas-multi-region-08-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/global/data-residency-policy.yaml', 10, 1),
  ('mission-atlas-multi-region-08-o1-c1', 'solution', 'EU records must not leave EU boundaries, verification RESIDENCY-7714. submit RESIDENCY-7714', 20, 2),

  ('mission-atlas-multi-region-09-o1-c1', 'orientation', 'Try: cat /var/atlas-global-01/latency-comparison.txt', 10, 1),
  ('mission-atlas-multi-region-09-o1-c1', 'solution', '210ms down to 38ms, verification LATENCYCOMP-1187. submit LATENCYCOMP-1187', 20, 2),

  ('mission-atlas-multi-region-10-o1-c1', 'orientation', 'Think about a few seconds of lag versus a slower, always-current read.', 10, 1),
  ('mission-atlas-multi-region-10-o1-c1', 'solution', 'Occasionally a few seconds behind, in exchange for lower latency.', 20, 2),

  ('mission-atlas-multi-region-11-o1-c1', 'orientation', 'Try: cat /var/atlas-global-01/regional-capacity-plan.txt', 10, 1),
  ('mission-atlas-multi-region-11-o1-c1', 'solution', '150 percent of normal peak, to absorb a failover, verification CAPACITYPLAN-2201. submit CAPACITYPLAN-2201', 20, 2),

  ('mission-atlas-multi-region-12-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/residency-audit.txt', 10, 1),
  ('mission-atlas-multi-region-12-o1-c1', 'solution', 'EU records present in us-west-2 since Act 29, verification RESIDENCYAUDIT-6631. submit RESIDENCYAUDIT-6631', 20, 2),
  ('mission-atlas-multi-region-12-o2-c1', 'orientation', 'Try: cat /var/atlas-observability-01/replication-pipeline-confirmation.txt', 10, 1),
  ('mission-atlas-multi-region-12-o2-c1', 'solution', 'Functioning exactly as designed, no region filter ever requested, verification REPLCONFIRM-7742. submit REPLCONFIRM-7742', 20, 2),
  ('mission-atlas-multi-region-12-o3-c1', 'orientation', 'The replication pipeline is confirmed working as designed and ruled out as a malfunction. Compare the residency policy against the pipeline''s actual scope.', 10, 1),
  ('mission-atlas-multi-region-12-o3-c1', 'solution', 'e3 and e4: a policy that did not exist yet, and a pipeline with no region-aware filtering to enforce it.', 20, 2),
  ('mission-atlas-multi-region-12-o4-c1', 'orientation', 'Combine the working-as-designed pipeline, the newer policy, and the fix into one sentence.', 15, 1),
  ('mission-atlas-multi-region-12-o4-c1', 'solution', 'The pipeline was never broken; it needs explicit region-scoping to honor a residency requirement that postdates it.', 25, 2);
