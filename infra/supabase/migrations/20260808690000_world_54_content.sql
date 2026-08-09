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

