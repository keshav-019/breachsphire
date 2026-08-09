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

