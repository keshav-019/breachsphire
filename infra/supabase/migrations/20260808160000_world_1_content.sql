-- Phase 2.4b: World 1 ("How Computers Actually Work: The Machine
-- Room") mission content. 1 campaign, 2 operations, 6 missions,
-- generated from docs/12-world-story-bible.md's World 1 entry.
-- Mission 1 is cross-world-gated on World 0's boss (mission-w0-10).

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-1a', 'world-1', 'the-machine-room', '1A - The Machine Room', 'Learn how computers represent and execute information, using a damaged file recovered from the first incident as the reason to care.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-1a-1', 'campaign-1a', 'foundations', 'Foundations', 'Binary, hardware roles and memory layout, learned as tools rather than theory.', 1),
  ('operation-1a-2', 'campaign-1a', 'investigation', 'Investigation', 'Apply those tools to the live process list and the damaged file itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w1-01', 'world-1', 'campaign-1a', 'operation-1a-1', 'the-machine-room', 'The Machine Room', 'Zayn and Luna bring the recruit into the hardware lab to make sense of a damaged file and an unfamiliar executable.', 'intro', ARRAY['zayn', 'luna'], '{"requiredMissionIds":["mission-w0-10"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w1-02', 'world-1', 'campaign-1a', 'operation-1a-1', 'speaking-in-bits', 'Speaking in Bits', 'The damaged file has a header that''s supposed to say what it is -- reading it means thinking in binary and hex first.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w1-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"hex-decoder-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w1-03', 'world-1', 'campaign-1a', 'operation-1a-1', 'building-the-machine', 'Building the Machine', 'Before calling a program''s behavior wrong, the recruit needs to know what''s supposed to happen when anything runs at all.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w1-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"component-assembly-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w1-04', 'world-1', 'campaign-1a', 'operation-1a-2', 'whos-running-what', 'Who''s Running What', 'The infected host was still running when it was imaged -- its live process list is real evidence.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w1-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"process-tree-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w1-05', 'world-1', 'campaign-1a', 'operation-1a-2', 'memory-map', 'Memory Map', 'One more piece before the file itself: where things live in memory while a program runs.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w1-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"memory-map-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w1-06', 'world-1', 'campaign-1a', 'operation-1a-2', 'hex-phantom', 'Hex Phantom', 'Everything so far points at one file -- report.txt. Prove what it actually is and what it would have done if it ran.', 'boss', ARRAY['zayn', 'luna', 'byte'], '{"requiredMissionIds":["mission-w1-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"hex-phantom-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["hex-phantom"],"skillXp":{"forensics":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w1-01', 1, 'zayn', 'Nova, right? Ava filled me in. You brought back a program from that phishing mess -- and a file that looks like it''s been through a blender.'),
  ('mission-w1-01', 2, 'luna', 'Before we touch either, we need to establish something: you can''t investigate what you can''t read. Every question Zayn walks you through has to trace back to this evidence, not a textbook.'),
  ('mission-w1-01', 3, 'zayn', 'Deal. First stop: what a computer actually thinks it''s doing when it runs something.'),
  ('mission-w1-02', 1, 'zayn', 'The damaged file has a header -- a handful of bytes at the very start that are supposed to say what it is. Before you can read it, you need to think the way the machine does: in bits.'),
  ('mission-w1-03', 1, 'zayn', 'Before you can say a program ''ran wrong,'' you need to know what''s actually supposed to happen when anything runs at all. Let''s build the machine.'),
  ('mission-w1-04', 1, 'luna', 'The infected host was still running when we imaged it. Its process list is real evidence -- if the implant was active, it''s in here somewhere.'),
  ('mission-w1-05', 1, 'zayn', 'One more piece before the file itself: where things live in memory while a program runs. The implant hides in the gaps between these regions.'),
  ('mission-w1-06', 1, 'zayn', 'Everything you''ve learned points at one file. It''s named report.txt. It is not a text file.'),
  ('mission-w1-06', 2, 'luna', 'Prove what it actually is, prove why the extension was misleading, and don''t guess.'),
  ('mission-w1-06', 3, 'zayn', 'MZ at the start of a file means exactly one thing, regardless of what the name says: this is a Windows executable.'),
  ('mission-w1-06', 4, 'luna', 'Check the compile metadata.'),
  ('mission-w1-06', 5, 'byte', 'The build tag reads GUARDIAN-INTERNAL-BUILD-07. That tooling was decommissioned before I existed. This should not be possible.'),
  ('mission-w1-06', 6, 'zayn', 'And it just reached out -- an outbound connection, seconds after execution. We need to understand where that connection actually goes. That''s a network problem now.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w1-01-o1', 'mission-w1-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to start from the evidence, not a lecture.'),
  ('mission-w1-02-o1', 'mission-w1-02', 1, 'Decode the byte', 'Convert a binary byte to its hexadecimal value.'),
  ('mission-w1-03-o1', 'mission-w1-03', 1, 'Match component to role', 'Assign each core hardware component to its functional role.'),
  ('mission-w1-04-o1', 'mission-w1-04', 1, 'Find what doesn''t belong', 'Identify the process entries whose parent relationship doesn''t match how they normally start.'),
  ('mission-w1-05-o1', 'mission-w1-05', 1, 'Order the regions', 'Order the memory regions from lowest to highest typical address.'),
  ('mission-w1-06-o1', 'mission-w1-06', 1, 'Read the true header', 'Determine the file''s real type from its magic bytes, not its extension.'),
  ('mission-w1-06-o2', 'mission-w1-06', 2, 'Explain the deception', 'Separate what actually determines the file''s behavior from what only misleads a human at a glance.'),
  ('mission-w1-06-o3', 'mission-w1-06', 3, 'Close the case', 'State the file''s real identity and how its extension was used to mislead.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w1-01-o1-c1', 'mission-w1-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Every concept we cover has to answer a real question from this evidence. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),
  ('mission-w1-02-o1-c1', 'mission-w1-02-o1', 1, 'multiple_choice', 'The byte 01001101 appears at the very start of the damaged file. What is it in hexadecimal?', '{"question":"The byte 01001101 appears at the very start of the damaged file. What is it in hexadecimal?","options":[{"id":"a","text":"0x4D"},{"id":"b","text":"0x53"},{"id":"c","text":"0x6D"},{"id":"d","text":"0xD4"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-03-o1-c1', 'mission-w1-03-o1', 1, 'drag_and_drop', 'Match each component to what it actually does.', '{"items":[{"id":"cpu","text":"CPU"},{"id":"ram","text":"RAM"},{"id":"storage","text":"Storage (disk/SSD)"},{"id":"bus","text":"System bus"}],"targets":[{"id":"execute","label":"Executes instructions"},{"id":"volatile","label":"Fast, temporary working memory"},{"id":"persistent","label":"Keeps data after power off"},{"id":"transport","label":"Moves data between components"}]}'::jsonb, '{"correctMapping":{"cpu":"execute","ram":"volatile","storage":"persistent","bus":"transport"}}'::jsonb),
  ('mission-w1-04-o1-c1', 'mission-w1-04-o1', 1, 'investigation', 'Which processes show a parent relationship that doesn''t match how these programs normally start?', '{"evidence":[{"id":"p1","label":"PID 412 -- explorer.exe","detail":"Parent: PID 1 (winlogon) -- normal for a user shell"},{"id":"p2","label":"PID 5588 -- svchost.exe","detail":"Parent: PID 412 (explorer.exe) -- svchost is normally spawned by services.exe, not the shell"},{"id":"p3","label":"PID 780 -- services.exe","detail":"Parent: PID 612 (wininit) -- normal system service host"},{"id":"p4","label":"PID 9021 -- conhost.exe","detail":"Parent: PID 780 (services.exe) -- a console host spawned by a background service with no user present"}],"question":"Which processes show a parent relationship that doesn''t match how these programs normally start?"}'::jsonb, '{"requiredEvidenceIds":["p2","p4"]}'::jsonb),
  ('mission-w1-05-o1-c1', 'mission-w1-05-o1', 1, 'interactive_diagram', 'Order these regions from lowest to highest typical address in a process''s memory layout.', '{"hotspots":[{"id":"code","label":"Code (text) segment","explanation":"Holds the program''s compiled instructions -- fixed size, loaded first, lowest typical address."},{"id":"data","label":"Data segment","explanation":"Global and static variables with a size known at compile time."},{"id":"heap","label":"Heap","explanation":"Dynamically allocated memory that grows upward as the program requests more."},{"id":"stack","label":"Stack","explanation":"Function calls, local variables and return addresses -- grows downward from the top of the process''s address space."}],"task":"Order these regions from lowest to highest typical address in a process''s memory layout."}'::jsonb, '{"correctOrderIds":["code","data","heap","stack"]}'::jsonb),
  ('mission-w1-06-o1-c1', 'mission-w1-06-o1', 1, 'multiple_choice', 'report.txt begins with the bytes 4D 5A. What does this actually tell you about the file?', '{"question":"report.txt begins with the bytes 4D 5A. What does this actually tell you about the file?","options":[{"id":"a","text":"It''s a corrupted text file"},{"id":"b","text":"It''s a Windows executable (PE/MZ header), regardless of its .txt extension"},{"id":"c","text":"It''s a compressed archive"},{"id":"d","text":"It''s a valid text file using an unusual encoding"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-w1-06-o2-c1', 'mission-w1-06-o2', 1, 'investigation', 'Which pieces of evidence explain why a human investigator could be fooled, separate from what the file actually is?', '{"evidence":[{"id":"ext","label":"File extension","detail":".txt"},{"id":"magic","label":"Magic bytes","detail":"4D 5A (\"MZ\") at offset 0"},{"id":"icon","label":"Shell icon","detail":"Generic document icon shown by the file explorer"},{"id":"assoc","label":"Default handler","detail":"The OS opens .txt files with a text editor by default, not the loader"}],"question":"Which pieces of evidence explain why a human investigator could be fooled, separate from what the file actually is?"}'::jsonb, '{"requiredEvidenceIds":["ext","icon"]}'::jsonb),
  ('mission-w1-06-o3-c1', 'mission-w1-06-o3', 1, 'boss_encounter', 'State the file''s real identity and how its extension was used to mislead.', '{"stages":[{"objectiveRef":"mission-w1-06-o1","label":"The true header"},{"objectiveRef":"mission-w1-06-o2","label":"The deception"}],"task":"State the file''s real identity and how its extension was used to mislead."}'::jsonb, '{"requiredObjectiveIds":["mission-w1-06-o1","mission-w1-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w1-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),
  ('mission-w1-02-o1-c1', 'orientation', 'Split the byte into two 4-bit halves -- each half is exactly one hex digit.', 10, 1),
  ('mission-w1-02-o1-c1', 'concept', '0100 in binary is 4. Work out the second half the same way.', 20, 2),
  ('mission-w1-02-o1-c1', 'solution', '0100 1101 splits into 4 and D, so the byte is 0x4D.', 30, 3),
  ('mission-w1-03-o1-c1', 'orientation', 'Ask what happens to each component''s contents the moment power is cut.', 10, 1),
  ('mission-w1-03-o1-c1', 'concept', 'One of these four literally does the ''thinking'' -- everything else supports it.', 20, 2),
  ('mission-w1-03-o1-c1', 'solution', 'CPU executes, RAM is fast/volatile working memory, storage persists across power-off, and the bus moves data between all of them.', 30, 3),
  ('mission-w1-04-o1-c1', 'orientation', 'Every process on this list has a parent. Most of those relationships are completely ordinary -- two aren''t.', 10, 1),
  ('mission-w1-04-o1-c1', 'concept', 'svchost.exe is a service host; it should be launched by the service control manager, not a user-facing shell.', 20, 2),
  ('mission-w1-04-o1-c1', 'tool_direction', 'Compare each parent against what would normally launch that specific program.', 30, 3),
  ('mission-w1-04-o1-c1', 'solution', 'PID 5588 (svchost spawned by explorer, not services.exe) and PID 9021 (a console host spawned by a background service with no logged-in user) both break the normal parent pattern.', 40, 4),
  ('mission-w1-05-o1-c1', 'orientation', 'Two of these are fixed-size and loaded first; two grow while the program runs, in opposite directions.', 10, 1),
  ('mission-w1-05-o1-c1', 'concept', 'The instructions themselves are placed lowest, since they''re fixed once the program is loaded.', 20, 2),
  ('mission-w1-05-o1-c1', 'solution', 'Lowest to highest: code, then data, then the heap growing upward, with the stack occupying the highest addresses.', 30, 3),
  ('mission-w1-06-o1-c1', 'orientation', 'A file''s extension is a suggestion to the OS shell, not a technical property of the file.', 15, 1),
  ('mission-w1-06-o1-c1', 'concept', 'Magic bytes at the start of a file identify its real format, independent of what it''s named.', 25, 2),
  ('mission-w1-06-o1-c1', 'solution', '4D 5A ("MZ") is the signature of a Windows PE executable -- the .txt extension is just cosmetic misdirection.', 35, 3),
  ('mission-w1-06-o2-c1', 'orientation', 'Separate what determines the file''s real behavior from what only determines how it looks and opens by default.', 15, 1),
  ('mission-w1-06-o2-c1', 'concept', 'Two of these are cosmetic (how it looks/opens); two are the actual technical proof of what it is.', 25, 2),
  ('mission-w1-06-o2-c1', 'solution', 'The extension and the generic icon are what mislead a human at a glance -- the magic bytes and default handler describe real mechanics, not the deception itself.', 35, 3),
  ('mission-w1-06-o3-c1', 'orientation', 'You''ve already gathered everything you need -- this is about stating the conclusion clearly.', 20, 1),
  ('mission-w1-06-o3-c1', 'concept', 'A disguised executable relies on the OS trusting cosmetic signals (extension, icon) instead of verifying the actual format.', 30, 2),
  ('mission-w1-06-o3-c1', 'tool_direction', 'Combine the true-header finding with the deception evidence into one statement.', 40, 3),
  ('mission-w1-06-o3-c1', 'near_solution', 'The file is a PE executable; the .txt extension and generic icon are what let it pass as harmless.', 50, 4),
  ('mission-w1-06-o3-c1', 'solution', 'report.txt is a Windows executable disguised behind a .txt extension and a generic icon -- its real identity is proven by its magic bytes, not its name.', 60, 5);
