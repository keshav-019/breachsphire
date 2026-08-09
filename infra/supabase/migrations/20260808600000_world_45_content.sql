-- world-45 ("Malware Analysis: The Specimen") mission content, generated
-- from docs/12-world-story-bible.md. Opens with the RESILIENCE_TRIAL_07
-- label recovered from forensics -- mission 1 is cross-world-gated on
-- world-44's boss mission. The preserved sample from Mercy behaves like
-- ransomware but carries extensive telemetry logic; static and dynamic
-- analysis answer whether destruction was the goal or the experiment.
-- Closes on an encrypted configuration module with no obvious symbols,
-- handing off to world-46's reverse engineering.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-45a', 'world-45', 'static-and-dynamic', '45A - Static and Dynamic', 'Strings, imports, hashes, PE structure and sandbox behavior, learned by classifying one live specimen.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-45a-1', 'campaign-45a', 'foundations', 'Foundations', 'File format, strings and imports -- what the sample is, before it ever runs.', 1),
  ('operation-45a-2', 'campaign-45a', 'investigation', 'Investigation', 'Sandbox behavior, network activity and configuration extraction -- what the sample actually does.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w45-01', 'world-45', 'campaign-45a', 'operation-45a-1', 'the-specimen-arrives', 'The Specimen Arrives', 'RESILIENCE_TRIAL_07 is a label, not an answer. A preserved sample from Mercy is in the sandbox now, fully isolated, waiting for static analysis.', 'intro', ARRAY['ava', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w44-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w45-02', 'world-45', 'campaign-45a', 'operation-45a-1', 'first-look', 'First Look', 'Before a single string is read, the file format itself already tells you something -- and it isn''t intent.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w45-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"specimen-static-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 2),
  ('mission-w45-03', 'world-45', 'campaign-45a', 'operation-45a-1', 'strings-and-imports', 'Strings and Imports', 'Encryption calls explain the ransomware. Something else in this import table doesn''t belong to ransomware at all.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w45-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"specimen-strings-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w45-04', 'world-45', 'campaign-45a', 'operation-45a-2', 'inside-the-sandbox', 'Inside the Sandbox', 'Watch it actually run, safely, and time every stage the way it timed itself.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w45-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"specimen-sandbox-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w45-05', 'world-45', 'campaign-45a', 'operation-45a-2', 'the-network-and-the-verdict', 'The Network and the Verdict', 'The traffic it generates and the classification you assign it are the same question, asked two ways.', 'advanced', ARRAY['zayn', 'ava'], '{"requiredMissionIds":["mission-w45-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"specimen-network-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w45-06', 'world-45', 'campaign-45a', 'operation-45a-2', 'the-specimen-boss', 'The Specimen', 'Classify the sample, explain its behavior, and extract the configuration that defines the trial.', 'boss', ARRAY['byte', 'zayn', 'ava'], '{"requiredMissionIds":["mission-w45-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"the-specimen-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["the-specimen"],"skillXp":{"malware_analysis":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w45-01', 1, 'ava', 'RESILIENCE_TRIAL_07. We have the label. Now we need to know what the payload actually is, underneath the ransomware behavior.'),
  ('mission-w45-01', 2, 'byte', '...A preserved sample from Mercy is in the sandbox now, fully isolated. Static analysis first -- we don''t execute anything blind.'),
  ('mission-w45-01', 3, 'zayn', 'It behaves like ransomware. But there''s telemetry logic in here that has no reason to exist in something built purely to destroy.'),
  ('mission-w45-02', 1, 'byte', '...The header alone won''t tell you intent. It''ll tell you what you''re actually looking at, which is where every analysis has to start.'),
  ('mission-w45-03', 1, 'zayn', 'Sort what this thing imports. Some of it explains the ransomware. Some of it explains something else entirely.'),
  ('mission-w45-04', 1, 'byte', '...Sandboxed, isolated, monitored. Watch every stage transition, and notice which ones it times.'),
  ('mission-w45-05', 1, 'zayn', 'Whatever this is calling home to, it isn''t just sending encrypted files.'),
  ('mission-w45-05', 2, 'ava', 'So we classify it properly. Was destruction the goal, or the experiment?'),
  ('mission-w45-06', 1, 'byte', '...Full picture assembled. Static format, strings and imports, sandbox behavior, network traffic -- all one classification.'),
  ('mission-w45-06', 2, 'zayn', 'This isn''t commodity ransomware. It''s a ransomware-shaped testbed, instrumented to log its own timings and phone them home.'),
  ('mission-w45-06', 3, 'ava', 'So was destruction the goal, or the experiment?'),
  ('mission-w45-06', 4, 'byte', '...The experiment. Destruction was just the cover it wore while it measured us.'),
  ('mission-w45-06', 5, 'zayn', 'I pulled the full configuration block. trial_id matches what forensics found. Telemetry endpoint, sample metadata -- all there.'),
  ('mission-w45-06', 6, 'byte', '...There''s one more thing in that config. A module reference: core.enc. AES-encrypted, zero exported symbols, entropy right at the edge of what compression alone would explain.'),
  ('mission-w45-06', 7, 'ava', 'No symbols means no easy read on what it actually does.'),
  ('mission-w45-06', 8, 'zayn', 'Then we stop analyzing behavior from the outside, and start taking it apart.'),
  ('mission-w45-06', 9, 'byte', '...Reverse engineering. That encrypted module is next.');

