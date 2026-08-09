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

