-- world-58 ("Memory Corruption: Memory Fault") mission content, generated
-- from docs/12-world-story-bible.md. Continues Act 8 "Zero Day". Mission 1
-- is cross-world-gated on world-57's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-58a', 'world-58', 'memory-fault', '58A - Memory Fault', 'A safe crash reproducer for the gateway parser. Controlled analysis of exactly how unsafe memory operations break a running program.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-58a-1', 'campaign-58a', 'foundations', 'Foundations', 'Stack overflows, integer errors, use-after-free and format strings, learned through controlled crash analysis.', 1),
  ('operation-58a-2', 'campaign-58a', 'investigation', 'Investigation', 'Identify the exact condition that corrupts state and produce a minimal reproducer.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w58-01', 'world-58', 'campaign-58a', 'operation-58a-1', 'a-safe-way-to-break-it', 'A Safe Way to Break It', 'A sandboxed, safe crash reproducer for the gateway parser. Nothing here can escape the sandbox -- the point is to understand exactly what breaks and why.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w57-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w58-02', 'world-58', 'campaign-58a', 'operation-58a-1', 'what-a-stack-overflow-actually-overwrites', 'What a Stack Overflow Actually Overwrites', 'A stack buffer that''s too small doesn''t just corrupt "the stack" abstractly -- it overwrites something specific, right next to it.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w58-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"stack-overflow-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w58-03', 'world-58', 'campaign-58a', 'operation-58a-1', 'a-number-that-wraps-around', 'A Number That Wraps Around', 'An integer that overflows doesn''t error out -- it silently wraps to a tiny or negative value, and everything downstream trusts it anyway.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w58-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"integer-overflow-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w58-04', 'world-58', 'campaign-58a', 'operation-58a-2', 'using-memory-after-its-gone', 'Using Memory After It''s Gone', 'A pointer to freed memory, used again as if it still pointed to something valid.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w58-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"use-after-free-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w58-05', 'world-58', 'campaign-58a', 'operation-58a-2', 'when-input-becomes-a-format-string', 'When Input Becomes a Format String', 'User-controlled input, passed directly as a format string instead of as an argument to one.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w58-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"format-string-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w58-06', 'world-58', 'campaign-58a', 'operation-58a-2', 'memory-fault-boss', 'Memory Fault', 'Identify the exact condition that corrupts state in the gateway parser, and produce a minimal reproducer in the sandbox -- the smallest input that still triggers it.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w58-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"memory-fault-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["memory-fault"],"skillXp":{"programming":50}}'::jsonb, true, 6);

