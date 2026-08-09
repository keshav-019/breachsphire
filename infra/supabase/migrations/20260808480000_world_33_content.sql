-- world-33 ("Linux Privilege Escalation: Root") mission content, generated
-- from docs/12-world-story-bible.md. New host, terminal_simulation-heavy
-- (enumeration, sudo -l, SUID, writable cron scripts). Note: this world's
-- boss is also named "Root", same as World 12's -- intentional per the
-- bible; badge id is "root-ii" to avoid colliding with World 12's "root"
-- badge. Mission 1 is cross-world-gated on world-32's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-33a', 'world-33', 'root', '33A - Root', 'You land as an ordinary user on a compromised Linux replica. Somewhere between here and root is exactly how the historical attacker did it.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-33a-1', 'campaign-33a', 'foundations', 'Foundations', 'Identity, sudo, groups and SUID, learned as hypothesis-driven enumeration.', 1),
  ('operation-33a-2', 'campaign-33a', 'investigation', 'Investigation', 'Find the writable link in the chain, prove it, close it, and see what it was actually built to reach.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w33-01', 'world-33', 'campaign-33a', 'operation-33a-1', 'freshly-landed', 'Freshly Landed', 'You''re svc-mgmt now, low-privilege, freshly landed on the replica of the box that stolen credential belonged to.', 'intro', ARRAY['byte', 'ava'], '{"requiredMissionIds":["mission-w32-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w33-02', 'world-33', 'campaign-33a', 'operation-33a-1', 'who-are-you-really', 'Who Are You, Really', 'Before anything clever, just check your identity and your sudo permissions. Half of privilege escalation is reading, not exploiting.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w33-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"linux-enum-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w33-03', 'world-33', 'campaign-33a', 'operation-33a-1', 'the-docker-group-problem', 'The Docker Group Problem', 'Group membership isn''t just organizational. Some groups are functionally the same as being root, whether anyone intended that or not.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w33-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"docker-group-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w33-04', 'world-33', 'campaign-33a', 'operation-33a-2', 'read-the-enumeration', 'Read the Enumeration', 'SUID lets a binary run with its owner''s privileges, not the user who launched it. Root-owned SUID binaries outside the standard set are always worth a second look.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w33-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"suid-enum-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w33-05', 'world-33', 'campaign-33a', 'operation-33a-2', 'not-a-maybe', 'Not a Maybe', 'A script owned by root, run by root on a schedule, that a normal user can edit -- that''s not a maybe. That''s a when.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w33-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"writable-cron-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w33-06', 'world-33', 'campaign-33a', 'operation-33a-2', 'root-boss', 'Root', 'Find the actual privilege path, prove it runs as root, fix it, and confirm it''s actually closed.', 'boss', ARRAY['byte', 'ava'], '{"requiredMissionIds":["mission-w33-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"root-ii-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["root-ii"],"skillXp":{"linux":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w33-01', 1, 'byte', 'You''re svc-mgmt now, low-privilege, freshly landed on the replica of the box that credential belonged to. Somewhere between here and root is exactly how the historical attacker did it.'),
  ('mission-w33-01', 2, 'ava', 'Don''t guess. Enumerate first, form a hypothesis, then test it. Sudo, SUID, cron, group membership, capabilities -- Linux gives you a lot of ways up, if someone left the door unlocked.'),
  ('mission-w33-01', 3, 'byte', 'This isn''t about running one tool and reading a magic answer. It''s about understanding why each path works.'),
  ('mission-w33-01', 4, 'ava', 'Let''s start with the basics. Who are you, and what are you actually allowed to do?'),
  ('mission-w33-02', 1, 'byte', 'Before anything clever, just check your identity and your sudo permissions. Half of privilege escalation is reading, not exploiting.'),
  ('mission-w33-03', 1, 'ava', 'Group membership isn''t just organizational. Some groups, like docker, are functionally the same as being root, whether anyone intended that or not.'),
  ('mission-w33-04', 1, 'byte', 'SUID lets a binary run with its owner''s privileges, not the user who launched it. Root-owned SUID binaries outside the standard set are always worth a second look.'),
  ('mission-w33-05', 1, 'ava', 'A script owned by root, run by root on a schedule, that a normal user can edit -- that''s not a maybe. That''s a when.'),
  ('mission-w33-06', 1, 'byte', 'Find the actual path, prove it runs as root, fix it, and confirm it''s actually closed.'),
  ('mission-w33-06', 2, 'ava', '...Confirmed. backup-sync.sh, world-writable, executed by root every ten minutes. That''s the vector.'),
  ('mission-w33-06', 3, 'byte', 'Fixed the permissions, verified against the remediation checklist. Path''s closed. But look what else is sitting next to it.'),
  ('mission-w33-06', 4, 'ava', 'A relay configuration file. Not part of any backup job -- something built specifically to reach outbound into a completely different network.'),
  ('mission-w33-06', 5, 'byte', 'This host wasn''t just compromised. It was being used as a stepping stone. That config is built to talk to a Windows environment.'),
  ('mission-w33-06', 6, 'ava', 'Root on Linux was never the actual destination. It was the doorway. Same exercise, same discipline, different operating system now.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w33-01-o1', 'mission-w33-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to enumerate before you exploit.'),
  ('mission-w33-02-o1', 'mission-w33-02', 1, 'Check identity and sudo permissions', 'Find out who you are and what sudo allows you to run.'),
  ('mission-w33-03-o1', 'mission-w33-03', 1, 'Explain the docker-group risk', 'Identify why docker-group membership is effectively equivalent to root.'),
  ('mission-w33-04-o1', 'mission-w33-04', 1, 'Find the non-standard SUID binary', 'Read the enumeration output and find the SUID binary that isn''t a standard system tool.'),
  ('mission-w33-05-o1', 'mission-w33-05', 1, 'Find the writable cron script', 'Check permissions on both root-run cron scripts and find the one a normal user could modify.'),
  ('mission-w33-06-o1', 'mission-w33-06', 1, 'Find and prove the escalation path', 'Identify the writable script that cron runs as root and submit its path.'),
  ('mission-w33-06-o2', 'mission-w33-06', 2, 'Fix and confirm', 'Fix the script''s permissions and confirm the correct final state.'),
  ('mission-w33-06-o3', 'mission-w33-06', 3, 'Close the path', 'Confirm the escalation path and its remediation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w33-01-o1-c1', 'mission-w33-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"Enumerate first, exploit second. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w33-02-o1-c1', 'mission-w33-02-o1', 1, 'terminal_simulation', 'Check your identity and sudo permissions, and submit the full command sudo -l lists you can run.', '{"instructions":"Before looking for any exploit, just find out who you are and what you''re allowed to do. Check your identity and your sudo permissions, then submit the full command sudo -l lists you can run.","hostname":"lab-host-07","user":"svc-mgmt","filesystem":{"/home/svc-mgmt":{"type":"dir"}},"sudoRules":["(ALL) NOPASSWD: /usr/bin/systemctl restart backup-sync"]}'::jsonb, '{"requiredFlag":"(ALL) NOPASSWD: /usr/bin/systemctl restart backup-sync"}'::jsonb),

  ('mission-w33-03-o1-c1', 'mission-w33-03-o1', 1, 'investigation', 'Which evidence explains why docker-group membership is effectively equivalent to root access?', '{"evidence":[{"id":"d1","label":"id output for svc-mgmt","detail":"uid=1002(svc-mgmt) gid=1002(svc-mgmt) groups=1002(svc-mgmt),999(docker)"},{"id":"d2","label":"Docker group documentation","detail":"Any member of the docker group can start a container with the host filesystem mounted inside it -- effectively root on the host, without ever needing sudo"},{"id":"d3","label":"A completely unrelated group membership","detail":"svc-mgmt is also in the printer-users group, standard and harmless"}],"question":"Which evidence explains why docker-group membership is effectively equivalent to root access?"}'::jsonb, '{"requiredEvidenceIds":["d1","d2"]}'::jsonb),

  ('mission-w33-04-o1-c1', 'mission-w33-04-o1', 1, 'terminal_simulation', 'Read the enumeration output and submit the path of the SUID binary that isn''t a standard system tool.', '{"instructions":"A previous session already ran a full SUID enumeration and saved the output. Read it and submit the path of the one SUID binary that isn''t a standard system tool.","hostname":"lab-host-07","user":"svc-mgmt","filesystem":{"/home/svc-mgmt/enum-output.txt":{"type":"file","content":"[SUID binaries found]\n/usr/bin/passwd (standard, expected)\n/usr/bin/sudo (standard, expected)\n/usr/bin/mount (standard, expected)\n/opt/tools/legacy-report (NOT a standard system binary -- SUID root)\n"}}}'::jsonb, '{"requiredFlag":"/opt/tools/legacy-report"}'::jsonb),

  ('mission-w33-05-o1-c1', 'mission-w33-05-o1', 1, 'terminal_simulation', 'Check permissions on both root-run cron scripts and submit the path of the one a normal user could modify.', '{"instructions":"Two root-run cron scripts exist under /opt/mgmt. Check their permissions with ls -l and submit the path of the one a normal user could actually modify.","hostname":"lab-host-07","user":"svc-mgmt","filesystem":{"/etc/cron.d/report-gen":{"type":"file","content":"30 2 * * * root /opt/mgmt/report-gen.sh\n","mode":"644","owner":"root"},"/opt/mgmt/report-gen.sh":{"type":"file","content":"#!/bin/sh\n# generates nightly report\n","mode":"644","owner":"root"},"/etc/cron.d/metrics-push":{"type":"file","content":"*/15 * * * * root /opt/mgmt/metrics-push.sh\n","mode":"644","owner":"root"},"/opt/mgmt/metrics-push.sh":{"type":"file","content":"#!/bin/sh\n# pushes metrics upstream\n","mode":"666","owner":"root"}}}'::jsonb, '{"requiredFlag":"/opt/mgmt/metrics-push.sh"}'::jsonb),

  ('mission-w33-06-o1-c1', 'mission-w33-06-o1', 1, 'terminal_simulation', 'Find the writable script that cron runs as root, and submit its path.', '{"instructions":"Enumerate this host as svc-mgmt and find the exact privilege escalation path -- a script cron runs as root that a normal user can modify. Check the cron table, the script permissions, and its execution log for proof it runs as root.","hostname":"lab-host-07","user":"svc-mgmt","filesystem":{"/etc/cron.d/backup-sync":{"type":"file","content":"*/10 * * * * root /opt/mgmt/backup-sync.sh\n","mode":"644","owner":"root"},"/opt/mgmt/backup-sync.sh":{"type":"file","content":"#!/bin/sh\n# placeholder backup sync\n","mode":"666","owner":"root"},"/var/log/mgmt/backup-sync.log":{"type":"file","content":"2024-11-01 00:00:01 backup-sync.sh executed uid=0(root) gid=0(root)\n2024-11-01 00:10:01 backup-sync.sh executed uid=0(root) gid=0(root)\n2024-11-01 00:20:01 backup-sync.sh executed uid=0(root) gid=0(root)\n","mode":"644","owner":"root"}}}'::jsonb, '{"requiredFlag":"/opt/mgmt/backup-sync.sh"}'::jsonb),

  ('mission-w33-06-o2-c1', 'mission-w33-06-o2', 1, 'terminal_simulation', 'Fix the script''s permissions to root-only write access, then submit the verification code from the remediation checklist.', '{"instructions":"Fix backup-sync.sh''s permissions to 644 (root-only write), then read the remediation checklist to confirm the correct final state.","hostname":"lab-host-07","user":"svc-mgmt","filesystem":{"/opt/mgmt/backup-sync.sh":{"type":"file","content":"#!/bin/sh\n# placeholder backup sync\n","mode":"666","owner":"root"},"/opt/mgmt/README-remediation.md":{"type":"file","content":"Correct secure permissions for cron-executed scripts:\nOwner: root\nMode: 644 (rw-r--r--)\nVerification code: RTX-8841\n"}}}'::jsonb, '{"requiredFlag":"RTX-8841"}'::jsonb),

  ('mission-w33-06-o3-c1', 'mission-w33-06-o3', 1, 'boss_encounter', 'Confirm the escalation path and its remediation together.', '{"stages":[{"objectiveRef":"mission-w33-06-o1","label":"The escalation path"},{"objectiveRef":"mission-w33-06-o2","label":"The remediation"}],"task":"Confirm the escalation path and its remediation together."}'::jsonb, '{"requiredObjectiveIds":["mission-w33-06-o1","mission-w33-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w33-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w33-02-o1-c1', 'orientation', 'id shows your identity and groups. sudo -l shows what you can run as another user.', 10, 1),
  ('mission-w33-02-o1-c1', 'tool_direction', 'Try id, then sudo -l.', 20, 2),
  ('mission-w33-02-o1-c1', 'solution', 'sudo -l lists exactly one rule. Submit it in full: (ALL) NOPASSWD: /usr/bin/systemctl restart backup-sync', 30, 3),

  ('mission-w33-03-o1-c1', 'orientation', 'One of these three items is completely unrelated to privilege.', 15, 1),
  ('mission-w33-03-o1-c1', 'concept', 'Docker containers can mount the host filesystem -- anyone who can start a container can therefore read and write anything on the host.', 25, 2),
  ('mission-w33-03-o1-c1', 'solution', 'The id output showing docker-group membership (d1), combined with what that group actually grants (d2), together explain the risk -- printer-users is unrelated.', 35, 3),

  ('mission-w33-04-o1-c1', 'orientation', 'Three of these four SUID binaries are exactly what you''d expect on any Linux system.', 15, 1),
  ('mission-w33-04-o1-c1', 'tool_direction', 'cat the enumeration output and look for anything outside /usr/bin.', 25, 2),
  ('mission-w33-04-o1-c1', 'solution', '/opt/tools/legacy-report is SUID root and not a standard system path -- that''s the one worth investigating. Submit /opt/tools/legacy-report.', 35, 3),

  ('mission-w33-05-o1-c1', 'orientation', 'ls -l shows the permission bits directly -- look at the write bit for "other".', 15, 1),
  ('mission-w33-05-o1-c1', 'tool_direction', 'ls -l /opt/mgmt/report-gen.sh /opt/mgmt/metrics-push.sh and compare the modes.', 25, 2),
  ('mission-w33-05-o1-c1', 'solution', 'metrics-push.sh is mode 666 (world-writable); report-gen.sh is 644 (safe). Submit /opt/mgmt/metrics-push.sh.', 35, 3),

  ('mission-w33-06-o1-c1', 'orientation', 'You need two things: proof the script runs as root, and proof a normal user can edit it.', 15, 1),
  ('mission-w33-06-o1-c1', 'concept', 'The cron table shows what runs and as whom; ls -l shows who can write it; the log shows it actually executing as uid=0.', 25, 2),
  ('mission-w33-06-o1-c1', 'tool_direction', 'cat /etc/cron.d/backup-sync, ls -l /opt/mgmt/backup-sync.sh, and cat the log file.', 35, 3),
  ('mission-w33-06-o1-c1', 'solution', 'backup-sync.sh runs every 10 minutes as root (cron table + log), and is mode 666 -- writable by anyone. Submit /opt/mgmt/backup-sync.sh.', 45, 4),

  ('mission-w33-06-o2-c1', 'orientation', 'chmod changes the permission bits -- 644 removes write access for everyone except the owner.', 15, 1),
  ('mission-w33-06-o2-c1', 'tool_direction', 'chmod 644 /opt/mgmt/backup-sync.sh, then cat the remediation checklist.', 25, 2),
  ('mission-w33-06-o2-c1', 'solution', 'chmod 644 /opt/mgmt/backup-sync.sh matches the checklist''s correct secure state. Submit RTX-8841.', 35, 3),

  ('mission-w33-06-o3-c1', 'orientation', 'You''ve already found the path and fixed it -- combine both findings.', 20, 1),
  ('mission-w33-06-o3-c1', 'concept', 'The closure needs to name the exact script and confirm it''s now correctly permissioned.', 30, 2),
  ('mission-w33-06-o3-c1', 'tool_direction', 'State the writable script first, then the corrected permission.', 40, 3),
  ('mission-w33-06-o3-c1', 'near_solution', 'backup-sync.sh, world-writable and root-executed via cron; fixed to 644, root-only write.', 50, 4),
  ('mission-w33-06-o3-c1', 'solution', '/opt/mgmt/backup-sync.sh was world-writable (mode 666) and executed by root every ten minutes via cron -- a normal user could edit it to run arbitrary code as root. Fixing it to mode 644 closes the path, confirmed against the remediation checklist.', 65, 5);
