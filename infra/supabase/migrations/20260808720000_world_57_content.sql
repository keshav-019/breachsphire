-- world-57 ("Operating-System Internals: Kernel Depths") mission content,
-- generated from docs/12-world-story-bible.md. Opens Act 8 "Zero Day".
-- Mission 1 is cross-world-gated on world-56's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-57a', 'world-57', 'kernel-depths', '57A - Kernel Depths', 'The gateway flaw behaves differently across OS versions. Understanding it means descending beneath the operating system everyone thinks they already know.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-57a-1', 'campaign-57a', 'foundations', 'Foundations', 'Process memory, syscalls, executable structure and the loader, revisited at a deeper level than ever before.', 1),
  ('operation-57a-2', 'campaign-57a', 'investigation', 'Investigation', 'Explain the execution path from process start to the vulnerable component.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w57-01', 'world-57', 'campaign-57a', 'operation-57a-1', 'the-flaw-that-changes-shape', 'The Flaw That Changes Shape', 'The gateway flaw from the power grid trial behaves differently on every OS version tested. Application logs can''t explain why.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w56-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w57-02', 'world-57', 'campaign-57a', 'operation-57a-1', 'the-shape-of-a-running-process', 'The Shape of a Running Process', 'Stack, heap, code and data -- every process is the same four regions, laid out in memory the same predictable way.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w57-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"process-memory-map-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w57-03', 'world-57', 'campaign-57a', 'operation-57a-1', 'asking-the-kernel-for-anything', 'Asking the Kernel for Anything', 'Every meaningful action a program takes -- reading a file, opening a socket -- eventually becomes a syscall. The trace shows exactly where this one went wrong.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w57-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"syscall-trace-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w57-04', 'world-57', 'campaign-57a', 'operation-57a-1', 'the-file-format-underneath-the-file', 'The File Format Underneath the File', 'An executable is a structured file before it''s ever a running process. Knowing which section holds code and which holds data changes what you''re looking at.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w57-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"pe-elf-structure-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w57-05', 'world-57', 'campaign-57a', 'operation-57a-2', 'from-the-network-to-the-parser', 'From the Network to the Parser', 'Trace the call stack from the moment a byte arrives over the network to the exact function that misparses it.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w57-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"call-stack-trace-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w57-06', 'world-57', 'campaign-57a', 'operation-57a-2', 'kernel-depths-boss', 'Kernel Depths', 'Explain the complete execution path from process start to the vulnerable component, in terms precise enough for someone else to reproduce the analysis.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w57-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"kernel-depths-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["kernel-depths"],"skillXp":{"linux":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w57-01', 1, 'ava', 'The gateway flaw from the grid trial behaves differently on every OS version we''ve tested it against. Application logs can''t explain that -- they''re too far above where the actual difference lives.'),
  ('mission-w57-01', 2, 'byte', 'We''re going below the application. Process memory, syscalls, the loader -- the layer that decides how code actually runs.'),
  ('mission-w57-02', 1, 'zayn', 'Stack, heap, code, data. Every process on every OS lays these out the same predictable way. Once you can see the shape, you can see what''s wrong with it.'),
  ('mission-w57-03', 1, 'byte', 'Reading a file, opening a socket -- eventually it all becomes a syscall, a direct request to the kernel. This trace shows exactly where this one goes sideways.'),
  ('mission-w57-04', 1, 'zayn', 'An executable is a structured file before it''s ever a running process. Knowing which section is code and which is data changes what you''re actually looking at.'),
  ('mission-w57-05', 1, 'byte', 'Trace the call stack. From the moment a byte arrives over the network, to the exact function that misreads it.'),
  ('mission-w57-06', 1, 'zayn', 'Explain the whole path. Process start to vulnerable component, precise enough that someone else could reproduce every step of your analysis.'),
  ('mission-w57-06', 2, 'byte', '...Path explained end to end. A malformed input reaches a memory-unsafe parser, several calls deep, with no bounds check anywhere along the way.'),
  ('mission-w57-06', 3, 'ava', 'That''s a real vulnerability, not a config mistake. We need to understand exactly what "memory-unsafe" means here before we go any further.'),
  ('mission-w57-06', 4, 'zayn', 'Which means the next step is looking at what actually happens in memory when that parser gets fed the wrong input.');

