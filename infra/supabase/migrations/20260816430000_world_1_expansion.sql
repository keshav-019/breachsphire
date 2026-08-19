-- Pilot expansion: World 1 ("The Machine Room") regular missions, deepened
-- from 1 objective/1 challenge each to 4 objectives/4 challenges each, to
-- test a longer-mission format before rolling it out across the rest of
-- Cyber Guardians' 74 worlds. Boss mission (mission-w1-06) is untouched --
-- it already has 3 objectives and appropriate depth.
--
-- Every added objective stays grounded in this world's existing evidence
-- and cast (Zayn, Luna, Byte; the damaged file and the unfamiliar
-- executable) rather than introducing new lore. The hex-practice
-- objectives in mission-w1-02 deliberately use different byte values than
-- the file's real header (4D 5A), so the boss mission's "this is a
-- Windows executable" reveal in mission-w1-06 still lands as a real
-- discovery instead of being pre-spoiled here.
--
-- Existing o1 objective/challenge/hint rows for each mission are left
-- untouched; this migration only adds o2-o4 plus updated mission rewards
-- (roughly proportional to the added depth).

update public.missions set rewards = '{"xp":150,"credits":30}'::jsonb where id = 'mission-w1-01';
update public.missions set rewards = '{"xp":260,"credits":45}'::jsonb where id = 'mission-w1-02';
update public.missions set rewards = '{"xp":280,"credits":45}'::jsonb where id = 'mission-w1-03';
update public.missions set rewards = '{"xp":280,"credits":45}'::jsonb where id = 'mission-w1-04';
update public.missions set rewards = '{"xp":280,"credits":45}'::jsonb where id = 'mission-w1-05';

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w1-02', 2, 'zayn', 'One byte down. You will not be reading the real header cold -- we warm up on a few practice bytes first.'),
  ('mission-w1-03', 2, 'luna', 'Matching parts to roles is the easy half. The real question is what actually happens, in order, the instant a program starts running.'),
  ('mission-w1-04', 2, 'luna', 'Finding two odd entries in a process list is a start. Explaining exactly why each one is wrong is what makes it evidence instead of a hunch.'),
  ('mission-w1-05', 2, 'zayn', 'Ordering the regions gets you the map. Understanding why they''re laid out that way is what lets you predict where something could go wrong.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w1-01-o2', 'mission-w1-01', 2, 'Confirm the evidence on the table', 'State exactly what Nova actually brought back from the phishing incident.'),
  ('mission-w1-01-o3', 'mission-w1-01', 3, 'Understand the ground rule', 'Explain why Luna insists every concept has to trace back to real evidence.'),
  ('mission-w1-01-o4', 'mission-w1-01', 4, 'Choose where to start', 'Decide which piece of evidence to examine first, and why.'),

  ('mission-w1-02-o2', 'mission-w1-02', 2, 'Decode a second byte', 'Convert a second binary byte to its hexadecimal value.'),
  ('mission-w1-02-o3', 'mission-w1-02', 3, 'Explain why hex', 'State why analysts write byte values in hexadecimal instead of raw binary.'),
  ('mission-w1-02-o4', 'mission-w1-02', 4, 'Read a reference header', 'Convert a short reference header, byte by byte, to hex.'),

  ('mission-w1-03-o2', 'mission-w1-03', 2, 'Explain why RAM exists', 'State why the CPU cannot simply execute directly from storage.'),
  ('mission-w1-03-o3', 'mission-w1-03', 3, 'Order the fetch-execute cycle', 'Put the stages of running one instruction in the order they actually happen.'),
  ('mission-w1-03-o4', 'mission-w1-03', 4, 'Locate where execution could go wrong', 'Identify which stage of the cycle a corrupted instruction stream would actually affect.'),

  ('mission-w1-04-o2', 'mission-w1-04', 2, 'Explain the svchost anomaly', 'State why svchost.exe having explorer.exe as its parent is abnormal.'),
  ('mission-w1-04-o3', 'mission-w1-04', 3, 'Explain the conhost anomaly', 'State why a console host spawned by a background service with no logged-in user is abnormal.'),
  ('mission-w1-04-o4', 'mission-w1-04', 4, 'Rank the findings by urgency', 'Identify which of four process entries actually warrant investigation, not just which look unusual.'),

  ('mission-w1-05-o2', 'mission-w1-05', 2, 'Explain the stack''s direction', 'State why the stack grows downward from the top of the address space.'),
  ('mission-w1-05-o3', 'mission-w1-05', 3, 'Distinguish heap from stack', 'State the actual functional difference between heap and stack allocation.'),
  ('mission-w1-05-o4', 'mission-w1-05', 4, 'Predict a collision risk', 'Identify what actually happens if the heap and stack grow into each other.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w1-01-o2-c1', 'mission-w1-01-o2', 1, 'multiple_choice', 'What has Nova actually brought back from the phishing incident?', '{"question":"What has Nova actually brought back from the phishing incident?","options":[{"id":"a","text":"A recovered program and a damaged file, both still unidentified"},{"id":"b","text":"A full incident report already written by Ava"},{"id":"c","text":"Nothing -- Zayn and Luna are starting from a clean slate"},{"id":"d","text":"A list of every contact the phishing message was sent to"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-01-o3-c1', 'mission-w1-01-o3', 1, 'multiple_choice', 'Why does Luna insist every concept has to trace back to this evidence, not a textbook?', '{"question":"Why does Luna insist every concept has to trace back to this evidence, not a textbook?","options":[{"id":"a","text":"Textbook knowledge you cannot apply to the evidence in front of you is not actually useful for an investigation"},{"id":"b","text":"Textbooks are considered classified material inside Cyber Guardians"},{"id":"c","text":"Zayn does not know how to teach from a textbook"},{"id":"d","text":"It is a formality with no real reasoning behind it"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-01-o4-c1', 'mission-w1-01-o4', 1, 'multiple_choice', 'Which piece of evidence should Nova examine first, and why?', '{"question":"Which piece of evidence should Nova examine first, and why?","options":[{"id":"a","text":"The damaged file first -- reading anything at the byte level has to come before trusting any conclusion about an executable''s behavior"},{"id":"b","text":"The unfamiliar executable first, since it is more likely to be dangerous"},{"id":"c","text":"Neither -- wait for Ava to assign an order"},{"id":"d","text":"Whichever one is smaller in file size"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w1-02-o2-c1', 'mission-w1-02-o2', 1, 'multiple_choice', 'A second practice byte, 10111010, appears in a training sample. What is it in hexadecimal?', '{"question":"A second practice byte, 10111010, appears in a training sample. What is it in hexadecimal?","options":[{"id":"a","text":"0xBA"},{"id":"b","text":"0xAB"},{"id":"c","text":"0xB1"},{"id":"d","text":"0x1B"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-02-o3-c1', 'mission-w1-02-o3', 1, 'multiple_choice', 'Why do analysts write byte values in hexadecimal instead of raw binary?', '{"question":"Why do analysts write byte values in hexadecimal instead of raw binary?","options":[{"id":"a","text":"Each hex digit maps exactly to 4 bits, so any byte becomes exactly two hex digits -- compact and lossless, unlike decimal"},{"id":"b","text":"Hexadecimal is simply a tradition with no technical reason behind it"},{"id":"c","text":"Computers cannot actually process binary directly"},{"id":"d","text":"Hexadecimal uses fewer total digits than decimal for every possible value"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-02-o4-c1', 'mission-w1-02-o4', 1, 'multiple_choice', 'A known-good reference file used for comparison starts with the bytes 25 50 44 46. What are the first two bytes in hex?', '{"question":"A known-good reference file used for comparison starts with the bytes 25 50 44 46. What are the first two bytes in hex?","options":[{"id":"a","text":"25 50"},{"id":"b","text":"52 05"},{"id":"c","text":"05 25"},{"id":"d","text":"50 25"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w1-03-o2-c1', 'mission-w1-03-o2', 1, 'multiple_choice', 'Why can''t the CPU simply execute instructions directly from storage?', '{"question":"Why can''t the CPU simply execute instructions directly from storage?","options":[{"id":"a","text":"Storage is far too slow for the CPU to read from on every single instruction -- RAM exists as fast, volatile working memory in between"},{"id":"b","text":"Storage devices are physically incompatible with the CPU''s connectors"},{"id":"c","text":"Instructions are only ever stored in RAM, never on disk, so this never comes up"},{"id":"d","text":"It actually can, and RAM is only used for user data, never instructions"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-03-o3-c1', 'mission-w1-03-o3', 1, 'interactive_diagram', 'Put these stages in the order they actually happen when the CPU runs one instruction.', '{"hotspots":[{"id":"fetch","label":"Fetch","explanation":"The CPU retrieves the next instruction from memory at the address the program counter points to."},{"id":"decode","label":"Decode","explanation":"The CPU interprets the fetched bits to determine which operation to perform."},{"id":"execute","label":"Execute","explanation":"The CPU actually performs the operation -- an arithmetic op, a memory access, a jump."},{"id":"writeback","label":"Write-back","explanation":"Any result is written back to a register or memory, and the program counter advances."}],"task":"Put these stages in the order they actually happen when the CPU runs one instruction."}'::jsonb, '{"correctOrderIds":["fetch","decode","execute","writeback"]}'::jsonb),
  ('mission-w1-03-o4-c1', 'mission-w1-03-o4', 1, 'multiple_choice', 'If a program''s instruction stream contained bytes that were never meant to be executed, which stage of the cycle would actually be affected first?', '{"question":"If a program''s instruction stream contained bytes that were never meant to be executed, which stage of the cycle would actually be affected first?","options":[{"id":"a","text":"Fetch -- the CPU would retrieve those bytes as if they were a legitimate instruction, with no way to tell the difference on its own"},{"id":"b","text":"Write-back -- the CPU always catches the problem at the very last stage"},{"id":"c","text":"None of them -- the operating system checks every instruction before the CPU ever sees it"},{"id":"d","text":"Decode -- fetch is always safe regardless of what the bytes actually are"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w1-04-o2-c1', 'mission-w1-04-o2', 1, 'multiple_choice', 'Why is svchost.exe having explorer.exe as its parent process abnormal?', '{"question":"Why is svchost.exe having explorer.exe as its parent process abnormal?","options":[{"id":"a","text":"svchost.exe hosts Windows services and is normally launched by services.exe (the service control manager), never by the user-facing shell"},{"id":"b","text":"svchost.exe should never appear in a process list at all"},{"id":"c","text":"explorer.exe is not allowed to have any child processes"},{"id":"d","text":"It is actually completely normal and not evidence of anything"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-04-o3-c1', 'mission-w1-04-o3', 1, 'multiple_choice', 'Why is a console host (conhost.exe) spawned by a background service, with no user logged in, abnormal?', '{"question":"Why is a console host (conhost.exe) spawned by a background service, with no user logged in, abnormal?","options":[{"id":"a","text":"conhost.exe exists to give a process a visible console window -- a background service with no interactive user has no legitimate reason to need one"},{"id":"b","text":"services.exe is never allowed to spawn any child process"},{"id":"c","text":"conhost.exe only ever appears during a system reboot"},{"id":"d","text":"It is normal; every service spawns a console host by default"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-04-o4-c1', 'mission-w1-04-o4', 1, 'investigation', 'Of these four process entries, which actually warrant investigation, versus which only look unusual at a glance?', '{"evidence":[{"id":"p1","label":"PID 412 -- explorer.exe","detail":"Parent: PID 1 (winlogon) -- the normal way a user shell starts"},{"id":"p2","label":"PID 5588 -- svchost.exe","detail":"Parent: PID 412 (explorer.exe) -- should be launched by services.exe, not the shell"},{"id":"p3","label":"PID 2201 -- backgroundTaskHost.exe","detail":"Parent: PID 412 (explorer.exe) -- this is actually the normal, documented way Windows launches UWP background tasks"},{"id":"p4","label":"PID 9021 -- conhost.exe","detail":"Parent: PID 780 (services.exe) -- a console host spawned by a background service with no interactive user present"}],"question":"Of these four process entries, which actually warrant investigation, versus which only look unusual at a glance?"}'::jsonb, '{"requiredEvidenceIds":["p2","p4"]}'::jsonb),

  ('mission-w1-05-o2-c1', 'mission-w1-05-o2', 1, 'multiple_choice', 'Why does the stack grow downward from the top of the process''s address space?', '{"question":"Why does the stack grow downward from the top of the process''s address space?","options":[{"id":"a","text":"It is a design convention that keeps the stack and the heap growing toward each other from opposite ends, using the address space efficiently until they meet"},{"id":"b","text":"Function calls are physically incapable of using ascending addresses"},{"id":"c","text":"It grows downward only on 32-bit systems, never on 64-bit ones"},{"id":"d","text":"There is no real reason -- it is arbitrary and could just as easily grow upward"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-05-o3-c1', 'mission-w1-05-o3', 1, 'multiple_choice', 'What is the actual functional difference between heap and stack allocation?', '{"question":"What is the actual functional difference between heap and stack allocation?","options":[{"id":"a","text":"Stack memory is automatically managed and tied to a function call''s lifetime; heap memory is manually requested and can outlive the function that allocated it"},{"id":"b","text":"They are functionally identical -- the names are purely stylistic"},{"id":"c","text":"The heap is faster to access than the stack in every case"},{"id":"d","text":"Only the stack can hold data larger than a few bytes"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w1-05-o4-c1', 'mission-w1-05-o4', 1, 'multiple_choice', 'What actually happens if the heap and the stack grow far enough to collide?', '{"question":"What actually happens if the heap and the stack grow far enough to collide?","options":[{"id":"a","text":"One overwrites the other''s data, corrupting program state -- exactly the kind of gap an implant could exploit to hide"},{"id":"b","text":"The operating system automatically merges them into one larger region with no side effects"},{"id":"c","text":"Nothing -- the two regions can never actually reach each other"},{"id":"d","text":"The program simply pauses until more memory becomes available"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w1-01-o2-c1', 'orientation', 'Re-read what Zayn said when he first greeted Nova in this mission.', 0, 1),
  ('mission-w1-01-o2-c1', 'solution', 'A recovered program and a damaged file -- neither has been identified yet.', 0, 2),
  ('mission-w1-01-o3-c1', 'orientation', 'Think about what happens when someone learns a rule but can never apply it to the case in front of them.', 0, 1),
  ('mission-w1-01-o3-c1', 'solution', 'Knowledge that cannot be applied to the actual evidence is not useful for an investigation.', 0, 2),
  ('mission-w1-01-o4-c1', 'orientation', 'You cannot trust conclusions about an executable''s behavior before you can even read raw bytes.', 0, 1),
  ('mission-w1-01-o4-c1', 'solution', 'The damaged file first -- byte-level literacy has to come before behavioral analysis.', 0, 2),

  ('mission-w1-02-o2-c1', 'orientation', 'Split the byte into two 4-bit halves, same as before.', 10, 1),
  ('mission-w1-02-o2-c1', 'concept', '1011 in binary is B. Work out the second half the same way.', 20, 2),
  ('mission-w1-02-o2-c1', 'solution', '1011 1010 splits into B and A, so the byte is 0xBA.', 30, 3),
  ('mission-w1-02-o3-c1', 'orientation', 'Think about how many bits one hex digit actually covers.', 10, 1),
  ('mission-w1-02-o3-c1', 'solution', 'One hex digit covers exactly 4 bits, so two hex digits describe a whole byte exactly.', 20, 2),
  ('mission-w1-02-o4-c1', 'orientation', 'This is a direct byte-for-byte hex read -- no arithmetic needed, just formatting.', 10, 1),
  ('mission-w1-02-o4-c1', 'solution', 'The first two bytes, read directly, are 25 50.', 20, 2),

  ('mission-w1-03-o2-c1', 'orientation', 'Think about the speed difference between storage and the CPU.', 10, 1),
  ('mission-w1-03-o2-c1', 'solution', 'Storage is too slow to read from on every instruction, so RAM sits in between as fast working memory.', 20, 2),
  ('mission-w1-03-o3-c1', 'orientation', 'The CPU has to know what an instruction says before it can decide what to do with it, and has to do that before actually doing it.', 10, 1),
  ('mission-w1-03-o3-c1', 'solution', 'Fetch, then decode, then execute, then write-back.', 20, 2),
  ('mission-w1-03-o4-c1', 'orientation', 'Think about which stage is the very first point the CPU touches an instruction at all.', 10, 1),
  ('mission-w1-03-o4-c1', 'solution', 'Fetch -- the CPU has no way to distinguish legitimate instructions from anything else at that stage.', 20, 2),

  ('mission-w1-04-o2-c1', 'orientation', 'Think about which system component is actually responsible for starting a Windows service.', 10, 1),
  ('mission-w1-04-o2-c1', 'solution', 'svchost.exe should be launched by services.exe, not by the user-facing shell.', 20, 2),
  ('mission-w1-04-o3-c1', 'orientation', 'Think about who a console window is actually for.', 10, 1),
  ('mission-w1-04-o3-c1', 'solution', 'A console host exists to give a process a visible window -- a headless background service has no legitimate need for one.', 20, 2),
  ('mission-w1-04-o4-c1', 'orientation', 'One of these four is a well-documented, normal Windows pattern -- don''t flag it just because it looks unfamiliar.', 10, 1),
  ('mission-w1-04-o4-c1', 'concept', 'backgroundTaskHost.exe under explorer.exe is the standard, documented way UWP background tasks launch.', 20, 2),
  ('mission-w1-04-o4-c1', 'solution', 'p2 and p4 are the real anomalies; p1 and p3 are both normal, documented parent relationships.', 30, 3),

  ('mission-w1-05-o2-c1', 'orientation', 'Think about the heap and the stack sharing the same address space from opposite ends.', 10, 1),
  ('mission-w1-05-o2-c1', 'solution', 'Growing toward each other from opposite ends uses the shared address space efficiently.', 20, 2),
  ('mission-w1-05-o3-c1', 'orientation', 'Think about which one is cleaned up automatically when a function returns.', 10, 1),
  ('mission-w1-05-o3-c1', 'solution', 'The stack is automatic and tied to function calls; the heap is manual and can outlive them.', 20, 2),
  ('mission-w1-05-o4-c1', 'orientation', 'Think about what it means for two different regions of memory to overlap.', 10, 1),
  ('mission-w1-05-o4-c1', 'solution', 'One overwrites the other, corrupting program state -- exactly the kind of gap an implant could exploit.', 20, 2);
