-- world-46 ("Reverse Engineering: Under the Machine") mission content,
-- generated from docs/12-world-story-bible.md. Opens directly on the
-- Guardians cracking the encrypted module recovered in World 45 ("The
-- Specimen"), teaches assembly/registers/stack/control-flow/decompilation
-- through a non-weaponized replica, and closes on the Decision Engine
-- capstone revealing an autonomous testing objective. Mission 1 is
-- cross-world-gated on world-45's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-46a', 'world-46', 'under-the-machine', '46A - Under the Machine', 'Registers, the stack, control flow and Ghidra-style decompilation, learned by tracing a non-weaponized replica of the encrypted module byte by byte.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-46a-1', 'campaign-46a', 'foundations', 'Foundations', 'Assembly, registers, the stack and function boundaries, learned as the machine actually sees them.', 1),
  ('operation-46a-2', 'campaign-46a', 'investigation', 'Investigation', 'Recover the Decision Engine''s scoring rule from the replica, and explain what it actually optimizes for.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w46-01', 'world-46', 'campaign-46a', 'operation-46a-1', 'no-obvious-symbols', 'No Obvious Symbols', 'The encrypted module has no strings, no imports that resolve to anything meaningful, no hash match anywhere. Everything about it has to be read at the level of the machine.', 'intro', ARRAY['byte', 'ava', 'zayn'], '{"requiredMissionIds":["mission-w45-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w46-02', 'world-46', 'campaign-46a', 'operation-46a-1', 'registers-and-the-stack', 'Registers and the Stack', 'Every function call leaves a footprint on the stack. Before any decompiler output means anything, you have to be able to read that footprint by hand.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w46-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"register-stack-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w46-03', 'world-46', 'campaign-46a', 'operation-46a-1', 'the-shape-of-a-function', 'The Shape of a Function', 'A function isn''t a straight line. Branches, loops and calls give it a shape -- and that shape is the first real clue to what it does.', 'beginner', ARRAY['byte', 'zayn'], '{"requiredMissionIds":["mission-w46-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"control-flow-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w46-04', 'world-46', 'campaign-46a', 'operation-46a-2', 'what-the-decompiler-missed', 'What the Decompiler Missed', 'A decompiler turns assembly into something readable -- but readable isn''t always correct. Somewhere in this output, the tool guessed wrong.', 'intermediate', ARRAY['byte', 'ava'], '{"requiredMissionIds":["mission-w46-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"decompiler-diff-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w46-05', 'world-46', 'campaign-46a', 'operation-46a-2', 'the-missing-constant', 'The Missing Constant', 'Every threshold this function checks against is a hardcoded number. Recover them, and you recover the actual rule the code is enforcing.', 'advanced', ARRAY['byte', 'zayn'], '{"requiredMissionIds":["mission-w46-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"constant-recovery-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w46-06', 'world-46', 'campaign-46a', 'operation-46a-2', 'decision-engine-boss', 'Decision Engine', 'Recover the rule the Decision Engine uses to score target weakness, and explain it in plain language.', 'boss', ARRAY['byte', 'ava', 'zayn'], '{"requiredMissionIds":["mission-w46-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"decision-engine-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["under-the-machine"],"skillXp":{"malware_analysis":50}}'::jsonb, true, 6);

