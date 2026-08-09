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

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w58-01', 1, 'ava', 'A safe, sandboxed crash reproducer for the gateway parser. Nothing here escapes the sandbox -- the goal is understanding, not exploitation.'),
  ('mission-w58-01', 2, 'byte', 'The parser copied unbounded network data into a fixed-size stack buffer. Now we find out exactly what that actually breaks.'),
  ('mission-w58-02', 1, 'zayn', 'A stack buffer that''s too small doesn''t corrupt "the stack" in the abstract. It overwrites whatever''s sitting right next to it in memory -- often, the return address.'),
  ('mission-w58-03', 1, 'byte', 'An integer overflow doesn''t throw an error. It silently wraps to something tiny or negative, and every calculation downstream trusts it without question.'),
  ('mission-w58-04', 1, 'zayn', 'A pointer to memory that''s already been freed, used again as if it still pointed to something valid. The memory might still look fine. It usually isn''t, for long.'),
  ('mission-w58-05', 1, 'byte', 'User-controlled input, passed directly as a format string instead of as an argument to one. The format specifiers inside it get interpreted, not printed.'),
  ('mission-w58-06', 1, 'zayn', 'Find the exact condition that corrupts state in this parser. Not "it''s unsafe" -- the precise input and the precise mechanism.'),
  ('mission-w58-06', 2, 'byte', '...Condition isolated. A header field claiming a length larger than the actual buffer causes an out-of-bounds copy that overwrites the return address.'),
  ('mission-w58-06', 3, 'ava', 'Now prove it with the smallest input that still triggers it. Nothing extra, nothing decorative.'),
  ('mission-w58-06', 4, 'zayn', 'Minimal reproducer built. It crashes reliably, every time, with exactly the bytes needed and not one more.'),
  ('mission-w58-06', 5, 'byte', 'A crash isn''t the whole story though. Modern builds have protections that make turning this into real control a lot harder than the crash alone suggests.'),
  ('mission-w58-06', 6, 'ava', 'Then we need to understand those protections before we understand what this bug actually means.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w58-01-o1', 'mission-w58-01', 1, 'Acknowledge the briefing', 'Confirm you understand this stays inside the sandbox.'),
  ('mission-w58-02-o1', 'mission-w58-02', 1, 'Identify what the overflow overwrites', 'Identify what a stack buffer overflow of this size overwrites next.'),
  ('mission-w58-03-o1', 'mission-w58-03', 1, 'Find the integer overflow', 'Identify the line where an integer calculation can silently wrap around.'),
  ('mission-w58-04-o1', 'mission-w58-04', 1, 'Find the use-after-free', 'Identify which code path uses a pointer after the memory it points to has been freed.'),
  ('mission-w58-05-o1', 'mission-w58-05', 1, 'Identify the format string bug', 'Determine which function call passes user input directly as a format string.'),
  ('mission-w58-06-o1', 'mission-w58-06', 1, 'Identify the exact corrupting condition', 'Determine the precise input condition that corrupts state in the gateway parser.'),
  ('mission-w58-06-o2', 'mission-w58-06', 2, 'Build the minimal reproducer', 'Choose the smallest input that still reliably triggers the crash.'),
  ('mission-w58-06-o3', 'mission-w58-06', 3, 'Confirm the finding', 'Confirm the corrupting condition and the minimal reproducer together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w58-01-o1-c1', 'mission-w58-01-o1', 1, 'story_dialogue', 'Confirm you understand this stays inside the sandbox.', '{"lines":[{"characterId":"ava","text":"Understanding, not exploitation. The sandbox stays sealed the entire time. Clear?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w58-02-o1-c1', 'mission-w58-02-o1', 1, 'interactive_diagram', 'A 64-byte stack buffer receives 96 bytes of input with no bounds check. What does the extra 32 bytes overwrite?', '{"hotspots":[{"id":"buf","label":"The 64-byte buffer itself","explanation":"Filled completely by the first 64 bytes."},{"id":"saved_regs","label":"Saved register values, adjacent in the stack frame","explanation":"Overwritten by the next portion of the overflow."},{"id":"return_addr","label":"The function''s saved return address","explanation":"Overwritten by the final bytes -- this is what makes stack overflows dangerous, not just disruptive."}],"task":"Order what gets overwritten as the 32 extra bytes continue past the buffer."}'::jsonb, '{"correctOrderIds":["buf","saved_regs","return_addr"]}'::jsonb),

  ('mission-w58-03-o1-c1', 'mission-w58-03-o1', 1, 'code_debugging', 'Which line contains an integer calculation that can silently wrap around?', '{"language":"c","code":"uint16_t count = read_u16(header);\nuint16_t total_size = count * sizeof(record_t);  // sizeof(record_t) == 64\nrecord_t *records = malloc(total_size);\nread_records(records, count);", "question":"Which line is the integer overflow risk, and why?"}'::jsonb, '{"requiredLineIds":["uint16_t total_size = count * sizeof(record_t);  // sizeof(record_t) == 64"]}'::jsonb),

  ('mission-w58-04-o1-c1', 'mission-w58-04-o1', 1, 'code_debugging', 'Which code path uses a pointer after the memory it points to has been freed?', '{"language":"c","code":"connection_t *conn = get_connection(id);\nprocess_request(conn);\nfree(conn);\n\nif (should_log_metrics(conn)) {\n  log_metrics(conn->stats);\n}", "question":"Which line is the use-after-free?"}'::jsonb, '{"requiredLineIds":["if (should_log_metrics(conn)) {"]}'::jsonb),

  ('mission-w58-05-o1-c1', 'mission-w58-05-o1', 1, 'multiple_choice', 'Which function call is a format string vulnerability?', '{"question":"Which function call is a format string vulnerability?","options":[{"id":"a","text":"printf(\"%s\", user_input);"},{"id":"b","text":"printf(user_input);"},{"id":"c","text":"printf(\"User said: %s\\n\", user_input);"},{"id":"d","text":"fprintf(stderr, \"%d\\n\", error_code);"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w58-06-o1-c1', 'mission-w58-06-o1', 1, 'investigation', 'What is the precise condition that corrupts state in the gateway parser?', '{"evidence":[{"id":"cond1","label":"Header field length matches actual payload size","detail":"Normal, safe case -- no corruption"},{"id":"cond2","label":"Header field claims a length of 512 bytes; the actual fixed-size destination buffer is 64 bytes; no comparison between the two occurs before the copy","detail":"The exact corrupting condition"}],"question":"Which condition corrupts state?"}'::jsonb, '{"requiredEvidenceIds":["cond2"]}'::jsonb),

  ('mission-w58-06-o2-c1', 'mission-w58-06-o2', 1, 'multiple_choice', 'Which input is the correct minimal reproducer?', '{"question":"Which input is the correct minimal reproducer?","options":[{"id":"a","text":"A full, realistic 10KB capture of legitimate traffic with the header length field changed to 512"},{"id":"b","text":"A header field declaring length 512, followed by exactly 65 bytes of payload -- just enough past the 64-byte buffer to overwrite the return address, nothing extraneous"},{"id":"c","text":"An empty packet with no header at all"},{"id":"d","text":"The maximum possible packet size the protocol allows"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w58-06-o3-c1', 'mission-w58-06-o3', 1, 'boss_encounter', 'Confirm the corrupting condition and the minimal reproducer together.', '{"stages":[{"objectiveRef":"mission-w58-06-o1","label":"The corrupting condition"},{"objectiveRef":"mission-w58-06-o2","label":"The minimal reproducer"}],"task":"Confirm the corrupting condition and the minimal reproducer together."}'::jsonb, '{"requiredObjectiveIds":["mission-w58-06-o1","mission-w58-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w58-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you understand the sandbox boundary.', 0, 1),

  ('mission-w58-02-o1-c1', 'orientation', 'Memory is contiguous -- whatever comes right after the buffer in the stack frame gets hit first.', 15, 1),
  ('mission-w58-02-o1-c1', 'solution', 'The buffer fills first, then adjacent saved registers, then the saved return address -- overwriting that last one is what turns a crash into something an attacker can potentially redirect.', 25, 2),

  ('mission-w58-03-o1-c1', 'orientation', 'Ask what happens when a 16-bit value gets multiplied by something and the true result doesn''t fit in 16 bits.', 15, 1),
  ('mission-w58-03-o1-c1', 'solution', 'count * sizeof(record_t) can wrap around in 16-bit arithmetic if count is large enough, producing a tiny total_size -- malloc then allocates far less than read_records() will actually write.', 25, 2),

  ('mission-w58-04-o1-c1', 'orientation', 'Find where the pointer is used again after the line that frees it.', 15, 1),
  ('mission-w58-04-o1-c1', 'solution', 'conn is freed, then passed to should_log_metrics() and conn->stats is dereferenced afterward -- both are use-after-free.', 25, 2),

  ('mission-w58-05-o1-c1', 'orientation', 'The vulnerable version is missing a fixed format string of its own.', 15, 1),
  ('mission-w58-05-o1-c1', 'solution', 'printf(user_input) treats the user''s data itself as the format string, so any %s, %x or %n inside it gets interpreted -- the other options all use a fixed format string with user data as a safe argument.', 25, 2),

  ('mission-w58-06-o1-c1', 'orientation', 'Ask what''s missing between reading the claimed length and using it.', 15, 1),
  ('mission-w58-06-o1-c1', 'solution', 'A header claiming 512 bytes copied into a 64-byte buffer with no length check in between is the exact corrupting condition -- the matching-length case (cond1) is completely safe.', 25, 2),

  ('mission-w58-06-o2-c1', 'orientation', 'Minimal means exactly enough to reach the return address, nothing more.', 15, 1),
  ('mission-w58-06-o2-c1', 'solution', '65 bytes past a 64-byte buffer, declared via the header field, is the smallest input that reliably reaches and overwrites the return address -- option b, not a full realistic capture.', 25, 2),

  ('mission-w58-06-o3-c1', 'orientation', 'You''ve already isolated the condition and built the reproducer -- combine them.', 20, 1),
  ('mission-w58-06-o3-c1', 'solution', 'The corrupting condition is an unchecked header length exceeding the 64-byte destination buffer, and the minimal reproducer is exactly 65 bytes past that boundary -- the smallest input that reliably overwrites the return address.', 35, 2);
