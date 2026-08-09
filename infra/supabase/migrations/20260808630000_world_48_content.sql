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

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w48-01-o1', 'mission-w48-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to rebuild the map in cloud terms.'),
  ('mission-w48-02-o1', 'mission-w48-02', 1, 'Sort responsibilities', 'Sort each security responsibility as belonging to the cloud provider or the customer.'),
  ('mission-w48-03-o1', 'mission-w48-03', 1, 'Identify the cloud services', 'Match each hotspot in the cloud architecture diagram to what kind of service it is.'),
  ('mission-w48-04-o1', 'mission-w48-04', 1, 'Find the over-permissive policy', 'Identify which IAM policy statement violates least privilege.'),
  ('mission-w48-05-o1', 'mission-w48-05', 1, 'Trace the ephemeral instance', 'Order the audit-log events for the short-lived compute instance correctly.'),
  ('mission-w48-06-o1', 'mission-w48-06', 1, 'Reconstruct the deployment chain', 'Order the complete chain from IaC deployment to workload teardown.'),
  ('mission-w48-06-o2', 'mission-w48-06', 2, 'Identify the compromised identity', 'Determine which identity actually triggered the deployment.'),
  ('mission-w48-06-o3', 'mission-w48-06', 3, 'Close the trace', 'Confirm the full chain and the compromised identity together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w48-01-o1-c1', 'mission-w48-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"No server to walk up to this time. Ready to rebuild the map?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w48-02-o1-c1', 'mission-w48-02-o1', 1, 'drag_and_drop', 'Sort each responsibility as belonging to the cloud provider or the customer.', '{"items":[{"id":"r1","text":"Physical security of the datacenter"},{"id":"r2","text":"Patching the hypervisor"},{"id":"r3","text":"Configuring IAM policies and roles"},{"id":"r4","text":"Encrypting data before it''s stored"},{"id":"r5","text":"Network ACLs and security groups for your workloads"}],"targets":[{"id":"provider","label":"Cloud Provider"},{"id":"customer","label":"Customer"}]}'::jsonb, '{"correctMapping":{"r1":"provider","r2":"provider","r3":"customer","r4":"customer","r5":"customer"}}'::jsonb),

  ('mission-w48-03-o1-c1', 'mission-w48-03-o1', 1, 'interactive_diagram', 'Match each hotspot in the cloud architecture diagram to what kind of service it is.', '{"hotspots":[{"id":"compute","label":"Virtual machine running the web tier","explanation":"Compute -- the cloud equivalent of a physical server."},{"id":"storage","label":"Object storage bucket holding uploaded files","explanation":"Storage -- durable, scalable, accessed over an API rather than a filesystem."},{"id":"network","label":"Virtual private network isolating the account''s resources","explanation":"Networking -- the software-defined equivalent of VLANs and routers."},{"id":"identity","label":"Role attached to an automation pipeline","explanation":"Identity -- who or what is allowed to do what, the thing that replaces a physical badge."},{"id":"serverless","label":"Function that runs only when triggered, with no server to patch","explanation":"Serverless compute -- the provider manages the runtime entirely."}],"task":"Identify what category of cloud service each hotspot represents."}'::jsonb, '{"correctOrderIds":["compute","storage","network","identity","serverless"]}'::jsonb),

  ('mission-w48-04-o1-c1', 'mission-w48-04-o1', 1, 'browser_simulation', 'Which IAM policy statement violates least privilege?', '{"screen":"iam-policy-viewer","policies":[{"id":"p1","name":"deploy-automation-role","statement":"{\"Effect\":\"Allow\",\"Action\":\"*\",\"Resource\":\"*\"}"},{"id":"p2","name":"read-only-audit-role","statement":"{\"Effect\":\"Allow\",\"Action\":[\"s3:GetObject\",\"logs:Describe*\"],\"Resource\":\"arn:aws:s3:::audit-bucket/*\"}"}],"question":"Which policy statement violates least privilege?"}'::jsonb, '{"correctOptionId":"p1"}'::jsonb),

  ('mission-w48-05-o1-c1', 'mission-w48-05-o1', 1, 'interactive_diagram', 'Order the audit-log events for the short-lived compute instance correctly.', '{"hotspots":[{"id":"e1","label":"IAM role assumed by the automation identity in an unused region","explanation":"The trigger -- credentials used somewhere they normally never appear."},{"id":"e2","label":"Compute instance launched from a custom machine image","explanation":"The instance is created, already carrying whatever it needs to run."},{"id":"e3","label":"Outbound connection to an external endpoint","explanation":"Whatever the instance was built to do, it does quickly."},{"id":"e4","label":"Instance terminated by the same automation identity that created it","explanation":"Self-cleanup -- no instance left behind to inspect directly."}],"task":"Order the audit-log events chronologically."}'::jsonb, '{"correctOrderIds":["e1","e2","e3","e4"]}'::jsonb),

  ('mission-w48-06-o1-c1', 'mission-w48-06-o1', 1, 'interactive_diagram', 'Reconstruct the complete chain from IaC deployment to workload teardown.', '{"hotspots":[{"id":"iac_commit","label":"Infrastructure-as-code template modified and applied","explanation":"Where the deployment actually originates."},{"id":"role_assumed","label":"Automation identity assumes an over-permissive role","explanation":"The wildcard policy from earlier makes this possible."},{"id":"instance_launch","label":"Ephemeral compute instance launched in an unused region","explanation":"Chosen specifically to avoid routine review."},{"id":"outbound","label":"Brief outbound connection, then self-termination","explanation":"In and out before any alert threshold triggers."}],"task":"Order the full chain from deployment to teardown."}'::jsonb, '{"correctOrderIds":["iac_commit","role_assumed","instance_launch","outbound"]}'::jsonb),

  ('mission-w48-06-o2-c1', 'mission-w48-06-o2', 1, 'multiple_choice', 'The IaC template was applied without any human login event around the same time. What does that indicate?', '{"question":"The IaC template was applied without any human login event around the same time. What does that indicate?","options":[{"id":"a","text":"A human just forgot to log the change"},{"id":"b","text":"The automation identity itself is compromised and is redeploying without a human trigger"},{"id":"c","text":"Nothing -- automation runs without humans all the time"},{"id":"d","text":"The logs are corrupted"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w48-06-o3-c1', 'mission-w48-06-o3', 1, 'boss_encounter', 'Confirm the full deployment chain and the compromised identity together.', '{"stages":[{"objectiveRef":"mission-w48-06-o1","label":"The deployment chain"},{"objectiveRef":"mission-w48-06-o2","label":"The compromised identity"}],"task":"Confirm the full deployment chain and the compromised identity together."}'::jsonb, '{"requiredObjectiveIds":["mission-w48-06-o1","mission-w48-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w48-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w48-02-o1-c1', 'orientation', 'Ask who could physically walk into the building versus who wrote the application code.', 15, 1),
  ('mission-w48-02-o1-c1', 'solution', 'Physical security and hypervisor patching are the provider''s job; IAM configuration, data encryption and workload-level network rules are always the customer''s.', 25, 2),

  ('mission-w48-03-o1-c1', 'orientation', 'Ask what problem each piece is actually solving, not what it''s branded as.', 15, 1),
  ('mission-w48-03-o1-c1', 'solution', 'VM = compute, bucket = storage, VPC = networking, pipeline role = identity, trigger-only function = serverless compute.', 25, 2),

  ('mission-w48-04-o1-c1', 'orientation', 'One of these two policies names exactly what it can touch. One doesn''t.', 15, 1),
  ('mission-w48-04-o1-c1', 'solution', 'A wildcard action on a wildcard resource (p1) grants unlimited access -- the audit role (p2) is scoped tightly and is the example of least privilege, not the violation.', 25, 2),

  ('mission-w48-05-o1-c1', 'orientation', 'Start with what had to happen before an instance could even exist.', 15, 1),
  ('mission-w48-05-o1-c1', 'solution', 'Role assumed, instance launched, outbound connection made, instance terminated -- in that order.', 25, 2),

  ('mission-w48-06-o1-c1', 'orientation', 'Start from the code change that started all of this, not from where you first noticed it.', 15, 1),
  ('mission-w48-06-o1-c1', 'concept', 'Each step enabled the next: the IaC change enabled the role assumption, which enabled the instance, which did its work and cleaned up after itself.', 25, 2),
  ('mission-w48-06-o1-c1', 'solution', 'IaC template applied -> role assumed -> ephemeral instance launched -> brief outbound connection and self-termination.', 35, 3),

  ('mission-w48-06-o2-c1', 'orientation', 'Ask what''s missing from the timeline, not what''s present in it.', 15, 1),
  ('mission-w48-06-o2-c1', 'solution', 'No human login event anywhere near the change means the automation identity itself acted on its own -- it''s compromised. Option b.', 25, 2),

  ('mission-w48-06-o3-c1', 'orientation', 'You''ve already reconstructed the chain and identified the compromised identity -- combine them.', 20, 1),
  ('mission-w48-06-o3-c1', 'solution', 'The chain runs from a modified IaC template, through a compromised automation identity assuming an over-permissive role, to an ephemeral instance that connected out and destroyed itself -- all without a single human action anywhere in the sequence.', 35, 2);
