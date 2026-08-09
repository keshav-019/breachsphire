-- world-48 ("Cloud Fundamentals: Above the Datacenter") mission content,
-- generated from docs/12-world-story-bible.md. Opens Act 7 "Cloudfall".
-- Mission 1 is cross-world-gated on world-47's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-48a', 'world-48', 'above-the-datacenter', '48A - Above the Datacenter', 'The map stops being physical. Regions, accounts, IAM and ephemeral compute replace racks and cable runs.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-48a-1', 'campaign-48a', 'foundations', 'Foundations', 'Shared responsibility, core services and the cloud architecture map, learned from scratch.', 1),
  ('operation-48a-2', 'campaign-48a', 'investigation', 'Investigation', 'Trace one Sentinel-X component across ephemeral cloud resources without assuming a single server.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w48-01', 'world-48', 'campaign-48a', 'operation-48a-1', 'no-server-to-trace', 'No Server to Trace', 'The adversary map pointed at cloud regions, CI/CD systems and edge devices. There is no rack to walk up to anymore.', 'intro', ARRAY['ava', 'zayn', 'byte'], '{"requiredMissionIds":["mission-w47-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w48-02', 'world-48', 'campaign-48a', 'operation-48a-1', 'whose-job-is-it', 'Whose Job Is It', 'The provider secures the floor the building sits on. You still have to lock your own door.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w48-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"shared-responsibility-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w48-03', 'world-48', 'campaign-48a', 'operation-48a-1', 'reading-the-new-map', 'Reading the New Map', 'Compute, storage, network and identity, redrawn as cloud services. Same concepts, unfamiliar shapes.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w48-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"cloud-architecture-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w48-04', 'world-48', 'campaign-48a', 'operation-48a-2', 'the-policy-that-trusts-everything', 'The Policy That Trusts Everything', 'A single IAM policy, written once and forgotten, turned out to be the widest door in the whole account.', 'intermediate', ARRAY['zayn', 'ava'], '{"requiredMissionIds":["mission-w48-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"iam-policy-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w48-05', 'world-48', 'campaign-48a', 'operation-48a-2', 'a-thing-that-existed-for-nine-minutes', 'A Thing That Existed for Nine Minutes', 'A compute instance spun up, did something, and tore itself down before anyone could log in to look at it. The logs are the only body left.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w48-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"cloudtrail-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w48-06', 'world-48', 'campaign-48a', 'operation-48a-2', 'find-the-workload-boss', 'Find the Workload', 'Trace one Sentinel-X component across ephemeral cloud resources, start to finish, without ever assuming a single server holds the answer.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w48-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"find-the-workload-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["find-the-workload"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w48-01', 1, 'ava', 'The adversary map from the last world pointed somewhere new -- cloud regions, CI/CD systems, edge devices. Nothing you can walk up to and unplug.'),
  ('mission-w48-01', 2, 'zayn', 'That''s the part that''s going to feel wrong at first. A workload can exist for nine minutes, do its damage, and vanish. No rack. No blinking light.'),
  ('mission-w48-01', 3, 'byte', 'Everything you already know still applies -- compute, storage, network, identity. It just doesn''t live in a building you can see.'),
  ('mission-w48-01', 4, 'ava', 'We rebuild the map in cloud terms before we chase anything through it. Ready?'),
  ('mission-w48-02', 1, 'zayn', 'Shared responsibility, in one sentence: the provider secures the cloud, you secure what you put in it. Mixing those up is how half of cloud breaches happen.'),
  ('mission-w48-03', 1, 'byte', 'Compute, storage, database, network, identity -- same five categories as any datacenter. Match each cloud service to what it actually is.'),
  ('mission-w48-04', 1, 'zayn', 'Somebody wrote an IAM policy with a wildcard action on a wildcard resource, years ago, to unblock a demo. Nobody ever tightened it back up.'),
  ('mission-w48-04', 2, 'ava', 'That policy is attached to an automation identity that''s still active today. Find out exactly what it can touch.'),
  ('mission-w48-05', 1, 'byte', 'A compute instance appeared in an unused region, ran for nine minutes, and tore itself down. All that''s left is what the audit log captured.'),
  ('mission-w48-06', 1, 'ava', 'Trace this Sentinel-X component from creation to teardown. Every step it took across the account, in order.'),
  ('mission-w48-06', 2, 'zayn', '...There it is. The whole chain traces back to one deployment, and it wasn''t a person who triggered it.'),
  ('mission-w48-06', 3, 'byte', 'The workload was deployed from infrastructure-as-code, owned by an automation identity that''s been compromised.'),
  ('mission-w48-06', 4, 'ava', 'Someone -- or something -- has been quietly redeploying itself through your own deployment pipeline this whole time.'),
  ('mission-w48-06', 5, 'zayn', 'Concepts are done. Now we go find out exactly what''s wrong with this account, for real.');

