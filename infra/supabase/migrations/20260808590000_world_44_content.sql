-- world-44 ("Digital Forensics: Ghost Protocol") mission content,
-- generated from docs/12-world-story-bible.md. Opens with Mercy Hospital
-- restored but leadership demanding proof of the full intrusion sequence
-- and whether data actually left the environment -- mission 1 is
-- cross-world-gated on world-43's boss mission. Closes on a recovered
-- configuration explicitly labeled RESILIENCE_TRIAL_07, handing off to
-- world-45's analysis of the payload itself.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-44a', 'world-44', 'chain-of-evidence', '44A - Chain of Evidence', 'Disk, timeline, browser, email, memory and network forensics, reconstructed with chain of custody intact.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-44a-1', 'campaign-44a', 'reconstruction', 'Reconstruction', 'Disk images, recovered files and a timeline built from filesystem metadata.', 1),
  ('operation-44a-2', 'campaign-44a', 'the-timeline', 'The Timeline', 'Browser, memory and network evidence, correlated into one evidence-backed account.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w44-01', 'world-44', 'campaign-44a', 'operation-44a-1', 'proof-not-promises', 'Proof, Not Promises', 'Mercy''s systems are back. Leadership wants more than "it''s fixed" -- they want the full intrusion sequence, and proof of whether anything left the network.', 'intro', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w43-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w44-02', 'world-44', 'campaign-44a', 'operation-44a-1', 'the-disk-image', 'The Disk Image', 'Somewhere in the unallocated space of this disk image is the file that started all of this.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w44-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-disk-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 2),
  ('mission-w44-03', 'world-44', 'campaign-44a', 'operation-44a-1', 'the-timeline-builder', 'The Timeline Builder', 'Filesystem metadata doesn''t lie about order, even when everything else about an intrusion is designed to confuse you.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w44-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-timeline-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w44-04', 'world-44', 'campaign-44a', 'operation-44a-2', 'the-browser-and-the-mailbox', 'The Browser and the Mailbox', 'If data actually left this network, it left a trail somewhere a person had to click.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w44-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-artifacts-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w44-05', 'world-44', 'campaign-44a', 'operation-44a-2', 'the-memory-and-the-wire', 'The Memory and the Wire', 'Disk and browser evidence tell you what happened. Memory and network traffic tell you what''s still true right now.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w44-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-memory-network-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w44-06', 'world-44', 'campaign-44a', 'operation-44a-2', 'ghost-protocol-boss', 'Ghost Protocol', 'Produce an evidence-backed timeline from first foothold to recovery, and identify what the attacker actually measured.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w44-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-protocol-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["ghost-protocol"],"skillXp":{"forensics":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w44-01', 1, 'zayn', 'Mercy''s back online. Leadership wants more than "it''s fixed" -- they want proof. Full intrusion sequence, and whether anything actually left this network.'),
  ('mission-w44-01', 2, 'ava', 'That means disk images, timelines, deleted files, memory, network captures. Every artifact, correlated, with chain of custody intact.'),
  ('mission-w44-01', 3, 'byte', '...Evidence integrity isn''t optional here. Every step gets logged, hashed and reproducible, or it doesn''t count as proof.'),
  ('mission-w44-02', 1, 'byte', '...There''s a file in the unallocated space of this image that predates the ransomware event by eleven days. Recover it and see what it actually is.'),
  ('mission-w44-03', 1, 'zayn', 'Filesystem timestamps don''t care what story the attacker wants told. Build the order they actually happened in.'),
  ('mission-w44-04', 1, 'ava', 'Staging a file is not the same as it leaving the building. We need to know which one actually happened here.'),
  ('mission-w44-05', 1, 'byte', '...Memory holds what disk forensics can''t show you -- what was actually running. Network traffic shows where it was actually talking to.'),
  ('mission-w44-06', 1, 'byte', '...Timeline complete. First foothold to right now, every step backed by a hashed, chain-of-custody artifact.'),
  ('mission-w44-06', 2, 'zayn', 'Dropper, persistence, beacon, staging, exfil through a personal cloud link, then the payload actually detonates. In that order.'),
  ('mission-w44-06', 3, 'ava', 'And the configuration file?'),
  ('mission-w44-06', 4, 'byte', '...operation_id: RESILIENCE_TRIAL_07. Not a ransom demand. A label. Like this was one run of something repeatable.'),
  ('mission-w44-06', 5, 'zayn', 'Trial. Seven. Whatever Cipher was cut off trying to tell us, this backs it up.'),
  ('mission-w44-06', 6, 'ava', 'We suspected Sentinel-X was testing our resilience. Now we can prove the tests are numbered.'),
  ('mission-w44-06', 7, 'byte', '...The payload itself is the last piece. We analyze what actually ran on that network, not just what it left behind.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w44-01-o1', 'mission-w44-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to reconstruct this as an evidence-backed forensic case.'),
  ('mission-w44-02-o1', 'mission-w44-02', 1, 'Recover the first-foothold artifact', 'Identify which recovered file from the disk image is the actual first-foothold dropper.'),
  ('mission-w44-03-o1', 'mission-w44-03', 1, 'Build the filesystem timeline', 'Order the intrusion events using their filesystem metadata timestamps.'),
  ('mission-w44-04-o1', 'mission-w44-04', 1, 'Determine whether data actually left', 'Identify the evidence showing data was exfiltrated, not merely staged.'),
  ('mission-w44-05-o1', 'mission-w44-05', 1, 'Find the hidden process in memory', 'Identify which process in the memory capture shows signs of hiding the payload.'),
  ('mission-w44-05-o2', 'mission-w44-05', 2, 'Correlate the network evidence', 'Map each piece of network evidence to what it actually proves.'),
  ('mission-w44-06-o1', 'mission-w44-06', 1, 'Build the evidence-backed timeline', 'Order the complete, evidence-backed timeline from first foothold to recovery.'),
  ('mission-w44-06-o2', 'mission-w44-06', 2, 'Identify what the attacker labeled', 'Find the recovered artifact that identifies this as more than an isolated attack.'),
  ('mission-w44-06-o3', 'mission-w44-06', 3, 'Close the case', 'Confirm the complete timeline and the recovered operation label together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w44-01-o1-c1', 'mission-w44-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Disk, timeline, browser, email, memory, network. Every artifact hashed and logged. Ready to reconstruct this properly?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w44-02-o1-c1', 'mission-w44-02-o1', 1, 'investigation', 'Which recovered file is the actual first-foothold artifact?', '{"evidence":[{"id":"d1","label":"svchost_update.exe","detail":"Recovered from unallocated space; creation timestamp predates the ransomware event by 11 days; matches the sentinel-sync persistence signature identified in an earlier incident"},{"id":"d2","label":"quarterly_report.xlsx","detail":"Still present, untouched, unrelated to the incident timeline"},{"id":"d3","label":"temp_cache.tmp","detail":"Auto-generated browser cache file with timestamps unrelated to the intrusion"}],"question":"Which recovered file is the actual first-foothold artifact?"}'::jsonb, '{"requiredEvidenceIds":["d1"]}'::jsonb),

  ('mission-w44-03-o1-c1', 'mission-w44-03-o1', 1, 'interactive_diagram', 'Order these events using their filesystem metadata timestamps.', '{"hotspots":[{"id":"dropper_written","label":"svchost_update.exe written to disk","explanation":"The earliest timestamp in the whole set -- the actual first-foothold artifact."},{"id":"task_registered","label":"A scheduled task registers the dropper for persistence","explanation":"Created shortly after the dropper itself, to survive a reboot."},{"id":"beacon_start","label":"First outbound beacon connection recorded","explanation":"Begins once persistence is in place, and continues at a regular interval afterward."},{"id":"lateral_copy","label":"A copy of the dropper appears on a second host","explanation":"File metadata shows it was copied, not independently created."},{"id":"payload_exec","label":"The ransomware payload executes on Records-DB-02 and Admin-WS-14","explanation":"Comes far later than the initial foothold -- this operation sat dormant before detonating."},{"id":"shadow_delete","label":"Volume shadow copies are deleted","explanation":"The last recorded step, immediately before the ransom note appears."}],"task":"Order these events using their filesystem metadata timestamps."}'::jsonb, '{"correctOrderIds":["dropper_written","task_registered","beacon_start","lateral_copy","payload_exec","shadow_delete"]}'::jsonb),

  ('mission-w44-04-o1-c1', 'mission-w44-04-o1', 1, 'investigation', 'Which evidence indicates data actually left the environment, as opposed to being staged but not exfiltrated?', '{"evidence":[{"id":"b1","label":"Browser history on Admin-WS-14","detail":"Shows a visit to a personal cloud-storage upload page, 40 minutes after the payload executed"},{"id":"b2","label":"Outbound transfer log","detail":"A file matching the size of the compressed staging archive was uploaded to that same cloud-storage link"},{"id":"b3","label":"Email client history","detail":"Shows only routine internal traffic, nothing unusual"}],"question":"Which evidence indicates data actually left the environment, as opposed to being staged but not exfiltrated?"}'::jsonb, '{"requiredEvidenceIds":["b1","b2"]}'::jsonb),

  ('mission-w44-05-o1-c1', 'mission-w44-05-o1', 1, 'investigation', 'Which process in this memory capture shows signs of the payload hiding in memory?', '{"evidence":[{"id":"m1","label":"svchost.exe (PID 4821)","detail":"No parent process on record, and a network connection open directly to an IP address with no corresponding DNS lookup"},{"id":"m2","label":"explorer.exe (PID 2210)","detail":"Normal shell process, expected parent process, no unusual open handles"}],"question":"Which process shows signs of the payload hiding in memory?"}'::jsonb, '{"requiredEvidenceIds":["m1"]}'::jsonb),

  ('mission-w44-05-o2-c1', 'mission-w44-05-o2', 1, 'drag_and_drop', 'Map each piece of network evidence to what it actually proves.', '{"items":[{"id":"n1","text":"A beacon at exactly a 300-second interval to a single external IP, sustained for days"},{"id":"n2","text":"A 240MB outbound transfer to the same cloud-storage link identified in the browser history"},{"id":"n3","text":"A DNS query for a domain that was registered nine days before the incident"}],"targets":[{"id":"command_and_control","label":"Command and Control"},{"id":"exfiltration","label":"Exfiltration"},{"id":"staging","label":"Staging"}]}'::jsonb, '{"correctMapping":{"n1":"command_and_control","n2":"exfiltration","n3":"staging"}}'::jsonb),

  ('mission-w44-06-o1-c1', 'mission-w44-06-o1', 1, 'interactive_diagram', 'Order the complete, evidence-backed timeline from first foothold to recovery.', '{"hotspots":[{"id":"dropper","label":"Dropper written to disk (recovered from unallocated space)","explanation":"The true starting point, eleven days before anything visible happened."},{"id":"persistence","label":"Scheduled task registers the dropper for persistence","explanation":"Ensures the foothold survives a reboot."},{"id":"beacon","label":"Beacon traffic begins, regular and sustained","explanation":"The ongoing channel back to whoever is running this."},{"id":"staging_exfil","label":"Files staged, then uploaded to a personal cloud-storage link","explanation":"Confirmed exfiltration, not just internal staging."},{"id":"detonation","label":"Ransomware payload executes and shadow copies are deleted","explanation":"The visible start of the crisis, far later than the actual intrusion."},{"id":"containment_recovery","label":"Containment, eradication and recovery, verified clean","explanation":"Where the incident officially ends -- and where the hidden telemetry log was found."}],"task":"Order the complete, evidence-backed timeline from first foothold to recovery."}'::jsonb, '{"correctOrderIds":["dropper","persistence","beacon","staging_exfil","detonation","containment_recovery"]}'::jsonb),

  ('mission-w44-06-o2-c1', 'mission-w44-06-o2', 1, 'investigation', 'Which artifact identifies this as more than an isolated ransomware attack?', '{"evidence":[{"id":"c1","label":"Recovered configuration file","detail":"Found in the payload''s working directory, containing the string operation_id: RESILIENCE_TRIAL_07"},{"id":"c2","label":"Ransom note template","detail":"Generic phrasing with no operational metadata of any kind"}],"question":"Which artifact identifies this as more than an isolated ransomware attack?"}'::jsonb, '{"requiredEvidenceIds":["c1"]}'::jsonb),

  ('mission-w44-06-o3-c1', 'mission-w44-06-o3', 1, 'boss_encounter', 'Confirm the complete timeline and the recovered operation label together.', '{"stages":[{"objectiveRef":"mission-w44-06-o1","label":"The evidence-backed timeline"},{"objectiveRef":"mission-w44-06-o2","label":"The operation_id label"}],"task":"Confirm the complete timeline and the recovered operation label together."}'::jsonb, '{"requiredObjectiveIds":["mission-w44-06-o1","mission-w44-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w44-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w44-02-o1-c1', 'orientation', 'Two of these three files have completely ordinary explanations for existing.', 15, 1),
  ('mission-w44-02-o1-c1', 'concept', 'A file predating the visible incident by eleven days, matching a known persistence signature, is not a coincidence.', 25, 2),
  ('mission-w44-02-o1-c1', 'solution', 'svchost_update.exe (d1) is the first-foothold artifact -- the other two files are unrelated to the intrusion.', 35, 3),

  ('mission-w44-03-o1-c1', 'orientation', 'Start from the file with the earliest timestamp, and work forward from there.', 15, 1),
  ('mission-w44-03-o1-c1', 'concept', 'Each step depends on the one before it: persistence needs the dropper to already exist, and detonation happens long after the beacon has been quietly running.', 25, 2),
  ('mission-w44-03-o1-c1', 'solution', 'Dropper written, then persistence registered, then the beacon starts, then a lateral copy appears, then the payload executes, then shadow copies are deleted.', 35, 3),

  ('mission-w44-04-o1-c1', 'orientation', 'Staging data in one place and data actually leaving the network are two different findings -- you need evidence for both.', 15, 1),
  ('mission-w44-04-o1-c1', 'concept', 'A visit to an upload page is suggestive on its own; a transfer matching the staged archive''s size, to that same destination, confirms it.', 25, 2),
  ('mission-w44-04-o1-c1', 'solution', 'The browser history (b1) and the matching outbound transfer (b2) together confirm exfiltration -- the email history (b3) shows nothing unusual.', 35, 3),

  ('mission-w44-05-o1-c1', 'orientation', 'A legitimate system process always has a legitimate parent.', 15, 1),
  ('mission-w44-05-o1-c1', 'solution', 'svchost.exe (PID 4821) with no parent process and a direct connection to an IP with no DNS lookup (m1) is the payload hiding in memory -- explorer.exe (m2) is normal.', 25, 2),

  ('mission-w44-05-o2-c1', 'orientation', 'Ask what each piece of network evidence actually demonstrates -- an ongoing channel, data leaving, or a destination being set up.', 15, 1),
  ('mission-w44-05-o2-c1', 'solution', 'The regular beacon is command and control, the large transfer to the cloud link is exfiltration, and the newly registered domain query is staging.', 25, 2),

  ('mission-w44-06-o1-c1', 'orientation', 'You''ve already built pieces of this timeline in earlier missions -- assemble them into one.', 15, 1),
  ('mission-w44-06-o1-c1', 'concept', 'The dropper came first, persistence and the beacon followed, staging and exfiltration happened before detonation, and containment/recovery came last.', 25, 2),
  ('mission-w44-06-o1-c1', 'tool_direction', 'Anchor the order to timestamps, not to when each artifact was discovered.', 35, 3),
  ('mission-w44-06-o1-c1', 'solution', 'Dropper written, persistence registered, beacon begins, files staged and exfiltrated, payload detonates, then containment/eradication/recovery.', 45, 4),

  ('mission-w44-06-o2-c1', 'orientation', 'One of these two artifacts carries operational metadata; the other is just cover text.', 15, 1),
  ('mission-w44-06-o2-c1', 'concept', 'A ransom note is meant to be read by the victim. An operation_id is meant to be read by whoever runs the operation.', 25, 2),
  ('mission-w44-06-o2-c1', 'tool_direction', 'Look for a field that labels this as one instance of something repeatable, not a one-off attack.', 35, 3),
  ('mission-w44-06-o2-c1', 'solution', 'The recovered configuration file (c1) contains operation_id: RESILIENCE_TRIAL_07 -- a label, not a ransom demand.', 45, 4),

  ('mission-w44-06-o3-c1', 'orientation', 'You''ve already built the timeline and found the operation label -- combine them.', 20, 1),
  ('mission-w44-06-o3-c1', 'concept', 'The closure needs the full chronological chain plus the artifact that names this as a numbered trial.', 30, 2),
  ('mission-w44-06-o3-c1', 'tool_direction', 'State the six-stage timeline first, then the operation_id finding.', 40, 3),
  ('mission-w44-06-o3-c1', 'near_solution', 'Dropper through containment/recovery, six stages, evidence-backed at every step, plus a recovered configuration labeling this operation_id: RESILIENCE_TRIAL_07.', 50, 4),
  ('mission-w44-06-o3-c1', 'solution', 'The evidence-backed timeline runs from the dropper written eleven days before detonation, through persistence and a sustained beacon, staged and confirmed exfiltration to a personal cloud link, the ransomware payload executing, and finally containment, eradication and recovery. A recovered configuration file in the payload''s own working directory labels the whole thing operation_id: RESILIENCE_TRIAL_07 -- proof this was one numbered trial, not an isolated attack.', 65, 5);
