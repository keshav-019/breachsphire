-- world-12 ("Linux III: Power User: Under the Hood") mission content,
-- generated from docs/12-world-story-bible.md. New host (skyport-gw02, a
-- hardened gateway) -- clean services, still beaconing. Leans on the
-- terminal engine's pipes/redirection (grep|awk|wc), cron, env and
-- pseudo-/proc file support (all just ordinary readable paths). Mission 1
-- is cross-world-gated on world-11's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-12a', 'world-12', 'under-the-hood', '12A - Under the Hood', 'A hardened gateway with clean services is still emitting the SX beacon. Whatever''s here knows how to hide from the basics.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-12a-1', 'campaign-12a', 'foundations', 'Foundations', 'Pipelines and scheduled jobs -- turning noise into evidence.', 1),
  ('operation-12a-2', 'campaign-12a', 'investigation', 'Investigation', 'Environment, capabilities, and closing the persistence path without breaking the gateway.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w12-01', 'world-12', 'campaign-12a', 'operation-12a-1', 'clean-on-the-surface', 'Clean on the Surface', 'This gateway looks completely clean. Services are healthy, nothing''s flagged. It''s still emitting the SX beacon.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w11-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w12-02', 'world-12', 'campaign-12a', 'operation-12a-1', 'filter-the-noise-find-the-signal', 'Filter the Noise, Find the Signal', 'One request pattern in this access log repeats on a schedule no human browsing habit produces.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w12-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-pipeline-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w12-03', 'world-12', 'campaign-12a', 'operation-12a-1', 'the-job-nobody-scheduled', 'The Job Nobody Scheduled', 'List every scheduled job on this box. Two are routine. One isn''t.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w12-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-cron-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w12-04', 'world-12', 'campaign-12a', 'operation-12a-2', 'read-the-environment', 'Read the Environment', 'Persistence doesn''t only live in cron. Check what this account loads automatically, and how it connects out.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w12-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-env-ssh-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w12-05', 'world-12', 'campaign-12a', 'operation-12a-2', 'behind-the-curtain', 'Behind the Curtain', 'A capability like cap_sys_admin on a binary outside any standard path is not normal.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w12-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-proc-caps-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w12-06', 'world-12', 'campaign-12a', 'operation-12a-2', 'root-boss', 'Root', 'Everything points to one script. Read it fully, close it down, and don''t touch the other two scheduled jobs -- they keep this gateway running.', 'boss', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w12-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"root-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["root"],"skillXp":{"linux":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w12-01', 1, 'ava', 'This gateway looks completely clean. Services are healthy, nothing''s flagged. And it''s still emitting the SX beacon.'),
  ('mission-w12-01', 2, 'byte', 'Clean at the surface just means whatever''s here knows how to hide from the tools you''ve used so far.'),
  ('mission-w12-01', 3, 'ava', 'Pipelines, cron, environment variables, /proc -- the places people forget to check. That''s where we''re going.'),
  ('mission-w12-01', 4, 'byte', 'Grep and awk aren''t just search tools. They''re how you turn noise into evidence.'),
  ('mission-w12-02', 1, 'byte', 'One request pattern in this log repeats on a schedule no human browsing habit produces. Grep for it.'),
  ('mission-w12-03', 1, 'ava', 'List every scheduled job on this box. Two are routine. One isn''t.'),
  ('mission-w12-04', 1, 'byte', 'Persistence doesn''t only live in cron. Check what this account''s shell loads automatically, and how it connects out.'),
  ('mission-w12-05', 1, 'ava', 'A capability like cap_sys_admin on some binary outside any standard path is not normal. Almost nothing legitimately needs it.'),
  ('mission-w12-06', 1, 'ava', 'Everything points to one script. Read it fully, close it down, and don''t touch the other two scheduled jobs -- they keep this gateway running.'),
  ('mission-w12-06', 2, 'byte', 'Found it. A comment, buried in the script. Signed CIPHER.'),
  ('mission-w12-06', 3, 'ava', 'Cipher again. Leaving a name inside the persistence mechanism itself isn''t something an attacker covering their tracks would normally do.'),
  ('mission-w12-06', 4, 'byte', 'Witness, informant, or something else entirely. I don''t have enough to call it yet.'),
  ('mission-w12-06', 5, 'ava', 'Whatever Cipher is, the trail doesn''t stay on Linux. A corporate workstation tied to this same campaign just lit up with suspicious logons. Windows next.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w12-01-o1', 'mission-w12-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to look past the obvious places.'),
  ('mission-w12-02-o1', 'mission-w12-02', 1, 'Find the recurring request', 'Filter the access log for the repeating pattern and submit its token.'),
  ('mission-w12-03-o1', 'mission-w12-03', 1, 'Identify the rogue cron job', 'Find the scheduled job running from a hidden directory and submit the code inside it.'),
  ('mission-w12-04-o1', 'mission-w12-04', 1, 'Check the environment and SSH config', 'Find the persistence clue in this account''s environment or SSH configuration.'),
  ('mission-w12-05-o1', 'mission-w12-05', 1, 'Find the over-privileged binary', 'Identify the binary holding capabilities it has no legitimate reason to need.'),
  ('mission-w12-06-o1', 'mission-w12-06', 1, 'Close the persistence path', 'Read the malicious script fully and recover its signature, without disturbing the legitimate scheduled jobs.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w12-01-o1-c1', 'mission-w12-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Nothing''s flagged, and it''s still beaconing. Ready to look harder?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w12-02-o1-c1', 'mission-w12-02-o1', 1, 'terminal_simulation', 'Filter the access log for the recurring request pattern and submit its token.', '{"instructions":"Most of this log is ordinary browsing. Grep for the request that repeats identically instead of scrolling through it all.","hostname":"skyport-gw02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-gw02\n"},"/home/recruit":{"type":"dir"},"/var/log/skyport-gw/access.log":{"type":"file","content":"10.44.6.9 - GET /status 200\n10.44.6.9 - GET /status 200\n10.44.6.44 - GET /sync?token=OPR-4471 200\n10.44.6.12 - GET /assets/logo.png 200\n10.44.6.44 - GET /sync?token=OPR-4471 200\n10.44.6.7 - GET /status 200\n10.44.6.44 - GET /sync?token=OPR-4471 200\n"}}}'::jsonb, '{"requiredFlag":"OPR-4471"}'::jsonb),

  ('mission-w12-03-o1-c1', 'mission-w12-03-o1', 1, 'terminal_simulation', 'List the scheduled jobs, find the one running from a hidden directory, and submit the code inside its script.', '{"instructions":"List every scheduled job. One runs from a hidden directory on an interval that doesn''t match any legitimate maintenance window.","hostname":"skyport-gw02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-gw02\n"},"/home/recruit":{"type":"dir"},"/opt/.sys/sync-helper.sh":{"type":"file","content":"#!/bin/sh\n# routine sync\ncurl -s http://10.44.9.2/beacon?id=OPR-5518\n"}},"cron":[{"schedule":"*/5 * * * *","user":"root","command":"/usr/lib/skyport/health-check.sh"},{"schedule":"0 3 * * *","user":"root","command":"/usr/lib/skyport/log-rotate.sh"},{"schedule":"*/7 * * * *","user":"root","command":"/opt/.sys/sync-helper.sh"}]}'::jsonb, '{"requiredFlag":"OPR-5518"}'::jsonb),

  ('mission-w12-04-o1-c1', 'mission-w12-04-o1', 1, 'terminal_simulation', 'Check this account''s environment and SSH config, and submit the token you find.', '{"instructions":"Persistence doesn''t only live in cron. Check what this shell loads automatically (env) and how it connects to other hosts (~/.ssh/config).","hostname":"skyport-gw02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-gw02\n"},"/home/recruit":{"type":"dir"},"/home/recruit/.ssh/config":{"type":"file","content":"Host backup-relay\n  HostName 10.44.9.2\n  User svc\n  ProxyCommand /opt/.sys/relay-helper --token OPR-6602\n"}},"env":{"PATH":"/usr/local/sbin:/usr/sbin:/sbin:/usr/bin","LD_PRELOAD":"/opt/.sys/libshim.so"}}'::jsonb, '{"requiredFlag":"OPR-6602"}'::jsonb),

  ('mission-w12-05-o1-c1', 'mission-w12-05-o1', 1, 'terminal_simulation', 'Find the binary holding capabilities it has no legitimate reason to need, and submit its full path.', '{"instructions":"Read the capability audit. Almost nothing outside standard system paths legitimately needs cap_sys_admin.","hostname":"skyport-gw02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-gw02\n"},"/home/recruit":{"type":"dir"},"/etc/skyport/capabilities-audit.txt":{"type":"file","content":"Binary                    Capabilities\n/usr/bin/ping             cap_net_raw\n/usr/sbin/tcpdump         cap_net_raw,cap_net_admin\n/opt/.sys/relay-helper    cap_sys_admin,cap_net_raw\n"},"/proc/2210/status":{"type":"file","content":"Name:\trelay-helper\nPid:\t2210\nUid:\t0\t0\t0\t0\n"}}}'::jsonb, '{"requiredFlag":"/opt/.sys/relay-helper"}'::jsonb),

  ('mission-w12-06-o1-c1', 'mission-w12-06-o1', 1, 'terminal_simulation', 'Read the malicious script fully and submit the signature you find, without touching the legitimate scheduled jobs.', '{"instructions":"Everything points to /opt/.sys/sync-helper.sh as the persistence mechanism. Read it fully -- and don''t modify or delete health-check.sh or log-rotate.sh, they''re legitimate and keep this gateway running.","hostname":"skyport-gw02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-gw02\n"},"/home/recruit":{"type":"dir"},"/opt/.sys/sync-helper.sh":{"type":"file","content":"#!/bin/sh\n# routine sync\n# maintained -- CIPHER\ncurl -s http://10.44.9.2/beacon?id=OPR-5518\n","mode":"755","owner":"root"},"/usr/lib/skyport/health-check.sh":{"type":"file","content":"#!/bin/sh\necho ok\n","mode":"755","owner":"root"},"/usr/lib/skyport/log-rotate.sh":{"type":"file","content":"#!/bin/sh\nlogrotate /etc/skyport/logrotate.conf\n","mode":"755","owner":"root"}},"cron":[{"schedule":"*/5 * * * *","user":"root","command":"/usr/lib/skyport/health-check.sh"},{"schedule":"0 3 * * *","user":"root","command":"/usr/lib/skyport/log-rotate.sh"},{"schedule":"*/7 * * * *","user":"root","command":"/opt/.sys/sync-helper.sh"}],"protectedPaths":["/usr/lib/skyport/health-check.sh","/usr/lib/skyport/log-rotate.sh"]}'::jsonb, '{"requiredFlag":"CIPHER","requireEvidencePreserved":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w12-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w12-02-o1-c1', 'orientation', 'Most of these requests only appear once or twice. One appears three times, identically.', 15, 1),
  ('mission-w12-02-o1-c1', 'concept', 'grep pulls out only the lines matching a pattern -- try filtering for the endpoint, not the whole line.', 25, 2),
  ('mission-w12-02-o1-c1', 'tool_direction', 'grep "/sync" /var/log/skyport-gw/access.log will isolate every occurrence.', 35, 3),
  ('mission-w12-02-o1-c1', 'solution', 'grep "/sync" access.log shows three identical requests carrying token=OPR-4471. Submit OPR-4471.', 45, 4),

  ('mission-w12-03-o1-c1', 'orientation', 'crontab -l lists every scheduled job for this user.', 15, 1),
  ('mission-w12-03-o1-c1', 'concept', 'A legitimate maintenance script lives under /usr/lib or similar -- not inside a hidden dotfile directory under /opt.', 25, 2),
  ('mission-w12-03-o1-c1', 'tool_direction', 'crontab -l, then cat the script running from /opt/.sys.', 35, 3),
  ('mission-w12-03-o1-c1', 'solution', 'crontab -l shows /opt/.sys/sync-helper.sh running every 7 minutes. cat it -- it beacons out with id=OPR-5518. Submit OPR-5518.', 45, 4),

  ('mission-w12-04-o1-c1', 'orientation', 'Two different places can hold this clue -- check both.', 15, 1),
  ('mission-w12-04-o1-c1', 'concept', 'env shows what gets loaded automatically; ~/.ssh/config shows how outbound connections are made.', 25, 2),
  ('mission-w12-04-o1-c1', 'tool_direction', 'cat ~/.ssh/config -- look at the ProxyCommand line for backup-relay.', 35, 3),
  ('mission-w12-04-o1-c1', 'solution', 'cat /home/recruit/.ssh/config shows a ProxyCommand invoking /opt/.sys/relay-helper --token OPR-6602. Submit OPR-6602.', 45, 4),

  ('mission-w12-05-o1-c1', 'orientation', 'Two of these three binaries having cap_net_raw is completely ordinary -- ping and tcpdump need it.', 15, 1),
  ('mission-w12-05-o1-c1', 'concept', 'cap_sys_admin is an extremely broad capability -- almost nothing needs it, and definitely not a binary living under a hidden /opt/.sys path.', 25, 2),
  ('mission-w12-05-o1-c1', 'solution', '/opt/.sys/relay-helper holds cap_sys_admin,cap_net_raw -- far more than a normal utility needs, and from a path that doesn''t belong. Submit /opt/.sys/relay-helper.', 35, 3),

  ('mission-w12-06-o1-c1', 'orientation', 'You already know which script this is -- read the whole thing, not just the first line.', 20, 1),
  ('mission-w12-06-o1-c1', 'concept', 'Comments in a malicious script sometimes reveal more than the code itself.', 30, 2),
  ('mission-w12-06-o1-c1', 'tool_direction', 'cat /opt/.sys/sync-helper.sh in full, and leave health-check.sh and log-rotate.sh completely untouched.', 40, 3),
  ('mission-w12-06-o1-c1', 'near_solution', 'One line in the script isn''t code at all -- it''s a signature.', 50, 4),
  ('mission-w12-06-o1-c1', 'solution', 'cat /opt/.sys/sync-helper.sh in full reveals a comment reading "maintained -- CIPHER". Submit CIPHER. Leave the other two scripts alone.', 65, 5);
