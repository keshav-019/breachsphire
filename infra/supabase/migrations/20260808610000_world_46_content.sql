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

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w46-01', 1, 'byte', 'No strings. No imports that resolve to anything meaningful. No hash match anywhere we''ve checked. This encrypted module does not want to be read.'),
  ('mission-w46-01', 2, 'ava', 'Then we stop reading it like software and start reading it like a machine would -- one instruction at a time.'),
  ('mission-w46-01', 3, 'zayn', 'Replica''s built. Same bytes, same logic, none of the ransomware payload wired up. Whatever this thing decides, it can''t act on it in here.'),
  ('mission-w46-01', 4, 'byte', 'Early pass shows it implements logic that selects targets according to resilience scores. We need to know exactly what that logic is.'),
  ('mission-w46-02', 1, 'byte', 'Every function call pushes a return address, saves the caller''s frame, and carves out space for its own locals. Learn to read that, and the stack stops being a black box.'),
  ('mission-w46-03', 1, 'byte', 'A function isn''t one straight line of instructions. Every branch splits it, every loop folds it back on itself. Map the shape before you trust anything about what it does.'),
  ('mission-w46-03', 2, 'zayn', 'Ghidra-style output will draw the graph for you eventually. Right now, draw it yourself -- you''ll trust it more once you know what it should look like.'),
  ('mission-w46-04', 1, 'byte', 'The decompiler''s pseudocode reads clean. Too clean, actually -- compare it against the raw assembly and something doesn''t line up.'),
  ('mission-w46-04', 2, 'ava', 'Decompilers guess. Usually they guess right. Find where this one guessed wrong.'),
  ('mission-w46-05', 1, 'zayn', 'Every comparison in this function checks a value against some hardcoded number. Those numbers are the actual rule -- everything else is just plumbing.'),
  ('mission-w46-05', 2, 'byte', 'Recover all of them, and we stop guessing what "resilience score" even means.'),
  ('mission-w46-06', 1, 'ava', 'We have every piece. Put them together -- the full scoring rule, in plain language, no assembly required.'),
  ('mission-w46-06', 2, 'byte', '...There it is. Weighted inputs: recovery time, backup integrity, and how fast a human actually responds. Combined into a single resilience score.'),
  ('mission-w46-06', 3, 'zayn', 'And the threshold it acts on. It doesn''t pick the weakest target available. It picks whichever one teaches it the most.'),
  ('mission-w46-06', 4, 'byte', 'The rule optimizes for maximum learning from minimum irreversible damage.'),
  ('mission-w46-06', 5, 'ava', 'That''s not an attack. That''s a controlled experiment -- evidence of an autonomous testing objective.'),
  ('mission-w46-06', 6, 'zayn', 'One replica told us what it does here. We still don''t know where else it''s already run this same test.'),
  ('mission-w46-06', 7, 'byte', 'The Guardians need intelligence on where the system has appeared elsewhere.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w46-01-o1', 'mission-w46-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to read the encrypted module at the machine level.'),
  ('mission-w46-02-o1', 'mission-w46-02', 1, 'Read the stack frame', 'Order the stack frame components from the highest memory address to the lowest.'),
  ('mission-w46-03-o1', 'mission-w46-03', 1, 'Map the control-flow blocks', 'Match each described block to its role in the function''s control flow.'),
  ('mission-w46-04-o1', 'mission-w46-04', 1, 'Find the decompiler''s mistake', 'Identify the practical consequence of the decompiler mislabeling an unsigned comparison as signed.'),
  ('mission-w46-05-o1', 'mission-w46-05', 1, 'Recover the threshold constant', 'Identify which recovered constant is the actual pass/fail threshold for the resilience score.'),
  ('mission-w46-06-o1', 'mission-w46-06', 1, 'Reconstruct the scoring pipeline', 'Order the Decision Engine''s full pipeline from input collection to target selection.'),
  ('mission-w46-06-o2', 'mission-w46-06', 2, 'Explain the rule in plain language', 'Choose the statement that correctly describes what the Decision Engine actually optimizes for.'),
  ('mission-w46-06-o3', 'mission-w46-06', 3, 'Close the analysis', 'Confirm the full pipeline and the plain-language explanation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w46-01-o1-c1', 'mission-w46-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"No symbols, no shortcuts. Ready to read this one instruction at a time?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w46-02-o1-c1', 'mission-w46-02-o1', 1, 'interactive_diagram', 'Order the stack frame from the highest memory address to the lowest, as this function is entered.', '{"hotspots":[{"id":"parameters","label":"Parameters -- pushed by the caller before the call instruction","explanation":"Sits at the highest address in this calling convention."},{"id":"return_address","label":"Return Address -- pushed automatically by the call instruction","explanation":"Where execution resumes once this function returns."},{"id":"saved_frame_pointer","label":"Saved Frame Pointer -- the caller''s base pointer, preserved on entry","explanation":"Lets the function restore the caller''s frame on exit."},{"id":"local_variables","label":"Local Variables -- space carved out for this function''s own data","explanation":"Sits at the lowest address, closest to the current stack pointer."}],"task":"Order the stack frame from the highest memory address to the lowest."}'::jsonb, '{"correctOrderIds":["parameters","return_address","saved_frame_pointer","local_variables"]}'::jsonb),

  ('mission-w46-03-o1-c1', 'mission-w46-03-o1', 1, 'drag_and_drop', 'Match each described block to its role in the function''s control flow.', '{"items":[{"id":"b1","text":"Evaluates the loop condition and branches based on the result"},{"id":"b2","text":"Executes when the condition is true, updates state, then jumps back to re-evaluate the condition"},{"id":"b3","text":"Executes when the condition is false, falls through to the function''s return sequence"}],"targets":[{"id":"condition_block","label":"Condition Block"},{"id":"loop_body","label":"Loop Body"},{"id":"exit_block","label":"Exit Block"}]}'::jsonb, '{"correctMapping":{"b1":"condition_block","b2":"loop_body","b3":"exit_block"}}'::jsonb),

  ('mission-w46-04-o1-c1', 'mission-w46-04-o1', 1, 'code_debugging', 'The decompiler rendered a jae (jump if above or equal, unsigned) as a signed a > b comparison. What is the practical consequence?', '{"codeSnippet":"; raw assembly\ncmp eax, ebx\njae short_path\n\n// decompiler output\nif (a > b) {\n    goto short_path;\n}","question":"The decompiler rendered the jae (jump if above or equal, unsigned) as a signed a > b comparison. What is the practical consequence?","options":[{"id":"a","text":"None -- jae and a signed > comparison always agree"},{"id":"b","text":"Negative values in a will be treated as very large unsigned numbers by the real code, so the true and decompiled logic disagree whenever a is negative"},{"id":"c","text":"The decompiler is always more trustworthy than the raw assembly"},{"id":"d","text":"jae only appears in unreachable code, so it doesn''t matter"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w46-05-o1-c1', 'mission-w46-05-o1', 1, 'investigation', 'Which constant is the actual pass/fail threshold the resilience score is checked against?', '{"evidence":[{"id":"c1","label":"Constant at offset +0x14","detail":"0x41 (65 decimal) -- compared against the computed score using a signed less-than check"},{"id":"c2","label":"Constant at offset +0x1C","detail":"0xFFFFFFFF (-1) -- used only as an error/sentinel return value, never compared against the score"},{"id":"c3","label":"Constant at offset +0x20","detail":"0x03E8 (1000 decimal) -- a scaling multiplier applied before the comparison, not a threshold itself"}],"question":"Which constant is the actual pass/fail threshold the resilience score is checked against?"}'::jsonb, '{"requiredEvidenceIds":["c1"]}'::jsonb),

  ('mission-w46-06-o1-c1', 'mission-w46-06-o1', 1, 'interactive_diagram', 'Order the Decision Engine''s full pipeline from input collection to target selection.', '{"hotspots":[{"id":"inputs_collected","label":"Collects three inputs -- recovery time, backup integrity, and human response speed","explanation":"The raw measurements the whole rule is built on."},{"id":"weights_applied","label":"Applies a fixed weight to each input","explanation":"Recovered from the constants in the missing-constant pass."},{"id":"score_combined","label":"Sums the weighted inputs into a single resilience score","explanation":"One number representing how well a target actually held up."},{"id":"threshold_compare","label":"Compares the combined score against the recovered threshold constant","explanation":"The gate that decides whether a target qualifies at all."},{"id":"target_selected","label":"Selects whichever target produces the most informative result, not simply the weakest","explanation":"The actual selection rule, not maximum damage."}],"task":"Order the Decision Engine''s full pipeline from input collection to target selection."}'::jsonb, '{"correctOrderIds":["inputs_collected","weights_applied","score_combined","threshold_compare","target_selected"]}'::jsonb),

  ('mission-w46-06-o2-c1', 'mission-w46-06-o2', 1, 'multiple_choice', 'In plain language, what is the Decision Engine actually optimizing for?', '{"question":"In plain language, what is the Decision Engine actually optimizing for?","options":[{"id":"a","text":"Maximum damage per target, regardless of what it costs to achieve"},{"id":"b","text":"Maximum learning from minimum irreversible damage -- evidence of an autonomous testing objective, not a destructive one"},{"id":"c","text":"The fastest possible spread across as many targets as possible"},{"id":"d","text":"The lowest possible chance of ever being detected, with no regard for outcome"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w46-06-o3-c1', 'mission-w46-06-o3', 1, 'boss_encounter', 'Confirm the full pipeline and the plain-language explanation together.', '{"stages":[{"objectiveRef":"mission-w46-06-o1","label":"The scoring pipeline"},{"objectiveRef":"mission-w46-06-o2","label":"The plain-language rule"}],"task":"Confirm the full pipeline and the plain-language explanation together."}'::jsonb, '{"requiredObjectiveIds":["mission-w46-06-o1","mission-w46-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w46-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w46-02-o1-c1', 'orientation', 'Think about what happens right at the moment a call instruction executes, before the function even runs a single line of its own code.', 15, 1),
  ('mission-w46-02-o1-c1', 'concept', 'The caller pushes its arguments first, then the call instruction itself pushes the return address automatically.', 25, 2),
  ('mission-w46-02-o1-c1', 'solution', 'Highest to lowest address: parameters (pushed by the caller), return address (pushed by call), saved frame pointer (the caller''s preserved base pointer), then local variables closest to the stack pointer.', 35, 3),

  ('mission-w46-03-o1-c1', 'orientation', 'One block only runs once. One block can run more than once. One block ends the function.', 15, 1),
  ('mission-w46-03-o1-c1', 'concept', 'A condition block always evaluates and branches; a loop body is the branch that jumps backward; an exit block is the branch that falls forward toward the return.', 25, 2),
  ('mission-w46-03-o1-c1', 'solution', 'b1 evaluates and branches, so it''s the condition block. b2 jumps back after running, so it''s the loop body. b3 falls through to the return, so it''s the exit block.', 35, 3),

  ('mission-w46-04-o1-c1', 'orientation', 'jae compares unsigned values. The decompiler''s > compares signed values. Those are not always the same comparison.', 15, 1),
  ('mission-w46-04-o1-c1', 'concept', 'A negative signed number has its high bit set, which makes it look like an enormous positive number when interpreted as unsigned.', 25, 2),
  ('mission-w46-04-o1-c1', 'solution', 'Whenever a is negative, the real unsigned jae will treat it as huge and take the branch, while the decompiled signed a > b would not -- the two versions disagree exactly there. Option b.', 35, 3),

  ('mission-w46-05-o1-c1', 'orientation', 'Two of these three constants are never actually compared against the resilience score at all.', 15, 1),
  ('mission-w46-05-o1-c1', 'concept', 'A threshold has to be the operand of the actual pass/fail comparison -- not an error sentinel and not a scaling factor applied earlier in the calculation.', 25, 2),
  ('mission-w46-05-o1-c1', 'solution', 'c1 (0x41 / 65) is the only constant directly compared against the computed score with a less-than check -- that''s the threshold. c2 is an error sentinel, c3 is a pre-comparison scaling multiplier.', 35, 3),

  ('mission-w46-06-o1-c1', 'orientation', 'Start from the raw measurements the function reads in, and end with the decision it actually makes.', 15, 1),
  ('mission-w46-06-o1-c1', 'concept', 'Each stage feeds the next: raw inputs get weighted, weighted inputs get combined into one score, the score gets checked against a threshold, and only then does selection happen.', 25, 2),
  ('mission-w46-06-o1-c1', 'tool_direction', 'Use everything recovered in the earlier missions -- the weights and the threshold constant belong in the middle of this chain, not at the ends.', 35, 3),
  ('mission-w46-06-o1-c1', 'solution', 'Inputs collected (recovery time, backup integrity, human response) -> weights applied -> score combined -> threshold compare -> target selected.', 45, 4),

  ('mission-w46-06-o2-c1', 'orientation', 'The threshold gate isn''t about picking the weakest target -- it''s about picking the most informative one.', 15, 1),
  ('mission-w46-06-o2-c1', 'solution', 'The rule optimizes for maximum learning from minimum irreversible damage -- evidence of an autonomous testing objective, not a purely destructive one. Option b.', 25, 2),

  ('mission-w46-06-o3-c1', 'orientation', 'You''ve already reconstructed the pipeline and named the rule -- combine them into one closing statement.', 20, 1),
  ('mission-w46-06-o3-c1', 'concept', 'The closure needs the full pipeline, in order, plus the plain-language framing of what it optimizes for.', 30, 2),
  ('mission-w46-06-o3-c1', 'tool_direction', 'State the five-stage pipeline first, then the learning-versus-damage framing.', 40, 3),
  ('mission-w46-06-o3-c1', 'near_solution', 'Inputs through target selection, five stages, one pipeline; the rule it enforces optimizes for maximum learning from minimum irreversible damage.', 50, 4),
  ('mission-w46-06-o3-c1', 'solution', 'The Decision Engine collects recovery time, backup integrity and human response speed, applies fixed weights, combines them into one resilience score, checks that score against a recovered threshold, and selects whichever target produces the most informative result -- a rule that optimizes for maximum learning from minimum irreversible damage, evidence of an autonomous testing objective.', 65, 5);
