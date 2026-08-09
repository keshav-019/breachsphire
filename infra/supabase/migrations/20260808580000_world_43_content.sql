-- world-43 ("Incident Response: Containment") mission content, generated
-- from docs/12-world-story-bible.md. Opens directly inside the live,
-- ransomware-like incident that world-42's capstone "Sleeper" triggered at
-- Mercy Hospital -- mission 1 is cross-world-gated on world-42's boss
-- mission and does not re-explain the foothold, it lands in the active
-- crisis. Preparation through lessons-learned are lived as phases of one
-- evolving incident. Closes on the suspicion that Sentinel-X is testing
-- resilience, handing off to world-44's forensic reconstruction.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-43a', 'world-43', 'containment-protocol', '43A - Containment Protocol', 'Preparation through lessons learned, lived as phases of one evolving crisis at Mercy Hospital.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-43a-1', 'campaign-43a', 'first-response', 'First Response', 'Detection, triage and the containment decision, made while the incident is still moving.', 1),
  ('operation-43a-2', 'campaign-43a', 'recovery', 'Recovery', 'Eradication, recovery verification and the review that turns a crisis into a lesson.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w43-01', 'world-43', 'campaign-43a', 'operation-43a-1', 'the-crisis-at-mercy', 'The Crisis at Mercy', 'The foothold you hunted without an alert just answered. It''s active inside Mercy Hospital''s network, right now.', 'intro', ARRAY['luna', 'zayn', 'byte', 'ava'], '{"requiredMissionIds":["mission-w42-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w43-02', 'world-43', 'campaign-43a', 'operation-43a-1', 'signal-from-noise', 'Signal From Noise', 'Some of these hosts are genuinely infected. One just looks that way. Sort signal from noise before committing to a containment scope.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w43-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-triage-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 2),
  ('mission-w43-03', 'world-43', 'campaign-43a', 'operation-43a-1', 'the-containment-line', 'The Containment Line', 'The clock is running. Decide what gets isolated and what keeps running, knowing every extra minute is spread and every unnecessary shutdown is patient care.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w43-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-containment-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w43-04', 'world-43', 'campaign-43a', 'operation-43a-1', 'chain-of-custody', 'Chain of Custody', 'Eradication can wait a few minutes. Evidence that gets overwritten can''t be recovered at all. Preserve it correctly, in order.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w43-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-evidence-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w43-05', 'world-43', 'campaign-43a', 'operation-43a-2', 'what-we-tell-them', 'What We Tell Them', 'A stakeholder message that overpromises will cost trust later. An eradication plan that skips a step will bring this right back.', 'intermediate', ARRAY['zayn', 'ava'], '{"requiredMissionIds":["mission-w43-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-comms-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w43-06', 'world-43', 'campaign-43a', 'operation-43a-2', 'mercy-hospital-boss', 'Mercy Hospital', 'Contain the incident without unnecessarily shutting down critical systems, then recover and document what actually happened.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w43-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-hospital-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["mercy-hospital"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w43-01', 1, 'luna', 'The foothold I asked you to hunt without an alert just answered. It''s active inside Mercy Hospital''s network, right now.'),
  ('mission-w43-01', 2, 'zayn', 'Encryption processes running on admin and records systems. Emergency department and patient monitoring are still up -- for now.'),
  ('mission-w43-01', 3, 'byte', '...This isn''t a hunting exercise anymore. This is a live incident. Preparation, detection, triage -- all of it, starting now.'),
  ('mission-w43-01', 4, 'ava', 'Every system that''s still running is a system we can still lose. Let''s move.'),
  ('mission-w43-02', 1, 'byte', 'Two hosts look infected. One host looks infected and isn''t -- it''s an overlapping backup window. Sort that out before we commit to a containment scope.'),
  ('mission-w43-03', 1, 'ava', 'We don''t get to shut down the whole hospital to feel safe. We isolate exactly what''s infected, and nothing that isn''t.'),
  ('mission-w43-04', 1, 'byte', '...Eradication can wait a few minutes. Evidence that gets overwritten can''t be recovered at all. Preserve it correctly, in order, before anything else touches that host.'),
  ('mission-w43-05', 1, 'zayn', 'Leadership, staff and eventually the public are all going to hear something about this. What we tell them has to be accurate without being alarmist.'),
  ('mission-w43-05', 2, 'ava', 'And eradication has to be complete, not cosmetic. Miss one persistence mechanism and this comes right back.'),
  ('mission-w43-06', 1, 'zayn', 'Systems are back. Patient records, admin, monitoring -- all restored, all clean.'),
  ('mission-w43-06', 2, 'byte', '...I finished the post-incident review. Full phase reconstruction: preparation, detection, triage, containment, eradication, recovery, lessons learned.'),
  ('mission-w43-06', 3, 'ava', 'Good. Now tell me why the ransom note reads like an afterthought.'),
  ('mission-w43-06', 4, 'byte', '...Because it might be one. I found a hidden log inside the payload''s own working directory. It timestamped our detection, our first containment action, and our restore time for every single system, individually.'),
  ('mission-w43-06', 5, 'zayn', 'That''s not what destructive malware does. That''s what a benchmark does.'),
  ('mission-w43-06', 6, 'ava', 'The payload appears destructive. But it also collected precise measurements of our recovery performance.'),
  ('mission-w43-06', 7, 'byte', '...Every phase of this incident, timed and logged by the thing that caused it.'),
  ('mission-w43-06', 8, 'ava', 'We suspect Sentinel-X is testing our resilience. Suspicion isn''t proof.'),
  ('mission-w43-06', 9, 'zayn', 'Then we get proof. Forensics next -- full timeline, first foothold to right now, and whatever left this network on the way out.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w43-01-o1', 'mission-w43-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to run this as a live, evolving incident.'),
  ('mission-w43-02-o1', 'mission-w43-02', 1, 'Separate confirmed infections from noise', 'Identify which hosts show genuine ransomware indicators and which are a false positive.'),
  ('mission-w43-03-o1', 'mission-w43-03', 1, 'Set the containment scope', 'Choose the containment action that stops the spread without unnecessarily shutting down critical systems.'),
  ('mission-w43-04-o1', 'mission-w43-04', 1, 'Preserve evidence in the correct order', 'Order the evidence-preservation steps that must happen before eradication touches the infected host.'),
  ('mission-w43-05-o1', 'mission-w43-05', 1, 'Draft the stakeholder message', 'Choose the message that is accurate and calm, without overpromising or leaking technical detail.'),
  ('mission-w43-05-o2', 'mission-w43-05', 2, 'Sort the eradication plan', 'Sort each eradication action by when it''s safe to do it -- or whether it should be done at all.'),
  ('mission-w43-06-o1', 'mission-w43-06', 1, 'Reconstruct the incident phases', 'Order the full incident from preparation through lessons learned.'),
  ('mission-w43-06-o2', 'mission-w43-06', 2, 'Find what the payload really measured', 'Identify the evidence showing this payload''s purpose goes beyond destruction.'),
  ('mission-w43-06-o3', 'mission-w43-06', 3, 'Close the incident', 'Confirm the incident reconstruction and the recovery-performance finding together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w43-01-o1-c1', 'mission-w43-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"This is live. Preparation, detection, triage, containment, eradication, recovery, lessons learned -- all one incident. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w43-02-o1-c1', 'mission-w43-02-o1', 1, 'log_analysis', 'Which hosts show confirmed ransomware activity that requires containment, and which is a false positive?', '{"logs":[{"id":"h1","label":"Records-DB-02","detail":"Mass file rename with a new .mercylock extension, sustained write-op spike, activity starting outside business hours"},{"id":"h2","label":"Backup-Srv-01","detail":"High disk write volume, but it matches the nightly scheduled backup window exactly, and the backup job log hash matches the known-good baseline"},{"id":"h3","label":"Admin-WS-14","detail":"A ransom note file dropped, spawned from an unusual parent process, timing consistent with Records-DB-02"},{"id":"h4","label":"NICU-Mon-03","detail":"No process anomalies; traffic stays isolated to the expected medical-device VLAN"}],"question":"Which hosts show confirmed ransomware activity that requires containment?"}'::jsonb, '{"requiredLogIds":["h1","h3"]}'::jsonb),

  ('mission-w43-03-o1-c1', 'mission-w43-03-o1', 1, 'timed_incident', 'Decide the containment scope before the infection spreads further.', '{"scenario":"Records-DB-02 and Admin-WS-14 are confirmed infected. NICU monitoring, ED admitting and the rest of the hospital network are clean but connected to the same core switch.","timeLimitSeconds":180,"options":[{"id":"a","text":"Shut down the entire hospital network, including NICU monitoring and ED admitting","consequence":"Fully stops spread, but takes down patient-care systems that were never infected."},{"id":"b","text":"Isolate Records-DB-02 and Admin-WS-14 at the switch port level; leave everything else running","consequence":"Contains the confirmed infection without disrupting systems that are still clean."},{"id":"c","text":"Keep monitoring and gather more evidence before acting","consequence":"The infection continues spreading while you wait."},{"id":"d","text":"Disconnect the hospital from the internet, but leave the internal network flat","consequence":"Does nothing to stop lateral spread inside the network itself."}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w43-04-o1-c1', 'mission-w43-04-o1', 1, 'interactive_diagram', 'Order the evidence-preservation steps that must happen before eradication begins.', '{"hotspots":[{"id":"photo","label":"Photograph and log the visible ransom note and screen state in place","explanation":"Captures the scene before anything about it changes."},{"id":"memory","label":"Capture volatile memory from the infected host before it is powered off","explanation":"Memory is lost the moment the host powers down -- it has to come first among the technical steps."},{"id":"image","label":"Take a write-blocked forensic disk image of the infected host","explanation":"Preserves the disk state without risking modification."},{"id":"hash","label":"Hash every collected artifact and log it in the chain-of-custody record","explanation":"Proves nothing was altered between collection and later analysis."},{"id":"eradicate","label":"Begin eradication on that host","explanation":"Only safe to start once everything above is already preserved."}],"task":"Order the evidence-preservation steps that must happen before eradication begins."}'::jsonb, '{"correctOrderIds":["photo","memory","image","hash","eradicate"]}'::jsonb),

  ('mission-w43-05-o1-c1', 'mission-w43-05-o1', 1, 'multiple_choice', 'Which stakeholder message is accurate without overpromising or leaking technical detail?', '{"question":"Which stakeholder message is accurate without overpromising or leaking technical detail?","options":[{"id":"a","text":"Post the full technical incident detail publicly, including exploited vulnerabilities"},{"id":"b","text":"\"Some administrative systems were affected. Patient care systems remain operational. An update will follow within a defined window; data-exposure status is not yet confirmed.\""},{"id":"c","text":"Deny that anything happened until the investigation is fully closed"},{"id":"d","text":"Promise full restoration \"within the hour\" before eradication is even complete"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w43-05-o2-c1', 'mission-w43-05-o2', 1, 'drag_and_drop', 'Sort each eradication action by when it''s safe to do it -- or whether it should be done at all.', '{"items":[{"id":"e1","text":"Remove the malicious scheduled task and rogue service account"},{"id":"e2","text":"Rotate every credential that touched the infected hosts"},{"id":"e3","text":"Patch the vulnerability used for initial access"},{"id":"e4","text":"Restore from the most recent backup without checking whether it''s clean"},{"id":"e5","text":"Monitor for beacon activity for a defined period after restoring"}],"targets":[{"id":"before_reconnect","label":"Do before reconnecting"},{"id":"after_reconnect","label":"Do after reconnecting"},{"id":"avoid","label":"Never do this"}]}'::jsonb, '{"correctMapping":{"e1":"before_reconnect","e2":"before_reconnect","e3":"before_reconnect","e4":"avoid","e5":"after_reconnect"}}'::jsonb),

  ('mission-w43-06-o1-c1', 'mission-w43-06-o1', 1, 'interactive_diagram', 'Order the full incident from preparation through lessons learned.', '{"hotspots":[{"id":"preparation","label":"Preparation -- backups, runbooks and roles that existed before this incident began","explanation":"Everything done ahead of time that made the rest of this possible."},{"id":"detection","label":"Detection -- the sleeper foothold activating and the first alerts firing","explanation":"The moment the crisis became visible."},{"id":"triage","label":"Triage -- separating confirmed infections from false positives","explanation":"Sorting signal from noise before committing to any action."},{"id":"containment","label":"Containment -- isolating exactly the infected hosts, nothing more","explanation":"Stopping the spread without unnecessary disruption."},{"id":"eradication","label":"Eradication -- persistence removed, credentials rotated, the entry point patched","explanation":"Making sure the cause is actually gone, not just hidden."},{"id":"recovery","label":"Recovery -- systems restored from verified-clean backups and monitored afterward","explanation":"Bringing things back online with confidence, not hope."},{"id":"lessons_learned","label":"Lessons learned -- the post-incident review, including what the payload itself recorded","explanation":"Where the recovery-performance finding actually surfaced."}],"task":"Order the full incident from preparation through lessons learned."}'::jsonb, '{"correctOrderIds":["preparation","detection","triage","containment","eradication","recovery","lessons_learned"]}'::jsonb),

  ('mission-w43-06-o2-c1', 'mission-w43-06-o2', 1, 'investigation', 'Which evidence suggests this payload''s real purpose goes beyond destruction?', '{"evidence":[{"id":"r1","label":"Ransom note","detail":"Generic phrasing, demands payment, no negotiation channel that actually works"},{"id":"r2","label":"Hidden log file","detail":"Found inside the payload''s own working directory, recording exact timestamps: detection at T+14m22s, first containment action at T+31m09s, and a per-system restore time logged individually for every host"},{"id":"r3","label":"Shadow copy deletion","detail":"Standard ransomware behavior, present but unremarkable on its own"}],"question":"Which evidence suggests this payload''s real purpose goes beyond destruction?"}'::jsonb, '{"requiredEvidenceIds":["r2"]}'::jsonb),

  ('mission-w43-06-o3-c1', 'mission-w43-06-o3', 1, 'boss_encounter', 'Confirm the incident reconstruction and the recovery-performance finding together.', '{"stages":[{"objectiveRef":"mission-w43-06-o1","label":"The full incident timeline"},{"objectiveRef":"mission-w43-06-o2","label":"What the payload measured"}],"task":"Confirm the incident reconstruction and the recovery-performance finding together."}'::jsonb, '{"requiredObjectiveIds":["mission-w43-06-o1","mission-w43-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w43-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w43-02-o1-c1', 'orientation', 'One of these four hosts has a perfectly ordinary explanation for its activity.', 15, 1),
  ('mission-w43-02-o1-c1', 'concept', 'A backup job that matches a known schedule and a known-good hash is not an infection, no matter how much disk activity it produces.', 25, 2),
  ('mission-w43-02-o1-c1', 'solution', 'Records-DB-02 (h1) and Admin-WS-14 (h3) are confirmed infections; Backup-Srv-01 (h2) is a scheduled-job false positive and NICU-Mon-03 (h4) shows no compromise.', 35, 3),

  ('mission-w43-03-o1-c1', 'orientation', 'The bible for this incident is simple: stop the spread, don''t stop patient care that was never at risk.', 15, 1),
  ('mission-w43-03-o1-c1', 'concept', 'Containment scope should match the actual blast radius -- only the hosts you''ve confirmed infected.', 25, 2),
  ('mission-w43-03-o1-c1', 'solution', 'Isolating only the two confirmed-infected hosts at the switch port (option b) contains the spread without touching NICU monitoring, ED admitting, or anything else still clean.', 35, 3),

  ('mission-w43-04-o1-c1', 'orientation', 'Volatile evidence disappears the moment power does. Order accordingly.', 15, 1),
  ('mission-w43-04-o1-c1', 'concept', 'Document the scene, then capture what disappears first (memory), then what''s more stable (disk), then prove nothing was altered (hashing), and only then start eradication.', 25, 2),
  ('mission-w43-04-o1-c1', 'solution', 'Photograph the scene, capture memory, image the disk, hash and log every artifact, then begin eradication.', 35, 3),

  ('mission-w43-05-o1-c1', 'orientation', 'Two of these four options either say too little or promise too much.', 15, 1),
  ('mission-w43-05-o1-c1', 'solution', 'Option b states real, verified facts in plain language without a technical dump or an unearned promise -- that''s the correct stakeholder message.', 25, 2),

  ('mission-w43-05-o2-c1', 'orientation', 'Ask whether each action is safe before or after systems reconnect to the network -- or whether it should never happen at all.', 15, 1),
  ('mission-w43-05-o2-c1', 'concept', 'Restoring from a backup that was never verified clean can simply reinfect everything you just cleaned.', 25, 2),
  ('mission-w43-05-o2-c1', 'solution', 'Remove persistence, rotate credentials and patch the entry point before reconnecting; monitor for beacon activity after reconnecting; never restore from an unverified backup.', 35, 3),

  ('mission-w43-06-o1-c1', 'orientation', 'This mirrors the standard incident-response lifecycle -- start from what existed before the incident even began.', 15, 1),
  ('mission-w43-06-o1-c1', 'concept', 'Each phase depends on the one before it: you can''t contain what you haven''t triaged, and you can''t learn lessons from an incident that isn''t yet recovered.', 25, 2),
  ('mission-w43-06-o1-c1', 'tool_direction', 'Place preparation first and lessons learned last -- everything else falls into the order you actually lived it in.', 35, 3),
  ('mission-w43-06-o1-c1', 'solution', 'Preparation, detection, triage, containment, eradication, recovery, lessons learned.', 45, 4),

  ('mission-w43-06-o2-c1', 'orientation', 'Two of these three pieces of evidence are exactly what you''d expect from ordinary ransomware.', 15, 1),
  ('mission-w43-06-o2-c1', 'concept', 'A generic ransom note and shadow-copy deletion are standard. Precisely timestamped logs of your own detection and recovery speed are not.', 25, 2),
  ('mission-w43-06-o2-c1', 'tool_direction', 'Ask what a purely destructive payload would have no reason to record.', 35, 3),
  ('mission-w43-06-o2-c1', 'solution', 'The hidden log timestamping detection, containment and per-system restore times (r2) is the finding -- it reads like a benchmark, not a ransom demand.', 45, 4),

  ('mission-w43-06-o3-c1', 'orientation', 'You''ve already reconstructed the timeline and found the recovery-performance log -- combine them.', 20, 1),
  ('mission-w43-06-o3-c1', 'concept', 'The closure needs the complete seven-phase incident plus the evidence that this was measured, not just destructive.', 30, 2),
  ('mission-w43-06-o3-c1', 'tool_direction', 'State the seven phases in order first, then name the recovery-performance log as the anomaly.', 40, 3),
  ('mission-w43-06-o3-c1', 'near_solution', 'Preparation through lessons learned, seven phases, with a hidden log inside the payload timestamping detection, containment and restore -- destructive on the surface, measured underneath.', 50, 4),
  ('mission-w43-06-o3-c1', 'solution', 'The incident ran preparation, detection, triage, containment, eradication, recovery and lessons learned as one continuous crisis. The payload looked like ordinary ransomware, but a hidden log inside it timestamped every phase of your own response -- detection, first containment action, and per-system restore time -- evidence that its real purpose was measuring your resilience, not just destroying data.', 65, 5);
