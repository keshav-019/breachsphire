-- Atlas Division pathway ("The Silence") Act 26 -- "On Call" content,
-- under world-atlas-on-call (already inserted separately). 1 campaign,
-- 2 operations, 12 missions (11 lessons + boss), opening World VIII
-- "The Failure Zone".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- incident-response artifact here is static seeded text read via
-- `cat`. New host `atlas-incident-01` holds the reconstructed record
-- of 03:17 itself (detection log, status updates, mitigation summary,
-- root-cause summary, the runbook written from it); the reused
-- `atlas-devbox-01` is not needed this Act, since nothing here is a
-- declared config -- every artifact is a genuine incident record.
-- Concept-only topics with no natural artifact (incident lifecycle,
-- incident command, postmortems, blameless analysis) stay
-- multiple_choice.
--
-- Narrative thread: this Act does not introduce a new incident. Every
-- mission reconstructs a real piece of the actual Act 1 story --
-- telemetry, CI runners, registries and DNS all going dark at 03:17,
-- the three independently discovered causes (an expiring certificate,
-- a filling disk, a killed process), and Leena''s original incident
-- command -- and finally runs it through the structured process this
-- World just taught. The boss's investigation deliberately includes a
-- ruled-out early hypothesis ("coordinated attack," `e3`) directly
-- pulled from Act 1''s own real tension, landing again on the exact
-- verbatim conclusion Act 1 already reached: nobody was attacked,
-- nobody was careless, this is what happens when nobody watches every
-- layer at once.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-on-call', 'world-atlas-on-call', 'on-call', '8A - On Call', 'Learn incident response from first principles -- the incident lifecycle, severity, detection, triage, incident command, communication, mitigation, recovery, postmortems, blameless analysis and runbooks -- while Atlas Division finally writes the postmortem 03:17 never actually got.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-on-call-1', 'campaign-atlas-on-call', 'the-night-everything-went-dark', 'The Night Everything Went Dark', 'The incident lifecycle, severity, detection, triage, incident command and communication.', 1),
  ('operation-atlas-on-call-2', 'campaign-atlas-on-call', 'the-postmortem-it-never-had', 'The Postmortem It Never Had', 'Mitigation, recovery, postmortems, blameless analysis and runbooks.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-on-call-01', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-1', 'incident-lifecycle', 'Incident Lifecycle', 'With real incident-response process finally in place, Cross proposes something Atlas Division never actually did -- a proper postmortem of the night this whole story began.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"incident-lifecycle-sim"}'::jsonb, '{"xp":640,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-on-call-02', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-1', 'severity', 'Severity', 'Confirm what severity level a night like that would actually be assigned today.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-on-call-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"severity-sim"}'::jsonb, '{"xp":640,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-on-call-03', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-1', 'detection', 'Detection', 'Confirm exactly how 03:17 was actually first noticed, and by what.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-atlas-on-call-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"detection-sim"}'::jsonb, '{"xp":650,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-on-call-04', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-1', 'triage', 'Triage', 'Understand what actually has to happen first, before anyone starts fixing anything at all.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-on-call-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"triage-sim"}'::jsonb, '{"xp":650,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-on-call-05', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-1', 'incident-command', 'Incident Command', 'Confirm who actually ran the response that night, and understand why that role exists at all.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-on-call-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"incident-command-sim"}'::jsonb, '{"xp":660,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-on-call-06', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-1', 'communication', 'Communication', 'Confirm how every other division actually stayed informed without interrupting the people fixing it.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-on-call-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"communication-sim"}'::jsonb, '{"xp":660,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-on-call-07', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-2', 'mitigation', 'Mitigation', 'Confirm exactly what actually stopped the bleeding that night, one cause at a time.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-on-call-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"mitigation-sim"}'::jsonb, '{"xp":670,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-on-call-08', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-2', 'recovery', 'Recovery', 'Understand why stopping the immediate symptom was never actually the same as being done.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-on-call-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"recovery-sim"}'::jsonb, '{"xp":670,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-on-call-09', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-2', 'postmortems', 'Postmortems', 'Understand why a postmortem gets written after every real incident, including the ones that ended fine.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-on-call-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"postmortems-sim"}'::jsonb, '{"xp":680,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-on-call-10', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-2', 'blameless-analysis', 'Blameless Analysis', 'Understand exactly what a postmortem is actually supposed to find responsible.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-on-call-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"blameless-analysis-sim"}'::jsonb, '{"xp":680,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-on-call-11', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-2', 'runbooks', 'Runbooks', 'Confirm what this postmortem actually produced, twenty-five Acts after the incident it describes.', 'beginner', ARRAY['cross','rook'], '{"requiredMissionIds":["mission-atlas-on-call-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"runbooks-sim"}'::jsonb, '{"xp":690,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-on-call-12', 'world-atlas-on-call', 'campaign-atlas-on-call', 'operation-atlas-on-call-2', '03-17', '03:17', 'Everything this World taught, turned on one night: not a new crisis, the first real closure the story ever had.', 'boss', ARRAY['leena','cross','byte','rook'], '{"requiredMissionIds":["mission-atlas-on-call-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"03-17-boss-sim"}'::jsonb, '{"xp":800,"credits":190,"badgeIds":["03-17"],"skillXp":{"cloud_devops_fundamentals":125}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-on-call-01', 1, 'leena', 'With real incident-response process finally in place, Cross wants to do something Atlas Division never actually did at the time -- a proper postmortem of the night this entire story began.'),
  ('mission-atlas-on-call-01', 2, 'cross', 'Imani Cross. Every real incident follows the same shape -- detect, triage, respond, mitigate, recover, and then write down exactly what happened. We lived through 03:17. We never actually closed it.'),

  ('mission-atlas-on-call-02', 1, 'cross', 'Severity is not about how it felt. It is about actual blast radius and user impact. Confirm what that night would actually be rated today.'),

  ('mission-atlas-on-call-03', 1, 'byte', 'No single alert caught this. Telemetry, CI runners, registries and DNS all went dark within the same few seconds. The pattern itself was the first real signal, not any one system.'),

  ('mission-atlas-on-call-04', 1, 'cross', 'Before anyone fixes anything, triage decides what actually gets looked at first. Confirm what that actually looked like, that night.'),

  ('mission-atlas-on-call-05', 1, 'leena', 'Someone has to coordinate, or everyone tries a different fix on the same system at once and nobody can tell what actually worked. That was me, that night, whether anyone called it incident command or not.'),

  ('mission-atlas-on-call-06', 1, 'leena', 'Every other division needed to know something was happening without pulling the people actually fixing it into a meeting. Confirm how that was actually handled.'),

  ('mission-atlas-on-call-07', 1, 'cross', 'Three independent causes meant three independent mitigations, run in parallel, not one fix waiting on another. Confirm exactly what each one actually was.'),

  ('mission-atlas-on-call-08', 1, 'cross', 'Stopping the immediate symptom is not recovery. Confirm what actually had to be true before that night was genuinely over.'),

  ('mission-atlas-on-call-09', 1, 'cross', 'A postmortem gets written after every real incident, even the ones that end cleanly -- especially those, honestly, since nobody is under pressure to write it while the fire is still going.'),

  ('mission-atlas-on-call-10', 1, 'leena', 'A postmortem is never supposed to find a person responsible. It is supposed to find whatever it was about the system, or the process, that let this happen -- the same thing, to anyone, under the same conditions.'),

  ('mission-atlas-on-call-11', 1, 'rook', 'A postmortem that changes nothing was never really finished. Confirm what this one actually produced.'),

  ('mission-atlas-on-call-12', 1, 'leena', 'Everything this World taught you, on one night. Not a new crisis -- the first real closure the story this pathway opened with has ever actually had.'),
  ('mission-atlas-on-call-12', 2, 'byte', 'I have the full reconstructed timeline and the root-cause summary both pulled up together. Twenty-five Acts late, but complete.'),
  ('mission-atlas-on-call-12', 3, 'cross', 'The early guess that night was a coordinated attack. Confirm whether that theory actually survives contact with the real evidence.'),
  ('mission-atlas-on-call-12', 4, 'leena', 'Find what this was always actually about, and finally write it down properly.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-on-call-01-o1', 'mission-atlas-on-call-01', 1, 'Explain the incident lifecycle', 'Choose the accurate description of the structured stages a real incident actually follows.'),

  ('mission-atlas-on-call-02-o1', 'mission-atlas-on-call-02', 1, 'Read the severity assessment', 'Read the severity assessment and submit the verification code.'),

  ('mission-atlas-on-call-03-o1', 'mission-atlas-on-call-03', 1, 'Read the detection log', 'Read the detection log and submit the verification code.'),

  ('mission-atlas-on-call-04-o1', 'mission-atlas-on-call-04', 1, 'Read the triage record', 'Read the triage record and submit the verification code.'),

  ('mission-atlas-on-call-05-o1', 'mission-atlas-on-call-05', 1, 'Explain incident command', 'Choose the accurate description of why a single incident commander is actually necessary.'),

  ('mission-atlas-on-call-06-o1', 'mission-atlas-on-call-06', 1, 'Read the status updates', 'Read the communication log and submit the verification code.'),

  ('mission-atlas-on-call-07-o1', 'mission-atlas-on-call-07', 1, 'Read the mitigation summary', 'Read the mitigation summary and submit the verification code.'),

  ('mission-atlas-on-call-08-o1', 'mission-atlas-on-call-08', 1, 'Explain recovery', 'Choose the accurate description of what actually has to be true for an incident to be considered recovered.'),

  ('mission-atlas-on-call-09-o1', 'mission-atlas-on-call-09', 1, 'Explain postmortems', 'Choose the accurate description of when a postmortem actually gets written.'),

  ('mission-atlas-on-call-10-o1', 'mission-atlas-on-call-10', 1, 'Explain blameless analysis', 'Choose the accurate description of what a postmortem is actually supposed to identify.'),

  ('mission-atlas-on-call-11-o1', 'mission-atlas-on-call-11', 1, 'Read the runbook', 'Read the runbook and submit the verification code.'),

  ('mission-atlas-on-call-12-o1', 'mission-atlas-on-call-12', 1, 'Confirm the reconstructed timeline', 'Read the full incident timeline and submit the verification code.'),
  ('mission-atlas-on-call-12-o2', 'mission-atlas-on-call-12', 2, 'Confirm the root-cause summary', 'Read the root-cause summary and submit the verification code.'),
  ('mission-atlas-on-call-12-o3', 'mission-atlas-on-call-12', 3, 'Identify what actually explains 03:17', 'Find the evidence that explains what this incident was always actually about.'),
  ('mission-atlas-on-call-12-o4', 'mission-atlas-on-call-12', 4, 'Write the postmortem', 'Having confirmed all three, write the postmortem this incident never actually got.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-on-call-01-o1-c1', 'mission-atlas-on-call-01-o1', 1, 'multiple_choice', 'A real incident actually follows which structured shape?', '{"question":"A real incident actually follows which structured shape?","options":[{"id":"a","text":"Detect, triage, respond, mitigate, recover, then write down exactly what happened -- a defined process, not just improvised firefighting"},{"id":"b","text":"Whoever notices first fixes it alone, then everyone moves on"},{"id":"c","text":"A postmortem is written first, before anything is actually fixed"},{"id":"d","text":"Severity is assigned only after the postmortem is complete"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-on-call-02-o1-c1', 'mission-atlas-on-call-02-o1', 1, 'terminal_simulation', 'Read the severity assessment and submit the verification code.', '{"instructions":"Read /var/atlas-incident-01/severity-03-17.txt and submit the verification code with: submit CODE","hostname":"atlas-incident-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-incident-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-incident-01/severity-03-17.txt":{"type":"file","content":"incident: 03:17 telemetry blackout\nblast radius: telemetry, CI runners, registries, DNS -- all of Atlas Division''s visibility at once\nseverity: SEV1 -- full loss of observability across the division\n# verification SEVERITY-3312\n"}}}'::jsonb, '{"requiredFlag":"SEVERITY-3312"}'::jsonb),

  ('mission-atlas-on-call-03-o1-c1', 'mission-atlas-on-call-03-o1', 1, 'terminal_simulation', 'Read the detection log and submit the verification code.', '{"instructions":"Read /var/atlas-incident-01/detection-03-17.txt and submit the verification code with: submit CODE","hostname":"atlas-incident-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-incident-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-incident-01/detection-03-17.txt":{"type":"file","content":"03:17:02 - telemetry dashboards: all metrics flatlined simultaneously\n03:17:04 - CI runners: all disconnected\n03:17:06 - registries: unreachable\n03:17:09 - DNS records: expired\nfirst human notice: 03:19, Byte flagging the simultaneous pattern\n# no single alert caught this -- the pattern itself was the first real signal\n# verification DETECTION-6602\n"}}}'::jsonb, '{"requiredFlag":"DETECTION-6602"}'::jsonb),

  ('mission-atlas-on-call-04-o1-c1', 'mission-atlas-on-call-04-o1', 1, 'terminal_simulation', 'Read the triage record and submit the verification code.', '{"instructions":"Read /var/atlas-incident-01/triage-03-17.txt and submit the verification code with: submit CODE","hostname":"atlas-incident-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-incident-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-incident-01/triage-03-17.txt":{"type":"file","content":"triage order: nexus-infra-19 (last host still reporting green) checked first, to find one working foothold before chasing every dark system at once\n# verification TRIAGE-7714\n"}}}'::jsonb, '{"requiredFlag":"TRIAGE-7714"}'::jsonb),

  ('mission-atlas-on-call-05-o1-c1', 'mission-atlas-on-call-05-o1', 1, 'multiple_choice', 'A single incident commander is actually necessary because...', '{"question":"A single incident commander is actually necessary because...","options":[{"id":"a","text":"Without one, multiple people can try conflicting fixes on the same system at once, making it impossible to tell what actually worked"},{"id":"b","text":"Only the incident commander is allowed to know what is happening"},{"id":"c","text":"The incident commander must personally fix every issue alone"},{"id":"d","text":"Incident command is only needed for incidents that turn out to be attacks"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-on-call-06-o1-c1', 'mission-atlas-on-call-06-o1', 1, 'terminal_simulation', 'Read the communication log and submit the verification code.', '{"instructions":"Read /var/atlas-incident-01/communication-03-17.txt and submit the verification code with: submit CODE","hostname":"atlas-incident-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-incident-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-incident-01/communication-03-17.txt":{"type":"file","content":"03:22 - status: investigating, multiple systems affected, cause unknown\n03:41 - status: three independent root causes identified\n04:15 - status: all three causes resolved, monitoring for recurrence\n04:40 - status: resolved\n# regular updates kept every division informed without interrupting the responders directly\n# verification COMMUNICATION-8802\n"}}}'::jsonb, '{"requiredFlag":"COMMUNICATION-8802"}'::jsonb),

  ('mission-atlas-on-call-07-o1-c1', 'mission-atlas-on-call-07-o1', 1, 'terminal_simulation', 'Read the mitigation summary and submit the verification code.', '{"instructions":"Read /var/atlas-incident-01/mitigation-03-17.txt and submit the verification code with: submit CODE","hostname":"atlas-incident-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-incident-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-incident-01/mitigation-03-17.txt":{"type":"file","content":"mitigation 1: renewed the expiring certificate manually\nmitigation 2: cleared the growing debug-trace.log that was filling disk\nmitigation 3: confirmed the killed process (log-compactor, pid 1337) was correctly terminated, not itself the problem\n# three parallel, independent fixes, not one root cause chased in sequence\n# verification MITIGATION-9012\n"}}}'::jsonb, '{"requiredFlag":"MITIGATION-9012"}'::jsonb),

  ('mission-atlas-on-call-08-o1-c1', 'mission-atlas-on-call-08-o1', 1, 'multiple_choice', 'An incident is actually considered recovered once...', '{"question":"An incident is actually considered recovered once...","options":[{"id":"a","text":"Full service is confirmed genuinely restored and stable, not just the moment the immediate symptom stops"},{"id":"b","text":"The first mitigation is applied, regardless of what happens afterward"},{"id":"c","text":"The incident commander declares it over without further confirmation"},{"id":"d","text":"A postmortem has been written"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-on-call-09-o1-c1', 'mission-atlas-on-call-09-o1', 1, 'multiple_choice', 'A postmortem actually gets written...', '{"question":"A postmortem actually gets written...","options":[{"id":"a","text":"After every real incident, including the ones that end cleanly, precisely because there is no pressure to skip it while nothing is still on fire"},{"id":"b","text":"Only after incidents severe enough to make the news"},{"id":"c","text":"Only when the cause turns out to be a person''s mistake"},{"id":"d","text":"Never, if the incident resolved itself"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-on-call-10-o1-c1', 'mission-atlas-on-call-10-o1', 1, 'multiple_choice', 'A postmortem is actually supposed to identify...', '{"question":"A postmortem is actually supposed to identify...","options":[{"id":"a","text":"Whatever it was about the system or the process that would let the same thing happen to anyone, under the same conditions -- never a person to blame"},{"id":"b","text":"The specific individual responsible for the incident"},{"id":"c","text":"Whether the on-call engineer followed every rule perfectly"},{"id":"d","text":"Nothing -- its only purpose is documentation, never process change"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-on-call-11-o1-c1', 'mission-atlas-on-call-11-o1', 1, 'terminal_simulation', 'Read the runbook and submit the verification code.', '{"instructions":"Read /var/atlas-incident-01/runbook-telemetry-blackout.txt and submit the verification code with: submit CODE","hostname":"atlas-incident-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-incident-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-incident-01/runbook-telemetry-blackout.txt":{"type":"file","content":"runbook: telemetry-blackout-response\ntrigger: 3 or more unrelated systems go dark within the same 60-second window\nstep 1: do not assume one cause -- check certificates, disk usage and process health independently, in parallel\nstep 2: assign one incident commander before anyone starts applying a fix\nstep 3: communicate status on a fixed interval, even when there is nothing new to report\n# written directly from the 03:17 postmortem, twenty-five Acts after the incident it describes\n# verification RUNBOOK-4471\n"}}}'::jsonb, '{"requiredFlag":"RUNBOOK-4471"}'::jsonb),

  ('mission-atlas-on-call-12-o1-c1', 'mission-atlas-on-call-12-o1', 1, 'terminal_simulation', 'Read the full incident timeline and submit the verification code.', '{"instructions":"Read /var/atlas-incident-01/detection-03-17.txt and submit the verification code with: submit CODE","hostname":"atlas-incident-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-incident-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-incident-01/detection-03-17.txt":{"type":"file","content":"03:17:02 - telemetry dashboards: all metrics flatlined simultaneously\n03:17:04 - CI runners: all disconnected\n03:17:06 - registries: unreachable\n03:17:09 - DNS records: expired\nfirst human notice: 03:19, Byte flagging the simultaneous pattern\n# no single alert caught this -- the pattern itself was the first real signal\n# verification DETECTION-6602\n"}}}'::jsonb, '{"requiredFlag":"DETECTION-6602"}'::jsonb),
  ('mission-atlas-on-call-12-o2-c1', 'mission-atlas-on-call-12-o2', 1, 'terminal_simulation', 'Read the root-cause summary and submit the verification code.', '{"instructions":"Read /var/atlas-incident-01/root-cause-summary-03-17.txt and submit the verification code with: submit CODE","hostname":"atlas-incident-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-incident-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-incident-01/root-cause-summary-03-17.txt":{"type":"file","content":"root cause 1: a certificate that was always going to expire\nroot cause 2: a disk that was always going to fill\nroot cause 3: a process that was always going to be killed\nall three discovered independently, all three unremarkable on their own\n# verification ROOTCAUSE-8802\n"}}}'::jsonb, '{"requiredFlag":"ROOTCAUSE-8802"}'::jsonb),
  ('mission-atlas-on-call-12-o3-c1', 'mission-atlas-on-call-12-o3', 1, 'investigation', 'Which evidence explains what 03:17 was always actually about?', '{"evidence":[{"id":"e1","label":"Detection log","detail":"Telemetry, CI runners, registries and DNS all went dark within seconds of each other"},{"id":"e2","label":"Root-cause summary","detail":"Three independent, individually unremarkable causes -- an expiring certificate, a filling disk, a killed process"},{"id":"e3","label":"Early hypothesis","detail":"The initial working theory that night was a coordinated attack across every system at once"},{"id":"e4","label":"No single owner","detail":"No individual or team was ever responsible for watching certificates, disk usage and process health across every system simultaneously"}],"question":"Which evidence explains what 03:17 was always actually about?"}'::jsonb, '{"requiredEvidenceIds":["e2","e4"]}'::jsonb),
  ('mission-atlas-on-call-12-o4-c1', 'mission-atlas-on-call-12-o4', 1, 'boss_encounter', 'Having confirmed the timeline, the root causes, and what this was always actually about, write the postmortem.', '{"stages":[{"objectiveRef":"mission-atlas-on-call-12-o1","label":"Confirm the reconstructed timeline"},{"objectiveRef":"mission-atlas-on-call-12-o2","label":"Confirm the root-cause summary"},{"objectiveRef":"mission-atlas-on-call-12-o3","label":"Identify what actually explains 03:17"}],"task":"Write the postmortem in one sentence: nothing about 03:17 was ever an attack -- a certificate that was always going to expire, a disk that was always going to fill and a process that was always going to be killed all surfaced within the same few seconds because no one team or system was ever watching every layer at once, and that gap, not any single cause, is the actual thing this pathway has spent twenty-five Acts closing."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-on-call-12-o1","mission-atlas-on-call-12-o2","mission-atlas-on-call-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-on-call-01-o1-c1', 'orientation', 'Think about a defined sequence of stages versus improvised firefighting.', 10, 1),
  ('mission-atlas-on-call-01-o1-c1', 'solution', 'Detect, triage, respond, mitigate, recover, then write it down.', 20, 2),

  ('mission-atlas-on-call-02-o1-c1', 'orientation', 'Try: cat /var/atlas-incident-01/severity-03-17.txt', 10, 1),
  ('mission-atlas-on-call-02-o1-c1', 'solution', 'SEV1, full visibility loss, verification SEVERITY-3312. submit SEVERITY-3312', 20, 2),

  ('mission-atlas-on-call-03-o1-c1', 'orientation', 'Try: cat /var/atlas-incident-01/detection-03-17.txt', 10, 1),
  ('mission-atlas-on-call-03-o1-c1', 'solution', 'The simultaneous pattern was the first signal, verification DETECTION-6602. submit DETECTION-6602', 20, 2),

  ('mission-atlas-on-call-04-o1-c1', 'orientation', 'Try: cat /var/atlas-incident-01/triage-03-17.txt', 10, 1),
  ('mission-atlas-on-call-04-o1-c1', 'solution', 'The last green host was checked first, verification TRIAGE-7714. submit TRIAGE-7714', 20, 2),

  ('mission-atlas-on-call-05-o1-c1', 'orientation', 'Think about what happens without one person coordinating who does what.', 10, 1),
  ('mission-atlas-on-call-05-o1-c1', 'solution', 'Without a commander, conflicting fixes make it impossible to tell what worked.', 20, 2),

  ('mission-atlas-on-call-06-o1-c1', 'orientation', 'Try: cat /var/atlas-incident-01/communication-03-17.txt', 10, 1),
  ('mission-atlas-on-call-06-o1-c1', 'solution', 'Regular status updates, verification COMMUNICATION-8802. submit COMMUNICATION-8802', 20, 2),

  ('mission-atlas-on-call-07-o1-c1', 'orientation', 'Try: cat /var/atlas-incident-01/mitigation-03-17.txt', 10, 1),
  ('mission-atlas-on-call-07-o1-c1', 'solution', 'Three parallel fixes, verification MITIGATION-9012. submit MITIGATION-9012', 20, 2),

  ('mission-atlas-on-call-08-o1-c1', 'orientation', 'Think about the symptom stopping versus full, stable service being confirmed.', 10, 1),
  ('mission-atlas-on-call-08-o1-c1', 'solution', 'Recovery means service is genuinely restored and stable, not just the symptom gone.', 20, 2),

  ('mission-atlas-on-call-09-o1-c1', 'orientation', 'Think about pressure while the fire is still going versus after it is out.', 10, 1),
  ('mission-atlas-on-call-09-o1-c1', 'solution', 'A postmortem is written after every real incident, even the clean ones.', 20, 2),

  ('mission-atlas-on-call-10-o1-c1', 'orientation', 'Think about a system-level cause versus a person to point at.', 10, 1),
  ('mission-atlas-on-call-10-o1-c1', 'solution', 'It finds the systemic cause that would happen to anyone, never a person to blame.', 20, 2),

  ('mission-atlas-on-call-11-o1-c1', 'orientation', 'Try: cat /var/atlas-incident-01/runbook-telemetry-blackout.txt', 10, 1),
  ('mission-atlas-on-call-11-o1-c1', 'solution', 'Written directly from the postmortem, verification RUNBOOK-4471. submit RUNBOOK-4471', 20, 2),

  ('mission-atlas-on-call-12-o1-c1', 'orientation', 'Try: cat /var/atlas-incident-01/detection-03-17.txt', 10, 1),
  ('mission-atlas-on-call-12-o1-c1', 'solution', 'verification DETECTION-6602. submit DETECTION-6602', 20, 2),
  ('mission-atlas-on-call-12-o2-c1', 'orientation', 'Try: cat /var/atlas-incident-01/root-cause-summary-03-17.txt', 10, 1),
  ('mission-atlas-on-call-12-o2-c1', 'solution', 'Three unremarkable, independent causes, verification ROOTCAUSE-8802. submit ROOTCAUSE-8802', 20, 2),
  ('mission-atlas-on-call-12-o3-c1', 'orientation', 'The timeline itself is a symptom, and the attack theory was already ruled out that same night. Look at the root causes and who was actually watching what.', 10, 1),
  ('mission-atlas-on-call-12-o3-c1', 'solution', 'e2 and e4: three mundane causes, and no one ever owned watching all three layers at once.', 20, 2),
  ('mission-atlas-on-call-12-o4-c1', 'orientation', 'Combine the three causes and the missing ownership into the postmortem''s actual finding.', 15, 1),
  ('mission-atlas-on-call-12-o4-c1', 'solution', 'Nothing was attacked -- three unremarkable causes surfaced together because nobody was ever watching every layer at once, and that gap is what this entire pathway has been closing.', 25, 2);
