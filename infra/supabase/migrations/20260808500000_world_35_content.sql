-- world-35 ("Active Directory Fundamentals: Kingdom of Trust") mission
-- content, generated from docs/12-world-story-bible.md. Opens Act 5 "The
-- Enterprise". Mission 1 is cross-world-gated on world-34's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-35a', 'world-35', 'kingdom-of-trust', '35A - Kingdom of Trust', 'The recovered map is an identity map: every user, computer and service in this domain, connected by trust relationships.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-35a-1', 'campaign-35a', 'foundations', 'Foundations', 'Domains, forests, OUs, GPOs, SIDs and Kerberos, learned as the operating system of an enterprise.', 1),
  ('operation-35a-2', 'campaign-35a', 'investigation', 'Investigation', 'Reconstruct the domain from sparse evidence and explain a service account''s authentication path.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w35-01', 'world-35', 'campaign-35a', 'operation-35a-1', 'an-identity-map', 'An Identity Map', 'The recovered map isn''t a network diagram. It''s an identity map -- every user, computer and service, connected by trust relationships.', 'intro', ARRAY['luna', 'byte'], '{"requiredMissionIds":["mission-w34-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w35-02', 'world-35', 'campaign-35a', 'operation-35a-1', 'different-jobs', 'Different Jobs', 'A domain controller holds the directory. An OU organizes objects. A GPO pushes configuration down. Different jobs, easy to blur together.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w35-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"ad-structure-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w35-03', 'world-35', 'campaign-35a', 'operation-35a-1', 'tickets-not-passwords', 'Tickets, Not Passwords', 'Kerberos never sends a password over the wire after the initial exchange. Everything after that is tickets.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w35-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"kerberos-flow-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w35-04', 'world-35', 'campaign-35a', 'operation-35a-2', 'sids-dont-lie', 'SIDs Don''t Lie', 'Every permission is actually granted to a SID, not a name. Names can be misleading. SIDs don''t lie.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w35-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"sid-acl-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w35-05', 'world-35', 'campaign-35a', 'operation-35a-2', 'relayable-in-ways-kerberos-isnt', 'Relayable in Ways Kerberos Isn''t', 'NTLM still works, mostly for compatibility. It''s also relayable in ways Kerberos, done correctly, simply isn''t.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w35-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"ntlm-kerberos-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w35-06', 'world-35', 'campaign-35a', 'operation-35a-2', 'kingdom-of-trust-boss', 'Kingdom of Trust', 'Reconstruct this domain from sparse evidence, then explain exactly how one specific service account authenticates.', 'boss', ARRAY['luna', 'byte'], '{"requiredMissionIds":["mission-w35-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"kingdom-of-trust-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["kingdom-of-trust"],"skillXp":{"windows":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w35-01', 1, 'luna', 'The recovered map isn''t a network diagram. It''s an identity map -- every user, computer and service in this domain, connected by trust relationships.'),
  ('mission-w35-01', 2, 'byte', 'Active Directory is basically the operating system of an entire enterprise. Domains, forests, controllers, organizational units, group policy, all of it exists to answer one question at scale: who is allowed to do what.'),
  ('mission-w35-01', 3, 'luna', 'DNS, LDAP, SIDs, ACLs, NTLM, Kerberos. Learn the vocabulary first. The map won''t make sense without it.'),
  ('mission-w35-01', 4, 'byte', 'Let''s build it from what we actually have.'),
  ('mission-w35-02', 1, 'luna', 'A domain controller holds the directory. An OU organizes objects inside it. A GPO pushes configuration down onto whatever the OU contains. Different jobs, easy to blur together.'),
  ('mission-w35-03', 1, 'byte', 'Kerberos never sends a password over the wire after the initial exchange. Everything after that is tickets, proving identity without repeating the secret.'),
  ('mission-w35-04', 1, 'luna', 'Every object in this domain has a SID, and every permission is actually granted to a SID, not a name. Names can be misleading. SIDs don''t lie.'),
  ('mission-w35-05', 1, 'byte', 'NTLM still works, mostly for compatibility. It''s also relayable in ways Kerberos, done correctly, simply isn''t.'),
  ('mission-w35-06', 1, 'luna', 'Reconstruct this domain from what little evidence we actually have, then explain exactly how one specific service account authenticates.'),
  ('mission-w35-06', 2, 'byte', '...Domain structure confirmed: single forest, two domains, the service account sits in a dedicated OU with a registered SPN.'),
  ('mission-w35-06', 3, 'luna', 'An SPN means something is authenticating to that account as a service, using Kerberos, not just a person logging in.'),
  ('mission-w35-06', 4, 'byte', 'The SPN is registered to sentinel-orchestrator.'),
  ('mission-w35-06', 5, 'luna', 'Of course it is. Same name, new layer. This time it''s not a rogue identity floating around -- it''s actually built into this domain''s own service model.'),
  ('mission-w35-06', 6, 'byte', 'Its permissions aren''t obviously privileged, though. Nothing screams "admin" when you look at it directly.'),
  ('mission-w35-06', 7, 'luna', 'That''s exactly what worries me. Real domain compromises rarely start with an account that looks dangerous. They start with one that looks boring and turns out to combine with something else. Time to actually map what it can reach.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w35-01-o1', 'mission-w35-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to learn Active Directory as an identity system.'),
  ('mission-w35-02-o1', 'mission-w35-02', 1, 'Match each AD component to its role', 'Sort each description to the correct Active Directory component.'),
  ('mission-w35-03-o1', 'mission-w35-03', 1, 'Order the Kerberos flow', 'Order the steps of a Kerberos authentication flow correctly.'),
  ('mission-w35-04-o1', 'mission-w35-04', 1, 'Find the exploitable ACL', 'Identify the ACL entry representing a real, exploitable misconfiguration.'),
  ('mission-w35-05-o1', 'mission-w35-05', 1, 'Explain why NTLM is weaker', 'Explain why NTLM is considered weaker than properly configured Kerberos.'),
  ('mission-w35-06-o1', 'mission-w35-06', 1, 'Reconstruct the domain', 'Identify the evidence that lets you reconstruct the domain structure and locate the service account.'),
  ('mission-w35-06-o2', 'mission-w35-06', 2, 'Explain the authentication path', 'Determine how the service account actually authenticates.'),
  ('mission-w35-06-o3', 'mission-w35-06', 3, 'Confirm the kingdom', 'Confirm the domain structure and the authentication path together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w35-01-o1-c1', 'mission-w35-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Time to learn the operating system of an entire enterprise. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w35-02-o1-c1', 'mission-w35-02-o1', 1, 'drag_and_drop', 'Sort each description to the correct Active Directory component.', '{"items":[{"id":"i1","text":"Holds the actual directory database and authenticates logons for the domain"},{"id":"i2","text":"A container organizing users, computers or groups for administrative purposes"},{"id":"i3","text":"A set of configuration settings applied automatically to everything inside a linked OU"},{"id":"i4","text":"The top-level security boundary containing one or more domains that trust each other"}],"targets":[{"id":"dc","label":"Domain Controller"},{"id":"ou","label":"Organizational Unit (OU)"},{"id":"gpo","label":"Group Policy Object (GPO)"},{"id":"forest","label":"Forest"}]}'::jsonb, '{"correctMapping":{"i1":"dc","i2":"ou","i3":"gpo","i4":"forest"}}'::jsonb),

  ('mission-w35-03-o1-c1', 'mission-w35-03-o1', 1, 'interactive_diagram', 'Order the steps of a Kerberos authentication flow, from initial login to accessing a service.', '{"hotspots":[{"id":"as_req","label":"Client sends AS-REQ to the KDC","explanation":"Requests a Ticket Granting Ticket, proving identity once using a key derived from the password."},{"id":"as_rep","label":"KDC responds with AS-REP containing a TGT","explanation":"The TGT is used for all future requests -- the password itself is never sent again."},{"id":"tgs_req","label":"Client sends TGS-REQ with the TGT to request a service ticket","explanation":"Asks for access to a specific service, presenting the TGT as proof of prior authentication."},{"id":"tgs_rep","label":"KDC responds with TGS-REP containing a service ticket","explanation":"A ticket specifically for the requested service, encrypted with that service''s own key."},{"id":"service_access","label":"Client presents the service ticket to the target service","explanation":"The service decrypts it with its own key and grants access -- no password or KDC contact needed at this step."}],"task":"Order the steps of a Kerberos authentication flow, from initial login to accessing a service."}'::jsonb, '{"correctOrderIds":["as_req","as_rep","tgs_req","tgs_rep","service_access"]}'::jsonb),

  ('mission-w35-04-o1-c1', 'mission-w35-04-o1', 1, 'investigation', 'Which ACL entry represents a real, exploitable misconfiguration?', '{"evidence":[{"id":"a1","label":"ACL entry on the Finance OU","detail":"Grants Domain Admins full control -- standard, expected"},{"id":"a2","label":"ACL entry on the Finance OU","detail":"Also grants a SID belonging to a disabled former-contractor account GenericAll permission -- full control over every object in the OU"},{"id":"a3","label":"ACL entry on a print server object","detail":"Grants Authenticated Users only the ability to print -- standard, expected"}],"question":"Which ACL entry represents a real, exploitable misconfiguration?"}'::jsonb, '{"requiredEvidenceIds":["a2"]}'::jsonb),

  ('mission-w35-05-o1-c1', 'mission-w35-05-o1', 1, 'multiple_choice', 'Why is NTLM authentication considered weaker than properly configured Kerberos in a modern Active Directory environment?', '{"question":"Why is NTLM authentication considered weaker than properly configured Kerberos in a modern Active Directory environment?","options":[{"id":"a","text":"NTLM is actually stronger since it''s simpler"},{"id":"b","text":"NTLM authentication can be relayed by an attacker positioned in the middle to authenticate to other services as the victim, while Kerberos tickets are scoped to a specific service and far harder to relay"},{"id":"c","text":"NTLM requires more network bandwidth"},{"id":"d","text":"There''s no meaningful difference"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w35-06-o1-c1', 'mission-w35-06-o1', 1, 'investigation', 'Which evidence together lets you reconstruct the domain structure and locate the service account?', '{"evidence":[{"id":"e1","label":"DNS SRV records for _kerberos._tcp","detail":"Point to two domain controllers, suggesting a two-domain forest structure"},{"id":"e2","label":"LDAP query results","detail":"Reveals a dedicated OU named \"Service Accounts\", separate from standard user OUs"},{"id":"e3","label":"SPN registration query","detail":"One SPN, HTTP/relay.guardian.internal, is registered to an account named sentinel-orchestrator, located in the Service Accounts OU"},{"id":"e4","label":"An unrelated print queue log","detail":"Routine, no bearing on domain structure"}],"question":"Which evidence together lets you reconstruct the domain structure and locate the service account?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2","e3"]}'::jsonb),

  ('mission-w35-06-o2-c1', 'mission-w35-06-o2', 1, 'multiple_choice', 'Given the SPN registration, how does sentinel-orchestrator actually authenticate when a client accesses its service?', '{"question":"Given the SPN registration, how does sentinel-orchestrator actually authenticate when a client accesses its service?","options":[{"id":"a","text":"It sends its password in plaintext every time"},{"id":"b","text":"A client requests a Kerberos service ticket for HTTP/relay.guardian.internal, and the KDC issues one encrypted with sentinel-orchestrator''s own key -- no password is transmitted at any point"},{"id":"c","text":"It uses NTLM exclusively, with no ticketing at all"},{"id":"d","text":"Authentication doesn''t apply to service accounts"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w35-06-o3-c1', 'mission-w35-06-o3', 1, 'boss_encounter', 'Confirm the domain structure and the authentication path together.', '{"stages":[{"objectiveRef":"mission-w35-06-o1","label":"The domain structure"},{"objectiveRef":"mission-w35-06-o2","label":"The authentication path"}],"task":"Confirm the domain structure and the authentication path together."}'::jsonb, '{"requiredObjectiveIds":["mission-w35-06-o1","mission-w35-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w35-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w35-02-o1-c1', 'orientation', 'Ask what each thing actually stores versus what it organizes versus what it enforces.', 15, 1),
  ('mission-w35-02-o1-c1', 'solution', 'A domain controller stores the directory, an OU organizes objects, a GPO pushes configuration, and a forest is the trust boundary containing domains.', 25, 2),

  ('mission-w35-03-o1-c1', 'orientation', 'The client talks to the KDC twice -- once for a TGT, once for a service ticket -- before ever reaching the actual service.', 15, 1),
  ('mission-w35-03-o1-c1', 'concept', 'Each exchange has a request and a response: AS-REQ/AS-REP for the TGT, then TGS-REQ/TGS-REP for the service ticket.', 25, 2),
  ('mission-w35-03-o1-c1', 'solution', 'AS-REQ -> AS-REP (get the TGT) -> TGS-REQ -> TGS-REP (get the service ticket) -> present it to the service.', 35, 3),

  ('mission-w35-04-o1-c1', 'orientation', 'Two of these three entries are exactly what you''d expect on a well-run domain.', 15, 1),
  ('mission-w35-04-o1-c1', 'concept', 'A disabled account that still holds full control over an entire OU is a live, exploitable path regardless of whether anyone logs into it directly.', 25, 2),
  ('mission-w35-04-o1-c1', 'solution', 'The disabled contractor SID holding GenericAll over the Finance OU (a2) is the real misconfiguration -- the other two entries are standard and expected.', 35, 3),

  ('mission-w35-05-o1-c1', 'orientation', 'Think about what happens when an attacker sits between a client and a server during authentication.', 15, 1),
  ('mission-w35-05-o1-c1', 'solution', 'NTLM responses can be captured and relayed to authenticate elsewhere as the victim; Kerberos tickets are scoped to a specific service and resist that. Option b.', 25, 2),

  ('mission-w35-06-o1-c1', 'orientation', 'One of these four items has nothing to do with domain structure at all.', 15, 1),
  ('mission-w35-06-o1-c1', 'concept', 'DNS reveals how many controllers exist, LDAP reveals how accounts are organized, and an SPN reveals which account runs which service.', 25, 2),
  ('mission-w35-06-o1-c1', 'tool_direction', 'Check the DNS SRV records, the Service Accounts OU, and the SPN registration together.', 35, 3),
  ('mission-w35-06-o1-c1', 'solution', 'The DNS SRV records (e1), the dedicated Service Accounts OU (e2), and the SPN registered to sentinel-orchestrator (e3) together reconstruct the structure and locate the account -- the print log is unrelated.', 45, 4),

  ('mission-w35-06-o2-c1', 'orientation', 'An SPN means Kerberos, not a plain password exchange.', 15, 1),
  ('mission-w35-06-o2-c1', 'solution', 'A client requests a service ticket for the registered SPN, and the KDC issues one encrypted with the service account''s own key -- authentication happens entirely through tickets, no password transmitted. Option b.', 25, 2),

  ('mission-w35-06-o3-c1', 'orientation', 'You''ve already reconstructed the structure and the authentication path -- combine them.', 20, 1),
  ('mission-w35-06-o3-c1', 'concept', 'The closure needs to name the domain structure, the account, and exactly how it authenticates.', 30, 2),
  ('mission-w35-06-o3-c1', 'tool_direction', 'State the domain structure first, then the SPN and its Kerberos authentication path.', 40, 3),
  ('mission-w35-06-o3-c1', 'near_solution', 'Two-domain forest, sentinel-orchestrator in the Service Accounts OU with SPN HTTP/relay.guardian.internal, authenticating entirely via Kerberos tickets.', 50, 4),
  ('mission-w35-06-o3-c1', 'solution', 'This is a single forest with two domains; sentinel-orchestrator sits in a dedicated Service Accounts OU with the SPN HTTP/relay.guardian.internal registered to it, and any client accessing that service authenticates entirely through Kerberos service tickets -- no password ever transmitted.', 65, 5);
