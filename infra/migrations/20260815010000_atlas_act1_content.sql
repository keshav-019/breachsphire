-- Atlas Division pathway ("The Silence") Act 1 -- "The Last Green Light"
-- content, under world-atlas-the-last-green-light (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), following the same campaigns -> operations -> missions ->
-- dialogue -> objectives -> challenges -> hints pattern as every other
-- pathway's Act 1.
--
-- Unlike every other pathway's Act 1, this one reuses Cyber Guardians'
-- existing terminal_simulation engine (apps/web/src/lib/terminal/) for
-- every hands-on Linux mission, rather than dressing quiz-style
-- challenges in narrative flavor -- this Act's topics (processes,
-- permissions, filesystem hierarchy, signals, systemd, journald, SSH,
-- shell automation, resource inspection) are exactly the domain that
-- engine was purpose-built for, so no new engineering was needed, only
-- more content data. Confirmed engine constraints respected: `df`/`free`
-- are hardcoded and cannot be seeded (resource inspection instead uses
-- `du` + file content, which IS dynamic); `ssh` has no interactive verb
-- (simulated as a static ~/.ssh/config file to read, same trick as
-- Cyber Guardians' World 12); `kill` has no signal-type distinction
-- (SIGTERM vs SIGKILL taught conceptually via multiple_choice alongside
-- the hands-on kill). Every terminal mission runs on the same host,
-- nexus-infra-19 -- the "last green light" -- so mission 3's runaway
-- process, mission 8's expired certificate and mission 11's disk growth
-- become the three causes the boss mission synthesizes.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-the-last-green-light', 'world-atlas-the-last-green-light', 'the-last-green-light', '1A - The Last Green Light', 'Learn the Linux fundamentals underneath every other Nexus system -- processes, permissions, the filesystem hierarchy, signals, systemd, journald, SSH and shell automation -- while Atlas Division tries to understand the one host still reporting green.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-the-last-green-light-1', 'campaign-atlas-the-last-green-light', 'the-machine-underneath', 'The Machine Underneath', 'Infrastructure mental model, processes and services, permissions, the filesystem hierarchy, and signals.', 1),
  ('operation-atlas-the-last-green-light-2', 'campaign-atlas-the-last-green-light', 'reading-a-host', 'Reading a Host', 'systemd, journald, SSH, shell automation and resource inspection.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-the-last-green-light-01', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-1', 'enter-atlas-command', 'Enter Atlas Command', 'At 03:17 Nexus Standard Time, every dashboard Byte relies on goes dark within the same minute. Commander Leena Rao pulls the player into Atlas Division to find the last host still reporting green before it goes dark too.', 'intro', ARRAY['leena','byte'], null, null, '{"type":"simulation","simulationId":"enter-atlas-command-sim"}'::jsonb, '{"xp":50,"credits":10}'::jsonb, false, 1),
  ('mission-atlas-the-last-green-light-02', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-1', 'infrastructure-mental-model', 'Infrastructure Mental Model', 'Atlas Division does not own the applications Nexus runs. It owns everything underneath them -- and tonight, everything underneath them is the problem.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"infrastructure-mental-model-sim"}'::jsonb, '{"xp":70,"credits":15}'::jsonb, false, 2),
  ('mission-atlas-the-last-green-light-03', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-1', 'processes-and-services', 'Processes and Services', 'The last green host is still up, but something on it is running hot. Before anything else, find out what is actually using its CPU right now.', 'beginner', ARRAY['leena','byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"processes-and-services-sim"}'::jsonb, '{"xp":80,"credits":15}'::jsonb, false, 3),
  ('mission-atlas-the-last-green-light-04', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-1', 'users-groups-and-permissions', 'Users, Groups and Permissions', 'A legitimate registry config on the host cannot be read by anything, including the service that owns it. Somewhere along the way its permissions were set wrong.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"users-groups-permissions-sim"}'::jsonb, '{"xp":80,"credits":20}'::jsonb, false, 4),
  ('mission-atlas-the-last-green-light-05', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-1', 'filesystem-hierarchy', 'Filesystem Hierarchy', 'Linux does not scatter files at random. Logs, configs and binaries each have a correct home -- and knowing that home is the fastest way to find anything on a host you have never touched before.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"filesystem-hierarchy-sim"}'::jsonb, '{"xp":90,"credits":20}'::jsonb, false, 5),
  ('mission-atlas-the-last-green-light-06', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-1', 'signals', 'Signals', 'Killing a process is not one action. Asking it to stop and forcing it to stop are different requests, with different consequences for whatever it was in the middle of doing.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"signals-sim"}'::jsonb, '{"xp":90,"credits":20}'::jsonb, false, 6),
  ('mission-atlas-the-last-green-light-07', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-2', 'systemd', 'systemd', 'A service the host depends on is not running, and nothing restarted it automatically. Bring it back the correct way, not by hand every time.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"systemd-sim"}'::jsonb, '{"xp":100,"credits":20}'::jsonb, false, 7),
  ('mission-atlas-the-last-green-light-08', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-2', 'journald', 'journald', 'A service failed hours ago and nobody noticed. Its own logs already say exactly why -- if anyone actually reads them.', 'beginner', ARRAY['leena','byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"journald-sim"}'::jsonb, '{"xp":100,"credits":25}'::jsonb, false, 8),
  ('mission-atlas-the-last-green-light-09', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-2', 'ssh', 'SSH', 'Remote access to this host was configured once, correctly, by someone who is not here anymore. Understanding how it works starts with reading what they left behind.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"ssh-sim"}'::jsonb, '{"xp":110,"credits":25}'::jsonb, false, 9),
  ('mission-atlas-the-last-green-light-10', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-2', 'shell-automation', 'Shell Automation', 'Reading a log by eye does not scale past a few lines. Reading it with a pipeline does.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"shell-automation-sim"}'::jsonb, '{"xp":110,"credits":25}'::jsonb, false, 10),
  ('mission-atlas-the-last-green-light-11', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-2', 'resource-inspection', 'Resource Inspection', 'Something on this host has been quietly growing for weeks. Nobody will notice a slow leak until the moment it stops being slow.', 'beginner', ARRAY['leena','byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"resource-inspection-sim"}'::jsonb, '{"xp":120,"credits":25}'::jsonb, false, 11),
  ('mission-atlas-the-last-green-light-12', 'world-atlas-the-last-green-light', 'campaign-atlas-the-last-green-light', 'operation-atlas-the-last-green-light-2', 'the-last-green-light', 'The Last Green Light', 'Everything this Act taught, turned on the one host still standing: not to blame it, to finally explain why every other system went dark within the same sixty seconds.', 'boss', ARRAY['leena','byte'], '{"requiredMissionIds":["mission-atlas-the-last-green-light-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"last-green-light-boss-sim"}'::jsonb, '{"xp":380,"credits":80,"badgeIds":["the-last-green-light"],"skillXp":{"cloud_devops_fundamentals":50}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-the-last-green-light-01', 1, 'leena', 'At 03:17 Nexus Standard Time, every dashboard Byte relies on went dark within the same sixty seconds. Telemetry. CI runners. Registries. DNS. All of it, at once.'),
  ('mission-atlas-the-last-green-light-01', 2, 'byte', 'I can still think. I can no longer see. That is the entire problem in one sentence.'),
  ('mission-atlas-the-last-green-light-01', 3, 'leena', 'Commander Leena Rao, Atlas Division. We do not build the applications Nexus runs. We keep the infrastructure underneath all of them alive, and most of it just stopped reporting.'),
  ('mission-atlas-the-last-green-light-01', 4, 'leena', 'One host is still reporting green. Before we do anything else, you are going to understand that host completely. Not guess. Understand.'),

  ('mission-atlas-the-last-green-light-02', 1, 'leena', 'An application is what a user sees. Infrastructure is everything underneath that has to be true first -- the host, its processes, its permissions, its network, its storage. Tonight, the failure is entirely down here.'),

  ('mission-atlas-the-last-green-light-03', 1, 'byte', 'This host, nexus-infra-19, is still green, but something on it is not behaving normally. Before we trust anything else it reports, we need to know what is actually running.'),
  ('mission-atlas-the-last-green-light-03', 2, 'leena', 'A process is one running instance of a program. A service is a process systemd is supposed to be managing on your behalf. Not the same thing, and tonight the difference matters.'),

  ('mission-atlas-the-last-green-light-04', 1, 'byte', 'The registry config on this host has a verification code we need, and nothing -- not even the service that owns it -- can currently read the file. Someone changed its permissions and never changed them back.'),

  ('mission-atlas-the-last-green-light-05', 1, 'byte', 'Configuration lives in /etc. Logs live in /var/log. Installed extras live in /opt. Nobody has to guess where something is on a Linux host if they actually know the layout.'),

  ('mission-atlas-the-last-green-light-06', 1, 'leena', 'Asking a process to stop and forcing it to stop are different requests. One gives it a chance to save its state and clean up. The other does not, ever, no matter what it was doing.'),

  ('mission-atlas-the-last-green-light-07', 1, 'byte', 'A service that crashes and stays down did not fail quietly by accident. systemd is supposed to be watching it. Find out why it is not being restarted, then bring it back the correct way.'),

  ('mission-atlas-the-last-green-light-08', 1, 'leena', 'Every service that fails writes down why, in its own words, before anyone ever asks. journald is where that record lives. Nobody has been reading it tonight.'),

  ('mission-atlas-the-last-green-light-09', 1, 'byte', 'Nobody currently at Atlas Division configured remote access to this host. Someone did, once, and left a trail of exactly how it works.'),

  ('mission-atlas-the-last-green-light-10', 1, 'byte', 'This host has thousands of log lines from tonight alone. Reading them one at a time is not a strategy. A single pipeline can answer in seconds what would take an hour by eye.'),

  ('mission-atlas-the-last-green-light-11', 1, 'leena', 'Nothing on this host crashed loudly tonight. If something is wrong, it has probably been wrong quietly, for weeks, and only now become impossible to ignore.'),

  ('mission-atlas-the-last-green-light-12', 1, 'leena', 'Every lesson tonight, on the one host that never went dark. Not to fix it. To finally explain why everything else did, in the same sixty seconds.'),
  ('mission-atlas-the-last-green-light-12', 2, 'byte', 'I have three threads on this host that never fully resolved. A certificate. A disk. A process. None of them looked urgent on their own.'),
  ('mission-atlas-the-last-green-light-12', 3, 'leena', 'They were never going to look urgent on their own. Walk through all three, in order, and tell me what they actually have in common.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-the-last-green-light-01-o1', 'mission-atlas-the-last-green-light-01', 1, 'Report for duty', 'Confirm what Atlas Division is actually responsible for before the briefing continues.'),

  ('mission-atlas-the-last-green-light-02-o1', 'mission-atlas-the-last-green-light-02', 1, 'Sort the layer', 'Sort each item into infrastructure or application.'),

  ('mission-atlas-the-last-green-light-03-o1', 'mission-atlas-the-last-green-light-03', 1, 'Find the hot process', 'Use the terminal to identify which process is consuming abnormal CPU on nexus-infra-19.'),
  ('mission-atlas-the-last-green-light-03-o2', 'mission-atlas-the-last-green-light-03', 2, 'Tell process from service', 'Choose the accurate distinction between a process and a service.'),

  ('mission-atlas-the-last-green-light-04-o1', 'mission-atlas-the-last-green-light-04', 1, 'Restore the permissions', 'Fix the registry config''s permissions and read its verification code.'),

  ('mission-atlas-the-last-green-light-05-o1', 'mission-atlas-the-last-green-light-05', 1, 'Find the log in its correct home', 'Use the standard Linux filesystem hierarchy to locate the probe status log and read its code.'),

  ('mission-atlas-the-last-green-light-06-o1', 'mission-atlas-the-last-green-light-06', 1, 'Tell graceful from forced', 'Choose the accurate distinction between asking a process to stop and forcing it to stop.'),
  ('mission-atlas-the-last-green-light-06-o2', 'mission-atlas-the-last-green-light-06', 2, 'Stop the stuck process', 'Use the terminal to terminate the stuck process on nexus-infra-19.'),

  ('mission-atlas-the-last-green-light-07-o1', 'mission-atlas-the-last-green-light-07', 1, 'Restore the service', 'Enable and start the failed service, then confirm its status code.'),

  ('mission-atlas-the-last-green-light-08-o1', 'mission-atlas-the-last-green-light-08', 1, 'Read the journal', 'Use journalctl to find why the telemetry-sync service actually failed.'),

  ('mission-atlas-the-last-green-light-09-o1', 'mission-atlas-the-last-green-light-09', 1, 'Read the SSH configuration', 'Find and read the SSH client configuration left on this host.'),

  ('mission-atlas-the-last-green-light-10-o1', 'mission-atlas-the-last-green-light-10', 1, 'Count with a pipeline', 'Use a shell pipeline to count how many ERROR lines the incident log contains.'),

  ('mission-atlas-the-last-green-light-11-o1', 'mission-atlas-the-last-green-light-11', 1, 'Find what is growing', 'Use disk usage inspection to find the file that has been quietly growing, and read its resource code.'),

  ('mission-atlas-the-last-green-light-12-o1', 'mission-atlas-the-last-green-light-12', 1, 'Confirm the certificate cause', 'Use the journal to confirm what actually made three independent systems fail within the same minute.'),
  ('mission-atlas-the-last-green-light-12-o2', 'mission-atlas-the-last-green-light-12', 2, 'Confirm the disk cause', 'Use disk usage inspection to confirm the growth pattern behind tonight''s disk-related failure.'),
  ('mission-atlas-the-last-green-light-12-o3', 'mission-atlas-the-last-green-light-12', 3, 'Confirm the process cause', 'Use the journal to confirm why a process was terminated tonight, and by what.'),
  ('mission-atlas-the-last-green-light-12-o4', 'mission-atlas-the-last-green-light-12', 4, 'State the diagnosis', 'Having confirmed all three causes, explain what they actually have in common.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-the-last-green-light-01-o1-c1', 'mission-atlas-the-last-green-light-01-o1', 1, 'multiple_choice', 'What is Atlas Division actually responsible for?', '{"question":"What is Atlas Division actually responsible for?","options":[{"id":"a","text":"Building the user-facing applications Nexus runs"},{"id":"b","text":"The infrastructure underneath every other Nexus division -- hosts, networking, storage and the platforms applications run on"},{"id":"c","text":"Only Byte''s own dashboards"},{"id":"d","text":"Marketing and communications for Nexus"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-atlas-the-last-green-light-02-o1-c1', 'mission-atlas-the-last-green-light-02-o1', 1, 'drag_and_drop', 'Sort each item into infrastructure or application.', '{"items":[{"id":"i1","text":"The Linux host a service runs on"},{"id":"i2","text":"A shopping cart feature in a retail app"},{"id":"i3","text":"The network route between two data centers"},{"id":"i4","text":"A user-facing dashboard showing order history"},{"id":"i5","text":"The disk storage backing a database"}],"targets":[{"id":"infra","label":"Infrastructure"},{"id":"app","label":"Application"}]}'::jsonb, '{"correctMapping":{"i1":"infra","i2":"app","i3":"infra","i4":"app","i5":"infra"}}'::jsonb),

  ('mission-atlas-the-last-green-light-03-o1-c1', 'mission-atlas-the-last-green-light-03-o1', 1, 'terminal_simulation', 'List the running processes and identify the one consuming abnormal CPU. Submit its PID.', '{"instructions":"Something on nexus-infra-19 is running hot. List the processes, find the one with abnormal CPU usage, and submit its PID with: submit PID","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"}},"processes":[{"pid":1,"user":"root","cmd":"/sbin/init","cpu":0.0,"mem":0.1},{"pid":412,"user":"root","cmd":"/usr/sbin/sshd -D","cpu":0.1,"mem":0.3},{"pid":892,"user":"atlas","cmd":"/opt/atlas/telemetry-agent --config /etc/atlas/telemetry.conf","cpu":0.4,"mem":1.2},{"pid":1337,"user":"atlas","cmd":"/opt/atlas/log-compactor --once","cpu":78.2,"mem":12.4}]}'::jsonb, '{"requiredFlag":"1337"}'::jsonb),
  ('mission-atlas-the-last-green-light-03-o2-c1', 'mission-atlas-the-last-green-light-03-o2', 1, 'multiple_choice', 'A process and a service differ in that...', '{"question":"A process and a service differ in that...","options":[{"id":"a","text":"They are the same thing, just different names"},{"id":"b","text":"A process is one running instance of a program; a service is a process systemd is supposed to be managing and supervising on your behalf"},{"id":"c","text":"A service always uses more memory than a process"},{"id":"d","text":"A process only exists on servers, a service only exists on laptops"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-atlas-the-last-green-light-04-o1-c1', 'mission-atlas-the-last-green-light-04-o1', 1, 'terminal_simulation', 'Fix the registry config''s permissions, then read its verification code.', '{"instructions":"/etc/atlas/registry.conf cannot be read by anyone right now, not even root-owned services that need it. Fix its permissions, then read it and submit the verification code with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"},"/etc/atlas/registry.conf":{"type":"file","content":"service=green-light-probe\nowner=atlas-infra\nverification=GL-4471\n","mode":"000","owner":"root"}}}'::jsonb, '{"requiredFlag":"GL-4471"}'::jsonb),

  ('mission-atlas-the-last-green-light-05-o1-c1', 'mission-atlas-the-last-green-light-05-o1', 1, 'terminal_simulation', 'Find the probe status log in its correct filesystem location and read its code.', '{"instructions":"A probe status log exists on this host. Logs live under /var/log by convention -- find it there, not in a decoy location, and submit the code inside it with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"},"/home/recruit/notes.txt":{"type":"file","content":"remember to check the probe log later\n"},"/tmp/probe-status.log":{"type":"file","content":"STALE COPY -- do not trust, see /var/log\n"},"/var/log/atlas/probe-status.log":{"type":"file","content":"PROBE-OK CODE=FHS-8823\n"}}}'::jsonb, '{"requiredFlag":"FHS-8823"}'::jsonb),

  ('mission-atlas-the-last-green-light-06-o1-c1', 'mission-atlas-the-last-green-light-06-o1', 1, 'multiple_choice', 'Asking a process to stop (SIGTERM) versus forcing it to stop (SIGKILL) differ in that...', '{"question":"Asking a process to stop (SIGTERM) versus forcing it to stop (SIGKILL) differ in that...","options":[{"id":"a","text":"They are identical, both stop the process instantly"},{"id":"b","text":"A graceful request gives the process a chance to save state and clean up; a forced kill does not, no matter what it was doing"},{"id":"c","text":"SIGKILL only works on services, never on plain processes"},{"id":"d","text":"SIGTERM only works as root"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-atlas-the-last-green-light-06-o2-c1', 'mission-atlas-the-last-green-light-06-o2', 1, 'terminal_simulation', 'Terminate the stuck process on nexus-infra-19.', '{"instructions":"A stuck process, pid 4471, is holding a lock it will never release on its own. Terminate it, then list the processes again and submit ok when it no longer appears, with: submit CLEARED","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"}},"processes":[{"pid":1,"user":"root","cmd":"/sbin/init","cpu":0.0,"mem":0.1},{"pid":4471,"user":"atlas","cmd":"/opt/atlas/lock-holder --stuck","cpu":0.0,"mem":2.1}]}'::jsonb, '{"requiredFlag":"CLEARED"}'::jsonb),

  ('mission-atlas-the-last-green-light-07-o1-c1', 'mission-atlas-the-last-green-light-07-o1', 1, 'terminal_simulation', 'Enable and start the failed greenlight-probe service, then confirm its status code.', '{"instructions":"The greenlight-probe service is failed and disabled. Enable it, start it, then check its status and submit the code shown with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"}},"services":[{"name":"greenlight-probe","status":"failed","description":"Atlas green-light heartbeat probe CODE=SVC-2205","enabled":false}]}'::jsonb, '{"requiredFlag":"SVC-2205"}'::jsonb),

  ('mission-atlas-the-last-green-light-08-o1-c1', 'mission-atlas-the-last-green-light-08-o1', 1, 'terminal_simulation', 'Use journalctl to find why telemetry-sync actually failed, and submit the job code named in the log.', '{"instructions":"telemetry-sync failed hours ago. Query its journal and submit the renewal job code named in the failure message with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"}},"journal":[{"timestamp":"2026-08-14T00:02:11","unit":"telemetry-sync","message":"handshake ok"},{"timestamp":"2026-08-14T03:15:00","unit":"telemetry-sync","message":"TLS handshake failed: certificate expired 2026-08-14T03:15:00, renewal job CERT-9012 never executed"}]}'::jsonb, '{"requiredFlag":"CERT-9012"}'::jsonb),

  ('mission-atlas-the-last-green-light-09-o1-c1', 'mission-atlas-the-last-green-light-09-o1', 1, 'terminal_simulation', 'Read the SSH client configuration on this host and submit the verification code inside it.', '{"instructions":"Someone configured remote access to this host and left the configuration behind. Read ~/.ssh/config and submit the verification code with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"},"/home/recruit/.ssh/config":{"type":"file","content":"Host atlas-jump\n  HostName jump.atlas.nexus.internal\n  User atlas-ops\n  IdentityFile ~/.ssh/atlas_ed25519\n  # verification AUTH-3341\n"}}}'::jsonb, '{"requiredFlag":"AUTH-3341"}'::jsonb),

  ('mission-atlas-the-last-green-light-10-o1-c1', 'mission-atlas-the-last-green-light-10-o1', 1, 'terminal_simulation', 'Use a pipeline to count how many ERROR lines the incident log contains, and submit the count.', '{"instructions":"Count the ERROR lines in /var/log/atlas/incidents.log without reading it by eye -- pipe grep into wc -l -- then submit the count with: submit COUNT","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"},"/var/log/atlas/incidents.log":{"type":"file","content":"INFO boot ok\nERROR probe timeout node-02\nERROR probe timeout node-03\nINFO retry\nERROR probe timeout node-04\nERROR probe timeout node-05\nERROR probe timeout node-06\nINFO retry\nERROR probe timeout node-07\nERROR probe timeout node-08\n"}}}'::jsonb, '{"requiredFlag":"7"}'::jsonb),

  ('mission-atlas-the-last-green-light-11-o1-c1', 'mission-atlas-the-last-green-light-11-o1', 1, 'terminal_simulation', 'Use disk usage inspection to find the growing file under /var/log/atlas, then read its resource code.', '{"instructions":"Something under /var/log/atlas has been quietly growing. Use du to find the largest file there, then read it and submit the resource code with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"},"/var/log/atlas/probe-status.log":{"type":"file","content":"PROBE-OK\n"},"/var/log/atlas/growth-audit.log":{"type":"file","content":"debug trace entry 0001\ndebug trace entry 0002\ndebug trace entry 0003\ndebug trace entry 0004\ndebug trace entry 0005\ndebug trace entry 0006\ndebug trace entry 0007\ndebug trace entry 0008\ndebug trace entry 0009\ndebug trace entry 0010\nRESOURCE-CODE=RSRC-6650\n"}}}'::jsonb, '{"requiredFlag":"RSRC-6650"}'::jsonb),

  ('mission-atlas-the-last-green-light-12-o1-c1', 'mission-atlas-the-last-green-light-12-o1', 1, 'terminal_simulation', 'Use the journal to find what made three independent systems fail within the same minute.', '{"instructions":"Three services failed within the same sixty seconds tonight. Query the journal and submit the shared renewal job code named across all three failures with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"}},"journal":[{"timestamp":"2026-08-15T03:16:55","unit":"telemetry-sync","message":"TLS handshake failed: shared root CA certificate expired 2026-08-15T03:15:00, renewal job CERT-4471 never executed"},{"timestamp":"2026-08-15T03:16:56","unit":"ci-runner-fleet","message":"TLS handshake failed: shared root CA certificate expired 2026-08-15T03:15:00, renewal job CERT-4471 never executed"},{"timestamp":"2026-08-15T03:16:57","unit":"registry-sync","message":"TLS handshake failed: shared root CA certificate expired 2026-08-15T03:15:00, renewal job CERT-4471 never executed"}]}'::jsonb, '{"requiredFlag":"CERT-4471"}'::jsonb),
  ('mission-atlas-the-last-green-light-12-o2-c1', 'mission-atlas-the-last-green-light-12-o2', 1, 'terminal_simulation', 'Use disk usage inspection to confirm the growth pattern behind tonight''s disk-related failure.', '{"instructions":"Use du under /var/log/atlas to find the file that finally crossed the line tonight, then read it and submit the code with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"},"/var/log/atlas/probe-status.log":{"type":"file","content":"PROBE-OK\n"},"/var/log/atlas/debug-trace.log":{"type":"file","content":"unrotated trace entry 0001\nunrotated trace entry 0002\nunrotated trace entry 0003\nunrotated trace entry 0004\nunrotated trace entry 0005\nunrotated trace entry 0006\nunrotated trace entry 0007\nunrotated trace entry 0008\nunrotated trace entry 0009\nunrotated trace entry 0010\nunrotated trace entry 0011\nunrotated trace entry 0012\nRESOURCE-CODE=RSRC-8802\n"}}}'::jsonb, '{"requiredFlag":"RSRC-8802"}'::jsonb),
  ('mission-atlas-the-last-green-light-12-o3-c1', 'mission-atlas-the-last-green-light-12-o3', 1, 'terminal_simulation', 'Use the journal to confirm why a process was terminated tonight, and by what.', '{"instructions":"Query the journal for what happened to pid 1337 tonight and submit the action code with: submit CODE","hostname":"nexus-infra-19","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"nexus-infra-19\n"},"/home/recruit":{"type":"dir"}},"journal":[{"timestamp":"2026-08-15T02:40:12","unit":"log-compactor","message":"memory usage exceeded cgroup limit, oom-watchdog terminated pid 1337 as designed, action code PROC-1190"}]}'::jsonb, '{"requiredFlag":"PROC-1190"}'::jsonb),
  ('mission-atlas-the-last-green-light-12-o4-c1', 'mission-atlas-the-last-green-light-12-o4', 1, 'boss_encounter', 'Having confirmed the certificate, disk and process causes, explain what they actually have in common.', '{"stages":[{"objectiveRef":"mission-atlas-the-last-green-light-12-o1","label":"Confirm the certificate cause"},{"objectiveRef":"mission-atlas-the-last-green-light-12-o2","label":"Confirm the disk cause"},{"objectiveRef":"mission-atlas-the-last-green-light-12-o3","label":"Confirm the process cause"}],"task":"State the diagnosis in one sentence: nothing was attacked -- every system that vanished did so through its own normal, correctly-configured failure path, a certificate that was always going to expire, a disk that was always going to fill, a process that was always going to be killed. The silence is not an intrusion. It is what production looks like when nobody is watching every layer at once."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-the-last-green-light-12-o1","mission-atlas-the-last-green-light-12-o2","mission-atlas-the-last-green-light-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-the-last-green-light-01-o1-c1', 'orientation', 'Atlas Division is not the group that builds what users see.', 10, 1),
  ('mission-atlas-the-last-green-light-01-o1-c1', 'solution', 'Atlas owns the infrastructure underneath every other Nexus division.', 20, 2),

  ('mission-atlas-the-last-green-light-02-o1-c1', 'orientation', 'Ask whether a user would ever directly see or click on this thing.', 10, 1),
  ('mission-atlas-the-last-green-light-02-o1-c1', 'solution', 'Infrastructure: the host, the network route, the disk storage. Application: the shopping cart feature, the user-facing dashboard.', 20, 2),

  ('mission-atlas-the-last-green-light-03-o1-c1', 'orientation', 'Try: ps', 10, 1),
  ('mission-atlas-the-last-green-light-03-o1-c1', 'solution', 'ps lists pid 1337, log-compactor, at 78.2% CPU -- far above every other process. submit 1337', 20, 2),
  ('mission-atlas-the-last-green-light-03-o2-c1', 'orientation', 'One of them is supervised by systemd. The other is just running.', 10, 1),
  ('mission-atlas-the-last-green-light-03-o2-c1', 'solution', 'A process is a running instance; a service is a process systemd is supposed to be managing on your behalf.', 20, 2),

  ('mission-atlas-the-last-green-light-04-o1-c1', 'orientation', 'Try: chmod 644 /etc/atlas/registry.conf, then cat /etc/atlas/registry.conf', 10, 1),
  ('mission-atlas-the-last-green-light-04-o1-c1', 'solution', 'The file reads verification=GL-4471 once readable. submit GL-4471', 20, 2),

  ('mission-atlas-the-last-green-light-05-o1-c1', 'orientation', 'Logs live under /var/log by convention, not /tmp or a home directory.', 10, 1),
  ('mission-atlas-the-last-green-light-05-o1-c1', 'solution', 'cat /var/log/atlas/probe-status.log reads CODE=FHS-8823. submit FHS-8823', 20, 2),

  ('mission-atlas-the-last-green-light-06-o1-c1', 'orientation', 'One of the two options never allows cleanup.', 10, 1),
  ('mission-atlas-the-last-green-light-06-o1-c1', 'solution', 'A graceful request allows cleanup; a forced kill never does, regardless of what the process was doing.', 20, 2),
  ('mission-atlas-the-last-green-light-06-o2-c1', 'orientation', 'Try: kill 4471, then ps to confirm it is gone.', 10, 1),
  ('mission-atlas-the-last-green-light-06-o2-c1', 'solution', 'Once pid 4471 no longer appears in ps, submit CLEARED', 20, 2),

  ('mission-atlas-the-last-green-light-07-o1-c1', 'orientation', 'Try: systemctl enable greenlight-probe, then systemctl start greenlight-probe, then systemctl status greenlight-probe', 10, 1),
  ('mission-atlas-the-last-green-light-07-o1-c1', 'solution', 'The status output reads CODE=SVC-2205. submit SVC-2205', 20, 2),

  ('mission-atlas-the-last-green-light-08-o1-c1', 'orientation', 'Try: journalctl -u telemetry-sync', 10, 1),
  ('mission-atlas-the-last-green-light-08-o1-c1', 'solution', 'The failure entry names renewal job CERT-9012, which never executed. submit CERT-9012', 20, 2),

  ('mission-atlas-the-last-green-light-09-o1-c1', 'orientation', 'Try: cat ~/.ssh/config', 10, 1),
  ('mission-atlas-the-last-green-light-09-o1-c1', 'solution', 'The config comment reads verification AUTH-3341. submit AUTH-3341', 20, 2),

  ('mission-atlas-the-last-green-light-10-o1-c1', 'orientation', 'Try: grep ERROR /var/log/atlas/incidents.log | wc -l', 10, 1),
  ('mission-atlas-the-last-green-light-10-o1-c1', 'solution', 'There are exactly 7 ERROR lines. submit 7', 20, 2),

  ('mission-atlas-the-last-green-light-11-o1-c1', 'orientation', 'Try: du /var/log/atlas/growth-audit.log, then cat it.', 10, 1),
  ('mission-atlas-the-last-green-light-11-o1-c1', 'solution', 'The file ends with RESOURCE-CODE=RSRC-6650. submit RSRC-6650', 20, 2),

  ('mission-atlas-the-last-green-light-12-o1-c1', 'orientation', 'Try: journalctl -n 20 and look for a pattern across multiple units.', 10, 1),
  ('mission-atlas-the-last-green-light-12-o1-c1', 'solution', 'All three failures name the same expired root CA and the same renewal job, CERT-4471. submit CERT-4471', 20, 2),
  ('mission-atlas-the-last-green-light-12-o2-c1', 'orientation', 'Try: du /var/log/atlas/debug-trace.log, then cat it.', 10, 1),
  ('mission-atlas-the-last-green-light-12-o2-c1', 'solution', 'The unrotated trace file ends with RESOURCE-CODE=RSRC-8802. submit RSRC-8802', 20, 2),
  ('mission-atlas-the-last-green-light-12-o3-c1', 'orientation', 'Try: journalctl -u log-compactor', 10, 1),
  ('mission-atlas-the-last-green-light-12-o3-c1', 'solution', 'The oom-watchdog terminated pid 1337 as designed, action code PROC-1190. submit PROC-1190', 20, 2),
  ('mission-atlas-the-last-green-light-12-o4-c1', 'orientation', 'Look at what all three causes have in common as a category, not as individual incidents.', 15, 1),
  ('mission-atlas-the-last-green-light-12-o4-c1', 'solution', 'Nothing was attacked. A certificate that was always going to expire, a disk that was always going to fill, a process that was always going to be killed -- the silence is what production looks like when nobody is watching every layer at once.', 25, 2);
