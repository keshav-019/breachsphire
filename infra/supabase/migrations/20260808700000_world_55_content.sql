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

