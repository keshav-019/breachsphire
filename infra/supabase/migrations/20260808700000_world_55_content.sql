-- world-55 ("IoT Security: Embedded Secrets") mission content, generated
-- from docs/12-world-story-bible.md. Continues Act 7 "Cloudfall". Mission 1
-- is cross-world-gated on world-54's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-55a', 'world-55', 'embedded-secrets', '55A - Embedded Secrets', 'Sensors across dozens of buildings, all sharing firmware from the same vendor stack -- and the same mistakes.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-55a-1', 'campaign-55a', 'foundations', 'Foundations', 'Firmware filesystems, debug interfaces and wireless protocol traffic, learned through a field-device investigation.', 1),
  ('operation-55a-2', 'campaign-55a', 'investigation', 'Investigation', 'Recover the configuration path in a training firmware image, then design a safe update strategy.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w55-01', 'world-55', 'campaign-55a', 'operation-55a-1', 'the-same-stack-everywhere', 'The Same Stack Everywhere', 'The industrial sensors that phone traced connect to are running firmware from one shared vendor stack, deployed across dozens of buildings.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w54-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w55-02', 'world-55', 'campaign-55a', 'operation-55a-1', 'inside-the-firmware-image', 'Inside the Firmware Image', 'A firmware image extracted from a training device, opened like a filesystem, reveals a configuration file no one meant to ship.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w55-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"firmware-filesystem-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w55-03', 'world-55', 'campaign-55a', 'operation-55a-1', 'pins-left-exposed', 'Pins Left Exposed', 'A debug interface, left active on the production board, gives anyone with physical access a direct line into the device.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w55-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"debug-interface-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w55-04', 'world-55', 'campaign-55a', 'operation-55a-2', 'a-channel-nobody-locked', 'A Channel Nobody Locked', 'Captured MQTT traffic between sensors and their controller shows commands accepted from anyone who can reach the broker, no authentication required.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w55-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"mqtt-traffic-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w55-05', 'world-55', 'campaign-55a', 'operation-55a-2', 'an-update-that-trusts-anything', 'An Update That Trusts Anything', 'The firmware update process accepts a new image without ever checking who signed it.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w55-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"secure-boot-review-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w55-06', 'world-55', 'campaign-55a', 'operation-55a-2', 'embedded-secrets-boss', 'Embedded Secrets', 'Recover the exact configuration path that turns this training firmware image into a working foothold, then design a secure-boot and signed-update strategy that closes it for good.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w55-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"embedded-secrets-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["embedded-secrets"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w55-01', 1, 'ava', 'Those industrial sensors the phone was talking to run firmware from one shared vendor stack, deployed across dozens of buildings.'),
  ('mission-w55-01', 2, 'byte', 'One shared stack means one shared mistake, repeated everywhere it was installed. That''s the pattern to look for.'),
  ('mission-w55-02', 1, 'zayn', 'A firmware image, opened like any other filesystem. There''s a configuration file in here that has no business shipping to a production device.'),
  ('mission-w55-03', 1, 'byte', 'A debug interface, still active on the production board. Anyone with a screwdriver and five minutes has a direct line into this device.'),
  ('mission-w55-04', 1, 'zayn', 'Captured broker traffic. Sensors accept commands from anyone who can reach the broker at all -- no authentication, no device identity check.'),
  ('mission-w55-05', 1, 'ava', 'The update process accepts a new firmware image without ever verifying who signed it. Anyone who can reach the update channel can push whatever they want.'),
  ('mission-w55-06', 1, 'zayn', 'Recover the actual configuration path in this training image. What does the hardcoded secret in that config file actually unlock?'),
  ('mission-w55-06', 2, 'byte', '...Path recovered. That config secret is a shared device key -- the same one on every sensor from this vendor stack. It authenticates to the broker and unlocks the debug interface remotely.'),
  ('mission-w55-06', 3, 'ava', 'One key, every device, no way to rotate it individually. That''s not a bug, that''s a design decision someone made under deadline pressure.'),
  ('mission-w55-06', 4, 'zayn', 'Secure update strategy is designed: unique per-device keys, signed firmware images, and a boot process that refuses to run anything it can''t verify.'),
  ('mission-w55-06', 5, 'byte', 'These sensors don''t just report data. They feed directly into the building and industrial control networks.'),
  ('mission-w55-06', 6, 'ava', 'Then whatever Sentinel-X wanted with them, it wasn''t just the sensor readings.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w55-01-o1', 'mission-w55-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to investigate the shared firmware stack.'),
  ('mission-w55-02-o1', 'mission-w55-02', 1, 'Find the hardcoded secret', 'Identify which file in the firmware filesystem contains a hardcoded secret.'),
  ('mission-w55-03-o1', 'mission-w55-03', 1, 'Recognize the debug interface risk', 'Determine what an exposed, unauthenticated debug interface allows on a production device.'),
  ('mission-w55-04-o1', 'mission-w55-04', 1, 'Spot the unauthenticated channel', 'Identify which captured message shows an unauthenticated command being accepted.'),
  ('mission-w55-05-o1', 'mission-w55-05', 1, 'Find the missing verification step', 'Identify what the update process fails to check before installing a new image.'),
  ('mission-w55-06-o1', 'mission-w55-06', 1, 'Recover the configuration path', 'Trace what the hardcoded secret actually unlocks, end to end.'),
  ('mission-w55-06-o2', 'mission-w55-06', 2, 'Design the secure update strategy', 'Choose the update-strategy design that closes every step of the path.'),
  ('mission-w55-06-o3', 'mission-w55-06', 3, 'Confirm the design', 'Confirm the recovered path and the secure design together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w55-01-o1-c1', 'mission-w55-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"One shared firmware stack, one shared mistake. Ready to find it?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w55-02-o1-c1', 'mission-w55-02-o1', 1, 'investigation', 'Which file in the extracted firmware filesystem contains a hardcoded secret?', '{"evidence":[{"id":"f1","label":"/etc/device_info.txt","detail":"Contains only the model number and firmware version -- no secrets"},{"id":"f2","label":"/etc/mqtt_config.json","detail":"Contains a broker hostname and a device_key field with a plaintext value identical across every unit sampled"}],"question":"Which file holds the hardcoded secret?"}'::jsonb, '{"requiredEvidenceIds":["f2"]}'::jsonb),

  ('mission-w55-03-o1-c1', 'mission-w55-03-o1', 1, 'multiple_choice', 'A UART debug interface is left active and unauthenticated on the production board. What does this allow someone with physical access to do?', '{"question":"A UART debug interface is left active and unauthenticated on the production board. What does this allow someone with physical access to do?","options":[{"id":"a","text":"Nothing -- debug interfaces are disabled automatically outside the factory"},{"id":"b","text":"Read the running firmware, extract secrets from memory, and potentially reflash the device -- all without needing any password"},{"id":"c","text":"Only view the device''s serial number"},{"id":"d","text":"Change the device''s physical color settings"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w55-04-o1-c1', 'mission-w55-04-o1', 1, 'browser_simulation', 'Which captured MQTT message shows an unauthenticated command being accepted?', '{"screen":"mqtt-traffic-viewer","messages":[{"id":"m1","label":"CONNECT from sensor-042, no username/password, broker accepts","detail":"Broker has no authentication configured at all"},{"id":"m2","label":"CONNECT from sensor-042, username \"device\" / password verified against a per-device certificate","detail":"This is what a properly authenticated connection looks like -- not what''s actually happening here"}],"question":"Which message shows the real, currently deployed behavior?"}'::jsonb, '{"correctOptionId":"m1"}'::jsonb),

  ('mission-w55-05-o1-c1', 'mission-w55-05-o1', 1, 'multiple_choice', 'The firmware update process writes any image it receives over the update channel directly to flash. What check is missing?', '{"question":"The firmware update process writes any image it receives over the update channel directly to flash. What check is missing?","options":[{"id":"a","text":"A check on the file size only"},{"id":"b","text":"Cryptographic signature verification against a trusted vendor key before the image is ever written to flash"},{"id":"c","text":"A check that the update happens at night"},{"id":"d","text":"Nothing is missing -- this is normal for firmware updates"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w55-06-o1-c1', 'mission-w55-06-o1', 1, 'interactive_diagram', 'Trace what the hardcoded device_key actually unlocks, end to end.', '{"hotspots":[{"id":"key_found","label":"Hardcoded device_key recovered from the firmware config file","explanation":"The single point of failure, identical on every device."},{"id":"broker_auth","label":"Same key authenticates to the MQTT broker as any sensor","explanation":"One key impersonates every device on the network."},{"id":"debug_unlock","label":"Same key also unlocks the remote debug interface","explanation":"Reused across two completely different subsystems -- authentication and debugging."},{"id":"full_control","label":"Combined access allows reading, spoofing, and reflashing any sensor on the network","explanation":"The end state -- full control over the entire fleet from one recovered key."}],"task":"Order the path from the recovered key to full fleet control."}'::jsonb, '{"correctOrderIds":["key_found","broker_auth","debug_unlock","full_control"]}'::jsonb),

  ('mission-w55-06-o2-c1', 'mission-w55-06-o2', 1, 'drag_and_drop', 'Match each design element to what it fixes.', '{"items":[{"id":"d1","text":"Unique per-device key, provisioned at manufacturing, never shared"},{"id":"d2","text":"Mutual TLS or certificate-based authentication to the broker"},{"id":"d3","text":"Debug interface disabled in production, requiring a physical fuse or signed unlock to re-enable"},{"id":"d4","text":"Secure boot verifying a cryptographic signature before running any firmware image"}],"targets":[{"id":"key_fix","label":"The shared-key problem"},{"id":"broker_fix","label":"The unauthenticated broker"},{"id":"debug_fix","label":"The exposed debug interface"},{"id":"update_fix","label":"The unverified update process"}]}'::jsonb, '{"correctMapping":{"d1":"key_fix","d2":"broker_fix","d3":"debug_fix","d4":"update_fix"}}'::jsonb),

  ('mission-w55-06-o3-c1', 'mission-w55-06-o3', 1, 'boss_encounter', 'Confirm the recovered configuration path and the secure update strategy together.', '{"stages":[{"objectiveRef":"mission-w55-06-o1","label":"The configuration path"},{"objectiveRef":"mission-w55-06-o2","label":"The secure design"}],"task":"Confirm the recovered configuration path and the secure update strategy together."}'::jsonb, '{"requiredObjectiveIds":["mission-w55-06-o1","mission-w55-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w55-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w55-02-o1-c1', 'orientation', 'Ask which file holds a value that''s identical across every device you''ve sampled.', 15, 1),
  ('mission-w55-02-o1-c1', 'solution', 'The MQTT config file (f2) holds a device_key that''s the same plaintext value on every unit -- device_info.txt (f1) has nothing sensitive in it.', 25, 2),

  ('mission-w55-03-o1-c1', 'orientation', 'Debug interfaces exist to give low-level, unrestricted access -- that''s exactly the danger if left unauthenticated.', 15, 1),
  ('mission-w55-03-o1-c1', 'solution', 'An open UART interface gives direct memory and flash access with no password required -- full read and potentially reflash capability. Option b.', 25, 2),

  ('mission-w55-04-o1-c1', 'orientation', 'Ask which message reflects what actually happened on the wire, not what proper behavior would look like.', 15, 1),
  ('mission-w55-04-o1-c1', 'solution', 'm1 is the real captured behavior -- a connection with no credentials, accepted by the broker. m2 describes proper authentication, which isn''t what''s deployed.', 25, 2),

  ('mission-w55-05-o1-c1', 'orientation', 'Ask what stops someone from writing their own firmware image to this device''s flash.', 15, 1),
  ('mission-w55-05-o1-c1', 'solution', 'Without signature verification against a trusted key, the device will flash any image handed to it -- that''s the missing check. Option b.', 25, 2),

  ('mission-w55-06-o1-c1', 'orientation', 'Start from the one thing that''s reused everywhere, and follow everywhere it''s reused.', 15, 1),
  ('mission-w55-06-o1-c1', 'concept', 'A single shared key, reused for two unrelated purposes (broker auth and debug unlock), turns one recovered secret into control over the entire fleet.', 25, 2),
  ('mission-w55-06-o1-c1', 'solution', 'Recovered device_key -> authenticates to the broker as any sensor -> also unlocks the remote debug interface -> combined, gives full read/spoof/reflash control over the fleet.', 35, 3),

  ('mission-w55-06-o2-c1', 'orientation', 'Match each fix to the specific weakness it removes, not to security in general.', 15, 1),
  ('mission-w55-06-o2-c1', 'solution', 'Per-device keys remove the shared-secret problem, certificate-based broker auth removes anonymous access, a disabled-by-default debug interface removes physical exposure, and secure boot removes unverified updates.', 25, 2),

  ('mission-w55-06-o3-c1', 'orientation', 'You''ve already traced the path and matched the design -- combine them.', 20, 1),
  ('mission-w55-06-o3-c1', 'solution', 'One shared device_key authenticates to the broker and unlocks the debug interface fleet-wide -- the secure design replaces it with unique per-device keys, certificate-based broker authentication, a disabled-by-default debug interface, and secure boot with signature verification.', 35, 2);
