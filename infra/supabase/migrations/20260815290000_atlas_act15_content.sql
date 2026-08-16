-- Atlas Division pathway ("The Silence") Act 15 -- "State of the
-- World" content, under world-atlas-state-of-the-world (already
-- inserted separately). 1 campaign, 2 operations, 12 missions (11
-- lessons + boss), continuing World V "The Terraform Expanse".
--
-- Same terminal-engine constraint as Acts 4-14 -- every Terraform
-- artifact here is static seeded text read via `cat`. Three hosts, all
-- reused: `atlas-devbox-01` (repo/module files), `atlas-terraform-01`
-- (lock logs, workspace list, import/state output, first introduced in
-- Act 14), and `atlas-aws-live-01` (live AWS inventory used to confirm
-- the boss's infrastructure is genuinely fine, first introduced in Act
-- 12). Purely conceptual topics stay multiple_choice only where no
-- natural artifact exists -- this Act leans almost entirely
-- terminal_simulation since nearly every advanced Terraform topic has
-- a real file or command output behind it.
--
-- Narrative thread: missions 1-2 (remote state, locking) set up the
-- migration Rook is mid-way through. Missions 3-4 (modules, module
-- interfaces) formalize Acts 10-13's hand-copied region resources into
-- one reusable module. Mission 10 (secrets in state) is a genuine
-- pathway callback -- a third, mechanically distinct kind of secret
-- exposure after Act 6 (a hardcoded git commit) and Act 11 (a static
-- IAM credential): Terraform state stores every resource attribute in
-- plaintext by default, including values marked sensitive on screen.
-- The boss reveals the newest module (the Act 12/13 serverless
-- pieces) had not been migrated to the remote backend yet when the
-- one laptop holding its local state died -- the exact scenario
-- missions 1-2 were teaching how to prevent, now landing for real.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-state-of-the-world', 'world-atlas-state-of-the-world', 'state-of-the-world', '5B - State of the World', 'Learn advanced Terraform -- remote state, state locking, modules, module interfaces, workspaces, data sources, import, lifecycle, for_each and count, secrets in state, and module versioning -- while Rook''s state migration reaches the one module that was not finished in time.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-state-of-the-world-1', 'campaign-atlas-state-of-the-world', 'sharing-the-source-of-truth', 'Sharing the Source of Truth', 'Remote state, state locking, modules, module interfaces, workspaces and data sources.', 1),
  ('operation-atlas-state-of-the-world-2', 'campaign-atlas-state-of-the-world', 'when-the-record-itself-goes-missing', 'When the Record Itself Goes Missing', 'Import, lifecycle, for_each and count, secrets in state, and module versioning.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-state-of-the-world-01', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-1', 'remote-state', 'Remote State', 'Rook starts migrating every workspace to a shared, locked backend -- the core region first.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"remote-state-sim"}'::jsonb, '{"xp":300,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-state-of-the-world-02', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-1', 'state-locking', 'State Locking', 'Confirm what actually stops two people from applying against the same state at the exact same moment.', 'beginner', ARRAY['rook','vey'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"state-locking-sim"}'::jsonb, '{"xp":300,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-state-of-the-world-03', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-1', 'modules', 'Modules', 'Confirm that every resource hand-copied across Acts 10-13 is now one reusable module.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"modules-sim"}'::jsonb, '{"xp":310,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-state-of-the-world-04', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-1', 'module-interfaces', 'Module Interfaces', 'Confirm exactly what this module actually expects as input, and what it promises back.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"module-interfaces-sim"}'::jsonb, '{"xp":310,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-state-of-the-world-05', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-1', 'workspaces', 'Workspaces', 'Confirm how one configuration manages two completely separate regions without duplicating a single file.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"workspaces-sim"}'::jsonb, '{"xp":320,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-state-of-the-world-06', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-1', 'data-sources', 'Data Sources', 'Confirm how this configuration reads something it does not actually manage or create.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"data-sources-sim"}'::jsonb, '{"xp":320,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-state-of-the-world-07', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-2', 'import', 'Import', 'Confirm how a resource that already existed in AWS got brought under Terraform''s management without ever being recreated.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"import-sim"}'::jsonb, '{"xp":330,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-state-of-the-world-08', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-2', 'lifecycle', 'Lifecycle', 'Confirm what actually refuses to let this specific resource ever be destroyed, even by accident.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"lifecycle-sim"}'::jsonb, '{"xp":330,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-state-of-the-world-09', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-2', 'for-each-count', 'for_each / count', 'Confirm what actually replaced two nearly-identical hand-copied resource blocks from Act 12.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"for-each-count-sim"}'::jsonb, '{"xp":330,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-state-of-the-world-10', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-2', 'secrets-in-state', 'Secrets in State', 'Confirm what a routine scan of the state file itself just found, and understand why this is a different kind of leak entirely.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"secrets-in-state-sim"}'::jsonb, '{"xp":340,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-state-of-the-world-11', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-2', 'module-versioning', 'Module Versioning', 'Confirm this module is actually pinned, so nobody''s changes upstream silently change this region.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"module-versioning-sim"}'::jsonb, '{"xp":340,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-state-of-the-world-12', 'world-atlas-state-of-the-world', 'campaign-atlas-state-of-the-world', 'operation-atlas-state-of-the-world-2', 'the-lost-state', 'The Lost State', 'Everything this Act taught, turned on one missing file: not to panic and rebuild from scratch, to finally explain how infrastructure can be completely fine while Terraform''s own record of it is simply gone.', 'boss', ARRAY['rook','vey','leena','byte'], '{"requiredMissionIds":["mission-atlas-state-of-the-world-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"lost-state-boss-sim"}'::jsonb, '{"xp":580,"credits":135,"badgeIds":["the-lost-state"],"skillXp":{"cloud_devops_fundamentals":100}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-state-of-the-world-01', 1, 'leena', 'Rook is migrating every workspace to a shared, locked remote backend, module by module -- the core region first.'),
  ('mission-atlas-state-of-the-world-01', 2, 'rook', 'A local state file only ever lives on one machine. Remote state puts it somewhere shared, versioned, and durable instead -- no single laptop is a point of failure for it anymore. Confirm this backend is actually configured.'),

  ('mission-atlas-state-of-the-world-02', 1, 'vey', 'Tomas Vey. I nearly ran an apply at the same moment Rook did last week. Confirm what actually stopped that from corrupting the same state file at once.'),
  ('mission-atlas-state-of-the-world-02', 2, 'rook', 'A lock. Whoever acquires it first runs their apply; everyone else waits until it releases. Without one, two concurrent writes to the same state file is exactly how you lose track of what is real.'),

  ('mission-atlas-state-of-the-world-03', 1, 'rook', 'Every resource hand-copied across Acts 10 through 13 is now one reusable module. Confirm it.'),

  ('mission-atlas-state-of-the-world-04', 1, 'rook', 'A module is a black box to whoever calls it -- confirm exactly what it actually expects as input, and what it promises to hand back.'),

  ('mission-atlas-state-of-the-world-05', 1, 'rook', 'One configuration, two workspaces, two completely separate states -- us-east and eu-west, without a single duplicated file between them. Confirm how that actually works.'),

  ('mission-atlas-state-of-the-world-06', 1, 'rook', 'Not everything this configuration references was created by it. A data source reads something that already exists, read-only, without ever trying to manage it.'),

  ('mission-atlas-state-of-the-world-07', 1, 'rook', 'Sometimes a resource exists in AWS before Terraform ever knows about it. Import brings it under management without recreating it from scratch. Confirm how that actually happened here.'),

  ('mission-atlas-state-of-the-world-08', 1, 'rook', 'Some resources should never be destroyed by accident, no matter what the rest of a plan says. Confirm what actually enforces that for this one.'),

  ('mission-atlas-state-of-the-world-09', 1, 'rook', 'Two nearly-identical hand-copied resource blocks from Act 12 do not need to exist twice. Confirm what replaced them with one.'),

  ('mission-atlas-state-of-the-world-10', 1, 'cross', 'Imani Cross. A routine scan just flagged something in the state file itself. Confirm what it actually found.'),
  ('mission-atlas-state-of-the-world-10', 2, 'rook', 'This is not Act 6 again, and it is not Act 11 again either. Terraform state stores every attribute in plaintext by default, including anything marked sensitive on screen -- a completely different mechanism, and the state file itself needs protecting because of it.'),

  ('mission-atlas-state-of-the-world-11', 1, 'rook', 'A module that can change underneath you without warning is not actually reusable, it is a liability. Confirm this one is pinned to a specific version.'),

  ('mission-atlas-state-of-the-world-12', 1, 'leena', 'Everything this Act taught you, on one missing file. Not to panic and rebuild everything from scratch -- to finally explain how the infrastructure can be completely fine while Terraform''s own record of it is simply gone.'),
  ('mission-atlas-state-of-the-world-12', 2, 'vey', 'My laptop. It held the only local state for the serverless module -- the newest one, the one that had not gotten its turn in the migration yet. It is gone.'),
  ('mission-atlas-state-of-the-world-12', 3, 'byte', 'I have the live AWS inventory and the state status both pulled up together. Nothing in AWS itself has changed at all.'),
  ('mission-atlas-state-of-the-world-12', 4, 'rook', 'Then this was never an outage. Confirm what is actually still running, confirm what Terraform actually lost track of, and explain how to bring the two back into agreement.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-state-of-the-world-01-o1', 'mission-atlas-state-of-the-world-01', 1, 'Read the remote backend config', 'Read the backend configuration and submit the verification code.'),

  ('mission-atlas-state-of-the-world-02-o1', 'mission-atlas-state-of-the-world-02', 1, 'Read the lock log', 'Read the state lock log and submit the verification code.'),

  ('mission-atlas-state-of-the-world-03-o1', 'mission-atlas-state-of-the-world-03', 1, 'Read the region module', 'Read the module call and submit the verification code.'),

  ('mission-atlas-state-of-the-world-04-o1', 'mission-atlas-state-of-the-world-04', 1, 'Read the module interface', 'Read the module''s inputs and outputs and submit the verification code.'),

  ('mission-atlas-state-of-the-world-05-o1', 'mission-atlas-state-of-the-world-05', 1, 'Read the workspace list', 'Read the workspace list and submit the verification code.'),

  ('mission-atlas-state-of-the-world-06-o1', 'mission-atlas-state-of-the-world-06', 1, 'Read the data source', 'Read the data source definition and submit the verification code.'),

  ('mission-atlas-state-of-the-world-07-o1', 'mission-atlas-state-of-the-world-07', 1, 'Read the import log', 'Read the import command output and submit the verification code.'),

  ('mission-atlas-state-of-the-world-08-o1', 'mission-atlas-state-of-the-world-08', 1, 'Read the lifecycle rule', 'Read the lifecycle block and submit the verification code.'),

  ('mission-atlas-state-of-the-world-09-o1', 'mission-atlas-state-of-the-world-09', 1, 'Read the for_each resource', 'Read the for_each resource definition and submit the verification code.'),

  ('mission-atlas-state-of-the-world-10-o1', 'mission-atlas-state-of-the-world-10', 1, 'Read the state secret scan', 'Read the state secret scan and submit the verification code.'),

  ('mission-atlas-state-of-the-world-11-o1', 'mission-atlas-state-of-the-world-11', 1, 'Read the module version pin', 'Read the module version pin and submit the verification code.'),

  ('mission-atlas-state-of-the-world-12-o1', 'mission-atlas-state-of-the-world-12', 1, 'Confirm the infrastructure is still live', 'Read the live AWS inventory and submit the verification code.'),
  ('mission-atlas-state-of-the-world-12-o2', 'mission-atlas-state-of-the-world-12', 2, 'Confirm the state is actually lost', 'Read the state status and submit the verification code.'),
  ('mission-atlas-state-of-the-world-12-o3', 'mission-atlas-state-of-the-world-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why this specific module''s state was lost.'),
  ('mission-atlas-state-of-the-world-12-o4', 'mission-atlas-state-of-the-world-12', 4, 'State the diagnosis', 'Having confirmed all three, explain how to bring Terraform and reality back into agreement.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-state-of-the-world-01-o1-c1', 'mission-atlas-state-of-the-world-01-o1', 1, 'terminal_simulation', 'Read the backend configuration and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/backend.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/backend.tf":{"type":"file","content":"terraform {\n  backend \"s3\" {\n    bucket = \"atlas-terraform-state\"\n    key    = \"region-one/terraform.tfstate\"\n    region = \"us-east-1\"\n    dynamodb_table = \"atlas-terraform-locks\"\n  }\n}\n# state now lives in one shared, versioned place instead of on any one laptop\n# verification REMOTESTATE-3312\n"}}}'::jsonb, '{"requiredFlag":"REMOTESTATE-3312"}'::jsonb),

  ('mission-atlas-state-of-the-world-02-o1-c1', 'mission-atlas-state-of-the-world-02-o1', 1, 'terminal_simulation', 'Read the state lock log and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/lock-log.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/lock-log.txt":{"type":"file","content":"lock acquired: LockID=a1b2c3d4  operation=apply  holder=rook  2026-08-16T09:00:00\n(second apply from vey blocked until the lock releases -- 09:00:41)\nlock released: 09:00:52\n# without this, two concurrent applies could corrupt the same state file at once\n# verification LOCK-6602\n"}}}'::jsonb, '{"requiredFlag":"LOCK-6602"}'::jsonb),

  ('mission-atlas-state-of-the-world-03-o1-c1', 'mission-atlas-state-of-the-world-03-o1', 1, 'terminal_simulation', 'Read the module call and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/region-module-call.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/region-module-call.tf":{"type":"file","content":"module \"eu_west\" {\n  source      = \"./modules/region\"\n  region_name = \"eu-west-1\"\n  vpc_cidr    = \"10.40.0.0/16\"\n}\n# the exact same resources built by hand across Acts 10-13, now one reusable module\n# verification MODULE-7714\n"}}}'::jsonb, '{"requiredFlag":"MODULE-7714"}'::jsonb),

  ('mission-atlas-state-of-the-world-04-o1-c1', 'mission-atlas-state-of-the-world-04-o1', 1, 'terminal_simulation', 'Read the module''s inputs and outputs and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/modules/region/interface.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/modules/region/interface.txt":{"type":"file","content":"module \"region\" interface:\n  inputs:  region_name, vpc_cidr, instance_count\n  outputs: vpc_id, load_balancer_dns, collector_instance_ids\n# verification INTERFACE-4471\n"}}}'::jsonb, '{"requiredFlag":"INTERFACE-4471"}'::jsonb),

  ('mission-atlas-state-of-the-world-05-o1-c1', 'mission-atlas-state-of-the-world-05-o1', 1, 'terminal_simulation', 'Read the workspace list and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/workspace-list.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/workspace-list.txt":{"type":"file","content":"terraform workspace list:\n  default\n  us-east   (state for the original region)\n* eu-west   (state for Region One)\n# one configuration, multiple isolated state instances -- no duplicated code per region\n# verification WORKSPACE-8802\n"}}}'::jsonb, '{"requiredFlag":"WORKSPACE-8802"}'::jsonb),

  ('mission-atlas-state-of-the-world-06-o1-c1', 'mission-atlas-state-of-the-world-06-o1', 1, 'terminal_simulation', 'Read the data source definition and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/data.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/data.tf":{"type":"file","content":"data \"aws_ami\" \"base_image\" {\n  filter {\n    name   = \"name\"\n    values = [\"atlas-image-v13.0.0\"]\n  }\n}\n# a read-only lookup of a resource this config does not manage or create\n# verification DATASOURCE-2291\n"}}}'::jsonb, '{"requiredFlag":"DATASOURCE-2291"}'::jsonb),

  ('mission-atlas-state-of-the-world-07-o1-c1', 'mission-atlas-state-of-the-world-07-o1', 1, 'terminal_simulation', 'Read the import command output and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/import-log.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/import-log.txt":{"type":"file","content":"$ terraform import aws_s3_bucket.legacy_logs atlas-eu-west-legacy-logs\naws_s3_bucket.legacy_logs: Import prepared\naws_s3_bucket.legacy_logs: Refreshing state...\nImport successful!\n# brings a resource that already existed in AWS under Terraform management, without recreating it\n# verification IMPORT-9012\n"}}}'::jsonb, '{"requiredFlag":"IMPORT-9012"}'::jsonb),

  ('mission-atlas-state-of-the-world-08-o1-c1', 'mission-atlas-state-of-the-world-08-o1', 1, 'terminal_simulation', 'Read the lifecycle block and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/lifecycle.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/lifecycle.tf":{"type":"file","content":"resource \"aws_db_instance\" \"eu_west_replica\" {\n  lifecycle {\n    prevent_destroy = true\n  }\n}\n# refuses to let terraform destroy this resource, even accidentally\n# verification LIFECYCLE-3390\n"}}}'::jsonb, '{"requiredFlag":"LIFECYCLE-3390"}'::jsonb),

  ('mission-atlas-state-of-the-world-09-o1-c1', 'mission-atlas-state-of-the-world-09-o1', 1, 'terminal_simulation', 'Read the for_each resource definition and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/instances-for-each.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/instances-for-each.tf":{"type":"file","content":"resource \"aws_instance\" \"collector\" {\n  for_each = toset([\"eu-west-1a\", \"eu-west-1b\"])\n  availability_zone = each.value\n}\n# replaces two nearly-identical hand-copied resource blocks from Act 12 with one\n# verification FOREACH-4471\n"}}}'::jsonb, '{"requiredFlag":"FOREACH-4471"}'::jsonb),

  ('mission-atlas-state-of-the-world-10-o1-c1', 'mission-atlas-state-of-the-world-10-o1', 1, 'terminal_simulation', 'Read the state secret scan and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/state-secret-scan.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/state-secret-scan.txt":{"type":"file","content":"scanning terraform.tfstate for plaintext sensitive values...\nFOUND: aws_db_instance.eu_west_replica.password stored in plaintext in state\nnot a leaked commit, not a leaked credential -- Terraform''s own state file stores every attribute in plaintext by default, including values marked sensitive on screen\n# verification SECRETSTATE-8814\n"}}}'::jsonb, '{"requiredFlag":"SECRETSTATE-8814"}'::jsonb),

  ('mission-atlas-state-of-the-world-11-o1-c1', 'mission-atlas-state-of-the-world-11-o1', 1, 'terminal_simulation', 'Read the module version pin and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/region-module-call.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/region-module-call.tf":{"type":"file","content":"module \"eu_west\" {\n  source  = \"atlas.internal/region\"\n  version = \"1.2.0\"\n}\n# pinning a version means an upstream module change never silently changes this region without a deliberate bump\n# verification VERSION-2210\n"}}}'::jsonb, '{"requiredFlag":"VERSION-2210"}'::jsonb),

  ('mission-atlas-state-of-the-world-12-o1-c1', 'mission-atlas-state-of-the-world-12-o1', 1, 'terminal_simulation', 'Read the live AWS inventory and submit the verification code.', '{"instructions":"Read /var/atlas-aws-live/serverless-inventory.txt and submit the verification code with: submit CODE","hostname":"atlas-aws-live-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-aws-live-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-aws-live/serverless-inventory.txt":{"type":"file","content":"live AWS resources (eu-west):\n  lambda function atlas-region-guard-remediate: EXISTS, recently invoked, healthy\n  cloudwatch alarm unrouted-region-guard: EXISTS, OK state\n  sns topic atlas-region-guard-topic: EXISTS\n# nothing in AWS itself has changed at all\n# verification LIVE-9012\n"}}}'::jsonb, '{"requiredFlag":"LIVE-9012"}'::jsonb),
  ('mission-atlas-state-of-the-world-12-o2-c1', 'mission-atlas-state-of-the-world-12-o2', 1, 'terminal_simulation', 'Read the state status and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/serverless-state-status.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/serverless-state-status.txt":{"type":"file","content":"$ terraform state list (serverless workspace)\nError: no state file found at ./serverless/terraform.tfstate\nlast known local state: last modified 2026-08-13, never migrated to the remote backend\n# verification LOSTSTATE-4471\n"}}}'::jsonb, '{"requiredFlag":"LOSTSTATE-4471"}'::jsonb),
  ('mission-atlas-state-of-the-world-12-o3-c1', 'mission-atlas-state-of-the-world-12-o3', 1, 'investigation', 'Which evidence explains why this specific module''s state was lost?', '{"evidence":[{"id":"e1","label":"Live AWS inventory","detail":"Every serverless resource this module manages is confirmed still running, healthy, in AWS"},{"id":"e2","label":"State status","detail":"No state file exists locally, and it was never migrated to the remote backend before being lost"},{"id":"e3","label":"Remote backend config (mission 1)","detail":"The remote backend migration covered the core region module first; the serverless module had not gotten its turn yet"},{"id":"e4","label":"Module versioning notes","detail":"Module version pinning prevents upstream changes from silently affecting a config"}],"question":"Which evidence explains why this specific module''s state was lost?"}'::jsonb, '{"requiredEvidenceIds":["e2","e3"]}'::jsonb),
  ('mission-atlas-state-of-the-world-12-o4-c1', 'mission-atlas-state-of-the-world-12-o4', 1, 'boss_encounter', 'Having confirmed the infrastructure is fine, the state is lost, and what explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-state-of-the-world-12-o1","label":"Confirm the infrastructure is still live"},{"objectiveRef":"mission-atlas-state-of-the-world-12-o2","label":"Confirm the state is actually lost"},{"objectiveRef":"mission-atlas-state-of-the-world-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: nothing about the infrastructure itself was ever at risk -- every serverless resource is still running fine in AWS -- but the module covering it had not been migrated to the remote backend yet when the one laptop holding its only local state was lost, so the fix is to terraform import every one of those resources back under management, then finish the remote-state migration for this module so a single laptop can never be a single point of failure for it again."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-state-of-the-world-12-o1","mission-atlas-state-of-the-world-12-o2","mission-atlas-state-of-the-world-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-state-of-the-world-01-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/backend.tf', 10, 1),
  ('mission-atlas-state-of-the-world-01-o1-c1', 'solution', 'State now lives in a shared S3 bucket with a lock table, verification REMOTESTATE-3312. submit REMOTESTATE-3312', 20, 2),

  ('mission-atlas-state-of-the-world-02-o1-c1', 'orientation', 'Try: cat /var/atlas-terraform/lock-log.txt', 10, 1),
  ('mission-atlas-state-of-the-world-02-o1-c1', 'solution', 'The second apply waited for the lock, verification LOCK-6602. submit LOCK-6602', 20, 2),

  ('mission-atlas-state-of-the-world-03-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/region-module-call.tf', 10, 1),
  ('mission-atlas-state-of-the-world-03-o1-c1', 'solution', 'One module call replaces the hand-copied resources, verification MODULE-7714. submit MODULE-7714', 20, 2),

  ('mission-atlas-state-of-the-world-04-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/modules/region/interface.txt', 10, 1),
  ('mission-atlas-state-of-the-world-04-o1-c1', 'solution', 'Three inputs, three outputs, verification INTERFACE-4471. submit INTERFACE-4471', 20, 2),

  ('mission-atlas-state-of-the-world-05-o1-c1', 'orientation', 'Try: cat /var/atlas-terraform/workspace-list.txt', 10, 1),
  ('mission-atlas-state-of-the-world-05-o1-c1', 'solution', 'eu-west is the active workspace, verification WORKSPACE-8802. submit WORKSPACE-8802', 20, 2),

  ('mission-atlas-state-of-the-world-06-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/data.tf', 10, 1),
  ('mission-atlas-state-of-the-world-06-o1-c1', 'solution', 'It looks up an existing AMI read-only, verification DATASOURCE-2291. submit DATASOURCE-2291', 20, 2),

  ('mission-atlas-state-of-the-world-07-o1-c1', 'orientation', 'Try: cat /var/atlas-terraform/import-log.txt', 10, 1),
  ('mission-atlas-state-of-the-world-07-o1-c1', 'solution', 'The import succeeded without recreating anything, verification IMPORT-9012. submit IMPORT-9012', 20, 2),

  ('mission-atlas-state-of-the-world-08-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/lifecycle.tf', 10, 1),
  ('mission-atlas-state-of-the-world-08-o1-c1', 'solution', 'prevent_destroy is set, verification LIFECYCLE-3390. submit LIFECYCLE-3390', 20, 2),

  ('mission-atlas-state-of-the-world-09-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/instances-for-each.tf', 10, 1),
  ('mission-atlas-state-of-the-world-09-o1-c1', 'solution', 'for_each replaces the duplicated blocks, verification FOREACH-4471. submit FOREACH-4471', 20, 2),

  ('mission-atlas-state-of-the-world-10-o1-c1', 'orientation', 'Try: cat /var/atlas-terraform/state-secret-scan.txt', 10, 1),
  ('mission-atlas-state-of-the-world-10-o1-c1', 'solution', 'A plaintext password was found in state, verification SECRETSTATE-8814. submit SECRETSTATE-8814', 20, 2),

  ('mission-atlas-state-of-the-world-11-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/region-module-call.tf', 10, 1),
  ('mission-atlas-state-of-the-world-11-o1-c1', 'solution', 'The module is pinned to version 1.2.0, verification VERSION-2210. submit VERSION-2210', 20, 2),

  ('mission-atlas-state-of-the-world-12-o1-c1', 'orientation', 'Try: cat /var/atlas-aws-live/serverless-inventory.txt', 10, 1),
  ('mission-atlas-state-of-the-world-12-o1-c1', 'solution', 'Everything is still running, verification LIVE-9012. submit LIVE-9012', 20, 2),
  ('mission-atlas-state-of-the-world-12-o2-c1', 'orientation', 'Try: cat /repo/infra/terraform/serverless-state-status.txt', 10, 1),
  ('mission-atlas-state-of-the-world-12-o2-c1', 'solution', 'No state file was ever migrated, verification LOSTSTATE-4471. submit LOSTSTATE-4471', 20, 2),
  ('mission-atlas-state-of-the-world-12-o3-c1', 'orientation', 'The infrastructure being fine is reassurance, not a cause. Look for what explains why the state specifically could be lost.', 10, 1),
  ('mission-atlas-state-of-the-world-12-o3-c1', 'solution', 'e2 and e3: the state was never migrated, because this module had not gotten its turn in the remote-backend migration yet.', 20, 2),
  ('mission-atlas-state-of-the-world-12-o4-c1', 'orientation', 'Combine what is still live, what is missing, and how to fix both into one sentence.', 15, 1),
  ('mission-atlas-state-of-the-world-12-o4-c1', 'solution', 'The infrastructure is fine -- only the local, unmigrated state was lost -- so import every live resource back under management, then finish migrating this module to the remote backend.', 25, 2);
