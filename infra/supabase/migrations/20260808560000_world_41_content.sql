-- world-41 ("Detection Engineering: Signal in the Noise") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 6 "The Hunt" --
-- the flood of world-40 is triaged but every signature the Guardians own is
-- already going stale, so the player builds behavior-based detections that
-- don't key on a single hash or IP. Mission 1 is cross-world-gated on
-- world-40's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-41a', 'world-41', 'signal-in-the-noise', '41A - Signal in the Noise', 'Sigma, YARA, Sysmon, Zeek and Suricata concepts, learned building behavior-based detections that don''t depend on a single hash or IP.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-41a-1', 'campaign-41a', 'foundations', 'Foundations', 'Sigma, YARA, Sysmon, Zeek and Suricata concepts, learned as the building blocks of behavior-based detection.', 1),
  ('operation-41a-2', 'campaign-41a', 'validation', 'Validation', 'Writing, tuning and validating a detection against real, replayed data -- not just theory.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w41-01', 'world-41', 'campaign-41a', 'operation-41a-1', 'faster-than-the-feed', 'Faster Than the Feed', 'Every IOC the team published yesterday is already useless. Sentinel-X is changing hashes, domains and infrastructure faster than any feed can keep up.', 'intro', ARRAY['luna', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w40-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w41-02', 'world-41', 'campaign-41a', 'operation-41a-1', 'the-rule-instead-of-the-hash', 'The Rule Instead of the Hash', 'A Sigma rule doesn''t say "block this hash." It says "alert when a process behaves like this" -- described once, matched anywhere.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w41-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"sigma-behavior-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w41-03', 'world-41', 'campaign-41a', 'operation-41a-1', 'what-sysmon-actually-sees', 'What Sysmon Actually Sees', 'Sysmon doesn''t replace an EDR, but it''s the free, detailed layer underneath almost every rule the team writes.', 'beginner', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w41-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"sysmon-events-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w41-04', 'world-41', 'campaign-41a', 'operation-41a-2', 'zeek-suricata-and-the-wire', 'Zeek, Suricata, and the Wire', 'One tool logs everything that happens on the wire. The other matches traffic against what it already knows to look for.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w41-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"zeek-suricata-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w41-05', 'world-41', 'campaign-41a', 'operation-41a-2', 'tuning-out-the-noise', 'Tuning Out the Noise', 'A detection nobody trusts gets muted within a week. Fix the noise before it ships.', 'advanced', ARRAY['byte', 'luna'], '{"requiredMissionIds":["mission-w41-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"rule-tuning-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w41-06', 'world-41', 'campaign-41a', 'operation-41a-2', 'signal-in-the-noise-boss', 'Signal in the Noise', 'Create a robust detection for a Sentinel-X behavior without keying on a single hash or IP.', 'boss', ARRAY['luna', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w41-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"signal-in-the-noise-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["signal-in-the-noise"],"skillXp":{"soc":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w41-01', 1, 'luna', 'Every IOC we published from yesterday''s flood is already dead. New hashes, new domains, new infrastructure -- Sentinel-X is rotating artifacts faster than any feed updates.'),
  ('mission-w41-01', 2, 'byte', 'I''ve tried matching against three different threat-intel feeds. All three are already stale by the time they sync.'),
  ('mission-w41-01', 3, 'zayn', 'So matching what it used to look like isn''t going to work anymore.'),
  ('mission-w41-01', 4, 'luna', 'Which means we stop chasing artifacts and start writing detections for what it does, not what it happens to be wearing today.'),
  ('mission-w41-02', 1, 'byte', 'A Sigma rule doesn''t say "block this hash." It says "alert when a process behaves like this" -- described once, matched anywhere.'),
  ('mission-w41-02', 2, 'byte', 'The best rules key on what an attacker has to do, not what tool they happened to use to do it.'),
  ('mission-w41-03', 1, 'zayn', 'Sysmon doesn''t replace your EDR, but it''s the free, detailed layer underneath almost everything we write rules against.'),
  ('mission-w41-03', 2, 'byte', 'Event ID 1 is process creation with the full command line. Event ID 3 is network connection. Event ID 11 is file creation. Almost everything else builds on those three.'),
  ('mission-w41-04', 1, 'zayn', 'Zeek doesn''t match signatures -- it builds a rich, structured log of every connection: protocol, duration, bytes, certificate details, all of it.'),
  ('mission-w41-04', 2, 'zayn', 'Suricata does the opposite. It matches traffic against defined rules and can block in-line, the way an IDS/IPS traditionally works.'),
  ('mission-w41-05', 1, 'byte', 'First draft of the rule is done. It''s also firing four hundred times an hour.'),
  ('mission-w41-05', 2, 'luna', 'A detection nobody trusts gets muted within a week. Fix the noise before it ships.'),
  ('mission-w41-06', 1, 'byte', 'Detection assembled. Running it live first, then against six months of replayed data just to be safe.'),
  ('mission-w41-06', 2, 'zayn', 'Live traffic first -- clean catch, no false positives so far.'),
  ('mission-w41-06', 3, 'byte', '...Now running it backward.'),
  ('mission-w41-06', 4, 'luna', 'How far backward.'),
  ('mission-w41-06', 5, 'byte', 'All the way. Six months of replayed logs, every organization in our archive.'),
  ('mission-w41-06', 6, 'byte', '...Confirmed. Multiple matches, well before the first flood alert. This behavior was here long before anyone noticed it.'),
  ('mission-w41-06', 7, 'luna', 'The detection reveals activity that began before any alert was generated.'),
  ('mission-w41-06', 8, 'zayn', 'So we weren''t slow to see the flood. The flood was already old news by the time it reached us.'),
  ('mission-w41-06', 9, 'luna', 'Which means chasing alerts isn''t enough anymore. We need to go looking before anything trips a wire at all.'),
  ('mission-w41-06', 10, 'byte', 'That''s not a detection engineering problem anymore. That''s threat hunting.');

