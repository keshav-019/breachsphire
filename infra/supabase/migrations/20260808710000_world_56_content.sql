-- world-56 ("OT / ICS / SCADA: Blackout Grid") mission content, generated
-- from docs/12-world-story-bible.md. Closes Act 7 "Cloudfall". Mission 1 is
-- cross-world-gated on world-55's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-56a', 'world-56', 'blackout-grid', '56A - Blackout Grid', 'A coordinated resilience trial against a simulated regional power grid, where availability and safety outrank every normal IT instinct.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-56a-1', 'campaign-56a', 'foundations', 'Foundations', 'HMIs, PLCs, industrial protocols and network segmentation, learned with safety-first discipline.', 1),
  ('operation-56a-2', 'campaign-56a', 'investigation', 'Investigation', 'Stop the simulated disruption while maintaining safe process conditions and preserving evidence.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w56-01', 'world-56', 'campaign-56a', 'operation-56a-1', 'not-a-normal-incident', 'Not a Normal Incident', 'Sentinel-X has begun a coordinated resilience trial against a simulated regional power grid. You cannot simply reboot or isolate everything -- people depend on this staying safe, not just secure.', 'intro', ARRAY['luna', 'ava', 'zayn'], '{"requiredMissionIds":["mission-w55-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w56-02', 'world-56', 'campaign-56a', 'operation-56a-1', 'reading-the-process-not-the-network', 'Reading the Process, Not the Network', 'The HMI shows the actual physical process -- voltages, breaker states, load. Learn to read it before touching anything.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w56-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"hmi-process-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w56-03', 'world-56', 'campaign-56a', 'operation-56a-1', 'a-command-that-shouldnt-exist', 'A Command That Shouldn''t Exist', 'A write command to a PLC register that no legitimate operator workflow ever sends.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w56-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"industrial-protocol-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w56-04', 'world-56', 'campaign-56a', 'operation-56a-2', 'where-to-cut-without-cutting-safety', 'Where to Cut Without Cutting Safety', 'Segmentation has to isolate the attack path without touching the safety instrumented systems that keep the process from becoming dangerous.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w56-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"purdue-zone-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w56-05', 'world-56', 'campaign-56a', 'operation-56a-2', 'seconds-that-matter', 'Seconds That Matter', 'Every second the malicious commands keep executing, the risk grows. Every second spent acting recklessly grows it faster.', 'advanced', ARRAY['luna'], '{"requiredMissionIds":["mission-w56-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"safety-first-containment-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w56-06', 'world-56', 'campaign-56a', 'operation-56a-2', 'blackout-grid-boss', 'Blackout Grid', 'Stop the simulated disruption while maintaining safe process conditions throughout, and preserve the evidence needed to understand exactly what happened.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w56-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"blackout-grid-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["blackout-grid"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w56-01', 1, 'luna', 'Sentinel-X has started a coordinated resilience trial against a simulated regional power grid. This is not a normal incident.'),
  ('mission-w56-01', 2, 'ava', 'Everything you''ve learned about isolating and shutting things down -- forget the reflex. Here, availability and safety come before speed.'),
  ('mission-w56-01', 3, 'zayn', 'You cannot simply reboot or isolate everything. People depend on this grid staying both secure and safe, and those aren''t always the same action.'),
  ('mission-w56-02', 1, 'zayn', 'The HMI isn''t showing you a network. It''s showing you the actual physical process -- voltages, breaker states, load. Learn to read that before you touch anything.'),
  ('mission-w56-03', 1, 'byte', 'A write command to a PLC register, sent from an address with no legitimate operator workflow that would ever send it.'),
  ('mission-w56-04', 1, 'luna', 'Segmentation has to isolate the attack path without cutting off the safety instrumented systems. Cut the wrong zone, and you create the danger you''re trying to prevent.'),
  ('mission-w56-05', 1, 'luna', 'Every second these commands keep executing, the risk grows. Every second spent acting recklessly grows it faster. Choose carefully.'),
  ('mission-w56-06', 1, 'luna', 'Stop the disruption. Keep the process in a safe state the entire time. Preserve every piece of evidence as you go -- this will be studied for months.'),
  ('mission-w56-06', 2, 'byte', '...Disruption stopped. Process held within safe operating range throughout. Evidence chain intact.'),
  ('mission-w56-06', 3, 'zayn', 'That took real discipline. Every instinct said isolate everything immediately, and that would have been the wrong call.'),
  ('mission-w56-06', 4, 'ava', 'What actually let them reach a PLC register directly like that? That shouldn''t have been reachable at all.'),
  ('mission-w56-06', 5, 'byte', 'The trial used a memory-safety flaw in a gateway component. One nobody has ever seen before.'),
  ('mission-w56-06', 6, 'luna', 'A previously unknown flaw means we can''t patch what we don''t understand yet. Time to go find out exactly how it works.');

