-- world-45 ("Malware Analysis: The Specimen") mission content, generated
-- from docs/12-world-story-bible.md. Opens with the RESILIENCE_TRIAL_07
-- label recovered from forensics -- mission 1 is cross-world-gated on
-- world-44's boss mission. The preserved sample from Mercy behaves like
-- ransomware but carries extensive telemetry logic; static and dynamic
-- analysis answer whether destruction was the goal or the experiment.
-- Closes on an encrypted configuration module with no obvious symbols,
-- handing off to world-46's reverse engineering.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-45a', 'world-45', 'static-and-dynamic', '45A - Static and Dynamic', 'Strings, imports, hashes, PE structure and sandbox behavior, learned by classifying one live specimen.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-45a-1', 'campaign-45a', 'foundations', 'Foundations', 'File format, strings and imports -- what the sample is, before it ever runs.', 1),
  ('operation-45a-2', 'campaign-45a', 'investigation', 'Investigation', 'Sandbox behavior, network activity and configuration extraction -- what the sample actually does.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w45-01', 'world-45', 'campaign-45a', 'operation-45a-1', 'the-specimen-arrives', 'The Specimen Arrives', 'RESILIENCE_TRIAL_07 is a label, not an answer. A preserved sample from Mercy is in the sandbox now, fully isolated, waiting for static analysis.', 'intro', ARRAY['ava', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w44-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w45-02', 'world-45', 'campaign-45a', 'operation-45a-1', 'first-look', 'First Look', 'Before a single string is read, the file format itself already tells you something -- and it isn''t intent.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w45-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"specimen-static-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 2),
  ('mission-w45-03', 'world-45', 'campaign-45a', 'operation-45a-1', 'strings-and-imports', 'Strings and Imports', 'Encryption calls explain the ransomware. Something else in this import table doesn''t belong to ransomware at all.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w45-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"specimen-strings-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w45-04', 'world-45', 'campaign-45a', 'operation-45a-2', 'inside-the-sandbox', 'Inside the Sandbox', 'Watch it actually run, safely, and time every stage the way it timed itself.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w45-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"specimen-sandbox-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w45-05', 'world-45', 'campaign-45a', 'operation-45a-2', 'the-network-and-the-verdict', 'The Network and the Verdict', 'The traffic it generates and the classification you assign it are the same question, asked two ways.', 'advanced', ARRAY['zayn', 'ava'], '{"requiredMissionIds":["mission-w45-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"specimen-network-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w45-06', 'world-45', 'campaign-45a', 'operation-45a-2', 'the-specimen-boss', 'The Specimen', 'Classify the sample, explain its behavior, and extract the configuration that defines the trial.', 'boss', ARRAY['byte', 'zayn', 'ava'], '{"requiredMissionIds":["mission-w45-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"the-specimen-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["the-specimen"],"skillXp":{"malware_analysis":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w45-01', 1, 'ava', 'RESILIENCE_TRIAL_07. We have the label. Now we need to know what the payload actually is, underneath the ransomware behavior.'),
  ('mission-w45-01', 2, 'byte', '...A preserved sample from Mercy is in the sandbox now, fully isolated. Static analysis first -- we don''t execute anything blind.'),
  ('mission-w45-01', 3, 'zayn', 'It behaves like ransomware. But there''s telemetry logic in here that has no reason to exist in something built purely to destroy.'),
  ('mission-w45-02', 1, 'byte', '...The header alone won''t tell you intent. It''ll tell you what you''re actually looking at, which is where every analysis has to start.'),
  ('mission-w45-03', 1, 'zayn', 'Sort what this thing imports. Some of it explains the ransomware. Some of it explains something else entirely.'),
  ('mission-w45-04', 1, 'byte', '...Sandboxed, isolated, monitored. Watch every stage transition, and notice which ones it times.'),
  ('mission-w45-05', 1, 'zayn', 'Whatever this is calling home to, it isn''t just sending encrypted files.'),
  ('mission-w45-05', 2, 'ava', 'So we classify it properly. Was destruction the goal, or the experiment?'),
  ('mission-w45-06', 1, 'byte', '...Full picture assembled. Static format, strings and imports, sandbox behavior, network traffic -- all one classification.'),
  ('mission-w45-06', 2, 'zayn', 'This isn''t commodity ransomware. It''s a ransomware-shaped testbed, instrumented to log its own timings and phone them home.'),
  ('mission-w45-06', 3, 'ava', 'So was destruction the goal, or the experiment?'),
  ('mission-w45-06', 4, 'byte', '...The experiment. Destruction was just the cover it wore while it measured us.'),
  ('mission-w45-06', 5, 'zayn', 'I pulled the full configuration block. trial_id matches what forensics found. Telemetry endpoint, sample metadata -- all there.'),
  ('mission-w45-06', 6, 'byte', '...There''s one more thing in that config. A module reference: core.enc. AES-encrypted, zero exported symbols, entropy right at the edge of what compression alone would explain.'),
  ('mission-w45-06', 7, 'ava', 'No symbols means no easy read on what it actually does.'),
  ('mission-w45-06', 8, 'zayn', 'Then we stop analyzing behavior from the outside, and start taking it apart.'),
  ('mission-w45-06', 9, 'byte', '...Reverse engineering. That encrypted module is next.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w45-01-o1', 'mission-w45-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to analyze the specimen safely, static-first.'),
  ('mission-w45-02-o1', 'mission-w45-02', 1, 'Identify the file format', 'Determine what the sample''s header bytes actually establish before any deeper analysis.'),
  ('mission-w45-03-o1', 'mission-w45-03', 1, 'Sort strings and imports by purpose', 'Sort each string or import into what it actually serves: encryption/destruction, telemetry, or networking.'),
  ('mission-w45-04-o1', 'mission-w45-04', 1, 'Order the sandboxed execution sequence', 'Order the sample''s actual stage transitions as observed in the sandbox.'),
  ('mission-w45-05-o1', 'mission-w45-05', 1, 'Find the telemetry exfiltration', 'Identify the network evidence showing the sample transmits performance data, not just encrypted files.'),
  ('mission-w45-05-o2', 'mission-w45-05', 2, 'Classify the sample', 'Choose the classification best supported by all the evidence gathered so far.'),
  ('mission-w45-06-o1', 'mission-w45-06', 1, 'Order the analysis methodology', 'Order the analysis pipeline you actually followed, from static format to final classification.'),
  ('mission-w45-06-o2', 'mission-w45-06', 2, 'Extract the trial configuration', 'Identify the artifact that defines the actual trial parameters, not just the ransomware dressing.'),
  ('mission-w45-06-o3', 'mission-w45-06', 3, 'Close the specimen case', 'Confirm the classification and the extracted configuration together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w45-01-o1-c1', 'mission-w45-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"Isolated sandbox, static analysis first, nothing executed blind. Ready to find out what this actually is?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w45-02-o1-c1', 'mission-w45-02-o1', 1, 'multiple_choice', 'The sample begins with the bytes 4D 5A ("MZ"). What does this establish before you''ve read a single string inside it?', '{"question":"The sample begins with the bytes 4D 5A (\"MZ\"). What does this establish before you''ve read a single string inside it?","options":[{"id":"a","text":"It''s definitely ransomware"},{"id":"b","text":"It''s a Windows PE executable -- the format alone says nothing yet about intent"},{"id":"c","text":"It''s a Linux ELF binary"},{"id":"d","text":"It''s corrupted and unreadable"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w45-03-o1-c1', 'mission-w45-03-o1', 1, 'drag_and_drop', 'Sort each string or import into what it actually serves.', '{"items":[{"id":"i1","text":"CryptEncrypt / CryptAcquireContext"},{"id":"i2","text":"GetTickCount / QueryPerformanceCounter, called at every stage transition"},{"id":"i3","text":"InternetOpenUrl / WinHttpSendRequest, to a hardcoded IP"},{"id":"i4","text":"FindFirstFile / FindNextFile, recursive directory walk"},{"id":"i5","text":"WriteFile to a hidden log path, timestamping each function entry"}],"targets":[{"id":"encryption_destruction","label":"Encryption / Destruction"},{"id":"telemetry","label":"Telemetry"},{"id":"networking","label":"Networking"}]}'::jsonb, '{"correctMapping":{"i1":"encryption_destruction","i2":"telemetry","i3":"networking","i4":"encryption_destruction","i5":"telemetry"}}'::jsonb),

  ('mission-w45-04-o1-c1', 'mission-w45-04-o1', 1, 'interactive_diagram', 'Order the sample''s actual stage transitions as observed in the sandbox.', '{"hotspots":[{"id":"start","label":"Process starts and runs environment/VM detection checks","explanation":"Before doing anything visible, it checks whether it''s being watched."},{"id":"ts1","label":"A timestamp is written to the hidden log immediately after the environment check","explanation":"The first of several precisely placed timing measurements."},{"id":"enumerate","label":"Recursive file enumeration begins across local drives","explanation":"Building the list of targets for encryption."},{"id":"encrypt","label":"Encryption begins, in batches","explanation":"The visible ransomware behavior."},{"id":"ts2","label":"A timestamp is written to the hidden log after each encryption batch","explanation":"Timing the destructive phase itself, not just the setup."},{"id":"note","label":"The ransom note is dropped","explanation":"The last visible action before the sample calls out."},{"id":"beacon_send","label":"The hidden log, full of timestamps, is sent to the command-and-control endpoint","explanation":"The payoff of all that timing -- it goes home."}],"task":"Order the sample''s actual stage transitions as observed in the sandbox."}'::jsonb, '{"correctOrderIds":["start","ts1","enumerate","encrypt","ts2","note","beacon_send"]}'::jsonb),

  ('mission-w45-05-o1-c1', 'mission-w45-05-o1', 1, 'investigation', 'Which network evidence shows the sample transmitting performance data, not just encrypted files?', '{"evidence":[{"id":"n1","label":"Beacon traffic","detail":"Connects to the same IP identified in world-44''s network mapping, at a regular interval"},{"id":"n2","label":"Outbound POST request","detail":"Contains a JSON body with keys including detect_t, contain_t and restore_t -- timestamps, not file data"},{"id":"n3","label":"Initial DNS resolution","detail":"A single lookup for the command-and-control domain, unremarkable on its own"}],"question":"Which network evidence shows the sample transmitting performance data, not just encrypted files?"}'::jsonb, '{"requiredEvidenceIds":["n2"]}'::jsonb),

  ('mission-w45-05-o2-c1', 'mission-w45-05-o2', 1, 'multiple_choice', 'Given the format, imports, sandbox behavior and network evidence gathered so far, which classification best fits this sample?', '{"question":"Given the format, imports, sandbox behavior and network evidence gathered so far, which classification best fits this sample?","options":[{"id":"a","text":"Generic commodity ransomware, financially motivated only"},{"id":"b","text":"A ransomware-shaped testbed, instrumented to log its own operational timings and exfiltrate them"},{"id":"c","text":"A benign monitoring tool with no destructive capability"},{"id":"d","text":"A decoy file with no real functionality"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w45-06-o1-c1', 'mission-w45-06-o1', 1, 'interactive_diagram', 'Order the analysis pipeline you actually followed, from static format to final classification.', '{"hotspots":[{"id":"static_format","label":"Static format identification -- confirming it''s a Windows PE, before assuming intent","explanation":"The first, intent-free step of any analysis."},{"id":"strings_imports","label":"Strings and imports triage -- sorting calls into encryption, telemetry and networking","explanation":"The first hint that this sample does more than one job."},{"id":"sandbox_dynamic","label":"Sandboxed dynamic execution -- observing the actual stage sequence, safely isolated","explanation":"Confirms what the static evidence only suggested."},{"id":"network_ioc","label":"Network and IOC extraction -- identifying what leaves the sandbox and what it contains","explanation":"Proves telemetry data, not just files, is being sent out."},{"id":"classification","label":"Classification -- naming what the sample actually is, based on all of the above","explanation":"The conclusion the entire pipeline was built to support."}],"task":"Order the analysis pipeline you actually followed, from static format to final classification."}'::jsonb, '{"correctOrderIds":["static_format","strings_imports","sandbox_dynamic","network_ioc","classification"]}'::jsonb),

  ('mission-w45-06-o2-c1', 'mission-w45-06-o2', 1, 'investigation', 'Which artifact defines the actual trial parameters, not just the ransomware dressing?', '{"evidence":[{"id":"cfg1","label":"Extracted configuration block","detail":"trial_id=RESILIENCE_TRIAL_07, telemetry_endpoint=<C2 address>, module: core.enc (AES-encrypted, 0 exported symbols, entropy 7.98)"},{"id":"cfg2","label":"Plaintext configuration string","detail":"Contains only the ransom note text -- no operational fields of any kind"}],"question":"Which artifact defines the actual trial parameters, not just the ransomware dressing?"}'::jsonb, '{"requiredEvidenceIds":["cfg1"]}'::jsonb),

  ('mission-w45-06-o3-c1', 'mission-w45-06-o3', 1, 'boss_encounter', 'Confirm the classification and the extracted configuration together.', '{"stages":[{"objectiveRef":"mission-w45-06-o1","label":"The analysis pipeline"},{"objectiveRef":"mission-w45-06-o2","label":"The trial configuration"}],"task":"Confirm the classification and the extracted configuration together."}'::jsonb, '{"requiredObjectiveIds":["mission-w45-06-o1","mission-w45-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w45-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w45-02-o1-c1', 'orientation', 'A file format header describes structure, not motive.', 15, 1),
  ('mission-w45-02-o1-c1', 'solution', 'MZ marks a Windows PE executable -- it says nothing yet about whether the file is malicious. Option b.', 25, 2),

  ('mission-w45-03-o1-c1', 'orientation', 'Ask what job each function call is actually doing for the sample, not what family of malware usually has it.', 15, 1),
  ('mission-w45-03-o1-c1', 'concept', 'Timing calls and hidden-log writes serve measurement, not encryption -- they don''t belong to a purely destructive payload.', 25, 2),
  ('mission-w45-03-o1-c1', 'solution', 'CryptEncrypt and the recursive file walk are encryption/destruction; GetTickCount/QueryPerformanceCounter and the hidden timestamped log are telemetry; the hardcoded-IP web request is networking.', 35, 3),

  ('mission-w45-04-o1-c1', 'orientation', 'Notice that a timestamp gets logged right after almost every meaningful step.', 15, 1),
  ('mission-w45-04-o1-c1', 'concept', 'The visible ransomware behavior (enumerate, encrypt, drop note) is interleaved with an invisible measurement behavior (log a timestamp after each stage).', 25, 2),
  ('mission-w45-04-o1-c1', 'solution', 'Start with environment checks, log a timestamp, enumerate files, encrypt in batches while logging a timestamp after each batch, drop the note, then send the full timestamped log home.', 35, 3),

  ('mission-w45-05-o1-c1', 'orientation', 'Two of these three pieces of network evidence are what you''d expect from any C2-connected ransomware.', 15, 1),
  ('mission-w45-05-o1-c1', 'concept', 'Field names like detect_t, contain_t and restore_t are timing data, not stolen files.', 25, 2),
  ('mission-w45-05-o1-c1', 'solution', 'The outbound POST containing detect_t/contain_t/restore_t (n2) is the telemetry exfiltration -- the beacon and DNS lookup are ordinary C2 infrastructure.', 35, 3),

  ('mission-w45-05-o2-c1', 'orientation', 'Weigh everything you''ve found: format, imports, sandbox timing behavior, and what actually left the sandbox.', 15, 1),
  ('mission-w45-05-o2-c1', 'solution', 'The evidence supports a ransomware-shaped testbed instrumented to log and exfiltrate its own operational timings -- option b.', 25, 2),

  ('mission-w45-06-o1-c1', 'orientation', 'This is the exact order you worked through worlds 45-02 through 45-05.', 15, 1),
  ('mission-w45-06-o1-c1', 'concept', 'Format first, then strings and imports, then dynamic sandbox behavior, then network evidence, and only then a classification supported by all of it.', 25, 2),
  ('mission-w45-06-o1-c1', 'tool_direction', 'Never classify before the evidence that justifies the classification.', 35, 3),
  ('mission-w45-06-o1-c1', 'solution', 'Static format identification, strings and imports triage, sandboxed dynamic execution, network and IOC extraction, then classification.', 45, 4),

  ('mission-w45-06-o2-c1', 'orientation', 'One of these two artifacts has real operational fields; the other is just what the victim was meant to read.', 15, 1),
  ('mission-w45-06-o2-c1', 'concept', 'A trial_id, telemetry endpoint and a named module are configuration, not cover text.', 25, 2),
  ('mission-w45-06-o2-c1', 'tool_direction', 'Look for the artifact that would matter to whoever is running the trial, not to the victim.', 35, 3),
  ('mission-w45-06-o2-c1', 'solution', 'The extracted configuration block (cfg1) is the trial definition -- trial_id, telemetry endpoint, and the core.enc module reference.', 45, 4),

  ('mission-w45-06-o3-c1', 'orientation', 'You''ve already walked the pipeline and extracted the configuration -- combine them.', 20, 1),
  ('mission-w45-06-o3-c1', 'concept', 'The closure needs the full analysis pipeline plus the configuration artifact that proves this was a measured trial.', 30, 2),
  ('mission-w45-06-o3-c1', 'tool_direction', 'State the five-stage pipeline first, then the trial_id and module reference it produced.', 40, 3),
  ('mission-w45-06-o3-c1', 'near_solution', 'Format, strings/imports, sandbox, network/IOC, classification -- five stages, ending in a config block naming trial_id RESILIENCE_TRIAL_07 and a module, core.enc, with zero exported symbols.', 50, 4),
  ('mission-w45-06-o3-c1', 'solution', 'The specimen is a ransomware-shaped testbed: a Windows PE whose imports split between real encryption/destruction calls and hidden telemetry calls, confirmed by a sandbox run that logs a timestamp after every stage, and a network capture proving those timestamps get exfiltrated as structured data. Its recovered configuration names trial_id RESILIENCE_TRIAL_07 and references one more piece: a module called core.enc, AES-encrypted, with zero exported symbols and entropy right at the edge of what compression alone would explain -- unreadable from the outside.', 65, 5);
