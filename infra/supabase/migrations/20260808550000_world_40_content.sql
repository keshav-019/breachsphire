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

