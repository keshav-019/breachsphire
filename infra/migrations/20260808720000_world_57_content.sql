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

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w57-01-o1', 'mission-w57-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to go beneath the application layer.'),
  ('mission-w57-02-o1', 'mission-w57-02', 1, 'Map the process memory regions', 'Match each memory region to what it actually holds.'),
  ('mission-w57-03-o1', 'mission-w57-03', 1, 'Find the syscall where it goes wrong', 'Identify which syscall in the trace corresponds to the flaw''s trigger point.'),
  ('mission-w57-04-o1', 'mission-w57-04', 1, 'Identify code vs data sections', 'Match each executable section to whether it holds code or data.'),
  ('mission-w57-05-o1', 'mission-w57-05', 1, 'Trace the call stack', 'Order the call stack from network read to the vulnerable parsing function.'),
  ('mission-w57-06-o1', 'mission-w57-06', 1, 'Explain the full execution path', 'Order the complete path from process start to the vulnerable component.'),
  ('mission-w57-06-o2', 'mission-w57-06', 2, 'Confirm the explanation', 'Confirm the full execution path is correct and complete.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w57-01-o1-c1', 'mission-w57-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"Below the application, where the real difference lives. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w57-02-o1-c1', 'mission-w57-02-o1', 1, 'drag_and_drop', 'Match each memory region to what it actually holds.', '{"items":[{"id":"r1","text":"Local variables and function call return addresses"},{"id":"r2","text":"Dynamically allocated memory (malloc/new)"},{"id":"r3","text":"The compiled machine instructions themselves"},{"id":"r4","text":"Global and static variables"}],"targets":[{"id":"stack","label":"Stack"},{"id":"heap","label":"Heap"},{"id":"code","label":"Code"},{"id":"data","label":"Data"}]}'::jsonb, '{"correctMapping":{"r1":"stack","r2":"heap","r3":"code","r4":"data"}}'::jsonb),

  ('mission-w57-03-o1-c1', 'mission-w57-03-o1', 1, 'investigation', 'Which syscall in this trace corresponds to the flaw''s trigger point?', '{"evidence":[{"id":"s1","label":"open() on a config file, returns normally","detail":"Routine startup behavior"},{"id":"s2","label":"read() on a network socket, returns an oversized buffer that''s immediately passed to a fixed-size stack buffer without a length check","detail":"The data enters here, unchecked"},{"id":"s3","label":"close() on the socket after processing","detail":"Routine cleanup"}],"question":"Which syscall marks the trigger point?"}'::jsonb, '{"requiredEvidenceIds":["s2"]}'::jsonb),

  ('mission-w57-04-o1-c1', 'mission-w57-04-o1', 1, 'interactive_diagram', 'Match each executable section to whether it holds code or data.', '{"hotspots":[{"id":"text_section","label":".text section","explanation":"Code -- the actual compiled instructions."},{"id":"data_section","label":".data section","explanation":"Data -- initialized global/static variables."},{"id":"bss_section","label":".bss section","explanation":"Data -- uninitialized global/static variables, zero-filled at load."},{"id":"rodata_section","label":".rodata section","explanation":"Data -- read-only constants like string literals."}],"task":"Identify code vs data for each section."}'::jsonb, '{"correctOrderIds":["text_section","data_section","bss_section","rodata_section"]}'::jsonb),

  ('mission-w57-05-o1-c1', 'mission-w57-05-o1', 1, 'interactive_diagram', 'Order the call stack from network read to the vulnerable parsing function.', '{"hotspots":[{"id":"main","label":"main() -- process entry point"},{"id":"accept_loop","label":"handle_connection() -- accepts the incoming socket"},{"id":"read_call","label":"read_message() -- calls read() on the socket"},{"id":"parse_call","label":"parse_header() -- copies the read buffer into a fixed-size stack buffer with no length check"}],"task":"Order the call stack from entry point to the vulnerable function."}'::jsonb, '{"correctOrderIds":["main","accept_loop","read_call","parse_call"]}'::jsonb),

  ('mission-w57-06-o1-c1', 'mission-w57-06-o1', 1, 'interactive_diagram', 'Order the complete execution path from process start to the vulnerable component.', '{"hotspots":[{"id":"loader","label":"OS loader maps the executable''s segments into a fresh process address space","explanation":"Where every process begins, before a single line of the program''s own code runs."},{"id":"entry","label":"main() begins executing from the .text section","explanation":"Program logic starts here."},{"id":"syscall_read","label":"A read() syscall pulls untrusted network data into the process","explanation":"The moment untrusted input enters memory."},{"id":"vulnerable_parse","label":"parse_header() copies that data into a fixed-size stack buffer with no bounds check","explanation":"The exact vulnerable component -- everything before this made the reach possible."}],"task":"Order the complete path from process start to the vulnerable component."}'::jsonb, '{"correctOrderIds":["loader","entry","syscall_read","vulnerable_parse"]}'::jsonb),

  ('mission-w57-06-o2-c1', 'mission-w57-06-o2', 1, 'boss_encounter', 'Confirm the complete execution path.', '{"stages":[{"objectiveRef":"mission-w57-06-o1","label":"The full execution path"}],"task":"Confirm the complete execution path from process start to the vulnerable component."}'::jsonb, '{"requiredObjectiveIds":["mission-w57-06-o1"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w57-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w57-02-o1-c1', 'orientation', 'Ask whether each item is fixed at compile time or created while the program runs.', 15, 1),
  ('mission-w57-02-o1-c1', 'solution', 'Local variables and return addresses live on the stack, dynamic allocations on the heap, instructions in code, and global/static variables in data.', 25, 2),

  ('mission-w57-03-o1-c1', 'orientation', 'Two of these three syscalls are routine bookends -- setup and cleanup.', 15, 1),
  ('mission-w57-03-o1-c1', 'solution', 'The read() call that hands an oversized, unchecked buffer straight to a fixed-size stack buffer (s2) is the trigger point -- open() and close() are routine.', 25, 2),

  ('mission-w57-04-o1-c1', 'orientation', 'Ask which sections the CPU executes versus which sections it only reads or writes as values.', 15, 1),
  ('mission-w57-04-o1-c1', 'solution', '.text holds executable code; .data, .bss and .rodata all hold data in different forms (initialized, uninitialized, read-only).', 25, 2),

  ('mission-w57-05-o1-c1', 'orientation', 'Follow the data, not the alphabet -- which function calls which.', 15, 1),
  ('mission-w57-05-o1-c1', 'solution', 'main() starts the process, hands off to handle_connection(), which calls read_message() to pull bytes off the socket, which passes them to parse_header() where the unsafe copy happens.', 25, 2),

  ('mission-w57-06-o1-c1', 'orientation', 'Start before the program''s own code even runs.', 15, 1),
  ('mission-w57-06-o1-c1', 'concept', 'Every process begins with the OS loader mapping its segments into memory, before main() and any of the program''s own logic starts.', 25, 2),
  ('mission-w57-06-o1-c1', 'solution', 'Loader maps the process -> main() begins in .text -> a read() syscall pulls in untrusted data -> parse_header() copies it into a fixed-size stack buffer with no bounds check.', 35, 3),

  ('mission-w57-06-o2-c1', 'orientation', 'You''ve already built the full path -- just confirm it.', 20, 1),
  ('mission-w57-06-o2-c1', 'solution', 'The path runs from OS loader, through main() and the network read, to an unbounded copy inside parse_header() -- the exact vulnerable component the next world will study in depth.', 30, 2);
