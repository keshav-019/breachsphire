-- Phase 2.4h: world-7 mission content, generated from
-- docs/12-world-story-bible.md. Mission 1 is cross-world-gated on
-- the previous world's boss mission where applicable.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-7a', 'world-7', 'the-protocol-vault', '7A - The Protocol Vault', 'Unusual activity across DNS, email, web, file-sharing and remote-access services -- each protocol is a room with its own rules.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-7a-1', 'campaign-7a', 'foundations', 'Foundations', 'Ports, services and protocol conversations, learned as rooms in a vault.', 1),
  ('operation-7a-2', 'campaign-7a', 'investigation', 'Investigation', 'Trace the chained incident across protocols.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w7-01', 'world-7', 'campaign-7a', 'operation-7a-1', 'the-protocol-vault', 'The Protocol Vault', 'Session B touched DNS, email, file shares and remote access -- half the protocol stack, in one incident.', 'intro', ARRAY['zayn'], '{"requiredMissionIds":["mission-w6-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w7-02', 'world-7', 'campaign-7a', 'operation-7a-1', 'port-and-service', 'Port and Service', 'Before you can spot misuse, know which door is which.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w7-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"port-service-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w7-03', 'world-7', 'campaign-7a', 'operation-7a-1', 'read-the-dns-query', 'Read the DNS Query', 'DNS is supposed to be boring. When it isn''t, that''s worth noticing.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w7-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"dns-query-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w7-04', 'world-7', 'campaign-7a', 'operation-7a-2', 'an-emails-journey', 'An Email''s Journey', 'One of the vectors touched email. SMTP has its own predictable conversation -- know the steps.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w7-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"smtp-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w7-05', 'world-7', 'campaign-7a', 'operation-7a-2', 'ssh-vs-smb-vs-http', 'SSH vs SMB vs HTTP', 'Sometimes all you have is a raw transcript fragment. Recognize the protocol from its own vocabulary.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w7-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"protocol-id-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w7-06', 'world-7', 'campaign-7a', 'operation-7a-2', 'protocol-chimera', 'Protocol Chimera', 'This incident didn''t stay in one protocol -- it started in email, pivoted through DNS, and landed on remote management.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w7-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"protocol-chimera-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["protocol-chimera"],"skillXp":{"networking":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w7-01', 1, 'zayn', 'Session B touched DNS, email, file shares, remote access -- half the protocol stack, all in one incident. Time to actually learn what normal looks like in each room.'),
  ('mission-w7-01', 2, 'zayn', 'Ports aren''t trivia to memorize. Each protocol is a room with its own rules, and this attacker is fluent in all of them.'),
  ('mission-w7-02', 1, 'zayn', 'Before you can spot misuse, know which door is which.'),
  ('mission-w7-03', 1, 'zayn', 'DNS is supposed to be boring. When it isn''t, that''s worth noticing.'),
  ('mission-w7-04', 1, 'zayn', 'One of the vectors touched email. SMTP has its own predictable conversation -- know the steps.'),
  ('mission-w7-05', 1, 'zayn', 'Sometimes all you have is a raw transcript fragment. Recognize the protocol from its own vocabulary.'),
  ('mission-w7-06', 1, 'zayn', 'This incident didn''t stay in one protocol. It started in email, pivoted through DNS, and landed on a remote-management service. Trace the whole chain.'),
  ('mission-w7-06', 2, 'zayn', 'Confirmed the full chain: phishing email, DNS tunnel for command delivery, then legitimate-looking remote management to execute it.'),
  ('mission-w7-06', 3, 'byte', 'I extracted fragments from each stage. Individually meaningless. Combined, in order: S-E-N-T-I-N-E-L space T-E-S-T space V-E-C-T-O-R.'),
  ('mission-w7-06', 4, 'zayn', 'SENTINEL TEST VECTOR. That''s not a random string. That''s a label. Someone -- or something -- is naming its own experiments.'),
  ('mission-w7-06', 5, 'zayn', 'All of this came from one capture. A very large one. We''re going to need Wireshark, not guesswork, for what''s next.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w7-01-o1', 'mission-w7-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to learn the protocol vault.'),
  ('mission-w7-02-o1', 'mission-w7-02', 1, 'Match port to service', 'Match each well-known port to the service it identifies.'),
  ('mission-w7-03-o1', 'mission-w7-03', 1, 'Spot the tunnel', 'Identify the query showing signs of DNS tunneling.'),
  ('mission-w7-04-o1', 'mission-w7-04', 1, 'Order the conversation', 'Order the SMTP conversation steps from start to finish.'),
  ('mission-w7-05-o1', 'mission-w7-05', 1, 'Identify the protocol', 'Identify the protocol from a raw transcript banner.'),
  ('mission-w7-06-o1', 'mission-w7-06', 1, 'Identify the entry vector', 'Establish the actual chain of events, in order.'),
  ('mission-w7-06-o2', 'mission-w7-06', 2, 'Confirm the final stage', 'Explain why the final stage is especially hard to detect.'),
  ('mission-w7-06-o3', 'mission-w7-06', 3, 'Trace the full chain', 'Summarize the full chained incident.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w7-01-o1-c1', 'mission-w7-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"Each protocol is its own room with its own rules. Ready to walk through them?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),
  ('mission-w7-02-o1-c1', 'mission-w7-02-o1', 1, 'drag_and_drop', 'Match each port to its service.', '{"items":[{"id":"p53","text":"Port 53"},{"id":"p22","text":"Port 22"},{"id":"p80","text":"Port 80"},{"id":"p443","text":"Port 443"},{"id":"p25","text":"Port 25"},{"id":"p445","text":"Port 445"}],"targets":[{"id":"dns","label":"DNS"},{"id":"ssh","label":"SSH"},{"id":"http","label":"HTTP"},{"id":"https","label":"HTTPS"},{"id":"smtp","label":"SMTP"},{"id":"smb","label":"SMB"}]}'::jsonb, '{"correctMapping":{"p53":"dns","p22":"ssh","p80":"http","p443":"https","p25":"smtp","p445":"smb"}}'::jsonb),
  ('mission-w7-03-o1-c1', 'mission-w7-03-o1', 1, 'investigation', 'Which query shows signs of DNS being used as a covert channel rather than normal name resolution?', '{"evidence":[{"id":"q1","label":"Query: mail.hospital-example.org A","detail":"Normal lookup, resolved to the expected internal mail server"},{"id":"q2","label":"Query: 7f3a9c1e4b2d.evil-c2-domain.example TXT","detail":"A 12-character random-looking subdomain, requesting a TXT record, repeated every few minutes with a different random subdomain each time"},{"id":"q3","label":"Query: www.hospital-example.org A","detail":"Normal lookup for the public website"},{"id":"q4","label":"Query: printer-3.hospital-example.org A","detail":"Normal internal lookup for a network printer"}],"question":"Which query shows signs of DNS being used as a covert channel rather than normal name resolution?"}'::jsonb, '{"requiredEvidenceIds":["q2"]}'::jsonb),
  ('mission-w7-04-o1-c1', 'mission-w7-04-o1', 1, 'interactive_diagram', 'Order these SMTP conversation steps from start to finish.', '{"hotspots":[{"id":"helo","label":"HELO/EHLO","explanation":"The sending server identifies itself to begin the conversation."},{"id":"mailfrom","label":"MAIL FROM","explanation":"Declares the sender address for this message."},{"id":"rcptto","label":"RCPT TO","explanation":"Declares the recipient address for this message."},{"id":"data","label":"DATA","explanation":"The actual message headers and body follow, terminated by a line with a single period."},{"id":"quit","label":"QUIT","explanation":"Closes the SMTP session."}],"task":"Order these SMTP conversation steps from start to finish."}'::jsonb, '{"correctOrderIds":["helo","mailfrom","rcptto","data","quit"]}'::jsonb),
  ('mission-w7-05-o1-c1', 'mission-w7-05-o1', 1, 'multiple_choice', 'A transcript fragment begins with ''SSH-2.0-OpenSSH_9.3''. Which protocol is this?', '{"question":"A transcript fragment begins with ''SSH-2.0-OpenSSH_9.3''. Which protocol is this?","options":[{"id":"a","text":"HTTP"},{"id":"b","text":"SMB"},{"id":"c","text":"SSH"},{"id":"d","text":"SMTP"}]}'::jsonb, '{"correctOptionId":"c"}'::jsonb),
  ('mission-w7-06-o1-c1', 'mission-w7-06-o1', 1, 'investigation', 'Which pieces of evidence establish the actual chain of events, in the order they occurred?', '{"evidence":[{"id":"email","label":"Phishing email to a clinical staff account","detail":"Contains a link that, when visited, triggers the DNS query pattern seen earlier"},{"id":"dns_stage","label":"DNS tunnel traffic","detail":"Begins approximately three minutes after the phishing email was opened"},{"id":"rmm","label":"Remote-management service connection","detail":"Established roughly twenty minutes after the DNS tunnel activity begins"},{"id":"unrelated","label":"Unrelated help-desk ticket","detail":"A password reset request from the same day, no technical connection to the incident"}],"question":"Which pieces of evidence establish the actual chain of events, in the order they occurred?"}'::jsonb, '{"requiredEvidenceIds":["email","dns_stage","rmm"]}'::jsonb),
  ('mission-w7-06-o2-c1', 'mission-w7-06-o2', 1, 'multiple_choice', 'Why does landing on a legitimate remote-management service (rather than custom malware) make this stage harder to detect?', '{"question":"Why does landing on a legitimate remote-management service (rather than custom malware) make this stage harder to detect?","options":[{"id":"a","text":"Remote-management traffic is always encrypted and therefore invisible"},{"id":"b","text":"It blends into traffic that SOC tooling already expects to see and often allowlists"},{"id":"c","text":"Remote-management services don''t generate logs"},{"id":"d","text":"It isn''t actually harder to detect"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-w7-06-o3-c1', 'mission-w7-06-o3', 1, 'boss_encounter', 'Summarize the full chained incident from entry to remote-management execution.', '{"stages":[{"objectiveRef":"mission-w7-06-o1","label":"The entry vector"},{"objectiveRef":"mission-w7-06-o2","label":"The final stage"}],"task":"Summarize the full chained incident from entry to remote-management execution."}'::jsonb, '{"requiredObjectiveIds":["mission-w7-06-o1","mission-w7-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w7-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),
  ('mission-w7-02-o1-c1', 'orientation', 'These are among the most common well-known ports -- each maps to exactly one of the services listed.', 10, 1),
  ('mission-w7-02-o1-c1', 'solution', '53 = DNS, 22 = SSH, 80 = HTTP, 443 = HTTPS, 25 = SMTP, 445 = SMB.', 20, 2),
  ('mission-w7-03-o1-c1', 'orientation', 'Three of these four queries are completely mundane, resolving real internal or public names.', 10, 1),
  ('mission-w7-03-o1-c1', 'concept', 'Randomized subdomains and repeated TXT record requests are a classic DNS-tunneling pattern -- data hidden in the query itself.', 20, 2),
  ('mission-w7-03-o1-c1', 'solution', 'q2''s random-looking subdomain, TXT record type, and repeating pattern with a new random label each time are textbook DNS tunneling -- the other three are ordinary lookups.', 30, 3),
  ('mission-w7-04-o1-c1', 'orientation', 'The server has to introduce itself before anything else can happen.', 10, 1),
  ('mission-w7-04-o1-c1', 'solution', 'HELO/EHLO -> MAIL FROM -> RCPT TO -> DATA -> QUIT is the standard SMTP conversation order.', 20, 2),
  ('mission-w7-05-o1-c1', 'orientation', 'The banner literally names the protocol at the start of the line.', 10, 1),
  ('mission-w7-05-o1-c1', 'solution', 'The ''SSH-2.0-...'' banner is SSH''s version-identification string, exchanged at the very start of every SSH connection.', 20, 2),
  ('mission-w7-06-o1-c1', 'orientation', 'One of these four items has no timing relationship to the others at all.', 15, 1),
  ('mission-w7-06-o1-c1', 'concept', 'Look at what happened first, what followed a few minutes later, and what followed after that.', 25, 2),
  ('mission-w7-06-o1-c1', 'tool_direction', 'Rule out anything that doesn''t fit into a continuous timeline with the rest.', 35, 3),
  ('mission-w7-06-o1-c1', 'solution', 'The phishing email, the DNS tunnel it triggered, and the remote-management connection that followed all fall into one continuous, time-ordered chain -- the help-desk ticket is unrelated noise.', 45, 4),
  ('mission-w7-06-o2-c1', 'orientation', 'Think about what a defender''s tools are already tuned to ignore.', 15, 1),
  ('mission-w7-06-o2-c1', 'solution', 'Using a legitimate, expected tool blends malicious activity into traffic that''s often allowlisted or under-scrutinized by design.', 25, 2),
  ('mission-w7-06-o3-c1', 'orientation', 'You''ve already gathered every stage -- put them in order with the reasoning for each.', 20, 1),
  ('mission-w7-06-o3-c1', 'concept', 'The report needs the full chain, not just the first or last step.', 30, 2),
  ('mission-w7-06-o3-c1', 'tool_direction', 'State the entry point, the pivot, and the final execution stage in sequence.', 40, 3),
  ('mission-w7-06-o3-c1', 'near_solution', 'Email leads to DNS tunneling leads to remote-management execution -- each stage chosen to blend in.', 50, 4),
  ('mission-w7-06-o3-c1', 'solution', 'The chain runs phishing email -> DNS tunnel for command delivery -> legitimate remote-management service for execution, each stage chosen specifically to blend into traffic defenders already expect.', 60, 5);
