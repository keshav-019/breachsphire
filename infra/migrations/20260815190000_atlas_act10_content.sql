-- Atlas Division pathway ("The Silence") Act 10 -- "The Cloud Opens"
-- content, under world-atlas-the-cloud-opens (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), opening World IV "Cloudreach" (Acts 10-13).
--
-- Same terminal-engine constraint as Acts 4-9 -- no cloud-provider-
-- specific commands exist in the engine -- so every cloud resource here
-- (region/zone listing, virtual network, compute instances, block and
-- object storage, managed database, load balancer, DNS, CDN) is static
-- seeded infra-as-code-style text under /repo/infra/, read via `cat` on
-- the reused `atlas-devbox-01` host, framed as the same repository
-- Rook and Vey both already work out of. Only "IaaS/PaaS/SaaS" and
-- "shared responsibility" (pure definitions, no natural artifact) stay
-- multiple_choice.
--
-- Narrative thread: Vey builds a full second region (`atlas-eu-west`)
-- as real redundancy -- network, compute, block storage, object
-- storage (replicating the Act 5 artifact bucket), a managed database
-- replica -- and every single resource comes up healthy. The load
-- balancer and DNS missions are the deliberate clues (targets/records
-- only ever mention `atlas-us-east`), confirmed and ruled nowhere near
-- provider fault by the CDN check, landing on the actual gap: nobody on
-- Atlas Division's own side of the shared-responsibility line ever
-- pointed real traffic at the new region.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-the-cloud-opens', 'world-atlas-the-cloud-opens', 'the-cloud-opens', '4A - The Cloud Opens', 'Learn cloud foundations end to end -- IaaS/PaaS/SaaS, regions and zones, virtual networks, compute, block and object storage, managed databases, load balancers, DNS, CDN and the shared responsibility model -- while Vey builds Atlas Division''s first real second region and finds out nothing is actually reaching it.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-the-cloud-opens-1', 'campaign-atlas-the-cloud-opens', 'a-region-built-from-nothing', 'A Region Built From Nothing', 'IaaS/PaaS/SaaS, regions and zones, virtual networks, compute, block storage and object storage.', 1),
  ('operation-atlas-the-cloud-opens-2', 'campaign-atlas-the-cloud-opens', 'a-region-nobody-can-reach', 'A Region Nobody Can Reach', 'Managed databases, load balancers, DNS, CDN and shared responsibility.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-the-cloud-opens-01', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-1', 'iaas-paas-saas', 'IaaS/PaaS/SaaS', 'Every host, pipeline and container built so far has lived in one place. Vey starts building Atlas Division''s first real second region.', 'beginner', ARRAY['leena','vey'], null, null, '{"type":"simulation","simulationId":"iaas-paas-saas-sim"}'::jsonb, '{"xp":210,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-the-cloud-opens-02', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-1', 'regions-zones', 'Regions and Zones', 'Confirm exactly what is actually being built alongside the existing region.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"regions-zones-sim"}'::jsonb, '{"xp":210,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-the-cloud-opens-03', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-1', 'virtual-networks', 'Virtual Networks', 'Confirm the new region''s own network actually exists and is available.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"virtual-networks-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-the-cloud-opens-04', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-1', 'compute', 'Compute', 'Confirm real compute instances are actually running in the new region.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"compute-cloud-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-the-cloud-opens-05', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-1', 'block-storage', 'Block Storage', 'Confirm each new instance actually has a disk attached and in use.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"block-storage-sim"}'::jsonb, '{"xp":230,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-the-cloud-opens-06', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-1', 'object-storage', 'Object Storage', 'Confirm the collector''s build artifacts are actually replicated into the new region too.', 'beginner', ARRAY['vey','rook'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"object-storage-sim"}'::jsonb, '{"xp":230,"credits":40}'::jsonb, false, 6),
  ('mission-atlas-the-cloud-opens-07', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-2', 'managed-databases', 'Managed Databases', 'Confirm the new region has a real, healthy database of its own, not just compute and storage.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"managed-databases-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-the-cloud-opens-08', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-2', 'load-balancers', 'Load Balancers', 'Every resource so far is healthy. Confirm what the load balancer is actually sending traffic to.', 'beginner', ARRAY['vey','cross'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"load-balancers-sim"}'::jsonb, '{"xp":250,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-the-cloud-opens-09', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-2', 'dns', 'DNS', 'Confirm whether anything actually resolves toward the new region at all.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"dns-cloud-sim"}'::jsonb, '{"xp":250,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-the-cloud-opens-10', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-2', 'cdn', 'CDN', 'Rule out the CDN as part of the problem before assuming anything else.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"cdn-sim"}'::jsonb, '{"xp":250,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-the-cloud-opens-11', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-2', 'shared-responsibility', 'Shared Responsibility', 'Every resource is healthy and the provider has done its part. Understand exactly where that responsibility actually ends.', 'beginner', ARRAY['vey','leena'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"shared-responsibility-sim"}'::jsonb, '{"xp":260,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-the-cloud-opens-12', 'world-atlas-the-cloud-opens', 'campaign-atlas-the-cloud-opens', 'operation-atlas-the-cloud-opens-2', 'the-empty-region', 'The Empty Region', 'Everything this Act taught, turned on one region: not to rebuild it, to finally explain how a region can be entirely healthy and still receive nothing.', 'boss', ARRAY['vey','leena','byte'], '{"requiredMissionIds":["mission-atlas-the-cloud-opens-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"empty-region-boss-sim"}'::jsonb, '{"xp":500,"credits":115,"badgeIds":["the-empty-region"],"skillXp":{"cloud_devops_fundamentals":85}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-the-cloud-opens-01', 1, 'leena', 'Every host, pipeline and container built so far has lived in exactly one region. That stops being acceptable the moment Atlas Division depends on it staying up around the clock.'),
  ('mission-atlas-the-cloud-opens-01', 2, 'vey', 'Tomas Vey. This is squarely mine -- cloud architecture, global infrastructure. I am building a second region from nothing, real redundancy, not a diagram.'),
  ('mission-atlas-the-cloud-opens-01', 3, 'vey', 'IaaS gives you raw infrastructure -- compute, storage, networking -- and you manage everything above it yourself. PaaS manages the runtime for you; you just deploy code. SaaS is a finished application you simply use. Know which layer you are actually operating at before assuming what is or is not your responsibility.'),

  ('mission-atlas-the-cloud-opens-02', 1, 'vey', 'A region is a distinct geographic area. Availability zones are isolated locations inside that region, each with independent power and networking -- redundancy within a region, not across one. Confirm what is actually being stood up.'),

  ('mission-atlas-the-cloud-opens-03', 1, 'vey', 'Nothing runs without a network under it first. Confirm the new region''s virtual network actually exists before anything else.'),

  ('mission-atlas-the-cloud-opens-04', 1, 'vey', 'Confirm real compute instances are actually running -- not just requested, actually running, in both zones.'),

  ('mission-atlas-the-cloud-opens-05', 1, 'vey', 'A compute instance without an attached disk is not doing anything useful yet. Confirm the storage is actually there.'),

  ('mission-atlas-the-cloud-opens-06', 1, 'rook', 'This is exactly the artifact repository work from Act 5, just replicated across regions now. Confirm it is actually syncing, not just configured to.'),
  ('mission-atlas-the-cloud-opens-06', 2, 'vey', 'It is. Object storage for build artifacts, block storage for the running instance''s own disk -- two different kinds of storage, two different jobs.'),

  ('mission-atlas-the-cloud-opens-07', 1, 'vey', 'Compute and storage are not enough on their own. Confirm the new region has a real, healthy database, replicating from the primary.'),

  ('mission-atlas-the-cloud-opens-08', 1, 'cross', 'Imani Cross. Every resource so far has come back healthy. That is exactly the pattern that makes me suspicious -- confirm what is actually being sent where.'),
  ('mission-atlas-the-cloud-opens-08', 2, 'vey', 'Confirm it yourself. Read what the load balancer is actually configured to send traffic to.'),

  ('mission-atlas-the-cloud-opens-09', 1, 'vey', 'A load balancer only routes what already reaches it. Confirm whether DNS itself even points anyone toward this region in the first place.'),

  ('mission-atlas-the-cloud-opens-10', 1, 'vey', 'Before concluding anything, rule out the CDN too -- confirm whether it is quietly part of the same problem or genuinely unrelated.'),

  ('mission-atlas-the-cloud-opens-11', 1, 'vey', 'The provider is not at fault here, and it never was. Understand exactly where their responsibility ends and Atlas Division''s own begins.'),
  ('mission-atlas-the-cloud-opens-11', 2, 'leena', 'The cloud handles the infrastructure existing and staying available. It was never going to decide, on its own, that this specific region should start receiving traffic. That call was always ours to make.'),

  ('mission-atlas-the-cloud-opens-12', 1, 'leena', 'Everything this Act taught you, on one region. Not to rebuild it -- to finally explain how a region can be entirely healthy in every dashboard and still receive nothing at all.'),
  ('mission-atlas-the-cloud-opens-12', 2, 'byte', 'I have the full resource inventory and the load balancer and DNS configuration both pulled up together. Every single resource in this region is healthy.'),
  ('mission-atlas-the-cloud-opens-12', 3, 'vey', 'Find exactly what was never configured to send anything here, and say plainly whose job that actually was.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-the-cloud-opens-01-o1', 'mission-atlas-the-cloud-opens-01', 1, 'Tell IaaS, PaaS and SaaS apart', 'Choose the accurate distinction between IaaS, PaaS and SaaS.'),

  ('mission-atlas-the-cloud-opens-02-o1', 'mission-atlas-the-cloud-opens-02', 1, 'Check the region and zone listing', 'Read the region listing and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-03-o1', 'mission-atlas-the-cloud-opens-03', 1, 'Check the virtual network', 'Read the network definition and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-04-o1', 'mission-atlas-the-cloud-opens-04', 1, 'Check compute instances', 'Read the compute inventory and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-05-o1', 'mission-atlas-the-cloud-opens-05', 1, 'Check block storage', 'Read the block storage report and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-06-o1', 'mission-atlas-the-cloud-opens-06', 1, 'Check object storage', 'Read the object storage report and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-07-o1', 'mission-atlas-the-cloud-opens-07', 1, 'Check the managed database', 'Read the managed database status and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-08-o1', 'mission-atlas-the-cloud-opens-08', 1, 'Check the load balancer targets', 'Read the load balancer configuration and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-09-o1', 'mission-atlas-the-cloud-opens-09', 1, 'Check DNS records', 'Read the DNS records and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-10-o1', 'mission-atlas-the-cloud-opens-10', 1, 'Check the CDN configuration', 'Read the CDN configuration and submit the verification code.'),

  ('mission-atlas-the-cloud-opens-11-o1', 'mission-atlas-the-cloud-opens-11', 1, 'Explain the shared responsibility model', 'Choose the accurate description of where the provider''s responsibility ends.'),

  ('mission-atlas-the-cloud-opens-12-o1', 'mission-atlas-the-cloud-opens-12', 1, 'Confirm the region is healthy', 'Read the compute inventory and submit the verification code.'),
  ('mission-atlas-the-cloud-opens-12-o2', 'mission-atlas-the-cloud-opens-12', 2, 'Confirm nothing routes traffic there', 'Read the DNS records and submit the verification code.'),
  ('mission-atlas-the-cloud-opens-12-o3', 'mission-atlas-the-cloud-opens-12', 3, 'Identify whose responsibility this was', 'Find the evidence that explains why this region receives no traffic.'),
  ('mission-atlas-the-cloud-opens-12-o4', 'mission-atlas-the-cloud-opens-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-the-cloud-opens-01-o1-c1', 'mission-atlas-the-cloud-opens-01-o1', 1, 'multiple_choice', 'IaaS, PaaS and SaaS differ in that...', '{"question":"IaaS, PaaS and SaaS differ in that...","options":[{"id":"a","text":"IaaS gives you raw infrastructure you manage yourself; PaaS manages the runtime so you only deploy code; SaaS is a finished application you simply use"},{"id":"b","text":"They are identical, just different marketing terms"},{"id":"c","text":"SaaS always requires you to manage your own servers"},{"id":"d","text":"IaaS only exists for storage, never for compute"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-cloud-opens-02-o1-c1', 'mission-atlas-the-cloud-opens-02-o1', 1, 'terminal_simulation', 'Read the region listing and submit the verification code.', '{"instructions":"Read /repo/infra/regions.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/regions.txt":{"type":"file","content":"region: atlas-us-east (existing, live since Act 1)\nregion: atlas-eu-west (new)\n  zone: eu-west-1a\n  zone: eu-west-1b\n# verification REGIONS-3312\n"}}}'::jsonb, '{"requiredFlag":"REGIONS-3312"}'::jsonb),

  ('mission-atlas-the-cloud-opens-03-o1-c1', 'mission-atlas-the-cloud-opens-03-o1', 1, 'terminal_simulation', 'Read the network definition and submit the verification code.', '{"instructions":"Read /repo/infra/network.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/network.txt":{"type":"file","content":"vpc: atlas-eu-west-vpc  cidr=10.40.0.0/16\nsubnets: eu-west-1a (10.40.1.0/24), eu-west-1b (10.40.2.0/24)\nstatus: available\n# verification NETWORK-6602\n"}}}'::jsonb, '{"requiredFlag":"NETWORK-6602"}'::jsonb),

  ('mission-atlas-the-cloud-opens-04-o1-c1', 'mission-atlas-the-cloud-opens-04-o1', 1, 'terminal_simulation', 'Read the compute inventory and submit the verification code.', '{"instructions":"Read /repo/infra/compute.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/compute.txt":{"type":"file","content":"instance: atlas-eu-west-collector-01  zone=eu-west-1a  status=running\ninstance: atlas-eu-west-collector-02  zone=eu-west-1b  status=running\n# verification COMPUTE-7714\n"}}}'::jsonb, '{"requiredFlag":"COMPUTE-7714"}'::jsonb),

  ('mission-atlas-the-cloud-opens-05-o1-c1', 'mission-atlas-the-cloud-opens-05-o1', 1, 'terminal_simulation', 'Read the block storage report and submit the verification code.', '{"instructions":"Read /repo/infra/block-storage.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/block-storage.txt":{"type":"file","content":"volume: atlas-eu-west-data-01  attached-to=atlas-eu-west-collector-01  size=50GB  status=in-use\nvolume: atlas-eu-west-data-02  attached-to=atlas-eu-west-collector-02  size=50GB  status=in-use\n# verification BLOCK-4471\n"}}}'::jsonb, '{"requiredFlag":"BLOCK-4471"}'::jsonb),

  ('mission-atlas-the-cloud-opens-06-o1-c1', 'mission-atlas-the-cloud-opens-06-o1', 1, 'terminal_simulation', 'Read the object storage report and submit the verification code.', '{"instructions":"Read /repo/infra/object-storage.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/object-storage.txt":{"type":"file","content":"bucket: atlas-eu-west-artifacts  region=atlas-eu-west  replication-of=atlas-us-east-artifacts  status=synced\n# verification OBJECT-8802\n"}}}'::jsonb, '{"requiredFlag":"OBJECT-8802"}'::jsonb),

  ('mission-atlas-the-cloud-opens-07-o1-c1', 'mission-atlas-the-cloud-opens-07-o1', 1, 'terminal_simulation', 'Read the managed database status and submit the verification code.', '{"instructions":"Read /repo/infra/database.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/database.txt":{"type":"file","content":"managed-db: atlas-eu-west-db-replica\nengine: postgres15\nrole: read-replica-of(atlas-us-east-db-primary)\nstatus: healthy, replication-lag=0.4s\n# verification DB-2291\n"}}}'::jsonb, '{"requiredFlag":"DB-2291"}'::jsonb),

  ('mission-atlas-the-cloud-opens-08-o1-c1', 'mission-atlas-the-cloud-opens-08-o1', 1, 'terminal_simulation', 'Read the load balancer configuration and submit the verification code.', '{"instructions":"Read /repo/infra/load-balancer.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/load-balancer.txt":{"type":"file","content":"load-balancer: atlas-global-lb\ntargets:\n  atlas-us-east-collector-01  weight=100\n  atlas-us-east-collector-02  weight=100\n(no atlas-eu-west targets are registered)\n# verification LB-5541\n"}}}'::jsonb, '{"requiredFlag":"LB-5541"}'::jsonb),

  ('mission-atlas-the-cloud-opens-09-o1-c1', 'mission-atlas-the-cloud-opens-09-o1', 1, 'terminal_simulation', 'Read the DNS records and submit the verification code.', '{"instructions":"Read /repo/infra/dns.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/dns.txt":{"type":"file","content":"A record: collector.atlas.internal -> atlas-us-east load balancer IP only\nno record routes any traffic toward atlas-eu-west\n# verification DNS-9012\n"}}}'::jsonb, '{"requiredFlag":"DNS-9012"}'::jsonb),

  ('mission-atlas-the-cloud-opens-10-o1-c1', 'mission-atlas-the-cloud-opens-10-o1', 1, 'terminal_simulation', 'Read the CDN configuration and submit the verification code.', '{"instructions":"Read /repo/infra/cdn.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/cdn.txt":{"type":"file","content":"cdn: atlas-edge\norigin: atlas-us-east load balancer only\neu-west edge locations exist and are healthy, but still pull exclusively from the us-east origin\n# verification CDN-3390\n"}}}'::jsonb, '{"requiredFlag":"CDN-3390"}'::jsonb),

  ('mission-atlas-the-cloud-opens-11-o1-c1', 'mission-atlas-the-cloud-opens-11-o1', 1, 'multiple_choice', 'Under the shared responsibility model, the cloud provider is responsible for...', '{"question":"Under the shared responsibility model, the cloud provider is responsible for...","options":[{"id":"a","text":"The infrastructure itself existing and staying available; the customer remains responsible for configuring how their own resources are actually used, such as routing traffic to them"},{"id":"b","text":"Every configuration decision the customer makes, including DNS and load balancer routing"},{"id":"c","text":"Nothing at all once a resource is provisioned"},{"id":"d","text":"Only physical security, with the customer responsible for hardware uptime too"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-cloud-opens-12-o1-c1', 'mission-atlas-the-cloud-opens-12-o1', 1, 'terminal_simulation', 'Read the compute inventory and submit the verification code.', '{"instructions":"Read /repo/infra/compute.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/compute.txt":{"type":"file","content":"instance: atlas-eu-west-collector-01  zone=eu-west-1a  status=running\ninstance: atlas-eu-west-collector-02  zone=eu-west-1b  status=running\n# verification COMPUTE-7714\n"}}}'::jsonb, '{"requiredFlag":"COMPUTE-7714"}'::jsonb),
  ('mission-atlas-the-cloud-opens-12-o2-c1', 'mission-atlas-the-cloud-opens-12-o2', 1, 'terminal_simulation', 'Read the DNS records and submit the verification code.', '{"instructions":"Read /repo/infra/dns.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/dns.txt":{"type":"file","content":"A record: collector.atlas.internal -> atlas-us-east load balancer IP only\nno record routes any traffic toward atlas-eu-west\n# verification DNS-9012\n"}}}'::jsonb, '{"requiredFlag":"DNS-9012"}'::jsonb),
  ('mission-atlas-the-cloud-opens-12-o3-c1', 'mission-atlas-the-cloud-opens-12-o3', 1, 'investigation', 'Which evidence explains why this region receives no traffic?', '{"evidence":[{"id":"e1","label":"DNS records","detail":"The only A record for the collector resolves to the atlas-us-east load balancer; nothing routes toward atlas-eu-west"},{"id":"e2","label":"Load balancer configuration","detail":"Only atlas-us-east instances are registered as targets; atlas-eu-west has no targets at all"},{"id":"e3","label":"Managed database status","detail":"The eu-west database replica is healthy with 0.4s replication lag"},{"id":"e4","label":"Object storage report","detail":"The eu-west artifact bucket is fully synced with us-east"}],"question":"Which evidence explains why this region receives no traffic?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-the-cloud-opens-12-o4-c1', 'mission-atlas-the-cloud-opens-12-o4', 1, 'boss_encounter', 'Having confirmed the region is healthy, that nothing routes traffic there, and whose responsibility that was, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-the-cloud-opens-12-o1","label":"Confirm the region is healthy"},{"objectiveRef":"mission-atlas-the-cloud-opens-12-o2","label":"Confirm nothing routes traffic there"},{"objectiveRef":"mission-atlas-the-cloud-opens-12-o3","label":"Identify whose responsibility this was"}],"task":"State the diagnosis in one sentence: the provider held up its entire side of the shared responsibility line -- every resource in atlas-eu-west is genuinely healthy -- but nobody on Atlas Division''s own side ever updated DNS or the load balancer to actually send traffic there, and a perfectly healthy region is not the same thing as a reachable one."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-the-cloud-opens-12-o1","mission-atlas-the-cloud-opens-12-o2","mission-atlas-the-cloud-opens-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-the-cloud-opens-01-o1-c1', 'orientation', 'Think about how much of the stack you manage yourself at each layer.', 10, 1),
  ('mission-atlas-the-cloud-opens-01-o1-c1', 'solution', 'IaaS is raw infrastructure you manage; PaaS manages the runtime; SaaS is a finished application.', 20, 2),

  ('mission-atlas-the-cloud-opens-02-o1-c1', 'orientation', 'Try: cat /repo/infra/regions.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-02-o1-c1', 'solution', 'atlas-eu-west is the new region, verification REGIONS-3312. submit REGIONS-3312', 20, 2),

  ('mission-atlas-the-cloud-opens-03-o1-c1', 'orientation', 'Try: cat /repo/infra/network.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-03-o1-c1', 'solution', 'The VPC is available, verification NETWORK-6602. submit NETWORK-6602', 20, 2),

  ('mission-atlas-the-cloud-opens-04-o1-c1', 'orientation', 'Try: cat /repo/infra/compute.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-04-o1-c1', 'solution', 'Both instances are running, verification COMPUTE-7714. submit COMPUTE-7714', 20, 2),

  ('mission-atlas-the-cloud-opens-05-o1-c1', 'orientation', 'Try: cat /repo/infra/block-storage.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-05-o1-c1', 'solution', 'Both volumes are in-use, verification BLOCK-4471. submit BLOCK-4471', 20, 2),

  ('mission-atlas-the-cloud-opens-06-o1-c1', 'orientation', 'Try: cat /repo/infra/object-storage.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-06-o1-c1', 'solution', 'The bucket is synced, verification OBJECT-8802. submit OBJECT-8802', 20, 2),

  ('mission-atlas-the-cloud-opens-07-o1-c1', 'orientation', 'Try: cat /repo/infra/database.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-07-o1-c1', 'solution', 'The replica is healthy, verification DB-2291. submit DB-2291', 20, 2),

  ('mission-atlas-the-cloud-opens-08-o1-c1', 'orientation', 'Try: cat /repo/infra/load-balancer.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-08-o1-c1', 'solution', 'No eu-west targets are registered, verification LB-5541. submit LB-5541', 20, 2),

  ('mission-atlas-the-cloud-opens-09-o1-c1', 'orientation', 'Try: cat /repo/infra/dns.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-09-o1-c1', 'solution', 'DNS only resolves to us-east, verification DNS-9012. submit DNS-9012', 20, 2),

  ('mission-atlas-the-cloud-opens-10-o1-c1', 'orientation', 'Try: cat /repo/infra/cdn.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-10-o1-c1', 'solution', 'The CDN origin is us-east only, verification CDN-3390. submit CDN-3390', 20, 2),

  ('mission-atlas-the-cloud-opens-11-o1-c1', 'orientation', 'Think about what the provider controls versus what only the customer configures.', 10, 1),
  ('mission-atlas-the-cloud-opens-11-o1-c1', 'solution', 'The provider keeps the infrastructure available; the customer configures how it is actually used.', 20, 2),

  ('mission-atlas-the-cloud-opens-12-o1-c1', 'orientation', 'Try: cat /repo/infra/compute.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-12-o1-c1', 'solution', 'verification COMPUTE-7714. submit COMPUTE-7714', 20, 2),
  ('mission-atlas-the-cloud-opens-12-o2-c1', 'orientation', 'Try: cat /repo/infra/dns.txt', 10, 1),
  ('mission-atlas-the-cloud-opens-12-o2-c1', 'solution', 'verification DNS-9012. submit DNS-9012', 20, 2),
  ('mission-atlas-the-cloud-opens-12-o3-c1', 'orientation', 'The database and storage are both healthy and irrelevant to this specific gap. Look for what was never configured to route anything here.', 10, 1),
  ('mission-atlas-the-cloud-opens-12-o3-c1', 'solution', 'e1 and e2: neither DNS nor the load balancer were ever configured to send traffic to this region.', 20, 2),
  ('mission-atlas-the-cloud-opens-12-o4-c1', 'orientation', 'Combine the healthy region, the missing routing, and whose job that was into one sentence.', 15, 1),
  ('mission-atlas-the-cloud-opens-12-o4-c1', 'solution', 'The provider held up its side completely -- every resource is healthy -- but nobody on Atlas Division''s own side ever updated DNS or the load balancer, and a healthy region is not the same thing as a reachable one.', 25, 2);
