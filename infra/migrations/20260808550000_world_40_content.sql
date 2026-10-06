-- world-40 ("SOC Operations: Red Alert") mission content, generated from
-- docs/12-world-story-bible.md. Opens Act 6 "The Hunt" -- mission 1 picks up
-- the instant world-39 leaves off: Cipher's SENTINEL reveal cut off by a
-- live, multi-sector alert flood. The player is pulled straight into the
-- SOC before Cipher's reveal can be unpacked. Mission 1 is cross-world-gated
-- on world-39's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-40a', 'world-40', 'red-alert', '40A - Red Alert', 'Alerts, incidents, SIEM, EDR/XDR, IDS/IPS and SOAR, learned triaging a flood of noise under time pressure.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-40a-1', 'campaign-40a', 'foundations', 'Foundations', 'Alerts, incidents, SIEM, EDR/XDR, IDS/IPS and SOAR concepts, learned as the vocabulary of active defense.', 1),
  ('operation-40a-2', 'campaign-40a', 'triage', 'Triage', 'Severity calls, log pivots, correlation and escalation, run against a flood of alerts that will not stop.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w40-01', 'world-40', 'campaign-40a', 'operation-40a-1', 'thrown-into-the-flood', 'Thrown Into the Flood', 'Cipher''s reveal is still hanging in the air. There''s no time to sit with it -- hospitals, banks and airports are all lighting up at once.', 'intro', ARRAY['luna', 'byte', 'zayn', 'ava'], '{"requiredMissionIds":["mission-w39-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w40-02', 'world-40', 'campaign-40a', 'operation-40a-1', 'alert-incident-or-neither', 'Alert, Incident, or Neither', 'A SIEM full of red doesn''t mean a SOC full of incidents. Learn the vocabulary before the queue teaches it to you the hard way.', 'beginner', ARRAY['luna', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w40-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"soc-toolchain-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w40-03', 'world-40', 'campaign-40a', 'operation-40a-1', 'where-the-evidence-lives', 'Where the Evidence Lives', 'Every log source tells a different part of the story. Knowing which one to open first is half of triage.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w40-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"log-source-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w40-04', 'world-40', 'campaign-40a', 'operation-40a-2', 'the-queue-doesnt-stop', 'The Queue Doesn''t Stop', 'The alert queue does not pause while you think. Every alert gets a call, and the ones behind it keep coming regardless.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w40-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"alert-queue-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w40-05', 'world-40', 'campaign-40a', 'operation-40a-2', 'two-halves-of-the-same-story', 'Two Halves of the Same Story', 'An endpoint alert and a network log are two halves of the same story. Read them together, then decide what happens next.', 'advanced', ARRAY['zayn', 'byte', 'luna'], '{"requiredMissionIds":["mission-w40-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"correlation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w40-06', 'world-40', 'campaign-40a', 'operation-40a-2', 'red-alert-boss', 'Red Alert', 'Triage a flood of alerts and identify the few that represent a coordinated intrusion.', 'boss', ARRAY['luna', 'byte', 'zayn', 'ava'], '{"requiredMissionIds":["mission-w40-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"red-alert-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"skillXp":{"soc":50},"badgeIds":["red-alert"]}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w40-01', 1, 'luna', 'Everyone into the SOC, now. Whatever Cipher was about to tell you keeps until the alerts stop moving.'),
  ('mission-w40-01', 2, 'byte', '...Alert count still climbing. Correlated events across three sectors, twelve organizations, in the last four minutes alone.'),
  ('mission-w40-01', 3, 'zayn', 'Cipher''s still sitting in the back of my head. But there''s a wall of red in front of us and no time to think about anything else right now.'),
  ('mission-w40-01', 4, 'ava', 'Then we stop thinking about what we can''t control and start triaging what we can. First rule: not every alert is an incident.'),
  ('mission-w40-01', 5, 'luna', 'You''re in the queue with the rest of us. Watch, listen, keep up -- we''ll explain as we go.'),
  ('mission-w40-02', 1, 'luna', 'An alert is a machine telling you something looked unusual. An incident is a human deciding that unusual actually matters. Confuse the two and a SOC drowns in its own noise.'),
  ('mission-w40-02', 2, 'byte', 'The SIEM is where every log source reports in -- endpoint, network, identity, cloud. It aggregates and correlates. It does not decide anything on its own.'),
  ('mission-w40-02', 3, 'zayn', 'EDR and XDR watch the endpoint itself -- process trees, file writes, registry changes. IDS and IPS watch the wire. SOAR is what actually runs a playbook once something, or someone, decides to act.'),
  ('mission-w40-03', 1, 'byte', 'A laptop in the finance department suddenly spawns a PowerShell process from Microsoft Word. Where would you actually look first to confirm that happened?'),
  ('mission-w40-04', 1, 'ava', 'The queue doesn''t pause while you think. Every alert gets a call -- dismiss it, watch it, or escalate it -- and the queue behind it keeps growing either way.'),
  ('mission-w40-05', 1, 'zayn', 'An EDR alert on its own is a maybe. A network log on its own is a maybe. Put them together and sometimes the maybe disappears.'),
  ('mission-w40-05', 2, 'byte', 'Here''s a process that reached out right after it was flagged. Here''s the connection it made. Read them as one story, not two.'),
  ('mission-w40-05', 3, 'luna', 'Once you''ve confirmed it, you still have to decide what happens next -- and not every confirmed alert gets the same response.'),
  ('mission-w40-06', 1, 'luna', 'The board still has forty-plus open alerts. Most of them are noise. A few of them aren''t. Find the few.'),
  ('mission-w40-06', 2, 'byte', 'I''ve pulled every alert from the last six hours across all twelve organizations. No two share a file hash, a domain, or an IP.'),
  ('mission-w40-06', 3, 'zayn', 'Then they''re not related by anything a signature would catch.'),
  ('mission-w40-06', 4, 'ava', 'So stop looking for what they share on paper, and look for what they share in behavior.'),
  ('mission-w40-06', 5, 'byte', '...Running the comparison now.'),
  ('mission-w40-06', 6, 'byte', 'There it is. Different tools, different infrastructure, same rhythm -- the same dwell time before first action, the same order of steps, almost to the second, across every real incident in this set.'),
  ('mission-w40-06', 7, 'luna', 'That''s not a coincidence. That''s one actor running the same playbook twelve times in parallel.'),
  ('mission-w40-06', 8, 'ava', 'The true alerts share no IOC, only a behavioral rhythm.'),
  ('mission-w40-06', 9, 'zayn', 'Which means every signature we own is about to be useless against whatever comes next.'),
  ('mission-w40-06', 10, 'luna', 'It already is. We need detection that doesn''t depend on knowing the file or the IP in advance.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w40-01-o1', 'mission-w40-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to step into the SOC mid-crisis.'),
  ('mission-w40-02-o1', 'mission-w40-02', 1, 'Map each SOC tool to its role', 'Match each tool to what it actually does in the SOC.'),
  ('mission-w40-03-o1', 'mission-w40-03', 1, 'Identify the right log source', 'Choose the log source that would show this activity first.'),
  ('mission-w40-04-o1', 'mission-w40-04', 1, 'Triage the incoming alert queue', 'Assign the correct action to each alert before the next one lands.'),
  ('mission-w40-05-o1', 'mission-w40-05', 1, 'Correlate the endpoint and network evidence', 'Determine whether the network log confirms the EDR alert.'),
  ('mission-w40-05-o2', 'mission-w40-05', 2, 'Choose the escalation path', 'Decide what happens now that the alert is confirmed.'),
  ('mission-w40-06-o1', 'mission-w40-06', 1, 'Separate the flood from the intrusion', 'Identify which alerts belong to the coordinated intrusion, out of the full flood.'),
  ('mission-w40-06-o2', 'mission-w40-06', 2, 'Name what actually connects them', 'State what the confirmed alerts actually share.'),
  ('mission-w40-06-o3', 'mission-w40-06', 3, 'Close the triage', 'Confirm the coordinated set and what connects it, together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w40-01-o1-c1', 'mission-w40-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to step into the SOC.', '{"lines":[{"text":"The board is already full and it''s not slowing down. Ready to step in?","characterId":"luna"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w40-02-o1-c1', 'mission-w40-02-o1', 1, 'drag_and_drop', 'Match each tool to what it actually does in the SOC.', '{"items":[{"id":"t1","text":"SIEM"},{"id":"t2","text":"EDR/XDR"},{"id":"t3","text":"IDS/IPS"},{"id":"t4","text":"SOAR"}],"targets":[{"id":"aggregation","label":"Aggregates and correlates logs from every source"},{"id":"endpoint","label":"Endpoint telemetry -- process, file and registry activity"},{"id":"network","label":"Network traffic pattern detection and blocking"},{"id":"automation","label":"Automates response playbooks once a decision is made"}]}'::jsonb, '{"correctMapping":{"t1":"aggregation","t2":"endpoint","t3":"network","t4":"automation"}}'::jsonb),

  ('mission-w40-03-o1-c1', 'mission-w40-03-o1', 1, 'investigation', 'Which log source would show this process lineage first?', '{"evidence":[{"id":"e1","label":"EDR endpoint telemetry","detail":"Full process lineage: winword.exe spawning powershell.exe, with the complete command line captured"},{"id":"e2","label":"Firewall netflow","detail":"Shows only the laptop''s external connections -- no process-level detail at all"},{"id":"e3","label":"Email gateway log","detail":"Shows the message arrived and was opened -- nothing about what happened on the endpoint afterward"}],"question":"Which log source would show this process lineage first?"}'::jsonb, '{"requiredEvidenceIds":["e1"]}'::jsonb),

  ('mission-w40-04-o1-c1', 'mission-w40-04-o1', 1, 'timed_incident', 'Assign each alert the correct triage action before the next one lands.', '{"alerts":[{"id":"a1","detail":"Failed login, single user, mistyped password, succeeded on retry thirty seconds later","source":"Identity"},{"id":"a2","detail":"A brand-new scheduled task created on a domain controller, by a service account that has never touched that host before","source":"EDR"},{"id":"a3","detail":"A vendor-managed backup job runs twenty minutes later than its usual schedule -- no error logged anywhere","source":"SIEM"},{"id":"a4","detail":"A finance server begins a large outbound transfer to an unfamiliar external IP at 3 AM, with no change ticket on file","source":"Network"}],"actions":["dismiss","monitor","escalate"],"question":"Assign each alert the correct triage action: dismiss, monitor, or escalate.","timeLimitSeconds":180}'::jsonb, '{"correctMapping":{"a1":"dismiss","a2":"escalate","a3":"monitor","a4":"escalate"}}'::jsonb),

  ('mission-w40-05-o1-c1', 'mission-w40-05-o1', 1, 'log_analysis', 'Which network log entry actually confirms the EDR alert?', '{"logLines":[{"id":"n1","text":"suspicious-proc.exe (child of winword.exe) flagged for an unusual outbound connection attempt at 14:02:07","source":"EDR"},{"id":"n2","text":"Outbound connection from the same host at 14:02:08, 64-byte packets, to a destination with no prior history, repeating every five minutes since","source":"Network"},{"id":"n3","text":"Unrelated outbound web browsing traffic from the same subnet, normal variable sizing, no correlation to the EDR timestamp","source":"Network"}],"question":"Which network log entry actually confirms the EDR alert?"}'::jsonb, '{"requiredLogLineIds":["n2"]}'::jsonb),

  ('mission-w40-05-o2-c1', 'mission-w40-05-o2', 1, 'multiple_choice', 'The alert is confirmed: a flagged process is beaconing out on a fixed interval. What''s the right next step?', '{"options":[{"id":"a","text":"Dismiss it -- a single host isn''t worth the attention"},{"id":"b","text":"Escalate to the incident response track and isolate the host through the SOAR playbook, not just log it and move on"},{"id":"c","text":"Wait until three more hosts show the same pattern before doing anything"},{"id":"d","text":"Delete the process and close the alert with no further action"}],"question":"The alert is confirmed: a flagged process is beaconing out on a fixed interval. What''s the right next step?"}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w40-06-o1-c1', 'mission-w40-06-o1', 1, 'log_analysis', 'Which alerts share the same behavioral rhythm, not the same indicators?', '{"logLines":[{"id":"f1","text":"Malware quarantined automatically by antivirus, single workstation, known adware family","source":"HarborBank"},{"id":"f2","text":"New admin-equivalent account created eleven minutes after an initial phishing click, followed by domain enumeration within ninety seconds","source":"Mercy General"},{"id":"f3","text":"Printer driver installation triggers a benign vendor telemetry alert","source":"Union Airfreight"},{"id":"f4","text":"Admin-equivalent account created twelve minutes after a phishing click, domain enumeration within eighty-five seconds of that","source":"SkyPort Regional"},{"id":"f5","text":"A VPN session drops and reconnects twice during a storm-related outage","source":"Meridian Trust"},{"id":"f6","text":"Admin-equivalent account created ten minutes after a phishing click, domain enumeration under two minutes later","source":"Cascade Medical"}],"question":"Which alerts share the same behavioral rhythm, not the same indicators?"}'::jsonb, '{"requiredLogLineIds":["f2","f4","f6"]}'::jsonb),

  ('mission-w40-06-o2-c1', 'mission-w40-06-o2', 1, 'multiple_choice', 'What do the confirmed alerts actually have in common?', '{"options":[{"id":"a","text":"The same malware hash"},{"id":"b","text":"The same command-and-control IP"},{"id":"c","text":"No shared IOC at all -- only the same behavioral rhythm: dwell time, order of steps, and timing, repeated almost exactly"},{"id":"d","text":"Nothing -- they are unrelated"}],"question":"What do the confirmed alerts actually have in common?"}'::jsonb, '{"correctOptionId":"c"}'::jsonb),

  ('mission-w40-06-o3-c1', 'mission-w40-06-o3', 1, 'boss_encounter', 'Confirm the coordinated set and what connects it, together.', '{"task":"Confirm the coordinated set and what connects it, together.","stages":[{"label":"The coordinated set","objectiveRef":"mission-w40-06-o1"},{"label":"What connects it","objectiveRef":"mission-w40-06-o2"}]}'::jsonb, '{"allCorrect":true,"requiredObjectiveIds":["mission-w40-06-o1","mission-w40-06-o2"]}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w40-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),
  ('mission-w40-02-o1-c1', 'orientation', 'Think about where each tool actually sits -- the wire, the endpoint, the log pipeline, or the response step.', 15, 1),
  ('mission-w40-02-o1-c1', 'concept', 'One of these ingests everything without deciding, two watch different layers of activity, and one only acts after a decision is made.', 25, 2),
  ('mission-w40-02-o1-c1', 'solution', 'SIEM aggregates and correlates every log source; EDR/XDR watches the endpoint; IDS/IPS watches the network; SOAR automates the response playbook.', 35, 3),
  ('mission-w40-03-o1-c1', 'orientation', 'Two of these log sources can''t see inside the process tree at all.', 15, 1),
  ('mission-w40-03-o1-c1', 'concept', 'Process lineage -- one process spawning another -- is endpoint-level detail, not network or email detail.', 25, 2),
  ('mission-w40-03-o1-c1', 'solution', 'EDR endpoint telemetry (e1) is built to capture exactly this: one process spawning another, with the full command line.', 35, 3),
  ('mission-w40-04-o1-c1', 'orientation', 'Ask what''s actually unusual about each one -- and whether it explains itself.', 15, 1),
  ('mission-w40-04-o1-c1', 'concept', 'A self-resolved typo explains itself. Unscheduled admin actions on sensitive hosts and unexplained large outbound transfers don''t.', 25, 2),
  ('mission-w40-04-o1-c1', 'tool_direction', 'The backup job isn''t clearly malicious, but it''s also not normal -- that''s a monitor, not a dismiss or an escalate.', 30, 3),
  ('mission-w40-04-o1-c1', 'solution', 'a1 dismiss (self-resolved typo), a2 escalate (unexplained privileged action on a domain controller), a3 monitor (unexplained but not clearly malicious timing drift), a4 escalate (unexplained large outbound transfer off-hours).', 40, 4),
  ('mission-w40-05-o1-c1', 'orientation', 'One of the three network entries actually lines up in time with the EDR alert.', 15, 1),
  ('mission-w40-05-o1-c1', 'concept', 'Correlation means the timestamps, the host, and the behavior all line up -- not just similar-looking traffic somewhere nearby.', 25, 2),
  ('mission-w40-05-o1-c1', 'solution', 'n2 matches the EDR timestamp almost exactly and shows the beacon-like pattern that followed -- n3 is unrelated traffic that just happens to be nearby.', 35, 3),
  ('mission-w40-05-o2-c1', 'orientation', 'Think about what''s actually confirmed here, and what a delay would cost.', 15, 1),
  ('mission-w40-05-o2-c1', 'solution', 'A confirmed beaconing process should be escalated and contained through the SOAR playbook immediately -- waiting for more hosts, or just deleting the process, both let the beacon keep running. Option b.', 25, 2),
  ('mission-w40-06-o1-c1', 'orientation', 'Ignore what each alert is made of and look at the sequence and timing instead.', 15, 1),
  ('mission-w40-06-o1-c1', 'concept', 'Three of these have an ordinary, self-contained explanation. Three share an unusually precise timing pattern between phishing click, privilege gain, and enumeration.', 25, 2),
  ('mission-w40-06-o1-c1', 'tool_direction', 'Line up the minutes between "phishing click" and "admin account created," then between that and "domain enumeration," across every alert.', 35, 3),
  ('mission-w40-06-o1-c1', 'near_solution', 'f2, f4 and f6 all show privilege escalation ten to twelve minutes after the click, and enumeration under two minutes after that -- an almost identical cadence.', 45, 4),
  ('mission-w40-06-o1-c1', 'solution', 'f2, f4 and f6 are the coordinated intrusion set -- same rhythm of phish, escalate, enumerate, timed almost to the second, despite different organizations and no shared indicator. f1, f3 and f5 all have ordinary, unrelated explanations.', 55, 5),
  ('mission-w40-06-o2-c1', 'orientation', 'You already found what lines up between the three real alerts -- it wasn''t a shared file or address.', 15, 1),
  ('mission-w40-06-o2-c1', 'solution', 'No shared IOC -- the connection is the behavioral rhythm itself: the same dwell time and the same order of steps, repeated almost exactly. Option c.', 25, 2),
  ('mission-w40-06-o3-c1', 'orientation', 'You''ve already separated the real alerts and named what connects them -- bring both together.', 20, 1),
  ('mission-w40-06-o3-c1', 'concept', 'Closing this out means stating which alerts are real and why they''re connected, in one answer.', 30, 2),
  ('mission-w40-06-o3-c1', 'tool_direction', 'Name the three confirmed alerts first, then the behavioral pattern that ties them together.', 40, 3),
  ('mission-w40-06-o3-c1', 'near_solution', 'f2, f4 and f6, tied together by identical timing between phishing click, privilege escalation and enumeration -- not by any shared indicator.', 50, 4),
  ('mission-w40-06-o3-c1', 'solution', 'The coordinated intrusion set is f2 (Mercy General), f4 (SkyPort Regional) and f6 (Cascade Medical) -- three organizations, three different toolsets, zero shared indicators, and the exact same rhythm: phishing click, admin-equivalent account within twelve minutes, domain enumeration under two minutes after that. The true alerts share no IOC, only a behavioral rhythm.', 65, 5);
