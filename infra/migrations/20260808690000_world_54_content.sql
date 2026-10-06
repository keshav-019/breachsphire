-- world-54 ("Mobile Security: Pocket Surface") mission content, generated
-- from docs/12-world-story-bible.md. Continues Act 7 "Cloudfall". Mission 1
-- is cross-world-gated on world-53's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-54a', 'world-54', 'pocket-surface', '54A - Pocket Surface', 'A field engineer''s phone, carrying an app built from the poisoned dependency, becomes the next crime scene.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-54a-1', 'campaign-54a', 'foundations', 'Foundations', 'APK structure, manifests, permissions and storage, learned through a device investigation.', 1),
  ('operation-54a-2', 'campaign-54a', 'investigation', 'Investigation', 'Find how the app exposes a device credential, and produce a secure remediation.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w54-01', 'world-54', 'campaign-54a', 'operation-54a-1', 'a-phone-in-the-field', 'A Phone in the Field', 'A field engineer''s phone, connected to an affected environment, is running a mobile app built from the same poisoned dependency traced in the last world.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w53-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w54-02', 'world-54', 'campaign-54a', 'operation-54a-1', 'permissions-it-shouldnt-need', 'Permissions It Shouldn''t Need', 'An app''s manifest declares every permission it will ever ask for. This one asks for far more than a field-reporting tool should.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w54-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"manifest-review-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w54-03', 'world-54', 'campaign-54a', 'operation-54a-1', 'a-credential-sitting-in-plain-text', 'A Credential Sitting in Plain Text', 'Local storage on the device is holding something that should never leave encrypted storage, let alone sit unencrypted on disk.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w54-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"local-storage-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w54-04', 'world-54', 'campaign-54a', 'operation-54a-2', 'watching-what-it-actually-sends', 'Watching What It Actually Sends', 'Captured traffic from the app shows exactly what leaves the device, and exactly how carelessly it''s protected in transit.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w54-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"mobile-traffic-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w54-05', 'world-54', 'campaign-54a', 'operation-54a-2', 'a-link-that-does-too-much', 'A Link That Does Too Much', 'A deep link meant to open a specific screen can be crafted to do something the app''s developers never intended.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w54-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"deep-link-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w54-06', 'world-54', 'campaign-54a', 'operation-54a-2', 'pocket-surface-boss', 'Pocket Surface', 'Find exactly how this app exposes a device credential, end to end, and produce a secure remediation the field team can actually ship.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w54-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"pocket-surface-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["pocket-surface"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w54-01', 1, 'ava', 'A field engineer''s phone, connected to an affected environment, is running an app built from the same poisoned dependency we just traced.'),
  ('mission-w54-01', 2, 'byte', 'This is our first real mobile investigation. Same principles as everything else -- what does it access, what does it store, what does it send.'),
  ('mission-w54-02', 1, 'zayn', 'A field-reporting app asking for contacts, precise location in the background, and access to nearby device discovery. None of that fits its job.'),
  ('mission-w54-03', 1, 'byte', 'Local storage on the device is holding an authentication token, completely unencrypted, sitting right next to the app''s cached images.'),
  ('mission-w54-04', 1, 'zayn', 'Captured traffic shows exactly what leaves this phone -- and exactly how little of it is actually protected.'),
  ('mission-w54-05', 1, 'ava', 'A deep link is supposed to open one specific screen. This one can be crafted to do something else entirely.'),
  ('mission-w54-06', 1, 'zayn', 'Put it all together. How does this app actually expose a device credential, start to finish?'),
  ('mission-w54-06', 2, 'byte', '...Full path confirmed: excessive permissions grant background location, that location and the plaintext-stored token both leave over an unencrypted connection, and a crafted deep link can trigger the export without the user ever opening the app.'),
  ('mission-w54-06', 3, 'ava', 'Remediation has to fix all three, not just the one that''s easiest to patch.'),
  ('mission-w54-06', 4, 'zayn', 'Done. Permissions trimmed to only what the job needs, token moved into encrypted device storage, traffic forced over TLS, and the deep link now validates its own input before doing anything.'),
  ('mission-w54-06', 5, 'byte', 'One more thing in that traffic capture. This app also talks to nearby industrial sensors, over short-range protocols.'),
  ('mission-w54-06', 6, 'ava', 'Then this doesn''t stop at the phone. It reaches into whatever those sensors are connected to.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w54-01-o1', 'mission-w54-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to investigate the device.'),
  ('mission-w54-02-o1', 'mission-w54-02', 1, 'Find the excessive permission', 'Identify which declared permission has no legitimate purpose for this app.'),
  ('mission-w54-03-o1', 'mission-w54-03', 1, 'Find the exposed credential', 'Identify which locally stored item is a real security exposure.'),
  ('mission-w54-04-o1', 'mission-w54-04', 1, 'Spot the unprotected traffic', 'Identify which captured request sends sensitive data without protection.'),
  ('mission-w54-05-o1', 'mission-w54-05', 1, 'Recognize the deep-link risk', 'Determine what an unvalidated deep link parameter allows an attacker to do.'),
  ('mission-w54-06-o1', 'mission-w54-06', 1, 'Trace the full exposure path', 'Order the complete path from excessive permission to exposed credential.'),
  ('mission-w54-06-o2', 'mission-w54-06', 2, 'Choose the complete remediation', 'Select the remediation set that fixes every step of the path.'),
  ('mission-w54-06-o3', 'mission-w54-06', 3, 'Confirm the remediation', 'Confirm the exposure path and the remediation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w54-01-o1-c1', 'mission-w54-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"Our first real mobile investigation. Ready to see what this app actually does?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w54-02-o1-c1', 'mission-w54-02-o1', 1, 'code_debugging', 'Which declared permission has no legitimate purpose for a field-reporting app?', '{"language":"xml","code":"<uses-permission android:name=\"android.permission.CAMERA\" />\n<uses-permission android:name=\"android.permission.INTERNET\" />\n<uses-permission android:name=\"android.permission.READ_CONTACTS\" />\n<uses-permission android:name=\"android.permission.ACCESS_BACKGROUND_LOCATION\" />","question":"Which permission is unjustified, and why?"}'::jsonb, '{"requiredLineIds":["<uses-permission android:name=\"android.permission.READ_CONTACTS\" />"]}'::jsonb),

  ('mission-w54-03-o1-c1', 'mission-w54-03-o1', 1, 'investigation', 'Which locally stored item is a real security exposure?', '{"evidence":[{"id":"s1","label":"Cached image thumbnails","detail":"Stored unencrypted, but contain nothing sensitive -- just UI assets"},{"id":"s2","label":"Authentication token","detail":"Stored in plaintext in the app''s shared preferences file, readable by any process with device-level file access on a rooted device"}],"question":"Which item is the real exposure?"}'::jsonb, '{"requiredEvidenceIds":["s2"]}'::jsonb),

  ('mission-w54-04-o1-c1', 'mission-w54-04-o1', 1, 'browser_simulation', 'Which captured request sends sensitive data without protection?', '{"screen":"traffic-capture-viewer","requests":[{"id":"r1","label":"GET https://cdn.example.com/app-icon.png","detail":"Plain HTTP, but only fetches a public icon"},{"id":"r2","label":"POST http://api.example-field.net/sync","detail":"Plain HTTP (not HTTPS), request body includes the device location and the auth token"}],"question":"Which request is the exposure?"}'::jsonb, '{"correctOptionId":"r2"}'::jsonb),

  ('mission-w54-05-o1-c1', 'mission-w54-05-o1', 1, 'multiple_choice', 'The app''s deep link handler accepts a "redirect" parameter and loads it directly in a WebView with no validation. What does this allow?', '{"question":"The app''s deep link handler accepts a \"redirect\" parameter and loads it directly in a WebView with no validation. What does this allow?","options":[{"id":"a","text":"Nothing -- deep links can only open screens inside the app"},{"id":"b","text":"An attacker can craft a link that loads an attacker-controlled page inside the app''s WebView, potentially with access to the app''s own storage and session"},{"id":"c","text":"It only affects which icon is shown"},{"id":"d","text":"Deep links can''t carry parameters"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w54-06-o1-c1', 'mission-w54-06-o1', 1, 'interactive_diagram', 'Order the complete path from excessive permission to exposed credential.', '{"hotspots":[{"id":"permission","label":"App is granted background location access it doesn''t need","explanation":"An unnecessary capability that becomes an exposure vector."},{"id":"storage","label":"Auth token stored in plaintext in shared preferences","explanation":"A second, independent exposure sitting on the same device."},{"id":"network","label":"Location and token sent together over plain HTTP","explanation":"Turns two local exposures into something interceptable over the network."},{"id":"deeplink","label":"A crafted deep link can trigger the sync (and the exposure) without the user opening the app","explanation":"Removes the need for the victim to do anything at all."}],"task":"Order the complete exposure path."}'::jsonb, '{"correctOrderIds":["permission","storage","network","deeplink"]}'::jsonb),

  ('mission-w54-06-o2-c1', 'mission-w54-06-o2', 1, 'drag_and_drop', 'Match each remediation to the step of the exposure path it fixes.', '{"items":[{"id":"f1","text":"Remove unnecessary permissions, request only what the current task needs"},{"id":"f2","text":"Move the auth token into the platform''s encrypted keystore/keychain"},{"id":"f3","text":"Enforce TLS for every network request, reject plaintext HTTP"},{"id":"f4","text":"Validate and allow-list deep-link parameters before loading anything in a WebView"}],"targets":[{"id":"permission_fix","label":"Excessive permission"},{"id":"storage_fix","label":"Plaintext storage"},{"id":"network_fix","label":"Unprotected network traffic"},{"id":"deeplink_fix","label":"Unvalidated deep link"}]}'::jsonb, '{"correctMapping":{"f1":"permission_fix","f2":"storage_fix","f3":"network_fix","f4":"deeplink_fix"}}'::jsonb),

  ('mission-w54-06-o3-c1', 'mission-w54-06-o3', 1, 'boss_encounter', 'Confirm the exposure path and the complete remediation together.', '{"stages":[{"objectiveRef":"mission-w54-06-o1","label":"The exposure path"},{"objectiveRef":"mission-w54-06-o2","label":"The remediation for each step"}],"task":"Confirm the exposure path and the complete remediation together."}'::jsonb, '{"requiredObjectiveIds":["mission-w54-06-o1","mission-w54-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w54-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w54-02-o1-c1', 'orientation', 'Ask what a field-reporting app actually needs to do its job -- take photos, upload them, know where it is.', 15, 1),
  ('mission-w54-02-o1-c1', 'solution', 'READ_CONTACTS has nothing to do with field reporting -- camera, internet and location at least map to plausible features, but contacts access is unjustified.', 25, 2),

  ('mission-w54-03-o1-c1', 'orientation', 'Ask which of these two items would actually matter if someone else read it off the device.', 15, 1),
  ('mission-w54-03-o1-c1', 'solution', 'The plaintext auth token (s2) is the real exposure -- cached UI images are harmless even unencrypted.', 25, 2),

  ('mission-w54-04-o1-c1', 'orientation', 'Compare what each request sends against how it''s protected in transit.', 15, 1),
  ('mission-w54-04-o1-c1', 'solution', 'The sync request (r2) sends location and the auth token over plain HTTP -- anyone on the same network can read it. The icon request (r1) carries nothing sensitive.', 25, 2),

  ('mission-w54-05-o1-c1', 'orientation', 'Ask what a WebView can normally access once something is loaded inside it.', 15, 1),
  ('mission-w54-05-o1-c1', 'solution', 'Loading an unvalidated URL directly into the app''s own WebView can expose that WebView''s access to the app''s storage and session to attacker-controlled content. Option b.', 25, 2),

  ('mission-w54-06-o1-c1', 'orientation', 'Start with the capability that had no reason to be granted in the first place.', 15, 1),
  ('mission-w54-06-o1-c1', 'concept', 'Each finding built on the last: an unneeded permission enabled data collection, plaintext storage exposed the token sitting locally, unprotected traffic exposed both over the network, and the deep link removed the need for user interaction.', 25, 2),
  ('mission-w54-06-o1-c1', 'solution', 'Excessive permission -> plaintext token storage -> unprotected network transmission -> deep link that triggers it all without user interaction.', 35, 3),

  ('mission-w54-06-o2-c1', 'orientation', 'Match each fix to the specific step it closes, not to the exposure as a whole.', 15, 1),
  ('mission-w54-06-o2-c1', 'solution', 'Trim permissions, move the token into encrypted keystore storage, enforce TLS, and validate deep-link parameters -- one fix per step of the chain.', 25, 2),

  ('mission-w54-06-o3-c1', 'orientation', 'You''ve already traced the path and matched the fixes -- combine them.', 20, 1),
  ('mission-w54-06-o3-c1', 'solution', 'The path runs from an unnecessary background-location permission, through a plaintext-stored auth token, to both being sent over plain HTTP and reachable via an unvalidated deep link -- each step now closed by trimmed permissions, encrypted storage, enforced TLS, and validated deep-link handling.', 35, 2);
