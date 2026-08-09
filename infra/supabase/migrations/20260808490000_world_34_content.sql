-- world-34 ("Windows Privilege Escalation: Elevation") mission content,
-- generated from docs/12-world-story-bible.md. Mirrors World 33's
-- enumeration discipline on Windows, using existing quiz/investigation
-- challenge types (no PowerShell engine in this codebase, per established
-- convention). Mission 1 is cross-world-gated on world-33's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-34a', 'world-34', 'elevation', '34A - Elevation', 'A low-privilege Windows account on the replica exposes services, tasks and stored secrets. Somewhere in them is exactly how Administrator was reached before.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-34a-1', 'campaign-34a', 'foundations', 'Foundations', 'Service paths, permissions and scheduled tasks, learned as the Windows cousins of sudo and cron.', 1),
  ('operation-34a-2', 'campaign-34a', 'investigation', 'Investigation', 'Confirm the historical chain, harden the endpoint, and see what it was actually protecting.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w34-01', 'world-34', 'campaign-34a', 'operation-34a-1', 'same-discipline-new-os', 'Same Discipline, New OS', 'Same exercise, new operating system. Somewhere in services, tasks, or the registry is exactly how someone reached Administrator before.', 'intro', ARRAY['luna', 'byte'], '{"requiredMissionIds":["mission-w33-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w34-02', 'world-34', 'campaign-34a', 'operation-34a-1', 'not-cosmetic', 'Not Cosmetic', 'An unquoted service path with spaces in it isn''t cosmetic. Windows will try each segment as a potential executable, in order.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w34-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"unquoted-path-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w34-03', 'world-34', 'campaign-34a', 'operation-34a-1', 'only-as-safe-as-its-permissions', 'Only as Safe as Its Permissions', 'A service running as SYSTEM is only as safe as the permissions on the service itself.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w34-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"service-acl-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w34-04', 'world-34', 'campaign-34a', 'operation-34a-2', 'crons-windows-cousin', 'Cron''s Windows Cousin', 'Scheduled tasks are cron''s Windows cousin. If a low-privilege account can write to what a SYSTEM-run task executes, the schedule doesn''t matter.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w34-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"scheduled-task-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w34-05', 'world-34', 'campaign-34a', 'operation-34a-2', 'in-plain-sight', 'In Plain Sight', 'The registry sometimes stores exactly what it shouldn''t -- credentials and weak permissions, hiding in plain sight for anyone who checks.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w34-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"registry-secrets-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w34-06', 'world-34', 'campaign-34a', 'operation-34a-2', 'elevation-boss', 'Elevation', 'Reach administrative control through the actual historical misconfiguration chain, then harden every part of it.', 'boss', ARRAY['luna', 'byte'], '{"requiredMissionIds":["mission-w34-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"elevation-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["elevation"],"skillXp":{"windows":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w34-01', 1, 'luna', 'Same exercise, new operating system. You''re a low-privilege account on a Windows replica. Somewhere in services, tasks, or the registry is exactly how someone reached Administrator before.'),
  ('mission-w34-01', 2, 'byte', 'Windows keeps a lot of its secrets in structured places -- services, scheduled tasks, the registry. Structured doesn''t mean secure.'),
  ('mission-w34-01', 3, 'luna', 'Tokens, service permissions, binary paths, scheduled tasks, registry ACLs, stored credentials, UAC. Enumerate deliberately, the same way you just did on Linux.'),
  ('mission-w34-01', 4, 'byte', 'Different shape, same discipline. Let''s see what this account can actually reach.'),
  ('mission-w34-02', 1, 'luna', 'An unquoted service path with spaces in it isn''t cosmetic. Windows will try each segment as a potential executable, in order, until one exists.'),
  ('mission-w34-03', 1, 'byte', 'A service running as SYSTEM is only as safe as the permissions on the service itself. If a low-privilege account can reconfigure it, it can make SYSTEM run anything.'),
  ('mission-w34-04', 1, 'luna', 'Scheduled tasks are cron''s Windows cousin. Same lesson: if a low-privilege account can write to what a SYSTEM-run task executes, the schedule doesn''t matter.'),
  ('mission-w34-05', 1, 'byte', 'The registry sometimes stores exactly what it shouldn''t -- credentials, weak permissions on sensitive keys, both hiding in plain sight for anyone who checks.'),
  ('mission-w34-06', 1, 'luna', 'Reach administrative control through the actual historical misconfiguration chain, then harden every part of it.'),
  ('mission-w34-06', 2, 'byte', '...Confirmed. Weak service permissions let a standard user reconfigure a SYSTEM service to run anything it wants.'),
  ('mission-w34-06', 3, 'luna', 'Textbook chain. Hardened the service ACL, fixed the unquoted path, confirmed a standard account can''t touch it anymore.'),
  ('mission-w34-06', 4, 'byte', 'Endpoint''s hardened. But look what was sitting in this account''s saved credentials after elevation -- a full map of an internal Active Directory domain.'),
  ('mission-w34-06', 5, 'luna', 'This was never just one Windows box. It was a door into something much bigger -- an entire enterprise identity system.'),
  ('mission-w34-06', 6, 'byte', 'Domains, forests, trust relationships. The scope just changed completely.'),
  ('mission-w34-06', 7, 'luna', 'Time to stop thinking about hosts, one at a time, and start thinking about the whole kingdom they all belong to.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w34-01-o1', 'mission-w34-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to enumerate Windows with the same discipline as Linux.'),
  ('mission-w34-02-o1', 'mission-w34-02', 1, 'Explain the unquoted-path risk', 'Determine what happens when an unquoted service path is exploited.'),
  ('mission-w34-03-o1', 'mission-w34-03', 1, 'Find the hijackable service', 'Identify the evidence showing a service a standard user could hijack to run as SYSTEM.'),
  ('mission-w34-04-o1', 'mission-w34-04', 1, 'Find the exploitable task', 'Identify the scheduled task that represents a real escalation opportunity.'),
  ('mission-w34-05-o1', 'mission-w34-05', 1, 'Identify the registry credential exposure', 'Determine what a plaintext AutoLogon registry entry represents.'),
  ('mission-w34-06-o1', 'mission-w34-06', 1, 'Confirm the escalation chain', 'Identify the evidence confirming the actual historical escalation chain.'),
  ('mission-w34-06-o2', 'mission-w34-06', 2, 'Choose the hardening steps', 'Select the steps that close this chain completely.'),
  ('mission-w34-06-o3', 'mission-w34-06', 3, 'Close the elevation path', 'Confirm the chain and the hardening together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w34-01-o1-c1', 'mission-w34-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Different shape, same discipline. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w34-02-o1-c1', 'mission-w34-02-o1', 1, 'multiple_choice', 'A Windows service''s binary path is set to C:\Program Files\Backup Tool\service host.exe (unquoted, contains spaces). An attacker with write access to C:\ places a file named C:\Program.exe. What happens when the service starts?', '{"question":"A Windows service''s binary path is set to C:\\Program Files\\Backup Tool\\service host.exe (unquoted, contains spaces). An attacker with write access to C:\\ places a file named C:\\Program.exe. What happens when the service starts?","options":[{"id":"a","text":"Nothing -- Windows always resolves the full intended path"},{"id":"b","text":"Windows tries each space-delimited segment as a potential executable in order, so C:\\Program.exe would execute instead of the intended service binary"},{"id":"c","text":"The service simply fails to start"},{"id":"d","text":"Only Administrators can trigger this behavior"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w34-03-o1-c1', 'mission-w34-03-o1', 1, 'investigation', 'Which evidence shows a service a standard user could hijack to run as SYSTEM?', '{"evidence":[{"id":"s1","label":"Service \"BackupToolSvc\" configuration","detail":"Runs as LocalSystem, startup type Automatic"},{"id":"s2","label":"Service ACL for BackupToolSvc","detail":"\"Authenticated Users\" group granted permission to change the binary path"},{"id":"s3","label":"Service \"PrintSpoolerSvc\" ACL","detail":"Only Administrators and SYSTEM have any configuration permissions -- standard, expected"}],"question":"Which evidence shows a service a standard user could hijack to run as SYSTEM?"}'::jsonb, '{"requiredEvidenceIds":["s1","s2"]}'::jsonb),

  ('mission-w34-04-o1-c1', 'mission-w34-04-o1', 1, 'investigation', 'Which task represents a real privilege escalation opportunity for a standard user?', '{"evidence":[{"id":"t1","label":"Scheduled task \"NightlySync\"","detail":"Runs as SYSTEM, executes C:\\ProgramData\\Sync\\sync-runner.bat"},{"id":"t2","label":"NTFS permissions on C:\\ProgramData\\Sync\\","detail":"The \"Users\" group is granted Modify permission on the folder and its contents"},{"id":"t3","label":"Scheduled task \"WindowsUpdateCheck\"","detail":"Runs as SYSTEM, executes a binary inside C:\\Windows\\System32\\, writable only by Administrators and SYSTEM"}],"question":"Which task represents a real privilege escalation opportunity for a standard user?"}'::jsonb, '{"requiredEvidenceIds":["t1","t2"]}'::jsonb),

  ('mission-w34-05-o1-c1', 'mission-w34-05-o1', 1, 'multiple_choice', 'The registry key HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon contains DefaultUserName and DefaultPassword values in plaintext, readable by any authenticated user. What does this represent?', '{"question":"The registry key HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon contains DefaultUserName and DefaultPassword values in plaintext, readable by any authenticated user. What does this represent?","options":[{"id":"a","text":"Normal, expected Windows configuration"},{"id":"b","text":"Stored AutoLogon credentials in plaintext, readable by any local user -- a direct credential exposure"},{"id":"c","text":"An encrypted credential vault"},{"id":"d","text":"A harmless legacy setting with no security impact"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w34-06-o1-c1', 'mission-w34-06-o1', 1, 'investigation', 'Which evidence confirms the actual historical escalation chain?', '{"evidence":[{"id":"c1","label":"BackupToolSvc configuration and ACL","detail":"Runs as LocalSystem; Authenticated Users can change its binary path"},{"id":"c2","label":"Historical incident timeline","detail":"BackupToolSvc''s binary path was modified shortly before Administrator-level activity first appeared on this host"},{"id":"c3","label":"An unrelated, correctly configured service","detail":"No permission issues, unrelated to the incident"}],"question":"Which evidence confirms the actual historical escalation chain?"}'::jsonb, '{"requiredEvidenceIds":["c1","c2"]}'::jsonb),

  ('mission-w34-06-o2-c1', 'mission-w34-06-o2', 1, 'multiple_choice', 'What hardening steps close this chain completely?', '{"question":"What hardening steps close this chain completely?","options":[{"id":"a","text":"Just restart the service"},{"id":"b","text":"Remove Authenticated Users'' configuration permission on the service, restrict it to Administrators/SYSTEM only, and audit for any other services with the same weak ACL pattern"},{"id":"c","text":"Rename the service"},{"id":"d","text":"Disable all services on the host"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w34-06-o3-c1', 'mission-w34-06-o3', 1, 'boss_encounter', 'Confirm the chain and the hardening together.', '{"stages":[{"objectiveRef":"mission-w34-06-o1","label":"The escalation chain"},{"objectiveRef":"mission-w34-06-o2","label":"The hardening"}],"task":"Confirm the chain and the hardening together."}'::jsonb, '{"requiredObjectiveIds":["mission-w34-06-o1","mission-w34-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w34-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w34-02-o1-c1', 'orientation', 'Windows parses an unquoted path by trying each space-separated token in turn as a possible file.', 15, 1),
  ('mission-w34-02-o1-c1', 'solution', 'Windows will attempt C:\\Program.exe before ever reaching the intended path -- if that file exists and is attacker-controlled, it runs instead. Option b.', 25, 2),

  ('mission-w34-03-o1-c1', 'orientation', 'Two of these three items describe the same service; one describes something unrelated.', 15, 1),
  ('mission-w34-03-o1-c1', 'concept', 'A SYSTEM-level service whose configuration a standard user can change is equivalent to that user being able to run anything as SYSTEM.', 25, 2),
  ('mission-w34-03-o1-c1', 'solution', 'BackupToolSvc runs as LocalSystem (s1) and Authenticated Users can reconfigure it (s2) -- together, that''s a hijackable service. PrintSpoolerSvc is correctly locked down.', 35, 3),

  ('mission-w34-04-o1-c1', 'orientation', 'One task runs from a location only Administrators can write to.', 15, 1),
  ('mission-w34-04-o1-c1', 'concept', 'A SYSTEM-run task is only exploitable if a lower-privilege user can actually modify what it executes.', 25, 2),
  ('mission-w34-04-o1-c1', 'solution', 'NightlySync runs as SYSTEM (t1) from a folder the Users group can modify (t2) -- that''s the real opportunity. WindowsUpdateCheck''s path is locked down to admins only.', 35, 3),

  ('mission-w34-05-o1-c1', 'orientation', 'Ask what those two registry values are actually used for, and who can read them.', 15, 1),
  ('mission-w34-05-o1-c1', 'solution', 'DefaultUserName/DefaultPassword store AutoLogon credentials in plaintext, readable by any local user -- a direct credential exposure. Option b.', 25, 2),

  ('mission-w34-06-o1-c1', 'orientation', 'One of these three items is unrelated background noise.', 15, 1),
  ('mission-w34-06-o1-c1', 'concept', 'A confirmed chain needs both the vulnerable configuration and evidence it was actually used.', 25, 2),
  ('mission-w34-06-o1-c1', 'tool_direction', 'Check the service''s permissions and the incident timeline together.', 35, 3),
  ('mission-w34-06-o1-c1', 'solution', 'BackupToolSvc''s weak ACL (c1) combined with its binary path being modified right before Administrator activity appeared (c2) confirms the actual chain.', 45, 4),

  ('mission-w34-06-o2-c1', 'orientation', 'The fix needs to remove the specific permission that made this possible, and check whether the same mistake exists elsewhere.', 15, 1),
  ('mission-w34-06-o2-c1', 'solution', 'Removing Authenticated Users'' configuration rights, restricting the service to Administrators/SYSTEM, and auditing for the same pattern elsewhere closes the chain completely. Option b.', 25, 2),

  ('mission-w34-06-o3-c1', 'orientation', 'You''ve already confirmed the chain and chosen the hardening -- combine them.', 20, 1),
  ('mission-w34-06-o3-c1', 'concept', 'The closure needs to name the exact service and the exact permission fix.', 30, 2),
  ('mission-w34-06-o3-c1', 'tool_direction', 'State the weak ACL and its use first, then the hardening steps.', 40, 3),
  ('mission-w34-06-o3-c1', 'near_solution', 'BackupToolSvc''s weak service ACL, exploited right before Administrator activity appeared; fixed by restricting configuration rights to Administrators/SYSTEM.', 50, 4),
  ('mission-w34-06-o3-c1', 'solution', 'BackupToolSvc ran as LocalSystem with a service ACL that let Authenticated Users change its binary path -- and the incident timeline confirms it was actually modified right before Administrator-level activity appeared. Restricting configuration rights to Administrators/SYSTEM, and auditing every other service for the same pattern, closes the chain completely.', 65, 5);
