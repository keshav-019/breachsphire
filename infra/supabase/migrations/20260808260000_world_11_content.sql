-- world-11 ("Linux II: Administration: Operator") mission content, generated
-- from docs/12-world-story-bible.md. Continues on the same skyport-mnt07
-- host as world-10, using the terminal_simulation engine
-- (apps/web/src/lib/terminal/) with its process/service/journal/package
-- subsystems. Mission 1 is cross-world-gated on world-10's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-11a', 'world-11', 'operator', '11A - Operator', 'sentinel-sync survived the reboot and is still touching privileged services. Stabilize this host as its administrator, not its tourist.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-11a-1', 'campaign-11a', 'foundations', 'Foundations', 'Permissions, processes and the difference between reading a system and administering it.', 1),
  ('operation-11a-2', 'campaign-11a', 'investigation', 'Investigation', 'Journals, packages, and closing the persistence window sentinel-sync opened.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w11-01', 'world-11', 'campaign-11a', 'operation-11a-1', 'the-account-that-wont-die', 'The Account That Won''t Die', 'sentinel-sync didn''t disappear when the controller rebooted. It came back, and it still touches privileged services.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w10-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w11-02', 'world-11', 'campaign-11a', 'operation-11a-1', 'fix-the-lock', 'Fix the Lock', 'A legitimate service can''t read its own config anymore. Permissions don''t change themselves.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w11-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-permissions-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w11-03', 'world-11', 'campaign-11a', 'operation-11a-1', 'doesnt-belong-here', 'Doesn''t Belong Here', 'Not every process belongs where it''s running. A legitimate service doesn''t hide in a cache directory.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w11-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-process-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w11-04', 'world-11', 'campaign-11a', 'operation-11a-2', 'filter-the-noise', 'Filter the Noise', 'The journal remembers everything. It doesn''t organize itself.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w11-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-journal-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w11-05', 'world-11', 'campaign-11a', 'operation-11a-2', 'compare-the-manifest', 'Compare the Manifest', 'We keep a baseline of what''s supposed to be installed on hosts like this. Compare it against what''s actually here.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w11-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-package-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w11-06', 'world-11', 'campaign-11a', 'operation-11a-2', 'persistence-window-boss', 'Persistence Window', 'sentinel-sync is blocking the legitimate service from starting. Shut it down properly, restore the real one, and find out how long it''s actually been here.', 'boss', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w11-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"persistence-window-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["persistence-window"],"skillXp":{"linux":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w11-01', 1, 'ava', 'sentinel-sync didn''t disappear when we rebooted this box. It came back, and it''s still touching privileged services.'),
  ('mission-w11-01', 2, 'ava', 'Finding it was survival. Dealing with it means learning to administer this system properly -- users, permissions, services, the whole stack.'),
  ('mission-w11-01', 3, 'byte', 'Think of it as the difference between reading a building''s blueprints and actually being allowed to hold the keys.'),
  ('mission-w11-01', 4, 'ava', 'You''re not a tourist here anymore. Let''s fix what''s broken.'),
  ('mission-w11-02', 1, 'byte', 'Permissions aren''t decoration. If a legitimate service can''t read its own config, someone -- or something -- changed that on purpose.'),
  ('mission-w11-03', 1, 'ava', 'Not every process belongs where it''s running. A legitimate service doesn''t hide in a cache directory.'),
  ('mission-w11-04', 1, 'byte', 'The journal remembers everything, but it doesn''t organize itself. Filter by unit, or you''ll drown in heartbeats.'),
  ('mission-w11-05', 1, 'ava', 'We keep a baseline of what''s supposed to be installed on hosts like this. Compare it against what''s actually here.'),
  ('mission-w11-06', 1, 'ava', 'sentinel-sync is blocking the legitimate service from starting. Shut it down properly, bring telemetry-sync back up, and find out how long it''s actually been here.'),
  ('mission-w11-06', 2, 'byte', 'Binary signature confirms it. Signed months before this incident ever started.'),
  ('mission-w11-06', 3, 'ava', 'Pre-positioned. Someone put this here long before the rogue access point ever went active.'),
  ('mission-w11-06', 4, 'ava', 'A second host on this network shows no obvious service at all -- whatever''s there is hiding somewhere less obvious. Time to go deeper than systemctl.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w11-01-o1', 'mission-w11-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to administer, not just explore.'),
  ('mission-w11-02-o1', 'mission-w11-02', 1, 'Restore the config''s permissions', 'Fix the permissions on the telemetry-sync config and read its verification code.'),
  ('mission-w11-03-o1', 'mission-w11-03', 1, 'Identify the process that doesn''t belong', 'Find the process running from a path no legitimate service would use.'),
  ('mission-w11-04-o1', 'mission-w11-04', 1, 'Filter the journal by unit', 'Isolate the sentinel-sync unit''s journal entries and extract the session code.'),
  ('mission-w11-05-o1', 'mission-w11-05', 1, 'Find the unauthorized package', 'Compare installed packages against the baseline manifest.'),
  ('mission-w11-06-o1', 'mission-w11-06', 1, 'Close the persistence window', 'Stop sentinel-sync, restore telemetry-sync, and recover the binary''s signing date.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w11-01-o1-c1', 'mission-w11-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Time to hold the keys, not just read the blueprints. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w11-02-o1-c1', 'mission-w11-02-o1', 1, 'terminal_simulation', 'Fix the permissions on the telemetry-sync config so it can be read, then submit its verification code.', '{"instructions":"The legitimate telemetry-sync service can''t read its own config anymore -- something changed its permissions. Fix it, then confirm you can read it.","hostname":"skyport-mnt07","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-mnt07\n"},"/home/recruit":{"type":"dir"},"/opt/skyport/agents/telemetry-sync.conf":{"type":"file","content":"service=telemetry-sync\ninterval=300\nverification=OPR-2201\n","mode":"000","owner":"root"}}}'::jsonb, '{"requiredFlag":"OPR-2201"}'::jsonb),

  ('mission-w11-03-o1-c1', 'mission-w11-03-o1', 1, 'terminal_simulation', 'Find the process running from a path no legitimate service would use, and submit its full command.', '{"instructions":"Something on this host is running from a path no legitimate service would use. List the processes and find it.","hostname":"skyport-mnt07","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-mnt07\n"},"/home/recruit":{"type":"dir"}},"processes":[{"pid":412,"user":"root","cmd":"/usr/sbin/telemetry-syncd"},{"pid":588,"user":"root","cmd":"/usr/lib/systemd/systemd-journald"},{"pid":701,"user":"facilities-ops","cmd":"-bash"},{"pid":933,"user":"root","cmd":"/tmp/.cache/svc-helper --daemon"}]}'::jsonb, '{"requiredFlag":"/tmp/.cache/svc-helper --daemon"}'::jsonb),

  ('mission-w11-04-o1-c1', 'mission-w11-04-o1', 1, 'terminal_simulation', 'Filter the journal for the sentinel-sync unit and submit its session code.', '{"instructions":"Search the journal for the sentinel-sync unit specifically -- filter it out from the routine telemetry-sync heartbeats.","hostname":"skyport-mnt07","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-mnt07\n"},"/home/recruit":{"type":"dir"}},"journal":[{"timestamp":"2024-11-03 02:00:01","unit":"telemetry-sync.service","message":"heartbeat ok"},{"timestamp":"2024-11-03 02:05:01","unit":"telemetry-sync.service","message":"heartbeat ok"},{"timestamp":"2024-11-03 02:10:14","unit":"sentinel-sync.service","message":"started by request of uid 0"},{"timestamp":"2024-11-03 02:10:15","unit":"sentinel-sync.service","message":"connected to relay, session=OPR-3390"},{"timestamp":"2024-11-03 02:15:01","unit":"telemetry-sync.service","message":"heartbeat ok"}]}'::jsonb, '{"requiredFlag":"OPR-3390"}'::jsonb),

  ('mission-w11-05-o1-c1', 'mission-w11-05-o1', 1, 'terminal_simulation', 'Compare installed packages against the baseline manifest and submit the name of the one that doesn''t belong.', '{"instructions":"Read the baseline manifest, list what''s actually installed, and find the package that was never supposed to be here.","hostname":"skyport-mnt07","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-mnt07\n"},"/home/recruit":{"type":"dir"},"/etc/skyport/baseline-packages.txt":{"type":"file","content":"openssh-server\ntelemetry-sync-agent\ncoreutils\nsystemd\n"}},"packages":[{"name":"openssh-server","version":"1:9.2p1-2"},{"name":"telemetry-sync-agent","version":"3.4.0-1"},{"name":"coreutils","version":"9.1-1"},{"name":"sentinel-sync-agent","version":"0.9.1-1"},{"name":"systemd","version":"252.5-2"}]}'::jsonb, '{"requiredFlag":"sentinel-sync-agent"}'::jsonb),

  ('mission-w11-06-o1-c1', 'mission-w11-06-o1', 1, 'terminal_simulation', 'Stop sentinel-sync, restore telemetry-sync, and submit the date its binary was actually signed.', '{"instructions":"sentinel-sync is active and blocking telemetry-sync from starting. Stop and disable sentinel-sync, start telemetry-sync back up, then find out when sentinel-sync''s binary was actually signed.","hostname":"skyport-mnt07","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"skyport-mnt07\n"},"/home/recruit":{"type":"dir"},"/opt/skyport/agents/sentinel-sync.meta":{"type":"file","content":"binary=sentinel-syncd\nsigned=2024-08-02\nnote=predates current incident window by months\n"}},"services":[{"name":"telemetry-sync","status":"inactive","description":"SkyPort telemetry sync (legitimate)","enabled":true},{"name":"sentinel-sync","status":"active","description":"System integrity helper","enabled":true,"unauthorized":true}]}'::jsonb, '{"requiredFlag":"2024-08-02"}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w11-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w11-02-o1-c1', 'orientation', 'Try cat''ing the config first -- the error will tell you exactly what''s wrong.', 10, 1),
  ('mission-w11-02-o1-c1', 'concept', 'chmod changes what a file allows; the number after it sets owner/group/other read-write-execute bits.', 20, 2),
  ('mission-w11-02-o1-c1', 'tool_direction', 'chmod 644 grants read to everyone and write to the owner -- a normal, safe config permission.', 30, 3),
  ('mission-w11-02-o1-c1', 'solution', 'chmod 644 /opt/skyport/agents/telemetry-sync.conf, then cat it. Submit OPR-2201.', 40, 4),

  ('mission-w11-03-o1-c1', 'orientation', 'Three of these four processes are exactly where you''d expect a legitimate one to be.', 15, 1),
  ('mission-w11-03-o1-c1', 'concept', 'Legitimate daemons run from /usr/sbin or /usr/lib, not from a hidden directory under /tmp.', 25, 2),
  ('mission-w11-03-o1-c1', 'solution', 'ps aux shows pid 933 running /tmp/.cache/svc-helper --daemon -- no real service lives under /tmp/.cache. Submit /tmp/.cache/svc-helper --daemon exactly as shown.', 35, 3),

  ('mission-w11-04-o1-c1', 'orientation', 'Most of this journal is routine telemetry-sync heartbeats -- filter them out.', 15, 1),
  ('mission-w11-04-o1-c1', 'concept', 'journalctl -u <unit> shows only entries from that specific unit.', 25, 2),
  ('mission-w11-04-o1-c1', 'tool_direction', 'Try journalctl -u sentinel-sync.service.', 35, 3),
  ('mission-w11-04-o1-c1', 'solution', 'journalctl -u sentinel-sync.service shows it connecting to a relay with session=OPR-3390. Submit OPR-3390.', 45, 4),

  ('mission-w11-05-o1-c1', 'orientation', 'cat the baseline manifest first, then list what''s actually installed.', 15, 1),
  ('mission-w11-05-o1-c1', 'concept', 'dpkg -l shows every installed package -- one of them won''t appear in the baseline at all.', 25, 2),
  ('mission-w11-05-o1-c1', 'solution', 'cat /etc/skyport/baseline-packages.txt, then dpkg -l. sentinel-sync-agent is installed but not in the baseline. Submit sentinel-sync-agent.', 35, 3),

  ('mission-w11-06-o1-c1', 'orientation', 'systemctl list-units will show you both services'' current state.', 20, 1),
  ('mission-w11-06-o1-c1', 'concept', 'stop halts a running service now; disable keeps it from starting again on its own.', 30, 2),
  ('mission-w11-06-o1-c1', 'tool_direction', 'systemctl stop sentinel-sync, systemctl disable sentinel-sync, systemctl start telemetry-sync -- then look for a metadata file recording when sentinel-sync was signed.', 40, 3),
  ('mission-w11-06-o1-c1', 'near_solution', 'cat /opt/skyport/agents/sentinel-sync.meta once the services are sorted out.', 50, 4),
  ('mission-w11-06-o1-c1', 'solution', 'After stopping/disabling sentinel-sync and starting telemetry-sync, cat /opt/skyport/agents/sentinel-sync.meta shows signed=2024-08-02 -- months before this incident. Submit 2024-08-02.', 65, 5);
