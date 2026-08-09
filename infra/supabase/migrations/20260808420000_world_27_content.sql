-- world-27 ("Scanning & Enumeration: The Surface") mission content,
-- generated from docs/12-world-story-bible.md. Uses the terminal engine's
-- nmap command (apps/web/src/lib/terminal/) for the scanning missions.
-- Mission 1 is cross-world-gated on world-26's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-27a', 'world-27', 'the-surface', '27A - The Surface', 'The footprint map gives us a list of live systems. Scan them, and find out what''s actually running.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-27a-1', 'campaign-27a', 'foundations', 'Foundations', 'Port scanning, banner interpretation and service enumeration, learned by asking what a service actually exposes.', 1),
  ('operation-27a-2', 'campaign-27a', 'investigation', 'Investigation', 'Find the smallest evidence-backed list of services that could form the original breach path.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w27-01', 'world-27', 'campaign-27a', 'operation-27a-1', 'stop-guessing', 'Stop Guessing', 'We have a list of live systems now. Time to stop guessing and actually scan them.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w26-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w27-02', 'world-27', 'campaign-27a', 'operation-27a-1', 'a-door-exists', 'A Door Exists', 'A port scan just tells you a door exists. It doesn''t tell you what''s behind it -- that''s what service identification is for.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w27-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"nmap-basics-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w27-03', 'world-27', 'campaign-27a', 'operation-27a-1', 'a-lead-not-proof', 'A Lead, Not Proof', 'A banner is a service announcing its own version, sometimes accurately. Read it like a lead, not like proof.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w27-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"banner-interpretation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w27-04', 'world-27', 'campaign-27a', 'operation-27a-2', 'oversharing-protocols', 'Oversharing Protocols', 'Every protocol has its own way of over-sharing. Misconfiguration looks different service to service.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w27-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"protocol-enumeration-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w27-05', 'world-27', 'campaign-27a', 'operation-27a-2', 'nobody-remembers-this', 'Nobody Remembers This', 'Most hosts on this list are exactly what we expect. One of them is running something nobody remembers deploying.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w27-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"deep-enumeration-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w27-06', 'world-27', 'campaign-27a', 'operation-27a-2', 'the-surface-boss', 'The Surface', 'Scan everything from the footprint map, then cut it to the smallest evidence-backed list of services that could actually explain the original breach.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w27-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"the-surface-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["the-surface"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w27-01', 1, 'zayn', 'We have a list of live systems now. Time to stop guessing and actually scan them -- but scanning generates its own flood of noise if you''re not careful.'),
  ('mission-w27-01', 2, 'byte', 'The lesson here isn''t reading tool output. It''s asking the right question about every open port: what does this actually expose, and why would that matter?'),
  ('mission-w27-01', 3, 'zayn', 'Discovery, service identification, deep enumeration. Let''s find out what''s actually running out there.'),
  ('mission-w27-02', 1, 'byte', 'A port scan just tells you a door exists. It doesn''t tell you what''s behind it -- that''s what service identification is for.'),
  ('mission-w27-03', 1, 'zayn', 'A banner is a service announcing its own version, sometimes accurately. Read it like a lead, not like proof.'),
  ('mission-w27-04', 1, 'byte', 'Every protocol has its own way of over-sharing. SMB null sessions, default SNMP community strings, open NFS exports -- misconfiguration looks different service to service.'),
  ('mission-w27-05', 1, 'zayn', 'Most hosts on this list are exactly what we expect. One of them is running something nobody remembers deploying.'),
  ('mission-w27-06', 1, 'zayn', 'Scan everything from the footprint map. Then cut it down to the smallest list of services that could actually explain the original breach -- evidence-backed, not guesswork.'),
  ('mission-w27-06', 2, 'byte', '...One forgotten web service, running on a host that was supposed to be decommissioned. And the code on it -- Zayn, this is Nexus Market code.'),
  ('mission-w27-06', 3, 'zayn', 'A forgotten copy of Nexus Market''s own application, still live, still reachable. That''s not a coincidence, that''s an actual entry point.'),
  ('mission-w27-06', 4, 'byte', 'This didn''t require chaining ten flaws. It required someone forgetting to turn a server off.'),
  ('mission-w27-06', 5, 'zayn', 'Smallest evidence-backed list, exactly like Luna asked for. Now we know exactly where to look next: the web application itself.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w27-01-o1', 'mission-w27-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to ask questions, not just read tool output.'),
  ('mission-w27-02-o1', 'mission-w27-02', 1, 'Scan a host', 'Scan a target and identify the service running on a specific port.'),
  ('mission-w27-03-o1', 'mission-w27-03', 1, 'Flag suspicious banners', 'Identify which banners are worth flagging for further investigation.'),
  ('mission-w27-04-o1', 'mission-w27-04', 1, 'Spot real misconfigurations', 'Identify which enumeration results reveal an actual misconfiguration.'),
  ('mission-w27-05-o1', 'mission-w27-05', 1, 'Find the unexpected host', 'Scan each host from the footprint map and find the one running something unexpected.'),
  ('mission-w27-06-o1', 'mission-w27-06', 1, 'Confirm what''s running', 'Scan the forgotten host and submit the exact banner identifying what''s running on it.'),
  ('mission-w27-06-o2', 'mission-w27-06', 2, 'Identify the original path', 'Choose the single service that forms the smallest evidence-backed path to the original breach.'),
  ('mission-w27-06-o3', 'mission-w27-06', 3, 'Close the surface', 'Confirm the running service and its significance together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w27-01-o1-c1', 'mission-w27-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"Ready to find out what''s actually running out there?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w27-02-o1-c1', 'mission-w27-02-o1', 1, 'terminal_simulation', 'Scan 203.0.113.10 and submit the name of the service running on port 22.', '{"instructions":"Scan 203.0.113.10 and submit the name of the service running on port 22.","hostname":"recon-ws01","user":"recruit","scanTargets":[{"host":"203.0.113.10","ports":[{"port":22,"proto":"tcp","state":"open","service":"ssh","banner":"OpenSSH 9.2"},{"port":80,"proto":"tcp","state":"open","service":"http","banner":"nginx 1.24.0"},{"port":443,"proto":"tcp","state":"open","service":"https","banner":"nginx 1.24.0"}]}]}'::jsonb, '{"requiredFlag":"ssh"}'::jsonb),

  ('mission-w27-03-o1-c1', 'mission-w27-03-o1', 1, 'investigation', 'Which banners are worth flagging for further investigation?', '{"evidence":[{"id":"b1","label":"Port 80 banner: nginx 1.24.0","detail":"Current stable release, no known unpatched vulnerabilities"},{"id":"b2","label":"Port 8081 banner: SentinelRelay/0.9","detail":"Not a recognized standard service -- custom software, no public vendor advisory to check against"},{"id":"b3","label":"Port 21 banner: vsftpd 2.3.4","detail":"A version with a well-documented, long-known backdoor vulnerability"},{"id":"b4","label":"Port 443 banner: nginx 1.24.0","detail":"Same current stable release as port 80"}],"question":"Which banners are worth flagging for further investigation?"}'::jsonb, '{"requiredEvidenceIds":["b2","b3"]}'::jsonb),

  ('mission-w27-04-o1-c1', 'mission-w27-04-o1', 1, 'investigation', 'Which of these enumeration results reveal an actual misconfiguration?', '{"evidence":[{"id":"p1","label":"SMB enumeration","detail":"Null session allowed -- full share listing returned with no credentials at all"},{"id":"p2","label":"SNMP enumeration","detail":"Community string ''public'' accepted -- full system description and interface table returned"},{"id":"p3","label":"DNS zone transfer attempt","detail":"Refused -- server correctly rejects unauthorized AXFR requests"},{"id":"p4","label":"HTTP enumeration","detail":"Standard security headers present, no directory listing, no verbose error pages"}],"question":"Which of these enumeration results reveal an actual misconfiguration?"}'::jsonb, '{"requiredEvidenceIds":["p1","p2"]}'::jsonb),

  ('mission-w27-05-o1-c1', 'mission-w27-05-o1', 1, 'terminal_simulation', 'Scan each host from the footprint map, and submit the hostname of the one running something nobody remembers deploying.', '{"instructions":"Scan each host from the footprint map. Submit the hostname of the one running something nobody remembers deploying.","hostname":"recon-ws01","user":"recruit","scanTargets":[{"host":"skyport-mnt07.internal-lab.example","ports":[{"port":22,"proto":"tcp","state":"open","service":"ssh","banner":"OpenSSH 9.2"}]},{"host":"nexus-market.example","ports":[{"port":443,"proto":"tcp","state":"open","service":"https","banner":"nginx 1.24.0"}]},{"host":"mnt-relay-legacy.skyport-logistics.example","ports":[{"port":8080,"proto":"tcp","state":"open","service":"http","banner":"nexus-market-storefront/1.2-legacy (decommission pending)"}]}]}'::jsonb, '{"requiredFlag":"mnt-relay-legacy.skyport-logistics.example"}'::jsonb),

  ('mission-w27-06-o1-c1', 'mission-w27-06-o1', 1, 'terminal_simulation', 'Scan the forgotten host in detail and submit the exact banner string identifying what''s running on it.', '{"instructions":"Scan the forgotten host in detail and submit the exact banner string that identifies what''s actually running on it.","hostname":"recon-ws01","user":"recruit","scanTargets":[{"host":"mnt-relay-legacy.skyport-logistics.example","ports":[{"port":8080,"proto":"tcp","state":"open","service":"http","banner":"nexus-market-storefront/1.2-legacy (decommission pending)"},{"port":22,"proto":"tcp","state":"filtered","service":"ssh"}]}]}'::jsonb, '{"requiredFlag":"nexus-market-storefront/1.2-legacy (decommission pending)"}'::jsonb),

  ('mission-w27-06-o2-c1', 'mission-w27-06-o2', 1, 'multiple_choice', 'Given everything scanned, which single service forms the smallest evidence-backed path back to the original breach?', '{"question":"Given everything scanned, which single service forms the smallest evidence-backed path back to the original breach?","options":[{"id":"a","text":"The SSH service on skyport-mnt07, already investigated and secured"},{"id":"b","text":"The forgotten nexus-market-storefront instance on mnt-relay-legacy, still running old Nexus Market code, marked \"decommission pending\" but never actually decommissioned"},{"id":"c","text":"The current, patched nginx instance on nexus-market.example"},{"id":"d","text":"The SNMP misconfiguration found earlier, unrelated to this specific host"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w27-06-o3-c1', 'mission-w27-06-o3', 1, 'boss_encounter', 'Confirm the running service and its significance together.', '{"stages":[{"objectiveRef":"mission-w27-06-o1","label":"What''s actually running"},{"objectiveRef":"mission-w27-06-o2","label":"Why it matters"}],"task":"Confirm the running service and its significance together."}'::jsonb, '{"requiredObjectiveIds":["mission-w27-06-o1","mission-w27-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w27-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w27-02-o1-c1', 'orientation', 'nmap reports the service name alongside each open port.', 10, 1),
  ('mission-w27-02-o1-c1', 'tool_direction', 'Try nmap 203.0.113.10.', 20, 2),
  ('mission-w27-02-o1-c1', 'solution', 'nmap 203.0.113.10 shows port 22 running ssh. Submit ssh.', 30, 3),

  ('mission-w27-03-o1-c1', 'orientation', 'Two of these four banners describe current, unremarkable software.', 15, 1),
  ('mission-w27-03-o1-c1', 'concept', 'An unrecognized custom service and a version with a documented backdoor both deserve a closer look -- routine current software doesn''t.', 25, 2),
  ('mission-w27-03-o1-c1', 'solution', 'SentinelRelay (b2, unrecognized custom software) and vsftpd 2.3.4 (b3, known backdoored version) both warrant investigation -- the two nginx banners are current and unremarkable.', 35, 3),

  ('mission-w27-04-o1-c1', 'orientation', 'Two of these four results are the protocol behaving exactly as it should.', 15, 1),
  ('mission-w27-04-o1-c1', 'concept', 'A null session or a default community string both mean unauthenticated access to information that should require credentials.', 25, 2),
  ('mission-w27-04-o1-c1', 'solution', 'The SMB null session (p1) and the default SNMP community string (p2) are both real misconfigurations granting unauthenticated access -- the DNS refusal and clean HTTP headers are both correct, expected behavior.', 35, 3),

  ('mission-w27-05-o1-c1', 'orientation', 'Two of these three hosts are running exactly what you''d expect from their name and purpose.', 15, 1),
  ('mission-w27-05-o1-c1', 'tool_direction', 'nmap each host in turn and read every banner carefully -- one doesn''t match its host''s apparent purpose at all.', 25, 2),
  ('mission-w27-05-o1-c1', 'solution', 'mnt-relay-legacy.skyport-logistics.example is running a banner labeled nexus-market-storefront -- completely unexpected for a maintenance relay host. Submit mnt-relay-legacy.skyport-logistics.example.', 35, 3),

  ('mission-w27-06-o1-c1', 'orientation', 'Scan the host directly and read the banner on its open port exactly as reported.', 15, 1),
  ('mission-w27-06-o1-c1', 'solution', 'nmap mnt-relay-legacy.skyport-logistics.example shows port 8080 running nexus-market-storefront/1.2-legacy (decommission pending). Submit that exact banner string.', 30, 2),

  ('mission-w27-06-o2-c1', 'orientation', 'Weigh a forgotten, never-decommissioned application instance against services that are already known-good or already fixed.', 15, 1),
  ('mission-w27-06-o2-c1', 'solution', 'A forgotten, still-live copy of Nexus Market''s own code marked for decommission but never removed is exactly the kind of single, evidence-backed entry point the exercise is looking for. Option b.', 25, 2),

  ('mission-w27-06-o3-c1', 'orientation', 'You''ve already found both halves -- combine what''s running with why it matters.', 20, 1),
  ('mission-w27-06-o3-c1', 'concept', 'The closure needs to name the exact service and explain why it''s the smallest evidence-backed path, not just flag that something looks odd.', 30, 2),
  ('mission-w27-06-o3-c1', 'tool_direction', 'State the banner first, then why it''s the most consequential finding among everything scanned.', 40, 3),
  ('mission-w27-06-o3-c1', 'near_solution', 'nexus-market-storefront/1.2-legacy, marked decommission pending but still live on mnt-relay-legacy -- the single service tying the scan results back to the original breach.', 50, 4),
  ('mission-w27-06-o3-c1', 'solution', 'mnt-relay-legacy.skyport-logistics.example is still running nexus-market-storefront/1.2-legacy (decommission pending) -- a forgotten, never-removed copy of Nexus Market''s own application, live and reachable. Of everything scanned, this single service is the smallest evidence-backed path back to the original breach.', 60, 5);
