-- world-28 ("Web Security: Metropolis Breach") mission content, generated
-- from docs/12-world-story-bible.md. Kept to the same 1-campaign/6-mission
-- structure as every other world in this codebase, despite the bible's
-- note about this world being a worked example for 3-6 campaigns.
-- Mission 1 is cross-world-gated on world-27's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-28a', 'world-28', 'metropolis-breach', '28A - Metropolis Breach', 'The forgotten Nexus Market instance is a full application: storefront, admin portal, APIs, support system, legacy pieces. Every offensive step gets a defensive follow-through.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-28a-1', 'campaign-28a', 'foundations', 'Foundations', 'Injection, XSS, access control and upload handling, learned by exploiting the sandbox and then patching it.', 1),
  ('operation-28a-2', 'campaign-28a', 'investigation', 'Investigation', 'Chain the flaws to reproduce the historical breach, then repair the application without breaking legitimate use.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w28-01', 'world-28', 'campaign-28a', 'operation-28a-1', 'the-forgotten-copy', 'The Forgotten Copy', 'This is the forgotten instance Zayn found -- old Nexus Market code, still live, still reachable, full storefront and all.', 'intro', ARRAY['ava', 'zayn'], '{"requiredMissionIds":["mission-w27-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w28-02', 'world-28', 'campaign-28a', 'operation-28a-1', 'one-bad-character', 'One Bad Character', 'A login form that glues your input directly into SQL is one bad character away from handing over the whole database.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w28-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"sqli-comparison-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w28-03', 'world-28', 'campaign-28a', 'operation-28a-1', 'poisoned-pages', 'Poisoned Pages', 'Stored XSS doesn''t need to trick you into clicking anything. It just needs someone else to view a page you already poisoned.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w28-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"stored-xss-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w28-04', 'world-28', 'campaign-28a', 'operation-28a-2', 'trusting-the-url', 'Trusting the URL', 'An access-control flaw doesn''t need clever code. It just needs the app to trust an ID in a URL instead of checking who''s actually asking.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w28-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"idor-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w28-05', 'world-28', 'campaign-28a', 'operation-28a-2', 'fix-the-code-not-the-request', 'Fix the Code, Not the Request', 'A file upload that trusts the filename it''s given is a path traversal waiting to happen.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w28-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"upload-patching-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w28-06', 'world-28', 'campaign-28a', 'operation-28a-2', 'the-broken-marketplace-boss', 'The Broken Marketplace', 'Chain what you''ve found. Reproduce the actual historical breach, then repair the application without breaking a single thing a real customer needs.', 'boss', ARRAY['ava', 'zayn'], '{"requiredMissionIds":["mission-w28-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"broken-marketplace-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["broken-marketplace"],"skillXp":{"web_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w28-01', 1, 'ava', 'This is the forgotten copy Zayn found -- old Nexus Market code, still live, still reachable. Full storefront, admin portal, APIs, support system, legacy pieces bolted on over the years.'),
  ('mission-w28-01', 2, 'zayn', 'Every one of those pieces is its own neighborhood, and every neighborhood has its own way of getting broken into.'),
  ('mission-w28-01', 3, 'ava', 'We''re not just breaking things today. Every offensive step gets a defensive follow-through -- exploit it in the sandbox, then patch it, then prove the patch actually holds.'),
  ('mission-w28-01', 4, 'zayn', 'Let''s start at the front door.'),
  ('mission-w28-02', 1, 'ava', 'A login form that builds its query by gluing your input directly into SQL is one bad character away from handing over the whole database.'),
  ('mission-w28-03', 1, 'zayn', 'Stored XSS doesn''t need to trick you into clicking anything. It just needs someone else to view a page you already poisoned.'),
  ('mission-w28-04', 1, 'ava', 'An access-control flaw doesn''t need clever code. It just needs the app to trust an ID in a URL instead of checking who''s actually asking.'),
  ('mission-w28-05', 1, 'zayn', 'A file upload that trusts the filename it''s given is a path traversal waiting to happen. Fix the code, not just this one request.'),
  ('mission-w28-06', 1, 'ava', 'Chain what you''ve found. Reproduce the actual historical breach, start to finish, then repair the application without breaking a single thing a real customer needs.'),
  ('mission-w28-06', 2, 'zayn', '...Chain confirmed. SQLi gets the first foothold, the access-control flaw gets into the admin portal, and from there--'),
  ('mission-w28-06', 3, 'byte', 'Wait. That admin session just called an endpoint that isn''t part of Nexus Market at all. /sentinel/evaluate.'),
  ('mission-w28-06', 4, 'ava', 'This was never just about stealing data. Something on the other end of that call is being fed information, deliberately.'),
  ('mission-w28-06', 5, 'zayn', 'Patched, retested, confirmed working for legitimate customers. But that endpoint is the real story now.'),
  ('mission-w28-06', 6, 'ava', '/sentinel/evaluate has to be part of something bigger -- an API ecosystem this application trusts. Time to find out what else trusts it too.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w28-01-o1', 'mission-w28-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to exploit only the sandbox and repair what you break.'),
  ('mission-w28-02-o1', 'mission-w28-02', 1, 'Identify the SQL-injectable login', 'Determine which login implementation is vulnerable to SQL injection.'),
  ('mission-w28-03-o1', 'mission-w28-03', 1, 'Find the stored XSS payloads', 'Identify which submissions contain a stored XSS payload.'),
  ('mission-w28-04-o1', 'mission-w28-04', 1, 'Name the access-control flaw', 'Identify the vulnerability class behind an order-ID-based data leak.'),
  ('mission-w28-05-o1', 'mission-w28-05', 1, 'Sort upload-handling patterns', 'Classify each upload-handling pattern as vulnerable or safe.'),
  ('mission-w28-06-o1', 'mission-w28-06', 1, 'Trace the chain', 'Identify the evidence that forms the actual chain from foothold to the unexpected endpoint call.'),
  ('mission-w28-06-o2', 'mission-w28-06', 2, 'Choose the complete fix', 'Select the fix that closes the chain without breaking legitimate use.'),
  ('mission-w28-06-o3', 'mission-w28-06', 3, 'Close the marketplace breach', 'Confirm the chain and its fix together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w28-01-o1-c1', 'mission-w28-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Exploit the sandbox, then repair it. Every time. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w28-02-o1-c1', 'mission-w28-02-o1', 1, 'browser_simulation', 'Compare these two login implementations. Which one is vulnerable to SQL injection?', '{"instructions":"Compare these two login implementations. Which one is vulnerable to SQL injection?","pages":[{"id":"current","url":"https://nexus-market.example/login","title":"Current login form (patched, parameterized queries)","indicators":{"https":true,"parameterized_query":true}},{"id":"legacy","url":"http://mnt-relay-legacy.skyport-logistics.example:8080/login","title":"Legacy login form (1.2-legacy, string-concatenated SQL)","indicators":{"https":false,"parameterized_query":false}}]}'::jsonb, '{"correctPageId":"legacy"}'::jsonb),

  ('mission-w28-03-o1-c1', 'mission-w28-03-o1', 1, 'investigation', 'Which submissions contain a stored XSS payload?', '{"evidence":[{"id":"x1","label":"Product review: \"Great product, fast shipping!\"","detail":"Plain text, rendered as-is, no script content"},{"id":"x2","label":"Product review containing a <script> tag that redirects to an attacker domain with the page''s cookies attached","detail":"Stored directly in the database and rendered without sanitization on every page view"},{"id":"x3","label":"Support ticket subject: \"Order #4471 not received\"","detail":"Plain text, no script content"},{"id":"x4","label":"Support ticket body containing an <img> tag with an onerror handler that runs JavaScript","detail":"Stored and rendered without sanitization in the support agent''s ticket view"}],"question":"Which submissions contain a stored XSS payload?"}'::jsonb, '{"requiredEvidenceIds":["x2","x4"]}'::jsonb),

  ('mission-w28-04-o1-c1', 'mission-w28-04-o1', 1, 'multiple_choice', 'Nexus Market''s order-details page loads via /api/orders/4471. Changing the URL to /api/orders/4472 returns a different customer''s full order, with no additional authentication. What''s this vulnerability called?', '{"question":"Nexus Market''s order-details page loads via /api/orders/4471. Changing the URL to /api/orders/4472 returns a different customer''s full order, with no additional authentication. What''s this vulnerability called?","options":[{"id":"a","text":"SQL injection"},{"id":"b","text":"Insecure Direct Object Reference (broken object-level access control) -- the app trusts the ID in the URL instead of verifying the requester owns that order"},{"id":"c","text":"Cross-site scripting"},{"id":"d","text":"A DNS misconfiguration"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w28-05-o1-c1', 'mission-w28-05-o1', 1, 'drag_and_drop', 'Classify each upload-handling pattern as vulnerable or safe.', '{"items":[{"id":"u1","text":"Upload handler saves the file using the client-supplied filename verbatim, including any ../ sequences"},{"id":"u2","text":"Upload handler generates a random server-side filename and validates the extension against an allowlist"},{"id":"u3","text":"Upload handler checks only the file''s declared Content-Type header, not its actual contents"},{"id":"u4","text":"Upload handler validates actual file content against the expected type, in addition to extension"}],"targets":[{"id":"vulnerable","label":"Vulnerable pattern"},{"id":"safe","label":"Safe pattern"}]}'::jsonb, '{"correctMapping":{"u1":"vulnerable","u2":"safe","u3":"vulnerable","u4":"safe"}}'::jsonb),

  ('mission-w28-06-o1-c1', 'mission-w28-06-o1', 1, 'investigation', 'Which three pieces of evidence form the actual chain from initial foothold to the unexpected endpoint call?', '{"evidence":[{"id":"h1","label":"SQL injection against the legacy login form","detail":"Confirmed exploitable, grants an authenticated low-privilege session"},{"id":"h2","label":"IDOR on the admin portal''s user-role endpoint","detail":"Allows the low-privilege session to view, and by extension assume, an admin user''s role"},{"id":"h3","label":"Admin session activity log","detail":"Immediately after privilege escalation, the session calls an internal endpoint: POST /sentinel/evaluate"},{"id":"h4","label":"Marketing newsletter signup form","detail":"Unrelated, standard email capture form, no security issues found"}],"question":"Which three pieces of evidence form the actual chain from initial foothold to the unexpected endpoint call?"}'::jsonb, '{"requiredEvidenceIds":["h1","h2","h3"]}'::jsonb),

  ('mission-w28-06-o2-c1', 'mission-w28-06-o2', 1, 'multiple_choice', 'Which fix closes this chain without breaking legitimate marketplace use?', '{"question":"Which fix closes this chain without breaking legitimate marketplace use?","options":[{"id":"a","text":"Take the entire marketplace offline permanently"},{"id":"b","text":"Parameterize the legacy login query, enforce object-level authorization on the role endpoint, and decommission the legacy instance entirely since it was never supposed to be running"},{"id":"c","text":"Delete the /sentinel/evaluate endpoint and leave everything else as-is"},{"id":"d","text":"Rate-limit login attempts only"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w28-06-o3-c1', 'mission-w28-06-o3', 1, 'boss_encounter', 'Confirm the chain and its fix together.', '{"stages":[{"objectiveRef":"mission-w28-06-o1","label":"The chain"},{"objectiveRef":"mission-w28-06-o2","label":"The fix"}],"task":"Confirm the chain and its fix together."}'::jsonb, '{"requiredObjectiveIds":["mission-w28-06-o1","mission-w28-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w28-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w28-02-o1-c1', 'orientation', 'Look at the indicators shown for each page, not just the title.', 10, 1),
  ('mission-w28-02-o1-c1', 'concept', 'A login form that builds SQL by string concatenation instead of parameterized queries lets user input change the query''s actual structure.', 20, 2),
  ('mission-w28-02-o1-c1', 'solution', 'The legacy login form is marked not parameterized and not HTTPS -- that''s the vulnerable one.', 30, 3),

  ('mission-w28-03-o1-c1', 'orientation', 'Two of these four submissions are completely ordinary text.', 15, 1),
  ('mission-w28-03-o1-c1', 'concept', 'Any submission containing executable script or an event handler that runs JavaScript, stored and rendered without sanitization, is a stored XSS payload.', 25, 2),
  ('mission-w28-03-o1-c1', 'solution', 'The review with the redirect script (x2) and the ticket with the onerror handler (x4) are both stored XSS -- the other two are plain text.', 35, 3),

  ('mission-w28-04-o1-c1', 'orientation', 'Nothing about the request itself is malformed -- only the ID in the URL changed.', 15, 1),
  ('mission-w28-04-o1-c1', 'concept', 'When an app trusts a client-supplied identifier instead of verifying ownership server-side, that''s a broken object-level access control issue.', 25, 2),
  ('mission-w28-04-o1-c1', 'solution', 'This is an Insecure Direct Object Reference -- the app never checks whether the requester actually owns order 4472. Option b.', 35, 3),

  ('mission-w28-05-o1-c1', 'orientation', 'Two of these four patterns trust something about the file that an attacker fully controls.', 15, 1),
  ('mission-w28-05-o1-c1', 'solution', 'Trusting the client filename (u1, path traversal risk) and trusting only the declared Content-Type (u3, content-spoofing risk) are both vulnerable. Random server-side naming with an extension allowlist (u2) and real content validation (u4) are both safe.', 25, 2),

  ('mission-w28-06-o1-c1', 'orientation', 'Follow the session from its first foothold through to whatever it does with elevated access.', 15, 1),
  ('mission-w28-06-o1-c1', 'concept', 'A working chain needs an entry point, a privilege gain, and what that elevated privilege was actually used for.', 25, 2),
  ('mission-w28-06-o1-c1', 'tool_direction', 'Check the SQLi finding, the IDOR finding, and the admin session''s own activity log.', 35, 3),
  ('mission-w28-06-o1-c1', 'solution', 'SQLi grants the foothold (h1), IDOR grants admin-level access (h2), and the admin session''s log shows it immediately calling /sentinel/evaluate (h3) -- together, the complete chain.', 45, 4),

  ('mission-w28-06-o2-c1', 'orientation', 'The fix needs to address the entry point, the access-control gap, and the fact that this instance should never have been running at all.', 15, 1),
  ('mission-w28-06-o2-c1', 'solution', 'Parameterizing the query, enforcing real object-level authorization, and decommissioning the legacy instance together close every part of the chain while leaving the real, current marketplace untouched. Option b.', 25, 2),

  ('mission-w28-06-o3-c1', 'orientation', 'You''ve already traced the chain and chosen the fix -- combine them.', 20, 1),
  ('mission-w28-06-o3-c1', 'concept', 'The closure needs to state the full chain and the complete remediation, not just one flaw and one patch.', 30, 2),
  ('mission-w28-06-o3-c1', 'tool_direction', 'State the three-step chain first, then the three-part fix.', 40, 3),
  ('mission-w28-06-o3-c1', 'near_solution', 'SQLi -> IDOR -> /sentinel/evaluate call. Fix: parameterize the query, enforce object-level authorization, decommission the legacy instance.', 50, 4),
  ('mission-w28-06-o3-c1', 'solution', 'The chain runs from SQL injection on the legacy login (foothold) through an IDOR on the role endpoint (admin access) to an admin session calling the unrelated /sentinel/evaluate endpoint. Closing it requires parameterizing the login query, enforcing real object-level authorization on the role endpoint, and decommissioning the legacy instance entirely -- it was never supposed to be running in the first place.', 65, 5);
