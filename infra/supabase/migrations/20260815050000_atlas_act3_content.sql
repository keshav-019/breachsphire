-- Atlas Division pathway ("The Silence") Act 3 -- "Servers" content,
-- under world-atlas-servers (already inserted separately). 1 campaign, 2
-- operations, 12 missions (11 lessons + boss), closing World I "The
-- Basement" (Acts 1-3). Continues mixing conceptual challenge types
-- (bare metal vs VMs, virtualization, cloud VMs are architectural
-- concepts, not commands) with terminal_simulation wherever the engine
-- genuinely supports it -- confirmed via source read before writing:
-- `dpkg -l` lists a seedable `packages` array; `ps` lists a seedable
-- `processes` array (multiple entries pinned at high CPU/mem is how
-- saturation/pressure is represented, since `free`/`df` remain hardcoded
-- and unusable, same constraint as Act 1); `du` + file content remains
-- the only dynamic disk-inspection path; machine images, bootstrap
-- scripts and service accounts are all taught via the established
-- "read a seeded config file" trick.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-servers', 'world-atlas-servers', 'servers', '1C - Servers', 'Learn the vocabulary of production hosts -- bare metal versus VMs, virtualization, cloud VMs, machine images, bootstrapping, packages, service accounts, disks and volumes -- while Imani Cross diagnoses a metrics collector dying under its first real load.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-servers-1', 'campaign-atlas-servers', 'what-a-host-actually-is', 'What a Host Actually Is', 'Bare metal versus VMs, virtualization, cloud VMs, machine images and bootstrapping.', 1),
  ('operation-atlas-servers-2', 'campaign-atlas-servers', 'a-host-under-pressure', 'A Host Under Pressure', 'Packages, service accounts, disks and volumes, and CPU, memory and disk pressure.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-servers-01', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-1', 'bare-metal-vs-vms', 'Bare Metal vs VMs', 'With the firewall rule corrected, traffic finally reaches the metrics collector -- and the collector itself starts dying. Imani Cross, SRE, takes over from here.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"bare-metal-vs-vms-sim"}'::jsonb, '{"xp":190,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-servers-02', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-1', 'virtualization', 'Virtualization', 'A hypervisor lets one physical machine pretend to be several, each one isolated from the others sharing the same hardware underneath.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-servers-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"virtualization-sim"}'::jsonb, '{"xp":190,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-servers-03', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-1', 'cloud-vms', 'Cloud VMs', 'A cloud VM is not just a virtual machine somewhere else. It is provisioned, resized and destroyed through an API, on demand, in a way a traditional VM was never designed to be.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-servers-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"cloud-vms-sim"}'::jsonb, '{"xp":200,"credits":35}'::jsonb, false, 3),
  ('mission-atlas-servers-04', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-1', 'machine-images', 'Machine Images', 'Every VM starts life as a copy of a machine image -- and whatever that image was built for is exactly what the VM will assume it can handle, whether that is true or not.', 'beginner', ARRAY['cross','byte'], '{"requiredMissionIds":["mission-atlas-servers-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"machine-images-sim"}'::jsonb, '{"xp":200,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-servers-05', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-1', 'bootstrapping', 'Bootstrapping', 'A fresh VM does not arrive ready to work. Something has to run on first boot to actually turn a blank image into the specific host it is supposed to be.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-servers-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"bootstrapping-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-servers-06', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-2', 'packages', 'Packages', 'The collector is running an agent version months out of date. Whether that is the actual problem or just a symptom is still an open question.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-servers-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"packages-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 6),
  ('mission-atlas-servers-07', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-2', 'service-accounts', 'Service Accounts', 'A service should never run as more than it needs to. Confirm what account the collector process is actually running under before assuming anything else about it.', 'beginner', ARRAY['cross','leena'], '{"requiredMissionIds":["mission-atlas-servers-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"service-accounts-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 7),
  ('mission-atlas-servers-08', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-2', 'disks-and-volumes', 'Disks and Volumes', 'An ephemeral volume disappears the moment the VM does. A persistent one does not -- and confusing the two is how data quietly stops existing.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-servers-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"disks-volumes-sim"}'::jsonb, '{"xp":220,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-servers-09', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-2', 'cpu-saturation', 'CPU Saturation', 'One busy process is normal. Several processes all pinned near the ceiling at once is not one incident -- it is saturation.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-servers-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"cpu-saturation-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-servers-10', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-2', 'memory-pressure', 'Memory Pressure', 'A host does not have to run out of memory to already be in trouble. Getting close to the limit changes behavior long before anything actually fails.', 'beginner', ARRAY['cross','byte'], '{"requiredMissionIds":["mission-atlas-servers-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"memory-pressure-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 10),
  ('mission-atlas-servers-11', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-2', 'disk-pressure', 'Disk Pressure', 'This is not the first time an unrotated log quietly filled a disk. It will not be the last, unless someone starts watching for the pattern instead of the individual incidents.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-servers-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"disk-pressure-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 11),
  ('mission-atlas-servers-12', 'world-atlas-servers', 'campaign-atlas-servers', 'operation-atlas-servers-2', 'the-dying-host', 'The Dying Host', 'Everything this Act taught, turned on one collector: not to patch around it, to finally explain why CPU, memory and disk all failed at once, on the very first day it mattered.', 'boss', ARRAY['cross','leena','byte'], '{"requiredMissionIds":["mission-atlas-servers-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"dying-host-boss-sim"}'::jsonb, '{"xp":460,"credits":100,"badgeIds":["the-dying-host"],"skillXp":{"cloud_devops_fundamentals":70}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-servers-01', 1, 'leena', 'The firewall rule is fixed. Traffic is reaching the metrics collector for the first time since it was racked. And now the collector itself is dying -- CPU pinned, memory climbing, disk filling.'),
  ('mission-atlas-servers-01', 2, 'cross', 'Imani Cross, SRE. This is not a networking problem anymore, and it is not really an application problem either. This is a host that has never had to survive real load before, doing exactly that for the first time.'),
  ('mission-atlas-servers-01', 3, 'cross', 'Bare metal is a physical machine, dedicated, nothing shared. A VM shares that same physical machine with others, isolated by software instead of a wall. Different failure modes, different assumptions -- know which one you are looking at before you diagnose anything.'),

  ('mission-atlas-servers-02', 1, 'cross', 'A hypervisor is what makes virtualization possible -- it partitions one physical machine''s CPU, memory and I/O among several isolated guest VMs, each believing it has the hardware to itself.'),

  ('mission-atlas-servers-03', 1, 'cross', 'A cloud VM is not just "a VM, but somewhere else." It is provisioned, resized and destroyed through an API on demand -- which also means it can be under-provisioned through that exact same API, by mistake, just as easily.'),

  ('mission-atlas-servers-04', 1, 'cross', 'Every VM is born from a machine image -- a frozen snapshot of an OS, packages and configuration. Whatever that image was sized and built for is exactly what the VM assumes it can do, correct or not.'),
  ('mission-atlas-servers-04', 2, 'byte', 'I pulled this host''s image manifest. It says exactly what it was built for. Nobody has read it since it was deployed.'),

  ('mission-atlas-servers-05', 1, 'cross', 'A blank image is not a working host. Something runs on first boot -- a bootstrap script -- installing packages, enabling services, turning a generic image into this specific collector.'),

  ('mission-atlas-servers-06', 1, 'cross', 'Packages are the installed software making up everything a host actually does. An outdated one is not automatically the problem, but it is always worth confirming before ruling it out.'),

  ('mission-atlas-servers-07', 1, 'cross', 'A service account should run with exactly the privilege it needs and nothing more. Confirm what this process actually runs as before assuming it is either fine or a problem.'),
  ('mission-atlas-servers-07', 2, 'leena', 'Least privilege is not paperwork. It is the difference between one process misbehaving and one process being able to misbehave everywhere.'),

  ('mission-atlas-servers-08', 1, 'cross', 'An ephemeral volume lives and dies with the VM itself -- reboot it, and whatever was on that volume is gone. A persistent volume survives independently. Mixing up which is which is how data quietly stops existing.'),

  ('mission-atlas-servers-09', 1, 'cross', 'One process pinned at high CPU is a busy process. Several processes all pinned near the ceiling at the same time is not one incident. That is saturation -- the host genuinely does not have enough CPU for what is being asked of it.'),

  ('mission-atlas-servers-10', 1, 'cross', 'Memory pressure is not the same thing as running out of memory. A host under pressure is already changing behavior -- slower allocation, more aggressive reclaiming -- long before anything actually fails outright.'),

  ('mission-atlas-servers-11', 1, 'cross', 'An unrotated log filling a disk is not a new failure mode. Atlas Division has seen this exact pattern before. Recognizing the pattern matters more than solving this one incident.'),

  ('mission-atlas-servers-12', 1, 'cross', 'Everything this Act taught you, on one collector. Not to patch around it. To finally explain why CPU, memory and disk all failed at once, on the very first day it actually mattered.'),
  ('mission-atlas-servers-12', 2, 'byte', 'I have live process data, a memory pressure log and a disk growth pattern all pulled up. None of them look like an attack. All three are happening at exactly the same time.'),
  ('mission-atlas-servers-12', 3, 'cross', 'Three symptoms at once is not three separate problems. Find what they all actually have in common.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-servers-01-o1', 'mission-atlas-servers-01', 1, 'Tell bare metal from a VM', 'Choose the accurate distinction between bare metal and a virtual machine.'),

  ('mission-atlas-servers-02-o1', 'mission-atlas-servers-02', 1, 'Define a hypervisor', 'Choose the accurate definition of a hypervisor.'),

  ('mission-atlas-servers-03-o1', 'mission-atlas-servers-03', 1, 'Explain what makes a VM a cloud VM', 'Choose the accurate description of what distinguishes a cloud VM from a traditional one.'),

  ('mission-atlas-servers-04-o1', 'mission-atlas-servers-04', 1, 'Read the machine image manifest', 'Read the collector''s machine image manifest and submit its verification code.'),

  ('mission-atlas-servers-05-o1', 'mission-atlas-servers-05', 1, 'Read the bootstrap script', 'Read the collector''s bootstrap script and submit its verification code.'),

  ('mission-atlas-servers-06-o1', 'mission-atlas-servers-06', 1, 'Find the outdated package', 'List installed packages and submit the outdated agent version.'),

  ('mission-atlas-servers-07-o1', 'mission-atlas-servers-07', 1, 'Confirm the service account', 'Read the service account configuration and submit its verification code.'),

  ('mission-atlas-servers-08-o1', 'mission-atlas-servers-08', 1, 'Tell ephemeral from persistent', 'Choose the accurate distinction between an ephemeral volume and a persistent volume.'),

  ('mission-atlas-servers-09-o1', 'mission-atlas-servers-09', 1, 'Confirm CPU saturation', 'List the collector''s processes and submit how many are simultaneously pinned above 90% CPU.'),

  ('mission-atlas-servers-10-o1', 'mission-atlas-servers-10', 1, 'Confirm memory pressure', 'Read the journal and submit the memory pressure code.'),

  ('mission-atlas-servers-11-o1', 'mission-atlas-servers-11', 1, 'Find the growing file', 'Use disk usage inspection to find the growing file and submit its resource code.'),

  ('mission-atlas-servers-12-o1', 'mission-atlas-servers-12', 1, 'Confirm CPU saturation', 'List the processes on the collector and submit how many worker processes are saturating CPU right now.'),
  ('mission-atlas-servers-12-o2', 'mission-atlas-servers-12', 2, 'Confirm memory pressure', 'Read the journal and submit the current memory pressure code.'),
  ('mission-atlas-servers-12-o3', 'mission-atlas-servers-12', 3, 'Identify the root cause', 'Find the evidence that explains why this host cannot handle its current load.'),
  ('mission-atlas-servers-12-o4', 'mission-atlas-servers-12', 4, 'State the diagnosis', 'Having confirmed all three, explain why CPU, memory and disk pressure are all happening at once.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-servers-01-o1-c1', 'mission-atlas-servers-01-o1', 1, 'multiple_choice', 'Bare metal and a virtual machine differ in that...', '{"question":"Bare metal and a virtual machine differ in that...","options":[{"id":"a","text":"Bare metal is a dedicated physical machine with nothing shared; a VM shares that same physical hardware with other isolated guests"},{"id":"b","text":"They are identical, just different names"},{"id":"c","text":"A VM is always faster than bare metal"},{"id":"d","text":"Bare metal only exists in the cloud"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-servers-02-o1-c1', 'mission-atlas-servers-02-o1', 1, 'multiple_choice', 'A hypervisor is best described as...', '{"question":"A hypervisor is best described as...","options":[{"id":"a","text":"Software that partitions one physical machine''s CPU, memory and I/O among several isolated guest VMs"},{"id":"b","text":"A synonym for a container"},{"id":"c","text":"A type of network firewall"},{"id":"d","text":"A monitoring dashboard"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-servers-03-o1-c1', 'mission-atlas-servers-03-o1', 1, 'multiple_choice', 'What actually distinguishes a cloud VM from a traditional VM?', '{"question":"What actually distinguishes a cloud VM from a traditional VM?","options":[{"id":"a","text":"It is provisioned, resized and destroyed through an API on demand, rather than manually configured once"},{"id":"b","text":"Cloud VMs cannot run Linux"},{"id":"c","text":"Cloud VMs never have a hypervisor underneath them"},{"id":"d","text":"There is no real difference"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-servers-04-o1-c1', 'mission-atlas-servers-04-o1', 1, 'terminal_simulation', 'Read the collector''s machine image manifest and submit its verification code.', '{"instructions":"Read /etc/atlas/image-manifest.txt and submit the verification code with: submit CODE","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"},"/etc/atlas/image-manifest.txt":{"type":"file","content":"image=atlas-base-v12\ntier=test-minimal\ncpu_limit=1\nmemory_limit_mb=512\nbuilt=2026-07-02\n# verification IMG-2210\n"}}}'::jsonb, '{"requiredFlag":"IMG-2210"}'::jsonb),

  ('mission-atlas-servers-05-o1-c1', 'mission-atlas-servers-05-o1', 1, 'terminal_simulation', 'Read the collector''s bootstrap script and submit its verification code.', '{"instructions":"Read /etc/atlas/bootstrap.sh and submit the verification code with: submit CODE","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"},"/etc/atlas/bootstrap.sh":{"type":"file","content":"#!/bin/bash\napt-get install -y atlas-metrics-agent\nsystemctl enable atlas-metrics-agent\n# verification BOOT-6650\n"}}}'::jsonb, '{"requiredFlag":"BOOT-6650"}'::jsonb),

  ('mission-atlas-servers-06-o1-c1', 'mission-atlas-servers-06-o1', 1, 'terminal_simulation', 'List the installed packages and submit the outdated agent version.', '{"instructions":"List installed packages with dpkg -l and submit the atlas-metrics-agent version with: submit VERSION","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"}},"packages":[{"name":"atlas-metrics-agent","version":"2.1.0"},{"name":"openssl","version":"3.0.2"},{"name":"curl","version":"8.4.0"}]}'::jsonb, '{"requiredFlag":"2.1.0"}'::jsonb),

  ('mission-atlas-servers-07-o1-c1', 'mission-atlas-servers-07-o1', 1, 'terminal_simulation', 'Read the service account configuration and submit its verification code.', '{"instructions":"Read /etc/atlas/service-accounts.conf and submit the verification code with: submit CODE","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"},"/etc/atlas/service-accounts.conf":{"type":"file","content":"svc-metrics-collector: uid=2001 shell=/usr/sbin/nologin groups=atlas-metrics\n# verification SVC-8814\n"}}}'::jsonb, '{"requiredFlag":"SVC-8814"}'::jsonb),

  ('mission-atlas-servers-08-o1-c1', 'mission-atlas-servers-08-o1', 1, 'multiple_choice', 'An ephemeral volume and a persistent volume differ in that...', '{"question":"An ephemeral volume and a persistent volume differ in that...","options":[{"id":"a","text":"An ephemeral volume disappears when the VM does; a persistent volume survives independently of any one VM"},{"id":"b","text":"They are identical, just different names"},{"id":"c","text":"Persistent volumes are always slower"},{"id":"d","text":"Ephemeral volumes can only store logs"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-servers-09-o1-c1', 'mission-atlas-servers-09-o1', 1, 'terminal_simulation', 'List the collector''s processes and submit how many are pinned above 90% CPU.', '{"instructions":"List processes and count how many are pinned above 90% CPU right now. Submit the count with: submit COUNT","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"}},"processes":[{"pid":1,"user":"root","cmd":"/sbin/init","cpu":0.0,"mem":0.1},{"pid":2210,"user":"svc-metrics","cmd":"/usr/bin/atlas-metrics-agent --workers 32","cpu":97.4,"mem":41.2},{"pid":2288,"user":"svc-metrics","cmd":"/usr/bin/atlas-metrics-agent --workers 32","cpu":95.8,"mem":39.7}]}'::jsonb, '{"requiredFlag":"2"}'::jsonb),

  ('mission-atlas-servers-10-o1-c1', 'mission-atlas-servers-10-o1', 1, 'terminal_simulation', 'Read the journal and submit the memory pressure code.', '{"instructions":"Query the journal for atlas-metrics-agent and submit the memory pressure code with: submit CODE","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"}},"journal":[{"timestamp":"2026-08-15T09:12:04","unit":"atlas-metrics-agent","message":"memory pressure high: 91% of 512MB limit in use, approaching OOM threshold, code MEM-3391"}]}'::jsonb, '{"requiredFlag":"MEM-3391"}'::jsonb),

  ('mission-atlas-servers-11-o1-c1', 'mission-atlas-servers-11-o1', 1, 'terminal_simulation', 'Use disk usage inspection to find the growing file and submit its resource code.', '{"instructions":"Use du under /var/log/atlas-metrics to find the largest file, then read it and submit the resource code with: submit CODE","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"},"/var/log/atlas-metrics/agent.log":{"type":"file","content":"agent started ok\n"},"/var/log/atlas-metrics/debug.log":{"type":"file","content":"debug entry 0001\ndebug entry 0002\ndebug entry 0003\ndebug entry 0004\ndebug entry 0005\ndebug entry 0006\ndebug entry 0007\ndebug entry 0008\ndebug entry 0009\ndebug entry 0010\ndebug entry 0011\nRESOURCE-CODE=DISK-7729\n"}}}'::jsonb, '{"requiredFlag":"DISK-7729"}'::jsonb),

  ('mission-atlas-servers-12-o1-c1', 'mission-atlas-servers-12-o1', 1, 'terminal_simulation', 'List the collector''s live processes and submit how many worker processes are saturating CPU right now.', '{"instructions":"List processes and count how many worker processes are simultaneously pinned above 90% CPU. Submit the count with: submit COUNT","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"}},"processes":[{"pid":3001,"user":"svc-metrics","cmd":"/usr/bin/atlas-metrics-agent --workers 32","cpu":98.9,"mem":44.0},{"pid":3002,"user":"svc-metrics","cmd":"/usr/bin/atlas-metrics-agent --workers 32","cpu":97.1,"mem":43.5},{"pid":3003,"user":"svc-metrics","cmd":"/usr/bin/atlas-metrics-agent --workers 32","cpu":96.4,"mem":42.9}]}'::jsonb, '{"requiredFlag":"3"}'::jsonb),
  ('mission-atlas-servers-12-o2-c1', 'mission-atlas-servers-12-o2', 1, 'terminal_simulation', 'Read the journal and submit the current memory pressure code.', '{"instructions":"Query the journal and submit the current memory pressure code with: submit CODE","hostname":"metrics-collector-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"metrics-collector-01\n"},"/home/recruit":{"type":"dir"}},"journal":[{"timestamp":"2026-08-15T09:20:41","unit":"atlas-metrics-agent","message":"memory pressure critical: 96% of 512MB limit in use, code MEM-9012"}]}'::jsonb, '{"requiredFlag":"MEM-9012"}'::jsonb),
  ('mission-atlas-servers-12-o3-c1', 'mission-atlas-servers-12-o3', 1, 'investigation', 'Which evidence explains why this host cannot handle its current load?', '{"evidence":[{"id":"e1","label":"Process telemetry","detail":"Three worker processes are simultaneously pinned above 90% CPU"},{"id":"e2","label":"Machine image manifest","detail":"The collector was built from a test-minimal tier image: 1 CPU, 512MB memory, never resized since built 2026-07-02"},{"id":"e3","label":"Network status","detail":"The firewall rule permitting traffic to this host was corrected in Act 2 and is functioning normally"},{"id":"e4","label":"Package list","detail":"All installed packages report normal, unremarkable versions"}],"question":"Which evidence explains why this host cannot handle its current load?"}'::jsonb, '{"requiredEvidenceIds":["e2"]}'::jsonb),
  ('mission-atlas-servers-12-o4-c1', 'mission-atlas-servers-12-o4', 1, 'boss_encounter', 'Having confirmed CPU saturation, memory pressure, and the root cause, explain why all three are happening at once.', '{"stages":[{"objectiveRef":"mission-atlas-servers-12-o1","label":"Confirm CPU saturation"},{"objectiveRef":"mission-atlas-servers-12-o2","label":"Confirm memory pressure"},{"objectiveRef":"mission-atlas-servers-12-o3","label":"Identify the root cause"}],"task":"State the diagnosis in one sentence: the collector was never attacked and never broke on its own -- it was built from a test-tier machine image, one CPU, 512 megabytes of memory, and nobody resized it before real production traffic finally reached it. Every resource pressure happening at once is the same undersized host meeting real load for the first time."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-servers-12-o1","mission-atlas-servers-12-o2","mission-atlas-servers-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-servers-01-o1-c1', 'orientation', 'Think about what is dedicated versus what is shared.', 10, 1),
  ('mission-atlas-servers-01-o1-c1', 'solution', 'Bare metal is dedicated physical hardware; a VM shares that hardware with other isolated guests.', 20, 2),

  ('mission-atlas-servers-02-o1-c1', 'orientation', 'It is the layer that makes several guests believe they each have the machine to themselves.', 10, 1),
  ('mission-atlas-servers-02-o1-c1', 'solution', 'A hypervisor partitions one machine''s resources among several isolated guest VMs.', 20, 2),

  ('mission-atlas-servers-03-o1-c1', 'orientation', 'Think about how the VM comes into existence and how it goes away.', 10, 1),
  ('mission-atlas-servers-03-o1-c1', 'solution', 'It is provisioned, resized and destroyed through an API on demand.', 20, 2),

  ('mission-atlas-servers-04-o1-c1', 'orientation', 'Try: cat /etc/atlas/image-manifest.txt', 10, 1),
  ('mission-atlas-servers-04-o1-c1', 'solution', 'The manifest ends with verification IMG-2210. submit IMG-2210', 20, 2),

  ('mission-atlas-servers-05-o1-c1', 'orientation', 'Try: cat /etc/atlas/bootstrap.sh', 10, 1),
  ('mission-atlas-servers-05-o1-c1', 'solution', 'The script ends with verification BOOT-6650. submit BOOT-6650', 20, 2),

  ('mission-atlas-servers-06-o1-c1', 'orientation', 'Try: dpkg -l', 10, 1),
  ('mission-atlas-servers-06-o1-c1', 'solution', 'atlas-metrics-agent is at version 2.1.0. submit 2.1.0', 20, 2),

  ('mission-atlas-servers-07-o1-c1', 'orientation', 'Try: cat /etc/atlas/service-accounts.conf', 10, 1),
  ('mission-atlas-servers-07-o1-c1', 'solution', 'The file ends with verification SVC-8814. submit SVC-8814', 20, 2),

  ('mission-atlas-servers-08-o1-c1', 'orientation', 'Ask what happens to each kind of volume when the VM itself is destroyed.', 10, 1),
  ('mission-atlas-servers-08-o1-c1', 'solution', 'Ephemeral disappears with the VM; persistent survives independently.', 20, 2),

  ('mission-atlas-servers-09-o1-c1', 'orientation', 'Try: ps -- count entries with cpu above 90.', 10, 1),
  ('mission-atlas-servers-09-o1-c1', 'solution', 'Two worker processes (pid 2210, 2288) are both above 90% CPU. submit 2', 20, 2),

  ('mission-atlas-servers-10-o1-c1', 'orientation', 'Try: journalctl -u atlas-metrics-agent', 10, 1),
  ('mission-atlas-servers-10-o1-c1', 'solution', 'The entry reads code MEM-3391. submit MEM-3391', 20, 2),

  ('mission-atlas-servers-11-o1-c1', 'orientation', 'Try: du /var/log/atlas-metrics/debug.log, then cat it.', 10, 1),
  ('mission-atlas-servers-11-o1-c1', 'solution', 'The file ends with RESOURCE-CODE=DISK-7729. submit DISK-7729', 20, 2),

  ('mission-atlas-servers-12-o1-c1', 'orientation', 'Try: ps -- count entries with cpu above 90 right now.', 10, 1),
  ('mission-atlas-servers-12-o1-c1', 'solution', 'Three worker processes are all above 90% CPU. submit 3', 20, 2),
  ('mission-atlas-servers-12-o2-c1', 'orientation', 'Try: journalctl -u atlas-metrics-agent', 10, 1),
  ('mission-atlas-servers-12-o2-c1', 'solution', 'The current entry reads code MEM-9012. submit MEM-9012', 20, 2),
  ('mission-atlas-servers-12-o3-c1', 'orientation', 'The symptoms are not the cause -- look for what explains all three at once.', 10, 1),
  ('mission-atlas-servers-12-o3-c1', 'solution', 'e2: the test-minimal image manifest -- 1 CPU, 512MB, never resized -- explains why this host cannot handle real load.', 20, 2),
  ('mission-atlas-servers-12-o4-c1', 'orientation', 'Combine the saturation, the pressure, and the image sizing into one sentence.', 15, 1),
  ('mission-atlas-servers-12-o4-c1', 'solution', 'The collector was built from a test-tier image and never resized before real production traffic reached it -- CPU, memory and disk pressure are all the same undersized host meeting real load for the first time.', 25, 2);
