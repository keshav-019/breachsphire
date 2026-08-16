-- Atlas Division pathway ("The Silence") Act 14 -- "Infrastructure as
-- Code" content, under world-atlas-infrastructure-as-code (already
-- inserted separately). 1 campaign, 2 operations, 12 missions (11
-- lessons + boss), opening World V "The Terraform Expanse" (Acts
-- 14-15).
--
-- Same terminal-engine constraint as Acts 4-13 -- every Terraform
-- artifact here is static seeded text read via `cat`. Two hosts: the
-- reused `atlas-devbox-01` for real .tf files under
-- /repo/infra/terraform/, and a new `atlas-terraform-01` for plan/apply
-- output and the state file itself -- the actual system of record,
-- distinct from the declared config. Only "destroy" (a pure, high-
-- stakes concept worth teaching without an in-fiction encouragement to
-- actually run it) stays multiple_choice.
--
-- Narrative thread: missions 1-6 formalize HCL, providers, resources,
-- variables and outputs -- the exact things every prior Act's text
-- files were only ever pretending to be. Mission 7 (plan) and 8
-- (apply) teach the mechanic safely on one small, explainable diff
-- before the boss's much larger reveal. The boss cross-references a
-- full-fleet `terraform plan` against the incident history from Acts
-- 9, 12 and 13, landing the world's story_reveal verbatim: every
-- drifted resource traces back to a legitimate, justified emergency
-- console fix, never written back into config, because nothing was
-- ever really enforcing that until this Act.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-infrastructure-as-code', 'world-atlas-infrastructure-as-code', 'infrastructure-as-code', '5A - Infrastructure as Code', 'Learn Terraform from first principles -- why IaC, HCL, providers, resources, variables, outputs, plan, apply, destroy, state and the dependency graph -- while Rook formalizes Region One into real code and the first real plan reveals drift everywhere.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-infrastructure-as-code-1', 'campaign-atlas-infrastructure-as-code', 'writing-it-for-real', 'Writing It For Real', 'Why IaC, HCL, providers, resources, variables and outputs.', 1),
  ('operation-atlas-infrastructure-as-code-2', 'campaign-atlas-infrastructure-as-code', 'what-the-code-actually-controls', 'What the Code Actually Controls', 'Plan, apply, destroy, state and the dependency graph.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-infrastructure-as-code-01', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-1', 'why-iac', 'Why IaC', 'Every resource in Region One has existed only as prose written to look like infrastructure code. Rook starts converting it into the real thing.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"why-iac-sim"}'::jsonb, '{"xp":250,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-infrastructure-as-code-02', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-1', 'hcl', 'HCL', 'Confirm what real Terraform syntax actually looks like, compared to everything read as prose since Act 10.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"hcl-sim"}'::jsonb, '{"xp":250,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-infrastructure-as-code-03', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-1', 'providers', 'Providers', 'Confirm what actually tells Terraform which cloud, and which account, it is even talking to.', 'beginner', ARRAY['rook','vey'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"providers-sim"}'::jsonb, '{"xp":260,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-infrastructure-as-code-04', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-1', 'resources', 'Resources', 'Confirm the same compute fleet from Act 12, now written as a real resource block.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"resources-sim"}'::jsonb, '{"xp":260,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-infrastructure-as-code-05', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-1', 'variables', 'Variables', 'Confirm what actually makes this configuration reusable instead of hardcoded to one region forever.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"variables-sim"}'::jsonb, '{"xp":270,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-infrastructure-as-code-06', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-1', 'outputs', 'Outputs', 'Confirm what this configuration actually exposes for everything else to depend on.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"outputs-sim"}'::jsonb, '{"xp":270,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-infrastructure-as-code-07', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-2', 'plan', 'Plan', 'Confirm what the very first real plan Terraform has ever run against Region One actually found.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"plan-sim"}'::jsonb, '{"xp":280,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-infrastructure-as-code-08', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-2', 'apply', 'Apply', 'Confirm what actually happened once that plan was approved and applied for real.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"apply-sim"}'::jsonb, '{"xp":280,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-infrastructure-as-code-09', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-2', 'destroy', 'Destroy', 'Understand exactly what destroy actually does before anyone ever runs it against something real.', 'beginner', ARRAY['rook','leena'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"destroy-sim"}'::jsonb, '{"xp":280,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-infrastructure-as-code-10', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-2', 'state', 'State', 'Confirm what Terraform actually believes exists, and understand why that is not automatically the same as reality.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"state-sim"}'::jsonb, '{"xp":290,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-infrastructure-as-code-11', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-2', 'dependency-graph', 'Dependency Graph', 'Confirm how Terraform actually knows what order to create -- or destroy -- everything in.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"dependency-graph-sim"}'::jsonb, '{"xp":290,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-infrastructure-as-code-12', 'world-atlas-infrastructure-as-code', 'campaign-atlas-infrastructure-as-code', 'operation-atlas-infrastructure-as-code-2', 'drift', 'Drift', 'Everything this Act taught, turned on one full plan: not to force it clean silently, to finally explain where months of drift actually came from.', 'boss', ARRAY['rook','vey','cross','leena'], '{"requiredMissionIds":["mission-atlas-infrastructure-as-code-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"drift-boss-sim"}'::jsonb, '{"xp":560,"credits":130,"badgeIds":["drift"],"skillXp":{"cloud_devops_fundamentals":95}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-infrastructure-as-code-01', 1, 'leena', 'Every resource in Region One has existed only as prose written to look like infrastructure code -- readable, but never once applied by any real tool. Rook starts converting it into the real thing.'),
  ('mission-atlas-infrastructure-as-code-01', 2, 'rook', 'Infrastructure as code means every change to real infrastructure goes through version-controlled, reviewable configuration first -- not a console click nobody wrote down. What we have had until now was the readability without any of the actual guarantee.'),

  ('mission-atlas-infrastructure-as-code-02', 1, 'rook', 'HCL is Terraform''s actual configuration language -- resource blocks, provider blocks, variable blocks, each with real, parseable syntax. Compare it against everything read as plain text since Act 10.'),

  ('mission-atlas-infrastructure-as-code-03', 1, 'vey', 'Tomas Vey. Before Terraform can touch anything of mine, it has to know exactly which cloud and which account it is talking to. Confirm that is actually configured.'),

  ('mission-atlas-infrastructure-as-code-04', 1, 'rook', 'This is the same compute fleet from Act 12. Confirm it is now written as an actual resource block, not a description of one.'),

  ('mission-atlas-infrastructure-as-code-05', 1, 'rook', 'A hardcoded region only ever describes one region. A variable lets the exact same configuration describe any region, parameterized instead of copy-pasted.'),

  ('mission-atlas-infrastructure-as-code-06', 1, 'rook', 'An output exposes a value -- a VPC ID, a load balancer''s DNS name -- for anything else that needs to depend on it, without hunting through the config by hand.'),

  ('mission-atlas-infrastructure-as-code-07', 1, 'rook', 'This is the moment. The very first real terraform plan Region One has ever had run against it. Confirm exactly what it found.'),

  ('mission-atlas-infrastructure-as-code-08', 1, 'rook', 'A plan only ever proposes a change. Apply is what actually makes it real. Confirm what happened once this one was approved.'),

  ('mission-atlas-infrastructure-as-code-09', 1, 'leena', 'Before this goes any further, understand destroy completely. It does not ask twice, and it does not stop at the resource you meant.'),
  ('mission-atlas-infrastructure-as-code-09', 2, 'rook', 'Destroy tears down every resource Terraform is currently tracking in state -- all of it, in dependency order, deliberately, on purpose. There is no smaller version of this command.'),

  ('mission-atlas-infrastructure-as-code-10', 1, 'rook', 'State is Terraform''s own record of what it believes exists -- not a live query of reality, a stored belief. Confirm what is actually written there right now.'),

  ('mission-atlas-infrastructure-as-code-11', 1, 'rook', 'Terraform does not guess what order to create or destroy things in. It builds a dependency graph automatically, from every resource that references another. Confirm how that actually looks for this fleet.'),

  ('mission-atlas-infrastructure-as-code-12', 1, 'leena', 'Everything this Act taught you, on one full plan. Not to force it clean silently -- to finally explain where months of quiet drift actually came from.'),
  ('mission-atlas-infrastructure-as-code-12', 2, 'byte', 'I have the full plan output and the incident history from Acts 9, 12 and 13 all pulled up together. None of these changes were ever malicious.'),
  ('mission-atlas-infrastructure-as-code-12', 3, 'cross', 'Every one of them was also correct in the moment. Someone needed a real fix, fast, during a real incident, and code review was never going to happen in the middle of one.'),
  ('mission-atlas-infrastructure-as-code-12', 4, 'rook', 'Find what actually connects every drifted resource to a specific incident, and explain why none of this was ever going to be caught before today.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-infrastructure-as-code-01-o1', 'mission-atlas-infrastructure-as-code-01', 1, 'Explain why IaC matters', 'Choose the accurate description of what infrastructure as code actually guarantees.'),

  ('mission-atlas-infrastructure-as-code-02-o1', 'mission-atlas-infrastructure-as-code-02', 1, 'Read real HCL', 'Read the main configuration file and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-03-o1', 'mission-atlas-infrastructure-as-code-03', 1, 'Read the provider configuration', 'Read the provider configuration and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-04-o1', 'mission-atlas-infrastructure-as-code-04', 1, 'Read a resource block', 'Read the compute resource definitions and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-05-o1', 'mission-atlas-infrastructure-as-code-05', 1, 'Read the variables', 'Read the variables file and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-06-o1', 'mission-atlas-infrastructure-as-code-06', 1, 'Read the outputs', 'Read the outputs file and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-07-o1', 'mission-atlas-infrastructure-as-code-07', 1, 'Read the first plan', 'Read the first terraform plan output and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-08-o1', 'mission-atlas-infrastructure-as-code-08', 1, 'Read the apply confirmation', 'Read the apply output and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-09-o1', 'mission-atlas-infrastructure-as-code-09', 1, 'Explain destroy', 'Choose the accurate description of what terraform destroy actually does.'),

  ('mission-atlas-infrastructure-as-code-10-o1', 'mission-atlas-infrastructure-as-code-10', 1, 'Read the state file', 'Read the state file and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-11-o1', 'mission-atlas-infrastructure-as-code-11', 1, 'Read the dependency graph', 'Read the dependency graph and submit the verification code.'),

  ('mission-atlas-infrastructure-as-code-12-o1', 'mission-atlas-infrastructure-as-code-12', 1, 'Confirm the full drift report', 'Read the full-fleet plan output and submit the verification code.'),
  ('mission-atlas-infrastructure-as-code-12-o2', 'mission-atlas-infrastructure-as-code-12', 2, 'Confirm the incident correlation', 'Read the incident correlation log and submit the verification code.'),
  ('mission-atlas-infrastructure-as-code-12-o3', 'mission-atlas-infrastructure-as-code-12', 3, 'Identify what actually explains the drift', 'Find the evidence that explains where every drifted resource actually came from.'),
  ('mission-atlas-infrastructure-as-code-12-o4', 'mission-atlas-infrastructure-as-code-12', 4, 'State the diagnosis', 'Having confirmed all three, explain why this was never going to be caught before today.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-infrastructure-as-code-01-o1-c1', 'mission-atlas-infrastructure-as-code-01-o1', 1, 'multiple_choice', 'Infrastructure as code actually guarantees that...', '{"question":"Infrastructure as code actually guarantees that...","options":[{"id":"a","text":"Changes to real infrastructure go through version-controlled, reviewable configuration first, rather than an unrecorded manual change"},{"id":"b","text":"Infrastructure can never fail once it is written as code"},{"id":"c","text":"No human ever needs to review a change again"},{"id":"d","text":"Cloud costs are automatically reduced"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-02-o1-c1', 'mission-atlas-infrastructure-as-code-02-o1', 1, 'terminal_simulation', 'Read the main configuration file and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/main.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/main.tf":{"type":"file","content":"resource \"aws_vpc\" \"atlas_eu_west\" {\n  cidr_block = var.vpc_cidr\n  tags = { Name = \"atlas-eu-west-vpc\" }\n}\n# real Terraform HCL at last -- every resource block before this Act was prose pretending to be this\n# verification HCL-3312\n"}}}'::jsonb, '{"requiredFlag":"HCL-3312"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-03-o1-c1', 'mission-atlas-infrastructure-as-code-03-o1', 1, 'terminal_simulation', 'Read the provider configuration and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/providers.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/providers.tf":{"type":"file","content":"terraform {\n  required_providers {\n    aws = { source = \"hashicorp/aws\", version = \"~> 5.0\" }\n  }\n}\nprovider \"aws\" {\n  region = var.region\n}\n# verification PROVIDER-6602\n"}}}'::jsonb, '{"requiredFlag":"PROVIDER-6602"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-04-o1-c1', 'mission-atlas-infrastructure-as-code-04-o1', 1, 'terminal_simulation', 'Read the compute resource definitions and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/resources-collector.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/resources-collector.tf":{"type":"file","content":"resource \"aws_instance\" \"collector_eu_west_01\" {\n  ami           = var.collector_ami\n  instance_type = \"t3.medium\"\n  availability_zone = \"eu-west-1a\"\n}\n# verification RESOURCE-7714\n"}}}'::jsonb, '{"requiredFlag":"RESOURCE-7714"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-05-o1-c1', 'mission-atlas-infrastructure-as-code-05-o1', 1, 'terminal_simulation', 'Read the variables file and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/variables.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/variables.tf":{"type":"file","content":"variable \"region\" { default = \"eu-west-1\" }\nvariable \"vpc_cidr\" { default = \"10.40.0.0/16\" }\nvariable \"collector_ami\" { type = string }\n# verification VARS-4471\n"}}}'::jsonb, '{"requiredFlag":"VARS-4471"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-06-o1-c1', 'mission-atlas-infrastructure-as-code-06-o1', 1, 'terminal_simulation', 'Read the outputs file and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/outputs.tf and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/outputs.tf":{"type":"file","content":"output \"vpc_id\" { value = aws_vpc.atlas_eu_west.id }\noutput \"load_balancer_dns\" { value = aws_lb.atlas_global.dns_name }\n# verification OUTPUT-8802\n"}}}'::jsonb, '{"requiredFlag":"OUTPUT-8802"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-07-o1-c1', 'mission-atlas-infrastructure-as-code-07-o1', 1, 'terminal_simulation', 'Read the first terraform plan output and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/plan-001.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/plan-001.txt":{"type":"file","content":"$ terraform plan\n~ aws_instance.collector_eu_west_01\n    tags.Owner: \"\" -> \"atlas-division\"\nPlan: 0 to add, 1 to change, 0 to destroy\n# verification PLAN-2291\n"}}}'::jsonb, '{"requiredFlag":"PLAN-2291"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-08-o1-c1', 'mission-atlas-infrastructure-as-code-08-o1', 1, 'terminal_simulation', 'Read the apply output and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/apply-001.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/apply-001.txt":{"type":"file","content":"$ terraform apply\naws_instance.collector_eu_west_01: Modifying...\naws_instance.collector_eu_west_01: Modification complete\nApply complete! Resources: 0 added, 1 changed, 0 destroyed.\n# verification APPLY-9012\n"}}}'::jsonb, '{"requiredFlag":"APPLY-9012"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-09-o1-c1', 'mission-atlas-infrastructure-as-code-09-o1', 1, 'multiple_choice', 'terraform destroy actually does what?', '{"question":"terraform destroy actually does what?","options":[{"id":"a","text":"Tears down every resource currently tracked in state, in dependency order, deliberately -- there is no smaller, partial version of the command"},{"id":"b","text":"Only removes resources that have drifted from configuration"},{"id":"c","text":"Deletes the Terraform configuration files themselves"},{"id":"d","text":"Asks for confirmation on each individual resource before proceeding, by default, with no way to skip it"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-10-o1-c1', 'mission-atlas-infrastructure-as-code-10-o1', 1, 'terminal_simulation', 'Read the state file and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/terraform-state.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/terraform-state.txt":{"type":"file","content":"resource \"aws_instance\" \"collector_eu_west_01\" { id = \"i-0a1b2c3d4e5f60789\" }\nresource \"aws_vpc\" \"atlas_eu_west\" { id = \"vpc-0f9e8d7c6b5a4321\" }\n# this file is what Terraform believes exists -- a stored record, not a live query of reality\n# verification STATE-3390\n"}}}'::jsonb, '{"requiredFlag":"STATE-3390"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-11-o1-c1', 'mission-atlas-infrastructure-as-code-11-o1', 1, 'terminal_simulation', 'Read the dependency graph and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/DEPENDENCIES.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/DEPENDENCIES.txt":{"type":"file","content":"dependency order (subset):\n  aws_vpc.atlas_eu_west\n    -> aws_subnet.eu_west_1a (depends on vpc id)\n      -> aws_instance.collector_eu_west_01 (depends on subnet id)\n# terraform builds this graph automatically from resource references -- apply and destroy each walk it in the correct order\n# verification GRAPH-5541\n"}}}'::jsonb, '{"requiredFlag":"GRAPH-5541"}'::jsonb),

  ('mission-atlas-infrastructure-as-code-12-o1-c1', 'mission-atlas-infrastructure-as-code-12-o1', 1, 'terminal_simulation', 'Read the full-fleet plan output and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/plan-full.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/plan-full.txt":{"type":"file","content":"$ terraform plan\n~ aws_lambda_function.region_guard_remediate\n    iam_role: (state) eu_west_bootstrap_v2 -> (actual) eu_west_bootstrap_v3\n~ aws_security_group.eu_west_collector\n    ingress: (state) 3 rules -> (actual) 4 rules\n~ aws_route53_record.collector_eu\n    weight: (state) 50 -> (actual) 75\nPlan: 0 to add, 3 to change, 0 to destroy\n# verification DRIFT-4471\n"}}}'::jsonb, '{"requiredFlag":"DRIFT-4471"}'::jsonb),
  ('mission-atlas-infrastructure-as-code-12-o2-c1', 'mission-atlas-infrastructure-as-code-12-o2', 1, 'terminal_simulation', 'Read the incident correlation log and submit the verification code.', '{"instructions":"Read /var/atlas-terraform/incident-log.txt and submit the verification code with: submit CODE","hostname":"atlas-terraform-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-terraform-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-terraform/incident-log.txt":{"type":"file","content":"drift correlation:\n  eu_west_bootstrap_v3: created during the Act 13 invocation storm response, applied directly via console to unblock remediation\n  security group rule: added during the Act 9 zombie fleet investigation, applied directly to isolate a suspect port\n  route53 weight: adjusted directly after Act 12 launch to shift more traffic to the newly verified region\nnone of these three changes was ever written back into the Terraform configuration\n# verification INCIDENTS-8814\n"}}}'::jsonb, '{"requiredFlag":"INCIDENTS-8814"}'::jsonb),
  ('mission-atlas-infrastructure-as-code-12-o3-c1', 'mission-atlas-infrastructure-as-code-12-o3', 1, 'investigation', 'Which evidence explains where every drifted resource actually came from?', '{"evidence":[{"id":"e1","label":"Full-fleet plan output","detail":"Three resources show real differences between state and actual live infrastructure"},{"id":"e2","label":"Incident correlation log","detail":"All three changes trace directly to legitimate emergency console fixes made during Acts 9, 12 and 13, never written back into configuration"},{"id":"e3","label":"Dependency graph","detail":"Terraform correctly orders resource creation and destruction based on references between them"},{"id":"e4","label":"State file","detail":"State correctly tracks the resource IDs Terraform originally created"}],"question":"Which evidence explains where every drifted resource actually came from?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-infrastructure-as-code-12-o4-c1', 'mission-atlas-infrastructure-as-code-12-o4', 1, 'boss_encounter', 'Having confirmed the full drift report, the incident correlation, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-infrastructure-as-code-12-o1","label":"Confirm the full drift report"},{"objectiveRef":"mission-atlas-infrastructure-as-code-12-o2","label":"Confirm the incident correlation"},{"objectiveRef":"mission-atlas-infrastructure-as-code-12-o3","label":"Identify what actually explains the drift"}],"task":"State the diagnosis in one sentence: every drifted resource traces back to a legitimate, correct, necessary console fix made in the middle of a real incident in Acts 9, 12 or 13, and none of it was ever going to be caught before today because until this Act there was no real Terraform actually enforcing that changes go through code at all -- now that there is, the fix is to reconcile state with reality once, and require every future change to go through a real plan and apply."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-infrastructure-as-code-12-o1","mission-atlas-infrastructure-as-code-12-o2","mission-atlas-infrastructure-as-code-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-infrastructure-as-code-01-o1-c1', 'orientation', 'Think about what changes going through a console click can never guarantee.', 10, 1),
  ('mission-atlas-infrastructure-as-code-01-o1-c1', 'solution', 'Changes go through version-controlled, reviewable configuration instead of an unrecorded manual step.', 20, 2),

  ('mission-atlas-infrastructure-as-code-02-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/main.tf', 10, 1),
  ('mission-atlas-infrastructure-as-code-02-o1-c1', 'solution', 'It is real HCL syntax, verification HCL-3312. submit HCL-3312', 20, 2),

  ('mission-atlas-infrastructure-as-code-03-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/providers.tf', 10, 1),
  ('mission-atlas-infrastructure-as-code-03-o1-c1', 'solution', 'The AWS provider and region are configured, verification PROVIDER-6602. submit PROVIDER-6602', 20, 2),

  ('mission-atlas-infrastructure-as-code-04-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/resources-collector.tf', 10, 1),
  ('mission-atlas-infrastructure-as-code-04-o1-c1', 'solution', 'It is a real resource block now, verification RESOURCE-7714. submit RESOURCE-7714', 20, 2),

  ('mission-atlas-infrastructure-as-code-05-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/variables.tf', 10, 1),
  ('mission-atlas-infrastructure-as-code-05-o1-c1', 'solution', 'Region and CIDR are both variables, verification VARS-4471. submit VARS-4471', 20, 2),

  ('mission-atlas-infrastructure-as-code-06-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/outputs.tf', 10, 1),
  ('mission-atlas-infrastructure-as-code-06-o1-c1', 'solution', 'The VPC ID and load balancer DNS are both exposed, verification OUTPUT-8802. submit OUTPUT-8802', 20, 2),

  ('mission-atlas-infrastructure-as-code-07-o1-c1', 'orientation', 'Try: cat /var/atlas-terraform/plan-001.txt', 10, 1),
  ('mission-atlas-infrastructure-as-code-07-o1-c1', 'solution', 'One tag needs to change, verification PLAN-2291. submit PLAN-2291', 20, 2),

  ('mission-atlas-infrastructure-as-code-08-o1-c1', 'orientation', 'Try: cat /var/atlas-terraform/apply-001.txt', 10, 1),
  ('mission-atlas-infrastructure-as-code-08-o1-c1', 'solution', 'The change was applied cleanly, verification APPLY-9012. submit APPLY-9012', 20, 2),

  ('mission-atlas-infrastructure-as-code-09-o1-c1', 'orientation', 'Think about whether there is a way to destroy only part of what is tracked.', 10, 1),
  ('mission-atlas-infrastructure-as-code-09-o1-c1', 'solution', 'It tears down every tracked resource in dependency order -- no smaller version exists.', 20, 2),

  ('mission-atlas-infrastructure-as-code-10-o1-c1', 'orientation', 'Try: cat /var/atlas-terraform/terraform-state.txt', 10, 1),
  ('mission-atlas-infrastructure-as-code-10-o1-c1', 'solution', 'It records resource IDs as a stored belief, verification STATE-3390. submit STATE-3390', 20, 2),

  ('mission-atlas-infrastructure-as-code-11-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/DEPENDENCIES.txt', 10, 1),
  ('mission-atlas-infrastructure-as-code-11-o1-c1', 'solution', 'VPC before subnet before instance, verification GRAPH-5541. submit GRAPH-5541', 20, 2),

  ('mission-atlas-infrastructure-as-code-12-o1-c1', 'orientation', 'Try: cat /var/atlas-terraform/plan-full.txt', 10, 1),
  ('mission-atlas-infrastructure-as-code-12-o1-c1', 'solution', 'Three resources show real drift, verification DRIFT-4471. submit DRIFT-4471', 20, 2),
  ('mission-atlas-infrastructure-as-code-12-o2-c1', 'orientation', 'Try: cat /var/atlas-terraform/incident-log.txt', 10, 1),
  ('mission-atlas-infrastructure-as-code-12-o2-c1', 'solution', 'Each drifted resource traces to a real incident, verification INCIDENTS-8814. submit INCIDENTS-8814', 20, 2),
  ('mission-atlas-infrastructure-as-code-12-o3-c1', 'orientation', 'The dependency graph and state file are both fine and irrelevant to why drift happened. Look for the plan and the incident history together.', 10, 1),
  ('mission-atlas-infrastructure-as-code-12-o3-c1', 'solution', 'e1 and e2: the plan shows the drift, the incident log explains it came from real, justified emergency fixes.', 20, 2),
  ('mission-atlas-infrastructure-as-code-12-o4-c1', 'orientation', 'Combine the drift, the incidents behind it, and why it was invisible until now into one sentence.', 15, 1),
  ('mission-atlas-infrastructure-as-code-12-o4-c1', 'solution', 'Every drifted resource traces to a legitimate emergency console fix, never caught because nothing was ever really enforcing that changes go through Terraform -- now that something does, state and reality can finally be reconciled.', 25, 2);
