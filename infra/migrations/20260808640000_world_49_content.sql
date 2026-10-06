-- world-49 ("Cloud Security: Misconfigured Sky") mission content, generated
-- from docs/12-world-story-bible.md. Continues Act 7 "Cloudfall". Mission 1
-- is cross-world-gated on world-48's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-49a', 'world-49', 'misconfigured-sky', '49A - Misconfigured Sky', 'The compromised automation identity had excessive privileges. Find out everywhere it actually went.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-49a-1', 'campaign-49a', 'foundations', 'Foundations', 'Public storage, metadata-service credential theft, secret leakage and network exposure, learned as one spreading account compromise.', 1),
  ('operation-49a-2', 'campaign-49a', 'investigation', 'Investigation', 'Reproduce the attack path end to end, then close it without taking the application down.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w49-01', 'world-49', 'campaign-49a', 'operation-49a-1', 'excessive-privileges', 'Excessive Privileges', 'The automation identity from the last world could touch far more than one region. Everywhere it could reach is now suspect.', 'intro', ARRAY['ava', 'zayn'], '{"requiredMissionIds":["mission-w48-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w49-02', 'world-49', 'campaign-49a', 'operation-49a-1', 'the-bucket-left-open', 'The Bucket Left Open', 'A storage bucket, set to public during a demo years ago and never locked back down, held far more than demo data.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w49-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"public-bucket-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w49-03', 'world-49', 'campaign-49a', 'operation-49a-1', 'the-service-that-answers-anything', 'The Service That Answers Anything', 'Every cloud instance can ask its own metadata service who it is. An app with a request-forwarding bug asked on the attacker''s behalf.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w49-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"metadata-ssrf-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w49-04', 'world-49', 'campaign-49a', 'operation-49a-1', 'a-secret-in-plain-sight', 'A Secret in Plain Sight', 'A serverless function''s configuration held a database password in plain text, visible to anyone who could read its settings.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w49-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"secret-config-review-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w49-05', 'world-49', 'campaign-49a', 'operation-49a-2', 'a-door-wide-open-to-everywhere', 'A Door Wide Open to Everywhere', 'A security group allowing inbound traffic from any address, on a port that should only ever hear from one internal service.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w49-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"security-group-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w49-06', 'world-49', 'campaign-49a', 'operation-49a-2', 'misconfigured-sky-boss', 'Misconfigured Sky', 'Reproduce the complete attack path from public bucket to stolen credentials, then close every step of it without taking the application offline.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w49-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"misconfigured-sky-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["misconfigured-sky"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w49-01', 1, 'ava', 'That automation identity from World 48 had excessive privileges across the account. We need to know everywhere it actually went, not just where we already caught it.'),
  ('mission-w49-01', 2, 'zayn', 'Cloud compromises rarely stay in one place. One misconfiguration usually leads straight into the next.'),
  ('mission-w49-02', 1, 'zayn', 'A storage bucket, set public for a demo years ago and never locked back down. It''s been sitting there the entire time.'),
  ('mission-w49-03', 1, 'byte', 'Every cloud instance can ask its own metadata service "who am I, and what can I do." An app with a request-forwarding bug let someone else ask on its behalf.'),
  ('mission-w49-04', 1, 'zayn', 'A serverless function''s configuration panel had a database password sitting in plain text. Anyone who could view settings could read it.'),
  ('mission-w49-05', 1, 'ava', 'A security group open to any address on the internet, on a port meant to only ever hear from one internal service. That''s not a typo, that''s an invitation.'),
  ('mission-w49-06', 1, 'zayn', 'Reproduce the whole path -- bucket, metadata service, secret, network exposure -- start to finish, in a sandboxed replica.'),
  ('mission-w49-06', 2, 'byte', '...Path confirmed. Every step chains into the next. This wasn''t one mistake, it was four small ones that happened to line up perfectly.'),
  ('mission-w49-06', 3, 'ava', 'Close every one of them without taking the application down. Customers are still using this system right now.'),
  ('mission-w49-06', 4, 'zayn', 'Done. Bucket locked, metadata service hardened, secret rotated into a vault, security group scoped to exactly what it needs.'),
  ('mission-w49-06', 5, 'byte', 'One more thing. The compromised deployment pulls its container image from a registry we''ve always trusted completely.'),
  ('mission-w49-06', 6, 'ava', 'Then the image itself is the next thing we stop trusting.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w49-01-o1', 'mission-w49-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to trace the compromised identity''s full reach.'),
  ('mission-w49-02-o1', 'mission-w49-02', 1, 'Find the exposed data', 'Identify which storage object in the public bucket represents a real exposure.'),
  ('mission-w49-03-o1', 'mission-w49-03', 1, 'Recognize metadata-service credential theft', 'Identify which request pattern shows an app being tricked into fetching credentials from the metadata service.'),
  ('mission-w49-04-o1', 'mission-w49-04', 1, 'Find the leaked secret', 'Identify the configuration field holding a plaintext secret.'),
  ('mission-w49-05-o1', 'mission-w49-05', 1, 'Fix the security group', 'Choose the correct least-exposure security group rule.'),
  ('mission-w49-06-o1', 'mission-w49-06', 1, 'Reproduce the attack path', 'Order the complete attack path from public bucket to stolen credentials.'),
  ('mission-w49-06-o2', 'mission-w49-06', 2, 'Close it without downtime', 'Choose the remediation sequence that closes every step while preserving application availability.'),
  ('mission-w49-06-o3', 'mission-w49-06', 3, 'Confirm the closure', 'Confirm the reproduced path and the safe remediation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w49-01-o1-c1', 'mission-w49-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Excessive privileges rarely stay contained to one incident. Ready to see how far this really went?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w49-02-o1-c1', 'mission-w49-02-o1', 1, 'browser_simulation', 'Which storage object in this public bucket represents a real exposure?', '{"screen":"storage-bucket-browser","objects":[{"id":"o1","name":"demo-logo.png","access":"public","note":"Marketing asset, always meant to be public"},{"id":"o2","name":"backend-config-2024.json","access":"public","note":"Contains database hostnames and an API key"},{"id":"o3","name":"readme.txt","access":"public","note":"Empty placeholder file"}],"question":"Which object is a real exposure?"}'::jsonb, '{"correctOptionId":"o2"}'::jsonb),

  ('mission-w49-03-o1-c1', 'mission-w49-03-o1', 1, 'investigation', 'Which request pattern shows an app being tricked into fetching credentials from the metadata service?', '{"evidence":[{"id":"m1","label":"Request pattern A","detail":"The application''s own URL-fetch feature was pointed at the instance''s internal metadata address instead of an external URL, and returned temporary IAM credentials"},{"id":"m2","label":"Request pattern B","detail":"A normal outbound request to a public API, completed successfully"}],"question":"Which request pattern shows metadata-service credential theft?"}'::jsonb, '{"requiredEvidenceIds":["m1"]}'::jsonb),

  ('mission-w49-04-o1-c1', 'mission-w49-04-o1', 1, 'code_debugging', 'Find the configuration field holding a plaintext secret.', '{"language":"json","code":"{\n  \"functionName\": \"order-processor\",\n  \"runtime\": \"node20\",\n  \"environment\": {\n    \"DB_HOST\": \"prod-db.internal\",\n    \"DB_USER\": \"svc_orders\",\n    \"DB_PASSWORD\": \"Sk7-prodpass-2024!\",\n    \"LOG_LEVEL\": \"info\"\n  }\n}","question":"Which field is the security issue, and why?"}'::jsonb, '{"requiredLineIds":["DB_PASSWORD"]}'::jsonb),

  ('mission-w49-05-o1-c1', 'mission-w49-05-o1', 1, 'multiple_choice', 'A security group allows inbound traffic on the database port from 0.0.0.0/0. What''s the correct fix?', '{"question":"A security group allows inbound traffic on the database port from 0.0.0.0/0 (any address). What''s the correct fix?","options":[{"id":"a","text":"Leave it -- the database has its own password"},{"id":"b","text":"Restrict the rule to only the internal application server''s security group or private IP range"},{"id":"c","text":"Block the port entirely, breaking the application"},{"id":"d","text":"Change the port number to something less obvious"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w49-06-o1-c1', 'mission-w49-06-o1', 1, 'interactive_diagram', 'Reconstruct the complete attack path from public bucket to stolen credentials.', '{"hotspots":[{"id":"bucket","label":"Public storage bucket exposing a config file with an API key","explanation":"The very first foothold -- data nobody meant to expose."},{"id":"ssrf","label":"Application SSRF bug used to query the instance metadata service","explanation":"Turns a leaked API key into temporary cloud credentials."},{"id":"secret","label":"Plaintext database password read from a serverless function''s config","explanation":"A second, independent way into the same data."},{"id":"network","label":"Overly broad security group allowing direct database access from anywhere","explanation":"The exposure that made the stolen credentials actually usable from outside."}],"task":"Order the complete attack path."}'::jsonb, '{"correctOrderIds":["bucket","ssrf","secret","network"]}'::jsonb),

  ('mission-w49-06-o2-c1', 'mission-w49-06-o2', 1, 'multiple_choice', 'What''s the correct order to remediate all four issues while keeping the application running for current users?', '{"question":"What''s the correct order to remediate all four issues while keeping the application running for current users?","options":[{"id":"a","text":"Take the whole application offline first, then fix everything at once"},{"id":"b","text":"Lock the bucket and rotate exposed secrets first, then patch the SSRF bug, then tighten the security group -- each step independently safe, none requiring downtime"},{"id":"c","text":"Only fix the security group -- the rest doesn''t matter"},{"id":"d","text":"Wait until the next scheduled maintenance window to fix anything"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w49-06-o3-c1', 'mission-w49-06-o3', 1, 'boss_encounter', 'Confirm the reproduced attack path and the safe remediation plan together.', '{"stages":[{"objectiveRef":"mission-w49-06-o1","label":"The attack path"},{"objectiveRef":"mission-w49-06-o2","label":"The safe remediation order"}],"task":"Confirm the reproduced attack path and the safe remediation plan together."}'::jsonb, '{"requiredObjectiveIds":["mission-w49-06-o1","mission-w49-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w49-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w49-02-o1-c1', 'orientation', 'Ask which of these three files would actually hurt if a stranger read it.', 15, 1),
  ('mission-w49-02-o1-c1', 'solution', 'The backend config file holding database hostnames and an API key (o2) is the real exposure -- the logo and empty readme were always meant to be public.', 25, 2),

  ('mission-w49-03-o1-c1', 'orientation', 'One of these two patterns targets an address that only makes sense from inside the instance itself.', 15, 1),
  ('mission-w49-03-o1-c1', 'solution', 'Pattern A points the app''s own fetch feature at the internal metadata address and gets back live credentials -- that''s SSRF-driven credential theft. Pattern B is an ordinary outbound call.', 25, 2),

  ('mission-w49-04-o1-c1', 'orientation', 'Three of these four settings are perfectly normal to have in plain text.', 15, 1),
  ('mission-w49-04-o1-c1', 'solution', 'DB_PASSWORD holding a raw password is the leak -- hostnames, usernames and log levels aren''t secrets, but a password belongs in a secrets manager, not a config field.', 25, 2),

  ('mission-w49-05-o1-c1', 'orientation', 'Ask who actually needs to reach this port -- it''s not "anyone on the internet."', 15, 1),
  ('mission-w49-05-o1-c1', 'solution', 'Scoping the rule to only the application server that legitimately needs database access (option b) closes the exposure without breaking anything that should still work.', 25, 2),

  ('mission-w49-06-o1-c1', 'orientation', 'Start with the piece that needed no prior access at all.', 15, 1),
  ('mission-w49-06-o1-c1', 'concept', 'Each step made the next one possible: the bucket leaked a key, the key plus the SSRF bug reached the metadata service, the metadata credentials and the leaked password gave two paths to the data, and the open security group made both paths reachable from outside.', 25, 2),
  ('mission-w49-06-o1-c1', 'solution', 'Public bucket -> SSRF against the metadata service -> plaintext secret in the function config -> overly broad security group exposing it all externally.', 35, 3),

  ('mission-w49-06-o2-c1', 'orientation', 'Ask which fixes can happen independently, without waiting on each other or breaking live traffic.', 15, 1),
  ('mission-w49-06-o2-c1', 'solution', 'Lock the bucket and rotate secrets first (removes what''s already exposed), patch the SSRF bug, then tighten the security group -- every step is independently safe and none require taking the app down. Option b.', 25, 2),

  ('mission-w49-06-o3-c1', 'orientation', 'You''ve already reproduced the path and picked the safe remediation order -- combine them.', 20, 1),
  ('mission-w49-06-o3-c1', 'solution', 'The path runs bucket -> SSRF -> leaked secret -> open security group, and it closes safely in that same order: secrets first, then the SSRF bug, then the network exposure -- no downtime required at any step.', 35, 2);
