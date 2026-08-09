-- world-36 ("Active Directory Security: Blood Paths") mission content,
-- generated from docs/12-world-story-bible.md. Mission 1 is
-- cross-world-gated on world-35's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-36a', 'world-36', 'blood-paths', '36A - Blood Paths', 'None of these permissions look dangerous individually. Together, they reach domain admin.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-36a-1', 'campaign-36a', 'foundations', 'Foundations', 'Kerberoasting, AS-REP roasting, delegation and certificate services, learned as individual links in a chain.', 1),
  ('operation-36a-2', 'campaign-36a', 'investigation', 'Investigation', 'Find the shortest path to domain-level impact, and remove it without breaking business access.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w36-01', 'world-36', 'campaign-36a', 'operation-36a-1', 'relationships-not-a-list', 'Relationships, Not a List', 'This graph isn''t a list of vulnerabilities. It''s relationships -- permission by permission, none of them individually alarming.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w35-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w36-02', 'world-36', 'campaign-36a', 'operation-36a-1', 'never-needed-to-touch-it', 'Never Needed to Touch It', 'Any account with an SPN can have a service ticket requested for it by anyone -- crack it offline, and you never needed to touch the account directly.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w36-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"kerberoasting-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w36-03', 'world-36', 'campaign-36a', 'operation-36a-1', 'no-credentials-required-first', 'No Credentials Required First', 'An account with Kerberos pre-authentication disabled hands out an encrypted response to anyone who asks, no valid credentials required first.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w36-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"asrep-roasting-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w36-04', 'world-36', 'campaign-36a', 'operation-36a-2', 'three-boring-steps', 'Three Boring Steps', 'Permission chains are the actual weapon here. Three boring steps, one domain compromise.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w36-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"delegation-chain-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w36-05', 'world-36', 'campaign-36a', 'operation-36a-2', 'a-rubber-stamp-for-impersonation', 'A Rubber Stamp for Impersonation', 'A certificate template that lets a low-privilege requester supply their own identity is a rubber stamp for impersonation, if nobody''s watching.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w36-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"adcs-misconfig-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w36-06', 'world-36', 'campaign-36a', 'operation-36a-2', 'domain-emperor-boss', 'Domain Emperor', 'Find the shortest actual historical path to domain-level impact in the sandbox, then remove it without breaking a single thing the business legitimately needs.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w36-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"domain-emperor-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["domain-emperor"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w36-01', 1, 'zayn', 'This graph isn''t a list of vulnerabilities. It''s relationships -- permission by permission, none of them individually alarming. Together, they reach domain admin.'),
  ('mission-w36-01', 2, 'byte', 'That''s the whole discipline of AD security. Nobody hands out "compromise the domain" as a single permission. They hand out ten boring ones that happen to chain.'),
  ('mission-w36-01', 3, 'zayn', 'Kerberoasting, AS-REP roasting, delegation abuse, ACL abuse, certificate services. Every one of these is a different link. Learn to see the chain, not just the links.'),
  ('mission-w36-01', 4, 'byte', 'Let''s start pulling on threads.'),
  ('mission-w36-02', 1, 'zayn', 'Any account with an SPN can have a service ticket requested for it by anyone in the domain. That ticket is encrypted with the account''s own password hash -- crack it offline, and you never needed to touch the account directly.'),
  ('mission-w36-03', 1, 'byte', 'An account with Kerberos pre-authentication disabled will hand out an encrypted response to literally anyone who asks for it, no valid credentials required first. That''s AS-REP roasting.'),
  ('mission-w36-04', 1, 'zayn', 'Permission chains are the actual weapon here. One account with write access to another, which has delegation rights to a server, which happens to hold a Domain Admin session -- three boring steps, one domain compromise.'),
  ('mission-w36-05', 1, 'byte', 'A certificate services template that lets a low-privilege requester supply their own identity in the certificate is a rubber stamp for impersonation, if nobody''s watching the template configuration.'),
  ('mission-w36-06', 1, 'zayn', 'Find the shortest actual historical path to domain-level impact in the sandbox. Then remove it -- without breaking a single thing the business legitimately needs.'),
  ('mission-w36-06', 2, 'byte', '...Path confirmed. Three hops: a helpdesk account with GenericWrite over a service account, that service account holds unconstrained delegation on a file server, and that file server had a cached Domain Admin session.'),
  ('mission-w36-06', 3, 'zayn', 'Nobody looks dangerous individually. The helpdesk account still needs GenericWrite for its actual job. The chain is the vulnerability, not any single grant.'),
  ('mission-w36-06', 4, 'byte', 'Removed the delegation right specifically -- the one link nothing legitimate actually depended on. Retested. Path''s gone, helpdesk still works exactly as before.'),
  ('mission-w36-06', 5, 'zayn', 'Confirmed. But this path ends somewhere specific -- a synchronization account. Not a person, not a normal service. Something that bridges this on-prem domain to a cloud tenant.'),
  ('mission-w36-06', 6, 'byte', 'That account is the actual reason this matters beyond one domain. Whatever''s on the other side of that sync isn''t local anymore.'),
  ('mission-w36-06', 7, 'zayn', 'Domain admin was never the ceiling. It was a doorway into the cloud. Entra ID, next.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w36-01-o1', 'mission-w36-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to see chains, not just individual permissions.'),
  ('mission-w36-02-o1', 'mission-w36-02', 1, 'Explain Kerberoasting', 'Determine what an attacker actually recovers through Kerberoasting.'),
  ('mission-w36-03-o1', 'mission-w36-03', 1, 'Find the AS-REP roastable account', 'Identify which account is vulnerable to AS-REP roasting and why it matters here.'),
  ('mission-w36-04-o1', 'mission-w36-04', 1, 'Trace the delegation chain', 'Order the steps of the attack path from a helpdesk permission to domain compromise.'),
  ('mission-w36-05-o1', 'mission-w36-05', 1, 'Explain the certificate template risk', 'Determine the risk created by a requester-controlled SAN certificate template.'),
  ('mission-w36-06-o1', 'mission-w36-06', 1, 'Find the shortest path', 'Identify the evidence forming the shortest path to domain-level impact.'),
  ('mission-w36-06-o2', 'mission-w36-06', 2, 'Choose the correct fix', 'Select the fix that removes the path without breaking legitimate access.'),
  ('mission-w36-06-o3', 'mission-w36-06', 3, 'Close the path', 'Confirm the path and the fix together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w36-01-o1-c1', 'mission-w36-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"See the chain, not just the links. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w36-02-o1-c1', 'mission-w36-02-o1', 1, 'multiple_choice', 'An attacker requests Kerberos service tickets for every account in the domain with a registered SPN, then attempts to crack those tickets offline. What are they actually trying to recover?', '{"question":"An attacker requests Kerberos service tickets for every account in the domain with a registered SPN, then attempts to crack those tickets offline. What are they actually trying to recover?","options":[{"id":"a","text":"The domain controller''s own password"},{"id":"b","text":"The service accounts'' plaintext passwords -- each ticket is encrypted with that account''s own password-derived hash and can be cracked offline without touching the account or triggering a lockout"},{"id":"c","text":"The forest''s root certificate"},{"id":"d","text":"Nothing -- Kerberos tickets can''t be cracked"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w36-03-o1-c1', 'mission-w36-03-o1', 1, 'investigation', 'Which account is vulnerable to AS-REP roasting, and why does it matter here specifically?', '{"evidence":[{"id":"r1","label":"Account svc-legacy-report","detail":"\"Do not require Kerberos preauthentication\" flag is enabled"},{"id":"r2","label":"Account j.martinez","detail":"Standard account, Kerberos preauthentication required as normal"},{"id":"r3","label":"svc-legacy-report''s password policy","detail":"Last changed four years ago, not part of the fine-grained password policy for service accounts"}],"question":"Which account is vulnerable to AS-REP roasting, and why does it matter here specifically?"}'::jsonb, '{"requiredEvidenceIds":["r1","r3"]}'::jsonb),

  ('mission-w36-04-o1-c1', 'mission-w36-04-o1', 1, 'interactive_diagram', 'Order these steps to trace the actual attack path from a helpdesk permission to domain compromise.', '{"hotspots":[{"id":"step1","label":"helpdesk-op has GenericWrite over svc-fileindex","explanation":"A normal, job-justified permission -- helpdesk resets service account passwords as part of routine support."},{"id":"step2","label":"svc-fileindex holds unconstrained delegation on FILESRV02","explanation":"Means anything authenticating to svc-fileindex''s service can impersonate that caller to any other service, including Domain Admins."},{"id":"step3","label":"FILESRV02 has a cached Domain Admin session","explanation":"A Domain Admin previously logged into this server, leaving a session an attacker with delegation rights can capture and reuse."},{"id":"step4","label":"Attacker now holds a usable Domain Admin ticket","explanation":"The final outcome -- full domain compromise, reached entirely through three individually ordinary permissions."}],"task":"Order these steps to trace the actual attack path from a helpdesk permission to domain compromise."}'::jsonb, '{"correctOrderIds":["step1","step2","step3","step4"]}'::jsonb),

  ('mission-w36-05-o1-c1', 'mission-w36-05-o1', 1, 'multiple_choice', 'A certificate template allows any authenticated user to enroll, and permits the requester to supply their own Subject Alternative Name (SAN) in the request. What risk does this create?', '{"question":"A certificate template allows any authenticated user to enroll, and permits the requester to supply their own Subject Alternative Name (SAN) in the request. What risk does this create?","options":[{"id":"a","text":"None, SANs are cosmetic"},{"id":"b","text":"A low-privilege user could request a certificate specifying a Domain Admin''s identity in the SAN, then use that certificate to authenticate as that admin"},{"id":"c","text":"It only affects email encryption"},{"id":"d","text":"Certificate templates can''t be misconfigured"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w36-06-o1-c1', 'mission-w36-06-o1', 1, 'investigation', 'Which three pieces of evidence together form the shortest path to domain-level impact?', '{"evidence":[{"id":"p1","label":"helpdesk-op permissions","detail":"GenericWrite over svc-fileindex -- a standard, job-justified grant"},{"id":"p2","label":"svc-fileindex delegation configuration","detail":"Unconstrained delegation enabled on FILESRV02 -- not required for its actual function, appears to be a leftover misconfiguration"},{"id":"p3","label":"FILESRV02 session history","detail":"A Domain Admin account authenticated to this server three weeks ago and the session was never explicitly cleared"},{"id":"p4","label":"An unrelated, correctly configured file server","detail":"No delegation, no cached privileged sessions"}],"question":"Which three pieces of evidence together form the shortest path to domain-level impact?"}'::jsonb, '{"requiredEvidenceIds":["p1","p2","p3"]}'::jsonb),

  ('mission-w36-06-o2-c1', 'mission-w36-06-o2', 1, 'multiple_choice', 'What''s the correct fix that removes this path without breaking helpdesk-op''s actual job?', '{"question":"What''s the correct fix that removes this path without breaking helpdesk-op''s actual job?","options":[{"id":"a","text":"Delete the helpdesk-op account entirely"},{"id":"b","text":"Remove the unnecessary unconstrained delegation from svc-fileindex specifically, leaving helpdesk-op''s GenericWrite permission intact since it''s legitimately needed"},{"id":"c","text":"Disable Kerberos domain-wide"},{"id":"d","text":"Do nothing, the chain is too complex to matter"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w36-06-o3-c1', 'mission-w36-06-o3', 1, 'boss_encounter', 'Confirm the path and the fix together.', '{"stages":[{"objectiveRef":"mission-w36-06-o1","label":"The shortest path"},{"objectiveRef":"mission-w36-06-o2","label":"The fix"}],"task":"Confirm the path and the fix together."}'::jsonb, '{"requiredObjectiveIds":["mission-w36-06-o1","mission-w36-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w36-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w36-02-o1-c1', 'orientation', 'The ticket itself is encrypted with something specific to the target account.', 15, 1),
  ('mission-w36-02-o1-c1', 'solution', 'The service ticket is encrypted with the service account''s own password hash -- cracking it offline recovers that password without ever touching the account directly. Option b.', 25, 2),

  ('mission-w36-03-o1-c1', 'orientation', 'Two of these three items describe the same account; one describes an unrelated, normal one.', 15, 1),
  ('mission-w36-03-o1-c1', 'concept', 'Disabled pre-authentication alone makes an account roastable; a stale, weak password policy is what makes that roastable ticket actually crackable in practice.', 25, 2),
  ('mission-w36-03-o1-c1', 'solution', 'svc-legacy-report has pre-authentication disabled (r1) and a four-year-old password outside the service-account policy (r3) -- together, roastable and crackable. j.martinez is a normal, unaffected account.', 35, 3),

  ('mission-w36-04-o1-c1', 'orientation', 'Start from the permission that''s actually granted to a real, working account, and follow where it leads.', 15, 1),
  ('mission-w36-04-o1-c1', 'concept', 'Each step in this chain grants access to the next -- write access to an account, delegation rights from that account, a cached session on the server that account can reach.', 25, 2),
  ('mission-w36-04-o1-c1', 'solution', 'helpdesk-op''s GenericWrite -> svc-fileindex''s unconstrained delegation -> FILESRV02''s cached Domain Admin session -> a usable Domain Admin ticket.', 35, 3),

  ('mission-w36-05-o1-c1', 'orientation', 'Ask what a certificate actually proves, and who controls what it says.', 15, 1),
  ('mission-w36-05-o1-c1', 'solution', 'If the requester controls the SAN, they can request a certificate claiming to be anyone, including a Domain Admin, and authenticate with it. Option b.', 25, 2),

  ('mission-w36-06-o1-c1', 'orientation', 'One of these four items is unrelated -- a server with no exploitable configuration at all.', 15, 1),
  ('mission-w36-06-o1-c1', 'concept', 'The shortest path needs a starting permission, an escalation mechanism, and something at the end worth reaching.', 25, 2),
  ('mission-w36-06-o1-c1', 'tool_direction', 'Trace from helpdesk-op''s permission through the delegation to the cached session.', 35, 3),
  ('mission-w36-06-o1-c1', 'solution', 'helpdesk-op''s GenericWrite (p1), svc-fileindex''s unconstrained delegation (p2), and FILESRV02''s cached Domain Admin session (p3) together form the shortest path -- the unrelated server (p4) is a distractor.', 45, 4),

  ('mission-w36-06-o2-c1', 'orientation', 'Only one link in this chain has no legitimate business purpose at all.', 15, 1),
  ('mission-w36-06-o2-c1', 'solution', 'The unconstrained delegation is the unnecessary link -- removing just that, while keeping the legitimately needed GenericWrite permission, closes the path without disrupting helpdesk-op''s real job. Option b.', 25, 2),

  ('mission-w36-06-o3-c1', 'orientation', 'You''ve already traced the path and chosen the fix -- combine them.', 20, 1),
  ('mission-w36-06-o3-c1', 'concept', 'The closure needs to name every hop in the chain and exactly which one gets removed.', 30, 2),
  ('mission-w36-06-o3-c1', 'tool_direction', 'State the three-hop path first, then the single removed link.', 40, 3),
  ('mission-w36-06-o3-c1', 'near_solution', 'GenericWrite -> unconstrained delegation -> cached Domain Admin session; fixed by removing only the delegation.', 50, 4),
  ('mission-w36-06-o3-c1', 'solution', 'The shortest path runs from helpdesk-op''s legitimate GenericWrite over svc-fileindex, through svc-fileindex''s unnecessary unconstrained delegation on FILESRV02, to a cached Domain Admin session on that server. Removing only the unconstrained delegation closes the entire path while leaving helpdesk-op''s actual job completely intact.', 65, 5);
