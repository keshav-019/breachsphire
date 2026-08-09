-- world-16 ("Shell & Automation: Ghost in the Shell") mission content,
-- generated from docs/12-world-story-bible.md. The infrastructure cluster
-- Signal Harvester surfaced reconfigures every few minutes, leaving
-- short-lived traces on Linux and Windows. Bash-specific missions
-- (pipelines, scheduled collection, the Watcher capstone) use the real
-- simulated shell in apps/web/src/lib/terminal/; PowerShell and
-- JSON/YAML/cross-platform missions have no such engine and are modeled as
-- text-based investigation/multiple_choice/drag_and_drop content, same
-- approach used for the Windows worlds. Mission 1 is cross-world-gated on
-- world-15's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-16a', 'world-16', 'ghost-in-the-shell', '16A - Ghost in the Shell', 'The infrastructure cluster reconfigures every few minutes. Bash and PowerShell turn a blink-and-you-miss-it window into reliable, repeatable evidence.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-16a-1', 'campaign-16a', 'foundations', 'Foundations', 'Bash pipelines and scheduled collection jobs, learned catching evidence that does not sit still.', 1),
  ('operation-16a-2', 'campaign-16a', 'investigation', 'Investigation', 'PowerShell automation, structured data and a monitoring routine built to catch the cluster mid-change.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w16-01', 'world-16', 'campaign-16a', 'operation-16a-1', 'ghost-in-the-shell', 'Ghost in the Shell', 'The indicators from Signal Harvester keep pointing at the same infrastructure cluster, but its registration details change every time anyone looks.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w15-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w16-02', 'world-16', 'campaign-16a', 'operation-16a-1', 'pipe-the-signal', 'Pipe the Signal', 'A status log is capturing every state change faster than anyone could read it by eye. Filter it, do not scroll it.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w16-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"cluster-watch-pipeline-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w16-03', 'world-16', 'campaign-16a', 'operation-16a-1', 'the-job-collecting-evidence', 'The Job Collecting Evidence', 'Three scheduled jobs run on this host. Only one of them is actually watching the cluster, once a minute, every minute.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w16-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"cluster-watch-cron-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w16-04', 'world-16', 'campaign-16a', 'operation-16a-2', 'filter-objects-not-text', 'Filter Objects, Not Text', 'PowerShell pipelines pass objects, not lines of text. Filter by property, not by string matching.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w16-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"powershell-pipeline-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w16-05', 'world-16', 'campaign-16a', 'operation-16a-2', 'same-data-different-shape', 'Same Data, Different Shape', 'Text filtering, scheduled execution and structured-data parsing all exist on both platforms. The commands differ. The job does not.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w16-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"cross-platform-mapping-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w16-06', 'world-16', 'campaign-16a', 'operation-16a-2', 'watcher-boss', 'Watcher', 'Build a monitoring routine that actually catches the cluster mid-rotation, then find out what it left behind.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w16-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"watcher-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["watcher"],"skillXp":{"programming":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w16-01', 1, 'zayn', 'The indicators from Signal Harvester keep pointing at the same infrastructure cluster, but the registration details are different every time we look. It is reconfiguring every few minutes.'),
  ('mission-w16-01', 2, 'zayn', 'That leaves traces -- short-lived ones, on both Linux and Windows hosts tied to this cluster. Manual collection cannot keep up with a window that small.'),
  ('mission-w16-01', 3, 'byte', 'This is where Bash and PowerShell stop being command-line trivia and start being collection infrastructure. Pipelines, scheduled jobs, structured data.'),
  ('mission-w16-01', 4, 'zayn', 'You are not typing one command and reading the result anymore. You are building something that keeps watching after you walk away. Ready?'),
  ('mission-w16-02', 1, 'byte', 'This status log is capturing every state change faster than anyone could read it by eye. Filter it, do not scroll it.'),
  ('mission-w16-03', 1, 'zayn', 'Three scheduled jobs run on this host. Only one of them is actually watching the cluster, once a minute, every minute.'),
  ('mission-w16-04', 1, 'byte', 'A PowerShell pipeline passes objects, not lines of text. Filter by property, not by string matching.'),
  ('mission-w16-05', 1, 'zayn', 'Text filtering, scheduled execution, structured-data parsing -- all three exist on both platforms. The commands differ. The job does not.'),
  ('mission-w16-06', 1, 'zayn', 'This is it. Watcher needs to actually catch the cluster mid-rotation, not just describe it after the fact.'),
  ('mission-w16-06', 2, 'zayn', 'Something got dropped during that window. Find it.'),
  ('mission-w16-06', 3, 'byte', 'Found the artifact. Running file and strings against it now.'),
  ('mission-w16-06', 4, 'byte', 'It is compiled. No readable source, barely any printable strings at all. Whatever this thing does is invisible to everything we have used so far.'),
  ('mission-w16-06', 5, 'zayn', 'Every previous artifact in this investigation, we could read -- logs, scripts, configs, even Cipher''s comments. This one gives us nothing at the shell.'),
  ('mission-w16-06', 6, 'zayn', 'Understanding it means going lower than any shell -- memory, pointers, how a compiled program actually behaves. That is the next skillset.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w16-01-o1', 'mission-w16-01', 1, 'Acknowledge the briefing', 'Confirm you are ready to build collection infrastructure, not just run one-off commands.'),
  ('mission-w16-02-o1', 'mission-w16-02', 1, 'Filter for the rotation event', 'Filter the status log for the moment the node was actually rotating configuration.'),
  ('mission-w16-03-o1', 'mission-w16-03', 1, 'Identify the real collector and its catch', 'Find the scheduled job that is actually collecting evidence, then find what it captured.'),
  ('mission-w16-04-o1', 'mission-w16-04', 1, 'Pick the correct pipeline', 'Choose the PowerShell pipeline that correctly filters by property.'),
  ('mission-w16-05-o1', 'mission-w16-05', 1, 'Map each command to its job', 'Sort each Bash or PowerShell command by what it actually does, not which platform it runs on.'),
  ('mission-w16-06-o1', 'mission-w16-06', 1, 'Catch the rotation', 'Find the snapshot where the cluster actually changed and recover the artifact it left behind.'),
  ('mission-w16-06-o2', 'mission-w16-06', 2, 'Understand what was caught', 'Determine why this artifact cannot be read the way every previous one could.'),
  ('mission-w16-06-o3', 'mission-w16-06', 3, 'Close out Watcher', 'Confirm what Watcher caught and why the investigation cannot go further with the tools you have now.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w16-01-o1-c1', 'mission-w16-01-o1', 1, 'story_dialogue', 'Confirm you are ready to continue.', '{"lines":[{"characterId":"zayn","text":"Manual collection cannot keep up with a window this small. Ready to build something that keeps watching?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w16-02-o1-c1', 'mission-w16-02-o1', 1, 'terminal_simulation', 'Filter the status log for the moment the node was actually rotating configuration, then pull out just the cfg field.', '{"instructions":"cluster-watch is capturing raw status lines faster than anyone can read them by eye. Filter for the one line where the node was actually rotating configuration, then use a pipeline to pull out just the cfg field, and submit it.","hostname":"watch-relay-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"watch-relay-01\n"},"/home/recruit":{"type":"dir"},"/var/log/cluster-watch/status.log":{"type":"file","content":"2026-08-08 03:00:01 node=edge-14 cfg=a13f state=active\n2026-08-08 03:00:07 node=edge-14 cfg=a13f state=active\n2026-08-08 03:00:13 node=edge-14 cfg=c9d2 state=rotating\n2026-08-08 03:00:19 node=edge-14 cfg=f701 state=active\n2026-08-08 03:00:25 node=edge-09 cfg=1148 state=active\n2026-08-08 03:00:31 node=edge-14 cfg=f701 state=active\n"}}}'::jsonb, '{"requiredFlag":"cfg=c9d2"}'::jsonb),

  ('mission-w16-03-o1-c1', 'mission-w16-03-o1', 1, 'terminal_simulation', 'List every scheduled job, identify the one collecting cluster-watch evidence every minute, then find the poll cycle where it actually captured something.', '{"instructions":"List every scheduled job on this host. Two are routine maintenance. One is the actual collector, running every single minute and appending to a log. Read that log and find the one cycle where it caught something.","hostname":"watch-relay-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"watch-relay-01\n"},"/home/recruit":{"type":"dir"},"/var/log/cluster-watch/poll-history.log":{"type":"file","content":"03:00:00 poll ok watch=none\n03:01:00 poll ok watch=none\n03:02:00 poll ok watch=none\n03:03:00 poll CAPTURED watch=WCH-2291\n03:04:00 poll ok watch=none\n"}},"cron":[{"schedule":"*/5 * * * *","user":"root","command":"/usr/lib/clusterwatch/health-check.sh"},{"schedule":"0 2 * * *","user":"root","command":"/usr/lib/clusterwatch/log-rotate.sh"},{"schedule":"* * * * *","user":"root","command":"/opt/clusterwatch/poll-collector.sh >> /var/log/cluster-watch/poll-history.log"}]}'::jsonb, '{"requiredFlag":"WCH-2291"}'::jsonb),

  ('mission-w16-04-o1-c1', 'mission-w16-04-o1', 1, 'multiple_choice', 'Which PowerShell pipeline correctly returns only processes with an active TCP connection to 10.66.4.9, sorted by process name?', '{"question":"A scheduled PowerShell job polls Windows hosts tied to this cluster for processes with an active TCP connection to 10.66.4.9. Which pipeline correctly returns only those processes, sorted by process name?","options":[{"id":"a","text":"Get-Process | Where-Object {$_.Name -eq \"10.66.4.9\"} | Sort-Object Name"},{"id":"b","text":"Get-NetTCPConnection -RemoteAddress 10.66.4.9 | Select-Object OwningProcess | Get-Process | Sort-Object Name"},{"id":"c","text":"Get-NetTCPConnection | Format-Table -RemoteAddress 10.66.4.9"},{"id":"d","text":"Get-Process -RemoteAddress 10.66.4.9 | Sort-Object"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w16-05-o1-c1', 'mission-w16-05-o1', 1, 'drag_and_drop', 'Sort each command by what it actually does, not which platform it runs on.', '{"items":[{"id":"d1","text":"grep -i cfg status.log"},{"id":"d2","text":"Select-String -Pattern cfg -CaseSensitive:$false"},{"id":"d3","text":"crontab -l lists: * * * * * /opt/poll-collector.sh"},{"id":"d4","text":"Register-ScheduledTask with a 1-minute repetition trigger"},{"id":"d5","text":"ConvertFrom-Json reading manifest.json"},{"id":"d6","text":"python json.load() reading manifest.json"}],"targets":[{"id":"textfilter","label":"Text/pattern filtering"},{"id":"schedule","label":"Scheduled/recurring execution"},{"id":"parse","label":"Structured data parsing"}]}'::jsonb, '{"correctMapping":{"d1":"textfilter","d2":"textfilter","d3":"schedule","d4":"schedule","d5":"parse","d6":"parse"}}'::jsonb),

  ('mission-w16-06-o1-c1', 'mission-w16-06-o1', 1, 'terminal_simulation', 'Diff these snapshots the fast way -- find the one snapshot where an artifact was actually captured, and submit its full path.', '{"instructions":"Watcher takes a snapshot of this node every minute. Most snapshots record no change at all. Search recursively for the one snapshot where an artifact was actually captured during the rotation, and submit its full path.","hostname":"watch-relay-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"watch-relay-01\n"},"/home/recruit":{"type":"dir"},"/var/lib/watcher/snapshots/snap-0300.log":{"type":"file","content":"node=edge-14 cfg=f701 artifact=none\n"},"/var/lib/watcher/snapshots/snap-0301.log":{"type":"file","content":"node=edge-14 cfg=f701 artifact=none\n"},"/var/lib/watcher/snapshots/snap-0302.log":{"type":"file","content":"node=edge-14 cfg=9be4 artifact=/opt/clusterwatch/updates/relay-9be4.bin\n"},"/var/lib/watcher/snapshots/snap-0303.log":{"type":"file","content":"node=edge-14 cfg=1a02 artifact=none\n"}}}'::jsonb, '{"requiredFlag":"/opt/clusterwatch/updates/relay-9be4.bin"}'::jsonb),

  ('mission-w16-06-o2-c1', 'mission-w16-06-o2', 1, 'investigation', 'Which evidence together explains why this artifact cannot be understood the way every previous artifact in this investigation could?', '{"evidence":[{"id":"ev1","label":"file relay-9be4.bin","detail":"Reports an ELF 64-bit executable, statically linked, with no readable debug information"},{"id":"ev2","label":"strings relay-9be4.bin | head","detail":"Returns almost nothing printable -- a handful of unrelated library version strings, no readable logic"},{"id":"ev3","label":"ls -l relay-9be4.bin","detail":"18 KB, mode 755, owned by root, dropped at the exact timestamp of the captured rotation"},{"id":"ev4","label":"cat relay-9be4.bin","detail":"Renders as raw binary noise in the terminal -- not source code, not a script, not a config file"}],"question":"Which evidence together explains why this artifact cannot be understood the way every previous artifact in this investigation could?"}'::jsonb, '{"requiredEvidenceIds":["ev1","ev4"]}'::jsonb),

  ('mission-w16-06-o3-c1', 'mission-w16-06-o3', 1, 'boss_encounter', 'Confirm what Watcher caught and why the investigation cannot go further with the tools you have now.', '{"stages":[{"objectiveRef":"mission-w16-06-o1","label":"The captured artifact"},{"objectiveRef":"mission-w16-06-o2","label":"Why it cannot be read"}],"task":"Confirm what Watcher caught and why the investigation cannot go further with the tools you have now."}'::jsonb, '{"requiredObjectiveIds":["mission-w16-06-o1","mission-w16-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w16-01-o1-c1', 'orientation', 'There is nothing to solve here -- just confirm you are ready to continue.', 0, 1),

  ('mission-w16-02-o1-c1', 'orientation', 'Most lines in this log say state=active. Only one says something else.', 15, 1),
  ('mission-w16-02-o1-c1', 'concept', 'grep pulls out only the lines matching a pattern -- filter for the state you actually care about first.', 25, 2),
  ('mission-w16-02-o1-c1', 'tool_direction', 'grep rotating status.log narrows to the one line you need; pipe that into awk to isolate a single field.', 35, 3),
  ('mission-w16-02-o1-c1', 'solution', 'grep rotating /var/log/cluster-watch/status.log | awk ''{print $4}'' isolates the rotating line and prints its fourth field, cfg=c9d2. Submit cfg=c9d2.', 45, 4),

  ('mission-w16-03-o1-c1', 'orientation', 'crontab -l lists every scheduled job for this user, with how often each one runs.', 15, 1),
  ('mission-w16-03-o1-c1', 'concept', 'A job scheduled with * * * * * runs every single minute -- that is the one actually keeping pace with a fast-changing target.', 25, 2),
  ('mission-w16-03-o1-c1', 'tool_direction', 'Once you have identified the collector, cat or grep the log it appends to for the one cycle marked CAPTURED instead of ok.', 35, 3),
  ('mission-w16-03-o1-c1', 'solution', 'crontab -l shows poll-collector.sh running every minute and appending to poll-history.log. grep CAPTURED on that log shows watch=WCH-2291. Submit WCH-2291.', 45, 4),

  ('mission-w16-04-o1-c1', 'orientation', 'Two of these four options try to filter processes using a property they do not actually have.', 15, 1),
  ('mission-w16-04-o1-c1', 'concept', 'Get-NetTCPConnection returns connection objects with an OwningProcess property -- that is the bridge from a connection back to a process.', 25, 2),
  ('mission-w16-04-o1-c1', 'solution', 'Get-NetTCPConnection -RemoteAddress 10.66.4.9 | Select-Object OwningProcess | Get-Process | Sort-Object Name filters by the actual remote-address property on connection objects, then resolves each owning process. Get-Process has no -RemoteAddress parameter, and matching Name against an IP string never succeeds.', 35, 3),

  ('mission-w16-05-o1-c1', 'orientation', 'Ignore which platform each command runs on -- ask what category of work it is doing.', 10, 1),
  ('mission-w16-05-o1-c1', 'concept', 'grep and Select-String both filter text by pattern; a cron entry and Register-ScheduledTask both set up recurring execution; ConvertFrom-Json and json.load both turn JSON text into structured data.', 20, 2),
  ('mission-w16-05-o1-c1', 'solution', 'd1/d2 are text filtering, d3/d4 are scheduled execution, and d5/d6 are structured data parsing -- the platform changes, the job the command performs does not.', 30, 3),

  ('mission-w16-06-o1-c1', 'orientation', 'Three of these four snapshots record artifact=none -- only one is different.', 15, 1),
  ('mission-w16-06-o1-c1', 'concept', 'grep -r lets you search every file under a directory at once instead of opening each snapshot by hand.', 25, 2),
  ('mission-w16-06-o1-c1', 'tool_direction', 'grep -r artifact= /var/lib/watcher/snapshots and look for the line that is not artifact=none.', 35, 3),
  ('mission-w16-06-o1-c1', 'solution', 'snap-0302.log is the only snapshot recording an actual artifact: /opt/clusterwatch/updates/relay-9be4.bin. Submit that path exactly.', 45, 4),

  ('mission-w16-06-o2-c1', 'orientation', 'Every earlier artifact in this investigation -- scripts, configs, logs -- was plain readable text. Compare that against what file and cat report here.', 15, 1),
  ('mission-w16-06-o2-c1', 'concept', 'A statically linked ELF executable with almost no printable strings is compiled machine code, not a script or a document.', 25, 2),
  ('mission-w16-06-o2-c1', 'tool_direction', 'Combine what file reports about the binary format with what cat actually shows when you try to read it directly.', 35, 3),
  ('mission-w16-06-o2-c1', 'solution', 'file identifies it as a compiled ELF executable, and cat renders it as raw binary noise -- together they confirm this is not something you can read the way every previous artifact in this investigation could be read.', 45, 4),

  ('mission-w16-06-o3-c1', 'orientation', 'You already have both pieces -- what was caught, and why it resists every tool used so far.', 20, 1),
  ('mission-w16-06-o3-c1', 'concept', 'The closing report needs the artifact''s identity and the reason ordinary shell tools cannot go further with it.', 30, 2),
  ('mission-w16-06-o3-c1', 'tool_direction', 'State the captured artifact''s path first, then why it is unreadable at the shell level.', 40, 3),
  ('mission-w16-06-o3-c1', 'near_solution', 'relay-9be4.bin, captured mid-rotation; confirmed compiled, no readable source.', 50, 4),
  ('mission-w16-06-o3-c1', 'solution', 'Watcher caught /opt/clusterwatch/updates/relay-9be4.bin during the rotation window; it is a compiled, statically linked executable with no readable source or printable strings, which is why this investigation cannot go any further with shell tools alone.', 65, 5);
