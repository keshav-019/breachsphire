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

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w56-01-o1', 'mission-w56-01', 1, 'Acknowledge the briefing', 'Confirm you understand this incident runs under safety-first rules.'),
  ('mission-w56-02-o1', 'mission-w56-02', 1, 'Read the process state', 'Identify which HMI reading indicates the process has left its safe operating range.'),
  ('mission-w56-03-o1', 'mission-w56-03', 1, 'Identify the malicious command', 'Identify which PLC write command is illegitimate.'),
  ('mission-w56-04-o1', 'mission-w56-04', 1, 'Choose the correct segmentation zone', 'Identify which network zone to isolate without disconnecting safety instrumented systems.'),
  ('mission-w56-05-o1', 'mission-w56-05', 1, 'Choose the safety-first containment action', 'Under time pressure, choose the action that halts the attack without creating an unsafe process condition.'),
  ('mission-w56-06-o1', 'mission-w56-06', 1, 'Stop the disruption safely', 'Order the containment sequence that stops the attack while keeping the process within safe limits.'),
  ('mission-w56-06-o2', 'mission-w56-06', 2, 'Preserve the evidence', 'Choose the evidence-preservation step that must happen before any destructive containment action.'),
  ('mission-w56-06-o3', 'mission-w56-06', 3, 'Confirm the response', 'Confirm the safe containment sequence and the evidence preservation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w56-01-o1-c1', 'mission-w56-01-o1', 1, 'story_dialogue', 'Confirm you understand the safety-first rules for this incident.', '{"lines":[{"characterId":"luna","text":"No reflex isolation here. Safety and availability come first. Understood?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w56-02-o1-c1', 'mission-w56-02-o1', 1, 'interactive_diagram', 'Which HMI reading indicates the process has left its safe operating range?', '{"hotspots":[{"id":"h1","label":"Substation A: voltage 231V, within 220-240V normal band","explanation":"Normal -- inside the expected range."},{"id":"h2","label":"Substation B: breaker cycling open/closed every 4 seconds, no operator command logged","explanation":"Abnormal -- rapid unexplained cycling with no legitimate trigger."},{"id":"h3","label":"Substation C: load at 62% of capacity, typical for this time of day","explanation":"Normal -- consistent with the usual daily pattern."}],"task":"Which reading is abnormal?"}'::jsonb, '{"correctOrderIds":["h2"]}'::jsonb),

  ('mission-w56-03-o1-c1', 'mission-w56-03-o1', 1, 'multiple_choice', 'Which PLC write command is illegitimate?', '{"question":"Which PLC write command is illegitimate?","options":[{"id":"a","text":"A write to a breaker-control register, sourced from the engineering workstation, matching a logged operator work order"},{"id":"b","text":"A write to the same breaker-control register, sourced from an IP address never seen on this network before, with no corresponding work order, sent at 3 AM"},{"id":"c","text":"A routine read-only status poll from the historian server"},{"id":"d","text":"A scheduled read-only poll from the HMI, on its normal interval"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w56-04-o1-c1', 'mission-w56-04-o1', 1, 'drag_and_drop', 'Sort each system into the zone it belongs to, then identify which zone to isolate.', '{"items":[{"id":"z1","text":"Corporate IT network (email, business systems)"},{"id":"z2","text":"The compromised gateway relaying commands into the control network"},{"id":"z3","text":"Safety instrumented systems (independent trip logic that shuts down unsafe conditions)"},{"id":"z4","text":"PLCs and RTUs directly controlling breakers"}],"targets":[{"id":"isolate","label":"Isolate this"},{"id":"never_isolate","label":"Never isolate this -- it''s the safety net"},{"id":"leave_alone","label":"Not part of this incident"}]}'::jsonb, '{"correctMapping":{"z1":"leave_alone","z2":"isolate","z3":"never_isolate","z4":"leave_alone"}}'::jsonb),

  ('mission-w56-05-o1-c1', 'mission-w56-05-o1', 1, 'timed_incident', 'The malicious commands are still executing. Choose the action that halts them without creating an unsafe condition.', '{"timeLimitSeconds":60,"alerts":[{"id":"alert1","text":"Breaker cycling continues at Substation B"}],"actions":[{"id":"act1","text":"Cut power to the entire substation immediately"},{"id":"act2","text":"Isolate the compromised gateway''s network path into the control network, leaving breaker control and safety systems on their normal, uncompromised path"},{"id":"act3","text":"Do nothing and monitor"},{"id":"act4","text":"Physically disconnect the safety instrumented system to \"simplify\" the response"}],"question":"Which action halts the attack safely?"}'::jsonb, '{"correctOptionId":"act2"}'::jsonb),

  ('mission-w56-06-o1-c1', 'mission-w56-06-o1', 1, 'interactive_diagram', 'Order the containment sequence that stops the attack while keeping the process within safe limits.', '{"hotspots":[{"id":"confirm","label":"Confirm the malicious command source and target via the process historian","explanation":"Know exactly what''s happening before acting on physical equipment."},{"id":"gateway_isolate","label":"Isolate the compromised gateway''s path into the control network only","explanation":"Cuts the attacker''s access without touching safety systems or normal operator paths."},{"id":"verify_safe","label":"Verify all monitored process values return to and hold within their safe operating range","explanation":"Confirms the isolation actually worked, not just that commands stopped being sent."},{"id":"restore","label":"Restore normal operator control through the verified-clean path","explanation":"Only after safety and containment are both confirmed."}],"task":"Order the safe containment sequence."}'::jsonb, '{"correctOrderIds":["confirm","gateway_isolate","verify_safe","restore"]}'::jsonb),

  ('mission-w56-06-o2-c1', 'mission-w56-06-o2', 1, 'multiple_choice', 'What evidence-preservation step must happen before the compromised gateway is powered off or reset?', '{"question":"What evidence-preservation step must happen before the compromised gateway is powered off or reset?", "options":[{"id":"a","text":"Nothing -- power it off immediately, evidence doesn''t matter in OT"},{"id":"b","text":"Capture the gateway''s current memory state, active connections, and command logs before any power-off or reset destroys them"},{"id":"c","text":"Wait a week before doing anything"},{"id":"d","text":"Delete the logs to avoid confusion"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w56-06-o3-c1', 'mission-w56-06-o3', 1, 'boss_encounter', 'Confirm the safe containment sequence and the evidence preservation together.', '{"stages":[{"objectiveRef":"mission-w56-06-o1","label":"The safe containment sequence"},{"objectiveRef":"mission-w56-06-o2","label":"Evidence preservation"}],"task":"Confirm the safe containment sequence and the evidence preservation together."}'::jsonb, '{"requiredObjectiveIds":["mission-w56-06-o1","mission-w56-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w56-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you understand the rules of engagement.', 0, 1),

  ('mission-w56-02-o1-c1', 'orientation', 'Two of these three readings match completely normal, expected patterns.', 15, 1),
  ('mission-w56-02-o1-c1', 'solution', 'A breaker cycling every 4 seconds with no operator command logged (h2) is the abnormal one -- the other two readings are within expected daily patterns.', 25, 2),

  ('mission-w56-03-o1-c1', 'orientation', 'A legitimate command has a paper trail -- a work order, a known source, a plausible time.', 15, 1),
  ('mission-w56-03-o1-c1', 'solution', 'The write from a never-seen IP, with no work order, at 3 AM (option b) has none of that -- the other options are all either legitimate writes or harmless reads.', 25, 2),

  ('mission-w56-04-o1-c1', 'orientation', 'Ask which system is actually carrying the attacker''s traffic, versus which system exists specifically to stop unsafe conditions no matter what else is happening.', 15, 1),
  ('mission-w56-04-o1-c1', 'solution', 'The compromised gateway is what needs isolating -- the safety instrumented systems must never be touched, since they''re the last line of defense against a genuinely unsafe condition.', 25, 2),

  ('mission-w56-05-o1-c1', 'orientation', 'Ask which action stops the attacker''s path without touching the systems that keep people safe.', 15, 1),
  ('mission-w56-05-o1-c1', 'solution', 'Isolating only the compromised gateway''s path (act2) stops the malicious commands while leaving breaker control and safety systems on their normal, trusted path -- cutting the whole substation or the safety system creates the danger you''re trying to avoid.', 25, 2),

  ('mission-w56-06-o1-c1', 'orientation', 'Understand before you act, act on the narrowest thing that stops it, then verify before declaring success.', 15, 1),
  ('mission-w56-06-o1-c1', 'concept', 'Acting on unconfirmed information risks the wrong response; isolating too broadly risks safety; not verifying risks declaring victory too early.', 25, 2),
  ('mission-w56-06-o1-c1', 'solution', 'Confirm the malicious source and target -> isolate only the compromised gateway''s path -> verify process values return to safe range -> restore normal control through the clean path.', 35, 3),

  ('mission-w56-06-o2-c1', 'orientation', 'Ask what would be permanently lost the moment the device loses power or gets reset.', 15, 1),
  ('mission-w56-06-o2-c1', 'solution', 'Volatile memory state, active connections, and in-progress logs disappear the moment the device is powered off or reset -- capture them first. Option b.', 25, 2),

  ('mission-w56-06-o3-c1', 'orientation', 'You''ve already sequenced the safe containment and the evidence step -- combine them.', 20, 1),
  ('mission-w56-06-o3-c1', 'solution', 'Confirm the malicious command first, capture the gateway''s volatile evidence before touching its power state, isolate only the compromised gateway''s path, verify the process holds safe values, then restore control through the clean path.', 35, 2);
