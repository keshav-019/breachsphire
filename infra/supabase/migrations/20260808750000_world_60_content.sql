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

