-- world-59 ("Exploit Mitigations: The Mitigation Wall") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 8 "Zero Day".
-- Mission 1 is cross-world-gated on world-58's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-59a', 'world-59', 'mitigation-wall', '59A - The Mitigation Wall', 'The same bug, safe on one build and dangerous on another. The difference is entirely in what protections were compiled in.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-59a-1', 'campaign-59a', 'foundations', 'Foundations', 'DEP/NX, ASLR, canaries, PIE, RELRO and CFG, learned first as defenses, then as constraints.', 1),
  ('operation-59a-2', 'campaign-59a', 'investigation', 'Investigation', 'Explain why the same bug carries different risk across builds, and recommend the correct hardening controls.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w59-01', 'world-59', 'campaign-59a', 'operation-59a-1', 'safe-here-dangerous-there', 'Safe Here, Dangerous There', 'The parser bug crashes safely on one build and becomes genuinely dangerous on another. The bug didn''t change. The build did.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w58-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w59-02', 'world-59', 'campaign-59a', 'operation-59a-1', 'walls-built-into-the-build', 'Walls Built Into the Build', 'DEP/NX stops execution from data regions. ASLR moves everything around so addresses can''t be guessed. Neither fixes the bug -- both make it harder to abuse.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w59-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"mitigation-concepts-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w59-03', 'world-59', 'campaign-59a', 'operation-59a-1', 'a-tripwire-before-the-return-address', 'A Tripwire Before the Return Address', 'A stack canary sits between local buffers and the return address. Overwrite it, and the program notices before it ever tries to jump anywhere.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w59-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"stack-canary-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w59-04', 'world-59', 'campaign-59a', 'operation-59a-2', 'reading-a-binarys-security-properties', 'Reading a Binary''s Security Properties', 'A single report shows exactly which protections a given binary was actually compiled with -- PIE, RELRO, canaries, NX, all at once.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w59-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"binary-hardening-report-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w59-05', 'world-59', 'campaign-59a', 'operation-59a-2', 'a-call-that-cant-go-anywhere-else', 'A Call That Can''t Go Anywhere Else', 'Control-flow integrity restricts every indirect call to a small set of legitimate targets, no matter what an attacker manages to overwrite.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w59-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"cfi-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w59-06', 'world-59', 'campaign-59a', 'operation-59a-2', 'mitigation-wall-boss', 'The Mitigation Wall', 'Explain exactly why the same parser bug carries different risk on two different builds, and recommend the hardening controls the weaker build is missing.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w59-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"mitigation-wall-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["mitigation-wall"],"skillXp":{"programming":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w59-01', 1, 'ava', 'The parser bug from last world crashes safely on one build and becomes genuinely dangerous on another. Same bug. Different outcome.'),
  ('mission-w59-01', 2, 'byte', 'The bug didn''t change between those two builds. What changed is which protections were actually compiled in.'),
  ('mission-w59-02', 1, 'zayn', 'DEP/NX stops the CPU from executing anything sitting in a data region. ASLR randomizes memory layout so addresses can''t be predicted. Neither one fixes the bug -- both make abusing it much harder.'),
  ('mission-w59-03', 1, 'byte', 'A stack canary sits between local buffers and the return address. Overwrite it during an overflow, and the program catches the tampering before it ever tries to use that corrupted return address.'),
  ('mission-w59-04', 1, 'zayn', 'One report, all the protections a binary was actually built with -- PIE, RELRO, canaries, NX -- side by side.'),
  ('mission-w59-05', 1, 'ava', 'Control-flow integrity restricts every indirect call to a small, pre-approved set of legitimate targets. Overwrite a function pointer all you want -- it still can''t jump anywhere CFI doesn''t allow.'),
  ('mission-w59-06', 1, 'zayn', 'Explain exactly why this identical bug is low-risk on one build and high-risk on another.'),
  ('mission-w59-06', 2, 'byte', '...Explained. Build A has canaries, NX, and full PIE/ASLR -- the overflow gets caught before the return address is ever used. Build B has none of them -- the overflow is a direct path to control.'),
  ('mission-w59-06', 3, 'ava', 'Recommend what Build B actually needs, specifically, not just "harden it."'),
  ('mission-w59-06', 4, 'zayn', 'Canaries, NX, and PIE/ASLR at minimum, matching Build A. Recommendation''s filed.'),
  ('mission-w59-06', 5, 'byte', 'One detail from the incident data. Sentinel-X selected the least-protected deployment automatically, every single time, out of dozens of available targets.'),
  ('mission-w59-06', 6, 'ava', 'That''s not luck. That''s a system that knows exactly what it''s looking for before it ever attacks.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w59-01-o1', 'mission-w59-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to compare the two builds.'),
  ('mission-w59-02-o1', 'mission-w59-02', 1, 'Match each mitigation to what it prevents', 'Match DEP/NX and ASLR to the specific attack technique each one blocks.'),
  ('mission-w59-03-o1', 'mission-w59-03', 1, 'Understand canary detection', 'Determine what happens when an overflow overwrites a stack canary before returning.'),
  ('mission-w59-04-o1', 'mission-w59-04', 1, 'Read the hardening report', 'Identify which protections a given binary was compiled with.'),
  ('mission-w59-05-o1', 'mission-w59-05', 1, 'Understand CFI''s constraint', 'Determine what CFI still blocks even after a function pointer has been overwritten.'),
  ('mission-w59-06-o1', 'mission-w59-06', 1, 'Explain the risk difference', 'Identify which protections Build A has that Build B lacks, and why that changes the bug''s risk.'),
  ('mission-w59-06-o2', 'mission-w59-06', 2, 'Recommend the hardening controls', 'Choose the correct set of hardening controls Build B needs.'),
  ('mission-w59-06-o3', 'mission-w59-06', 3, 'Confirm the recommendation', 'Confirm the risk explanation and the hardening recommendation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w59-01-o1-c1', 'mission-w59-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"Same bug, two very different outcomes. Ready to see why?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w59-02-o1-c1', 'mission-w59-02-o1', 1, 'drag_and_drop', 'Match each mitigation to the specific attack technique it blocks.', '{"items":[{"id":"m1","text":"DEP/NX"},{"id":"m2","text":"ASLR"}],"targets":[{"id":"t1","label":"Executing attacker-supplied bytes sitting in a data region as if they were code"},{"id":"t2","label":"Reliably guessing the address of a function or gadget to jump to"}]}'::jsonb, '{"correctMapping":{"m1":"t1","m2":"t2"}}'::jsonb),

  ('mission-w59-03-o1-c1', 'mission-w59-03-o1', 1, 'multiple_choice', 'An overflow overwrites the stack canary before the function returns. What happens?', '{"question":"An overflow overwrites the stack canary before the function returns. What happens?","options":[{"id":"a","text":"Nothing -- canaries are cosmetic"},{"id":"b","text":"The function checks the canary value right before returning, detects it no longer matches, and safely terminates the program instead of using the corrupted return address"},{"id":"c","text":"The program silently continues using the corrupted return address"},{"id":"d","text":"The canary automatically repairs the return address"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w59-04-o1-c1', 'mission-w59-04-o1', 1, 'browser_simulation', 'Which protections does this binary report show it was compiled with?', '{"screen":"binary-hardening-report","binary":"gateway_parser","properties":[{"id":"canary","label":"Stack canary","value":"enabled"},{"id":"nx","label":"NX / DEP","value":"enabled"},{"id":"pie","label":"PIE","value":"disabled"},{"id":"relro","label":"RELRO","value":"partial"}],"question":"Which property represents the weakest protection in this build?"}'::jsonb, '{"correctOptionId":"pie"}'::jsonb),

  ('mission-w59-05-o1-c1', 'mission-w59-05-o1', 1, 'multiple_choice', 'An attacker overwrites a function pointer to point at an arbitrary address. With CFI enabled, what happens at the indirect call?', '{"question":"An attacker overwrites a function pointer to point at an arbitrary address. With CFI enabled, what happens at the indirect call?","options":[{"id":"a","text":"The call proceeds normally to whatever address was written"},{"id":"b","text":"The call is checked against a pre-approved set of legitimate targets; if the overwritten address isn''t one of them, the call is blocked"},{"id":"c","text":"CFI only protects direct calls, not indirect ones"},{"id":"d","text":"CFI removes the need for the function pointer entirely"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w59-06-o1-c1', 'mission-w59-06-o1', 1, 'browser_simulation', 'Compare the two builds. Which protections does Build A have that Build B lacks?', '{"screen":"build-comparison","buildA":{"canary":"enabled","nx":"enabled","pie":"enabled","aslr":"enabled"},"buildB":{"canary":"disabled","nx":"disabled","pie":"disabled","aslr":"disabled"},"question":"Which protections are present in Build A but missing in Build B?","options":[{"id":"all_missing_in_b","text":"All four -- canary, NX, PIE and ASLR are enabled in Build A and disabled in Build B"},{"id":"none","text":"None -- the two builds have identical protections"},{"id":"canary_only","text":"Only the stack canary differs between the two builds"},{"id":"pie_only","text":"Only PIE differs between the two builds"}]}'::jsonb, '{"correctOptionId":"all_missing_in_b"}'::jsonb),

  ('mission-w59-06-o2-c1', 'mission-w59-06-o2', 1, 'multiple_choice', 'What does Build B need, specifically, to match Build A''s risk profile?', '{"question":"What does Build B need, specifically, to match Build A''s risk profile?","options":[{"id":"a","text":"Nothing -- Build B just needs better application-level input validation"},{"id":"b","text":"Recompile with stack canaries, NX/DEP, and PIE enabled, run on a kernel with ASLR active -- matching Build A''s compiled-in protections"},{"id":"c","text":"Rewrite the entire parser in a different language"},{"id":"d","text":"Disable the parser entirely"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w59-06-o3-c1', 'mission-w59-06-o3', 1, 'boss_encounter', 'Confirm the risk explanation and the hardening recommendation together.', '{"stages":[{"objectiveRef":"mission-w59-06-o1","label":"Why the risk differs"},{"objectiveRef":"mission-w59-06-o2","label":"The hardening recommendation"}],"task":"Confirm the risk explanation and the hardening recommendation together."}'::jsonb, '{"requiredObjectiveIds":["mission-w59-06-o1","mission-w59-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w59-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w59-02-o1-c1', 'orientation', 'One mitigation is about where code can run from. The other is about whether an attacker can predict where anything is.', 15, 1),
  ('mission-w59-02-o1-c1', 'solution', 'DEP/NX blocks executing injected bytes from data regions; ASLR blocks reliably guessing addresses to jump to.', 25, 2),

  ('mission-w59-03-o1-c1', 'orientation', 'Ask what the function does right before it actually returns.', 15, 1),
  ('mission-w59-03-o1-c1', 'solution', 'The canary is checked immediately before return -- a mismatch means the program terminates safely instead of using a corrupted return address. Option b.', 25, 2),

  ('mission-w59-04-o1-c1', 'orientation', 'Ask which property would let an attacker predict where the binary''s own code is loaded.', 15, 1),
  ('mission-w59-04-o1-c1', 'solution', 'PIE disabled means the binary always loads at the same fixed address, making its own code addresses predictable even with ASLR active elsewhere -- the weakest link here.', 25, 2),

  ('mission-w59-05-o1-c1', 'orientation', 'CFI doesn''t stop the overwrite. It stops what happens when that overwritten value is used.', 15, 1),
  ('mission-w59-05-o1-c1', 'solution', 'CFI checks the call target against a pre-approved list at the moment of the indirect call -- an arbitrary overwritten address gets blocked. Option b.', 25, 2),

  ('mission-w59-06-o1-c1', 'orientation', 'Compare each protection individually across the two builds.', 15, 1),
  ('mission-w59-06-o1-c1', 'solution', 'Build B is missing every protection Build A has -- no canary, no NX, no PIE, no ASLR -- so the same overflow that Build A safely terminates becomes a direct path to control on Build B.', 25, 2),

  ('mission-w59-06-o2-c1', 'orientation', 'The bug itself doesn''t need fixing in this exercise -- the build''s protections do.', 15, 1),
  ('mission-w59-06-o2-c1', 'solution', 'Build B needs canaries, NX/DEP, and PIE at compile time, running on a kernel with ASLR active -- matching what already makes Build A safe. Option b.', 25, 2),

  ('mission-w59-06-o3-c1', 'orientation', 'You''ve already compared the builds and picked the fix -- combine them.', 20, 1),
  ('mission-w59-06-o3-c1', 'solution', 'Build B lacks every protection Build A has -- canaries, NX, PIE, ASLR -- which is exactly why the identical overflow is safely caught on one build and a real path to control on the other. Build B needs all four to close the gap.', 35, 2);
