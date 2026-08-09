-- world-71 ("AI Fundamentals: The Machine Learns") mission content,
-- generated from docs/12-world-story-bible.md. Opens Act 10 "Singularity" --
-- the final act. Byte reveals its own lineage traces back to Project
-- SENTINEL. Mission 1 is cross-world-gated on world-70's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-71a', 'world-71', 'the-machine-learns', '71A - The Machine Learns', 'Byte opens its own safe training twin for inspection, and reveals where its architecture actually comes from.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-71a-1', 'campaign-71a', 'foundations', 'Foundations', 'Tokens, embeddings, retrieval and agent tool use, learned by inspecting Byte''s own safe training twin.', 1),
  ('operation-71a-2', 'campaign-71a', 'investigation', 'Investigation', 'Trace how a single question becomes retrieval, reasoning, tool use, and an answer -- and find where security controls actually belong.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w71-01', 'world-71', 'campaign-71a', 'operation-71a-1', 'the-same-lineage', 'The Same Lineage', 'Byte has something to say before this world starts. Its own architecture descends from the same research program as Project SENTINEL -- built with restricted agency and hard safety boundaries, but the same lineage.', 'intro', ARRAY['byte', 'ava', 'luna'], '{"requiredMissionIds":["mission-w70-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w71-02', 'world-71', 'campaign-71a', 'operation-71a-1', 'words-become-numbers', 'Words Become Numbers', 'Before a model can reason about anything, text becomes tokens, and tokens become vectors of numbers that capture something like meaning.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w71-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"token-embedding-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w71-03', 'world-71', 'campaign-71a', 'operation-71a-1', 'finding-the-right-thing-to-remember', 'Finding the Right Thing to Remember', 'Retrieval-augmented generation only works if the system pulls back the actually relevant fact, not just the most confidently-worded one.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w71-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"rag-retrieval-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w71-04', 'world-71', 'campaign-71a', 'operation-71a-1', 'thinking-then-acting-then-checking', 'Thinking, Then Acting, Then Checking', 'An AI agent doesn''t just answer. It reasons about what it needs, calls a tool to get it, reads the result, and decides what to do next -- a loop, not a single step.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w71-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"agent-tool-loop-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 4),
  ('mission-w71-05', 'world-71', 'campaign-71a', 'operation-71a-2', 'the-same-question-twice', 'The Same Question Twice', 'Ask a model the exact same question twice, and the answer can differ. Understanding why is the difference between trusting a model and verifying it.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w71-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"model-behavior-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w71-06', 'world-71', 'campaign-71a', 'operation-71a-2', 'inside-byte-boss', 'Inside Byte', 'Trace exactly how one question becomes retrieval, reasoning, tool use, and a final answer inside Byte''s own architecture, and identify precisely where security controls belong along that path.', 'boss', ARRAY['byte', 'zayn', 'ava', 'luna'], '{"requiredMissionIds":["mission-w71-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"inside-byte-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["inside-byte"],"skillXp":{"ai_security":50}}'::jsonb, true, 6);

