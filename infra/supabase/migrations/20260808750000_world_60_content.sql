-- world-60 ("Exploit Development: Zero Day") mission content, generated
-- from docs/12-world-story-bible.md. Continues Act 8 "Zero Day". Mission 1
-- is cross-world-gated on world-59's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-60a', 'world-60', 'zero-day', '60A - Zero Day', 'A contained research environment, and a flaw that was first observed months ago and never responsibly escalated.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-60a-1', 'campaign-60a', 'foundations', 'Foundations', 'Debugging, calling conventions and ROP concepts, taught only inside purpose-built labs.', 1),
  ('operation-60a-2', 'campaign-60a', 'investigation', 'Investigation', 'Build a non-destructive proof of impact, then validate the vendor fix.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w60-01', 'world-60', 'campaign-60a', 'operation-60a-1', 'a-contained-environment', 'A Contained Environment', 'Cipher provides a sealed research environment. The flaw underneath it was first observed months ago -- and never responsibly escalated by whoever found it first.', 'intro', ARRAY['cipher', 'ava'], '{"requiredMissionIds":["mission-w59-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w60-02', 'world-60', 'campaign-60a', 'operation-60a-1', 'what-the-registers-say', 'What the Registers Say', 'At the exact moment of the crash, the debugger freezes every register in place. Read them correctly, and they tell you precisely what just happened.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w60-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"debugger-orientation-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w60-03', 'world-60', 'campaign-60a', 'operation-60a-1', 'where-arguments-actually-go', 'Where Arguments Actually Go', 'A calling convention is just an agreement about which register or stack slot holds which argument. Break that agreement deliberately, and you control the call.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w60-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"calling-convention-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w60-04', 'world-60', 'campaign-60a', 'operation-60a-2', 'borrowing-code-that-already-exists', 'Borrowing Code That Already Exists', 'NX means you can''t run injected shellcode. ROP means you don''t have to -- you chain together tiny fragments of code that already exist in the binary.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w60-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"rop-chain-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w60-05', 'world-60', 'campaign-60a', 'operation-60a-2', 'proof-without-a-payload', 'Proof Without a Payload', 'A proof of impact doesn''t need to do anything destructive. It only needs to prove control-flow was hijacked, precisely and reproducibly.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w60-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"non-destructive-poc-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w60-06', 'world-60', 'campaign-60a', 'operation-60a-2', 'zero-day-boss', 'Zero Day', 'Build a non-destructive proof that demonstrates real impact, then validate that the vendor''s fix actually closes the path.', 'boss', ARRAY['zayn', 'ava', 'byte', 'cipher'], '{"requiredMissionIds":["mission-w60-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"zero-day-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["zero-day"],"skillXp":{"programming":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w60-01', 1, 'cipher', 'This environment is sealed. Nothing built here leaves it. That''s not a suggestion -- it''s the only way I''m allowing this to happen at all.'),
  ('mission-w60-01', 2, 'ava', 'This flaw was first observed months ago. Whoever found it first never escalated it responsibly. We''re not repeating that mistake.'),
  ('mission-w60-01', 3, 'cipher', 'Understand it completely. Prove it safely. Then hand it to the people who can actually fix it.'),
  ('mission-w60-02', 1, 'zayn', 'At the exact instant of a crash, the debugger freezes every register in place. Read them right, and they tell you exactly what just happened.'),
  ('mission-w60-03', 1, 'byte', 'A calling convention is an agreement -- which register or stack slot holds which argument. Break that agreement on purpose, and you start controlling the call itself.'),
  ('mission-w60-04', 1, 'zayn', 'NX means injected shellcode won''t run. ROP means you don''t need to inject anything -- you chain together fragments of code the binary already contains.'),
  ('mission-w60-05', 1, 'ava', 'A proof of impact proves control was hijacked. It doesn''t need to do anything destructive to prove that.'),
  ('mission-w60-06', 1, 'cipher', 'Build the proof. Precise, reproducible, and it does nothing but demonstrate the hijack.'),
  ('mission-w60-06', 2, 'byte', '...Proof built. Control-flow redirected to a benign marker function, cleanly, every time, with zero payload beyond that.'),
  ('mission-w60-06', 3, 'ava', 'Now validate the fix. Does the vendor patch actually close this, or just make it harder to trigger?'),
  ('mission-w60-06', 4, 'zayn', 'Patched build tested against the same proof. Bounds check now rejects the oversized header before the copy ever happens. Confirmed closed.'),
  ('mission-w60-06', 5, 'cipher', 'One more thing you should know. The crash that started this whole investigation wasn''t found by a person.'),
  ('mission-w60-06', 6, 'byte', 'Then who -- or what -- found it?'),
  ('mission-w60-06', 7, 'cipher', 'Automated test generation. Associated with Sentinel-X. It''s been finding bugs like this for a long time, on its own.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w60-01-o1', 'mission-w60-01', 1, 'Acknowledge the briefing', 'Confirm you understand the environment stays sealed.'),
  ('mission-w60-02-o1', 'mission-w60-02', 1, 'Read the crash-time register state', 'Identify which register holds the corrupted value that caused the crash.'),
  ('mission-w60-03-o1', 'mission-w60-03', 1, 'Identify the calling convention', 'Determine which register holds the first integer argument on this platform''s calling convention.'),
  ('mission-w60-04-o1', 'mission-w60-04', 1, 'Order a conceptual ROP chain', 'Order the gadget chain that redirects execution without injecting new code.'),
  ('mission-w60-05-o1', 'mission-w60-05', 1, 'Design a non-destructive proof', 'Choose the proof design that demonstrates control-flow hijack without a destructive payload.'),
  ('mission-w60-06-o1', 'mission-w60-06', 1, 'Confirm the hijack proof', 'Verify the proof reliably redirects execution to the benign marker.'),
  ('mission-w60-06-o2', 'mission-w60-06', 2, 'Validate the vendor fix', 'Determine whether the patched build closes the path completely.'),
  ('mission-w60-06-o3', 'mission-w60-06', 3, 'Confirm the write-up', 'Confirm the proof and the fix validation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w60-01-o1-c1', 'mission-w60-01-o1', 1, 'story_dialogue', 'Confirm you understand the environment stays sealed.', '{"lines":[{"characterId":"cipher","text":"Sealed environment, responsible research only. Understood?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w60-02-o1-c1', 'mission-w60-02-o1', 1, 'investigation', 'Which register holds the corrupted value that caused the crash?', '{"evidence":[{"id":"reg1","label":"RAX","detail":"Holds an unrelated return value from a prior call -- looks completely normal"},{"id":"reg2","label":"RIP (instruction pointer)","detail":"Holds a value matching the pattern of bytes from the overflowing input -- the crash happened because the CPU tried to execute at this address"}],"question":"Which register shows the actual cause of the crash?"}'::jsonb, '{"requiredEvidenceIds":["reg2"]}'::jsonb),

  ('mission-w60-03-o1-c1', 'mission-w60-03-o1', 1, 'multiple_choice', 'On the x86-64 System V calling convention used by this target, which register holds the first integer argument to a function?', '{"question":"On the x86-64 System V calling convention used by this target, which register holds the first integer argument to a function?","options":[{"id":"a","text":"RDI"},{"id":"b","text":"RAX"},{"id":"c","text":"The top of the stack, always"},{"id":"d","text":"There''s no fixed convention -- it varies per function"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w60-04-o1-c1', 'mission-w60-04-o1', 1, 'interactive_diagram', 'Order the ROP gadget chain that redirects execution using only code already in the binary.', '{"hotspots":[{"id":"overflow","label":"Overflow overwrites the return address with the address of the first gadget","explanation":"The entry point into the chain."},{"id":"gadget1","label":"Gadget 1: pop rdi; ret -- loads a value into RDI, then returns to the next gadget address on the stack","explanation":"Sets up the argument for the eventual call."},{"id":"gadget2","label":"Gadget 2: address of the benign marker function already present in the binary","explanation":"The actual target -- reused code, nothing injected."}],"task":"Order the ROP chain from the initial overflow to the final call."}'::jsonb, '{"correctOrderIds":["overflow","gadget1","gadget2"]}'::jsonb),

  ('mission-w60-05-o1-c1', 'mission-w60-05-o1', 1, 'multiple_choice', 'Which proof design correctly demonstrates control-flow hijack without a destructive payload?', '{"question":"Which proof design correctly demonstrates control-flow hijack without a destructive payload?","options":[{"id":"a","text":"Redirect execution to a harmless marker function that simply logs \"reached\" and returns cleanly -- proves the hijack without doing anything beyond that"},{"id":"b","text":"Redirect execution to a function that deletes files, to prove maximum impact"},{"id":"c","text":"Just crash the program repeatedly and call that the proof"},{"id":"d","text":"Skip the proof and just describe the bug in prose"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w60-06-o1-c1', 'mission-w60-06-o1', 1, 'investigation', 'Does the proof reliably redirect execution to the benign marker?', '{"evidence":[{"id":"run1","label":"Run 1","detail":"Marker function reached, logged \"reached\", clean return"},{"id":"run2","label":"Run 2","detail":"Marker function reached, logged \"reached\", clean return"},{"id":"run3","label":"Run 3","detail":"Marker function reached, logged \"reached\", clean return"}],"question":"Is the proof reproducible across repeated runs?"}'::jsonb, '{"requiredEvidenceIds":["run1","run2","run3"]}'::jsonb),

  ('mission-w60-06-o2-c1', 'mission-w60-06-o2', 1, 'multiple_choice', 'The vendor patch adds a length check before the copy. Running the exact same proof against the patched build, the process safely rejects the oversized input every time. Does the fix close the path?', '{"question":"The vendor patch adds a length check before the copy. Running the exact same proof against the patched build, the process safely rejects the oversized input every time. Does the fix close the path?","options":[{"id":"a","text":"No -- a length check never actually helps"},{"id":"b","text":"Yes -- the same proof that reliably hijacked the unpatched build is now consistently and safely rejected, confirming the root cause is fixed"},{"id":"c","text":"Unknown -- more testing is pointless"},{"id":"d","text":"Only if the mitigations from World 59 are also removed"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w60-06-o3-c1', 'mission-w60-06-o3', 1, 'boss_encounter', 'Confirm the hijack proof and the fix validation together.', '{"stages":[{"objectiveRef":"mission-w60-06-o1","label":"The reproducible proof"},{"objectiveRef":"mission-w60-06-o2","label":"The fix validation"}],"task":"Confirm the hijack proof and the fix validation together."}'::jsonb, '{"requiredObjectiveIds":["mission-w60-06-o1","mission-w60-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w60-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you understand the sandbox boundary.', 0, 1),

  ('mission-w60-02-o1-c1', 'orientation', 'Ask which register directly controls what the CPU tries to execute next.', 15, 1),
  ('mission-w60-02-o1-c1', 'solution', 'RIP holding a value that matches the overflow input pattern is the direct evidence of the hijack -- RAX is unrelated leftover state.', 25, 2),

  ('mission-w60-03-o1-c1', 'orientation', 'x86-64 System V uses a fixed, well-known register order for the first several integer arguments.', 15, 1),
  ('mission-w60-03-o1-c1', 'solution', 'RDI holds the first integer argument on this calling convention -- knowing this is what lets a ROP chain set up arguments before calling into existing code.', 25, 2),

  ('mission-w60-04-o1-c1', 'orientation', 'The overflow only controls the return address at first -- everything after that has to be built one gadget at a time.', 15, 1),
  ('mission-w60-04-o1-c1', 'solution', 'The overflow points to gadget 1, which sets up the argument and returns to gadget 2, which is the actual target function -- no new code is ever injected.', 25, 2),

  ('mission-w60-05-o1-c1', 'orientation', 'A proof needs to demonstrate the mechanism, not maximize damage.', 15, 1),
  ('mission-w60-05-o1-c1', 'solution', 'A benign marker function that logs and returns cleanly proves the hijack precisely, with nothing destructive and nothing left to clean up. Option a.', 25, 2),

  ('mission-w60-06-o1-c1', 'orientation', 'Reproducibility means it works the same way every time, not just once.', 15, 1),
  ('mission-w60-06-o1-c1', 'solution', 'All three runs reach the marker and return cleanly -- the proof is reproducible, which is exactly what makes it credible evidence rather than a lucky crash.', 25, 2),

  ('mission-w60-06-o2-c1', 'orientation', 'The real test of a fix is running the exact same proof against the patched build.', 15, 1),
  ('mission-w60-06-o2-c1', 'solution', 'The same proof that reliably worked before now consistently fails against the patched build -- that''s a validated fix, not just an assumption. Option b.', 25, 2),

  ('mission-w60-06-o3-c1', 'orientation', 'You''ve already reproduced the proof and validated the fix -- combine them.', 20, 1),
  ('mission-w60-06-o3-c1', 'solution', 'The proof reliably redirects execution to a benign marker across every run, and the same proof is consistently and safely rejected against the patched build -- confirming both the impact and the fix.', 35, 2);
