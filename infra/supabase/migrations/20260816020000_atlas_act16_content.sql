-- Atlas Division pathway ("The Silence") Act 16 -- "Configuration"
-- content, under world-atlas-configuration (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), closing World V "The Terraform Expanse" (Acts 14-16).
--
-- Same terminal-engine constraint as Acts 4-15 -- every configuration-
-- management artifact here is static seeded text read via `cat`. Two
-- hosts: the reused `atlas-devbox-01` for Ansible repo files
-- (inventory, playbooks, roles, templates, vault), and a new
-- `atlas-ansible-01` (the control node actually running ansible
-- commands) for check-mode/drift output. The boss's terminal missions
-- deliberately reuse the exact hostname `metrics-collector-01` first
-- introduced in Act 3, now revisited with years of undocumented manual
-- drift -- pure narrative continuity, since each terminal_simulation
-- challenge defines its own isolated filesystem regardless of hostname
-- reuse across Acts.
--
-- Narrative thread: missions 1-10 build out real Ansible tooling
-- (inventory, playbooks, roles, templates, vault-based secrets) against
-- the standard collector fleet. Mission 5's inventory file plants the
-- mystery -- metrics-collector-01 is conspicuously absent. Mission 11
-- runs the very first check-mode dry run against it, and the boss's
-- full drift report reveals seventeen undocumented manual changes
-- accumulated since Act 3, none malicious, none ever written into any
-- playbook -- because the host was never migrated to the immutable,
-- code-managed paradigm the rest of this story adopted around it.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-configuration', 'world-atlas-configuration', 'configuration', '5C - Configuration', 'Learn configuration management from first principles -- immutable versus mutable infrastructure, bootstrapping, cloud-init, Ansible, inventory, playbooks, idempotency, roles, templates, secrets and config drift -- while Rook''s new inventory surfaces a host nothing has managed since Act 3.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-configuration-1', 'campaign-atlas-configuration', 'configuring-the-fleet-for-real', 'Configuring the Fleet For Real', 'Immutable versus mutable, bootstrapping, cloud-init, Ansible, inventory and playbooks.', 1),
  ('operation-atlas-configuration-2', 'campaign-atlas-configuration', 'the-host-nothing-ever-managed', 'The Host Nothing Ever Managed', 'Idempotency, roles, templates, secrets and config drift.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-configuration-01', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-1', 'immutable-vs-mutable', 'Immutable vs Mutable', 'Provisioning is finally solid. Rook turns to what actually runs inside these servers.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"immutable-vs-mutable-sim"}'::jsonb, '{"xp":300,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-configuration-02', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-1', 'bootstrapping', 'Bootstrapping', 'Confirm what Act 3''s one-time bootstrap script actually did, and how ongoing configuration management is different.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-configuration-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"bootstrapping-config-sim"}'::jsonb, '{"xp":300,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-configuration-03', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-1', 'cloud-init', 'cloud-init', 'Confirm what actually runs on an EC2 instance the moment it launches, before Ansible ever gets involved.', 'beginner', ARRAY['rook','vey'], '{"requiredMissionIds":["mission-atlas-configuration-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"cloud-init-sim"}'::jsonb, '{"xp":310,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-configuration-04', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-1', 'ansible', 'Ansible', 'Confirm the actual configuration Rook is running everything through.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-configuration-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"ansible-sim"}'::jsonb, '{"xp":310,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-configuration-05', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-1', 'inventory', 'Inventory', 'Confirm exactly which hosts are actually under management -- and which are not.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-configuration-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"inventory-sim"}'::jsonb, '{"xp":320,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-configuration-06', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-1', 'playbooks', 'Playbooks', 'Confirm what actually gets applied to every host in the collectors group.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-configuration-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"playbooks-sim"}'::jsonb, '{"xp":320,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-configuration-07', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-2', 'idempotency', 'Idempotency', 'Understand exactly why running the same playbook ten times should never be riskier than running it once.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-configuration-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"idempotency-sim"}'::jsonb, '{"xp":330,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-configuration-08', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-2', 'roles', 'Roles', 'Confirm how the collector''s configuration is actually organized into one reusable unit.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-configuration-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"roles-sim"}'::jsonb, '{"xp":330,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-configuration-09', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-2', 'templates', 'Templates', 'Confirm how one file actually renders differently for every single host it is applied to.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-configuration-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"templates-sim"}'::jsonb, '{"xp":330,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-configuration-10', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-2', 'secrets-ansible', 'Secrets', 'Confirm this playbook never has to see a real credential in plain text either.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-configuration-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"secrets-ansible-sim"}'::jsonb, '{"xp":340,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-configuration-11', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-2', 'config-drift', 'Config Drift', 'Confirm what happens the very first time this playbook is ever pointed at metrics-collector-01.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-configuration-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"config-drift-sim"}'::jsonb, '{"xp":350,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-configuration-12', 'world-atlas-configuration', 'campaign-atlas-configuration', 'operation-atlas-configuration-2', 'snowflake-server', 'Snowflake Server', 'Everything this Act taught, turned on one host: not to force it into compliance, to finally explain how the oldest surviving machine in this whole story became the one thing nothing here could ever manage.', 'boss', ARRAY['rook','cross','leena','byte'], '{"requiredMissionIds":["mission-atlas-configuration-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"snowflake-server-boss-sim"}'::jsonb, '{"xp":600,"credits":140,"badgeIds":["snowflake-server"],"skillXp":{"cloud_devops_fundamentals":100}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-configuration-01', 1, 'leena', 'Provisioning is finally solid -- real Terraform, real state, real modules. Rook is turning to what actually runs inside these servers now.'),
  ('mission-atlas-configuration-01', 2, 'rook', 'A mutable server gets patched in place, over and over, for as long as it lives -- every change compounding on the last. An immutable one is never patched at all. It gets replaced outright, from a known-good image, every single time. Everything built since Act 8 has quietly assumed the second one.'),

  ('mission-atlas-configuration-02', 1, 'rook', 'Act 3''s bootstrap script ran exactly once, at first boot, and nobody touched it again after that. Configuration management is not a one-time script -- it can be reapplied any time, to keep a host in its intended state going forward, not just at birth.'),

  ('mission-atlas-configuration-03', 1, 'vey', 'Tomas Vey. Before Ansible ever touches anything, cloud-init already ran once, at launch, on every EC2 instance in this fleet. Confirm what it actually does.'),

  ('mission-atlas-configuration-04', 1, 'rook', 'Confirm the actual configuration everything is about to run through.'),

  ('mission-atlas-configuration-05', 1, 'rook', 'Before applying anything anywhere, confirm exactly which hosts are actually under management. Read the inventory.'),

  ('mission-atlas-configuration-06', 1, 'rook', 'A playbook is what actually gets applied -- the tasks, in order, against every host in a group. Confirm what this one does to the collectors group.'),

  ('mission-atlas-configuration-07', 1, 'rook', 'Idempotency means running this playbook once, or ten times, or a hundred times, always ends at the exact same state. If a playbook is not idempotent, it is not safe to ever run twice.'),

  ('mission-atlas-configuration-08', 1, 'rook', 'A role bundles related tasks, templates and defaults into one reusable unit, instead of scattering them across a dozen unrelated files. Confirm how the collector''s is organized.'),

  ('mission-atlas-configuration-09', 1, 'rook', 'A template is not one static file -- it renders differently per host, filled in with each host''s own variables. Confirm what actually changes from one collector to the next.'),

  ('mission-atlas-configuration-10', 1, 'cross', 'Imani Cross. After Act 6 and Act 15, I am checking every new tool for this on principle now -- confirm this playbook never has to see a real secret written down anywhere.'),
  ('mission-atlas-configuration-10', 2, 'rook', 'It does not. Anything sensitive is vault-encrypted and only ever decrypted at run time, resolving straight from the same secrets manager Act 6 already fixed this to use.'),

  ('mission-atlas-configuration-11', 1, 'rook', 'Building this inventory out, one host was conspicuously missing. metrics-collector-01. Confirm what happens the very first time this playbook is ever actually pointed at it.'),
  ('mission-atlas-configuration-11', 2, 'cross', 'That host has been running since Act 3. It has never once been under any of this.'),

  ('mission-atlas-configuration-12', 1, 'leena', 'Everything this Act taught you, on one host. Not to force it into compliance -- to finally explain how the oldest surviving machine in this entire story became the one thing nothing here could ever manage.'),
  ('mission-atlas-configuration-12', 2, 'byte', 'I have the full drift report and the inventory history both pulled up together. Nothing on this host was ever malicious. Every change was someone doing their job.'),
  ('mission-atlas-configuration-12', 3, 'cross', 'Every one of those changes was also correct in the moment, made by hand, over SSH, because nothing here was ever set up to catch them.'),
  ('mission-atlas-configuration-12', 4, 'rook', 'Find what actually explains seventeen undocumented differences on one host, and say plainly what has to happen to it now.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-configuration-01-o1', 'mission-atlas-configuration-01', 1, 'Tell mutable from immutable', 'Choose the accurate distinction between mutable and immutable infrastructure.'),

  ('mission-atlas-configuration-02-o1', 'mission-atlas-configuration-02', 1, 'Read the bootstrapping notes', 'Read the bootstrapping notes and submit the verification code.'),

  ('mission-atlas-configuration-03-o1', 'mission-atlas-configuration-03', 1, 'Read the cloud-init config', 'Read the cloud-init configuration and submit the verification code.'),

  ('mission-atlas-configuration-04-o1', 'mission-atlas-configuration-04', 1, 'Read the Ansible config', 'Read the Ansible configuration and submit the verification code.'),

  ('mission-atlas-configuration-05-o1', 'mission-atlas-configuration-05', 1, 'Read the inventory', 'Read the inventory file and submit the verification code.'),

  ('mission-atlas-configuration-06-o1', 'mission-atlas-configuration-06', 1, 'Read the playbook', 'Read the collector playbook and submit the verification code.'),

  ('mission-atlas-configuration-07-o1', 'mission-atlas-configuration-07', 1, 'Explain idempotency', 'Choose the accurate description of what idempotency actually guarantees.'),

  ('mission-atlas-configuration-08-o1', 'mission-atlas-configuration-08', 1, 'Read the role structure', 'Read the role directory structure and submit the verification code.'),

  ('mission-atlas-configuration-09-o1', 'mission-atlas-configuration-09', 1, 'Read the template', 'Read the configuration template and submit the verification code.'),

  ('mission-atlas-configuration-10-o1', 'mission-atlas-configuration-10', 1, 'Confirm vault-encrypted secrets', 'Read the vault reference and submit the verification code.'),

  ('mission-atlas-configuration-11-o1', 'mission-atlas-configuration-11', 1, 'Confirm the first check-mode run', 'Read the check-mode output and submit the verification code.'),

  ('mission-atlas-configuration-12-o1', 'mission-atlas-configuration-12', 1, 'Confirm the full drift report', 'Read the drift report and submit the verification code.'),
  ('mission-atlas-configuration-12-o2', 'mission-atlas-configuration-12', 2, 'Confirm the inventory history', 'Read the inventory history and submit the verification code.'),
  ('mission-atlas-configuration-12-o3', 'mission-atlas-configuration-12', 3, 'Identify what actually explains this', 'Find the evidence that explains how this host became a snowflake.'),
  ('mission-atlas-configuration-12-o4', 'mission-atlas-configuration-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to happen to this host now.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-configuration-01-o1-c1', 'mission-atlas-configuration-01-o1', 1, 'multiple_choice', 'Mutable and immutable infrastructure differ in that...', '{"question":"Mutable and immutable infrastructure differ in that...","options":[{"id":"a","text":"A mutable server is patched in place repeatedly over its life; an immutable one is never patched at all, only ever replaced outright from a known-good image"},{"id":"b","text":"They are identical, just different marketing terms"},{"id":"c","text":"Immutable infrastructure can never be updated at all, ever"},{"id":"d","text":"Mutable infrastructure only applies to databases"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-configuration-02-o1-c1', 'mission-atlas-configuration-02-o1', 1, 'terminal_simulation', 'Read the bootstrapping notes and submit the verification code.', '{"instructions":"Read /repo/infra/ansible/bootstrapping-notes.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/ansible/bootstrapping-notes.txt":{"type":"file","content":"Act 3''s bootstrap.sh ran once, at first boot, and was never touched again.\nConfiguration management is different: it can be reapplied any time, not just once, to keep a host in its intended state going forward.\n# verification BOOTSTRAP-3312\n"}}}'::jsonb, '{"requiredFlag":"BOOTSTRAP-3312"}'::jsonb),

  ('mission-atlas-configuration-03-o1-c1', 'mission-atlas-configuration-03-o1', 1, 'terminal_simulation', 'Read the cloud-init configuration and submit the verification code.', '{"instructions":"Read /repo/infra/terraform/cloud-init.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/terraform/cloud-init.yaml":{"type":"file","content":"#cloud-config\npackages:\n  - atlas-metrics-agent\nruncmd:\n  - systemctl enable atlas-metrics-agent\n# runs once at instance launch, before Ansible ever gets involved\n# verification CLOUDINIT-6602\n"}}}'::jsonb, '{"requiredFlag":"CLOUDINIT-6602"}'::jsonb),

  ('mission-atlas-configuration-04-o1-c1', 'mission-atlas-configuration-04-o1', 1, 'terminal_simulation', 'Read the Ansible configuration and submit the verification code.', '{"instructions":"Read /repo/infra/ansible/ansible.cfg and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/ansible/ansible.cfg":{"type":"file","content":"[defaults]\ninventory = ./inventory.ini\nhost_key_checking = False\n# verification ANSIBLE-7714\n"}}}'::jsonb, '{"requiredFlag":"ANSIBLE-7714"}'::jsonb),

  ('mission-atlas-configuration-05-o1-c1', 'mission-atlas-configuration-05-o1', 1, 'terminal_simulation', 'Read the inventory file and submit the verification code.', '{"instructions":"Read /repo/infra/ansible/inventory.ini and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/ansible/inventory.ini":{"type":"file","content":"[collectors]\ncollector-eu-west-01\ncollector-eu-west-02\ncollector-us-east-01\ncollector-us-east-02\n# metrics-collector-01 is not listed here -- it has never been added to Ansible inventory\n# verification INVENTORY-4471\n"}}}'::jsonb, '{"requiredFlag":"INVENTORY-4471"}'::jsonb),

  ('mission-atlas-configuration-06-o1-c1', 'mission-atlas-configuration-06-o1', 1, 'terminal_simulation', 'Read the collector playbook and submit the verification code.', '{"instructions":"Read /repo/infra/ansible/playbook-collector.yml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/ansible/playbook-collector.yml":{"type":"file","content":"- hosts: collectors\n  tasks:\n    - name: ensure atlas-metrics-agent package is present\n      package: name=atlas-metrics-agent state=present\n    - name: ensure config file matches template\n      template: src=collector.conf.j2 dest=/etc/atlas/collector.conf\n# verification PLAYBOOK-8802\n"}}}'::jsonb, '{"requiredFlag":"PLAYBOOK-8802"}'::jsonb),

  ('mission-atlas-configuration-07-o1-c1', 'mission-atlas-configuration-07-o1', 1, 'multiple_choice', 'Idempotency in a playbook actually guarantees that...', '{"question":"Idempotency in a playbook actually guarantees that...","options":[{"id":"a","text":"Running it once, ten times, or a hundred times always ends at the exact same target state, regardless of the starting state"},{"id":"b","text":"The playbook can only ever be run exactly once, safely"},{"id":"c","text":"Every task always reports changed, every single run"},{"id":"d","text":"It removes the need for an inventory file entirely"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-configuration-08-o1-c1', 'mission-atlas-configuration-08-o1', 1, 'terminal_simulation', 'Read the role directory structure and submit the verification code.', '{"instructions":"Read /repo/infra/ansible/roles/collector/structure.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/ansible/roles/collector/structure.txt":{"type":"file","content":"roles/collector/\n  tasks/main.yml\n  templates/collector.conf.j2\n  defaults/main.yml\n# a role bundles related tasks, templates and defaults into one reusable unit\n# verification ROLES-2291\n"}}}'::jsonb, '{"requiredFlag":"ROLES-2291"}'::jsonb),

  ('mission-atlas-configuration-09-o1-c1', 'mission-atlas-configuration-09-o1', 1, 'terminal_simulation', 'Read the configuration template and submit the verification code.', '{"instructions":"Read /repo/infra/ansible/roles/collector/templates/collector.conf.j2 and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/ansible/roles/collector/templates/collector.conf.j2":{"type":"file","content":"service_name={{ inventory_hostname }}\nregion={{ region }}\nlog_level={{ log_level | default(\"info\") }}\n# verification TEMPLATE-9012\n"}}}'::jsonb, '{"requiredFlag":"TEMPLATE-9012"}'::jsonb),

  ('mission-atlas-configuration-10-o1-c1', 'mission-atlas-configuration-10-o1', 1, 'terminal_simulation', 'Read the vault reference and submit the verification code.', '{"instructions":"Read /repo/infra/ansible/group_vars/vault-notes.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/ansible/group_vars/vault-notes.txt":{"type":"file","content":"secrets in this playbook are ansible-vault encrypted and decrypted only at run time\nATLAS_AUTH_TOKEN resolves from the same secrets manager already established in Act 6 -- never written in plain text here\n# verification VAULT-3390\n"}}}'::jsonb, '{"requiredFlag":"VAULT-3390"}'::jsonb),

  ('mission-atlas-configuration-11-o1-c1', 'mission-atlas-configuration-11-o1', 1, 'terminal_simulation', 'Read the check-mode output and submit the verification code.', '{"instructions":"Read /var/atlas-ansible/check-metrics-collector-01.txt and submit the verification code with: submit CODE","hostname":"atlas-ansible-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ansible-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ansible/check-metrics-collector-01.txt":{"type":"file","content":"$ ansible-playbook playbook-collector.yml --limit metrics-collector-01 --check\nchanged: [metrics-collector-01] => package atlas-metrics-agent (would upgrade 2.1.0 -> 2.4.0)\nchanged: [metrics-collector-01] => 14 additional differences detected between current config and template\n# this host has never had this playbook run against it before\n# verification DRIFTCHECK-4471\n"}}}'::jsonb, '{"requiredFlag":"DRIFTCHECK-4471"}'::jsonb),

  ('mission-atlas-configuration-12-o1-c1', 'mission-atlas-configuration-12-o1', 1, 'terminal_simulation', 'Read the drift report and submit the verification code.', '{"instructions":"Read /var/atlas-ansible/drift-report-metrics-collector-01.txt and submit the verification code with: submit CODE","hostname":"atlas-ansible-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ansible-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ansible/drift-report-metrics-collector-01.txt":{"type":"file","content":"metrics-collector-01 configuration drift report:\n  17 manual changes detected since the last known baseline (Act 3, 2026-06-10)\n  including: 3 undocumented cron jobs, 5 hand-edited config values, 4 packages installed outside any playbook, 2 custom shell scripts in /usr/local/bin, 3 manually created users\nnone of these changes exist in any playbook, role or template\n# verification SNOWFLAKE-9012\n"}}}'::jsonb, '{"requiredFlag":"SNOWFLAKE-9012"}'::jsonb),
  ('mission-atlas-configuration-12-o2-c1', 'mission-atlas-configuration-12-o2', 1, 'terminal_simulation', 'Read the inventory history and submit the verification code.', '{"instructions":"Read /var/atlas-ansible/inventory-history.txt and submit the verification code with: submit CODE","hostname":"atlas-ansible-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-ansible-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-ansible/inventory-history.txt":{"type":"file","content":"metrics-collector-01: never added to Ansible inventory\nfirst appeared in Atlas Division systems: Act 1\nlast touched by any automated tooling: never -- every change since Act 3 was made by hand, directly, over SSH\n# verification HISTORY-8814\n"}}}'::jsonb, '{"requiredFlag":"HISTORY-8814"}'::jsonb),
  ('mission-atlas-configuration-12-o3-c1', 'mission-atlas-configuration-12-o3', 1, 'investigation', 'Which evidence explains how this host became a snowflake?', '{"evidence":[{"id":"e1","label":"Drift report","detail":"17 undocumented manual changes have accumulated since Act 3, none of them tracked in any playbook, role or template"},{"id":"e2","label":"Inventory history","detail":"metrics-collector-01 has never once been added to Ansible inventory and has never been touched by any automated tooling"},{"id":"e3","label":"Idempotency test on other hosts","detail":"The same playbook is provably idempotent and works cleanly on every other collector in the fleet"},{"id":"e4","label":"Vault-encrypted secrets","detail":"Sensitive values in the playbook are properly vault-encrypted and never written in plain text"}],"question":"Which evidence explains how this host became a snowflake?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-configuration-12-o4-c1', 'mission-atlas-configuration-12-o4', 1, 'boss_encounter', 'Having confirmed the drift report, the inventory history, and what actually explains this, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-configuration-12-o1","label":"Confirm the full drift report"},{"objectiveRef":"mission-atlas-configuration-12-o2","label":"Confirm the inventory history"},{"objectiveRef":"mission-atlas-configuration-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: metrics-collector-01 was never added to Ansible inventory and never migrated to the immutable, code-managed paradigm the rest of this story adopted around it, so seventeen individually reasonable manual fixes since Act 3 compounded into a host nothing here can safely manage anymore -- and the fix is not to force the playbook onto it, but to finally replace it outright with a fresh, immutable, properly managed instance."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-configuration-12-o1","mission-atlas-configuration-12-o2","mission-atlas-configuration-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-configuration-01-o1-c1', 'orientation', 'Think about patching in place versus replacing outright.', 10, 1),
  ('mission-atlas-configuration-01-o1-c1', 'solution', 'Mutable is patched repeatedly in place; immutable is only ever replaced from a known-good image.', 20, 2),

  ('mission-atlas-configuration-02-o1-c1', 'orientation', 'Try: cat /repo/infra/ansible/bootstrapping-notes.txt', 10, 1),
  ('mission-atlas-configuration-02-o1-c1', 'solution', 'Bootstrap runs once; config management can reapply anytime, verification BOOTSTRAP-3312. submit BOOTSTRAP-3312', 20, 2),

  ('mission-atlas-configuration-03-o1-c1', 'orientation', 'Try: cat /repo/infra/terraform/cloud-init.yaml', 10, 1),
  ('mission-atlas-configuration-03-o1-c1', 'solution', 'It installs and enables the agent at launch, verification CLOUDINIT-6602. submit CLOUDINIT-6602', 20, 2),

  ('mission-atlas-configuration-04-o1-c1', 'orientation', 'Try: cat /repo/infra/ansible/ansible.cfg', 10, 1),
  ('mission-atlas-configuration-04-o1-c1', 'solution', 'It points to the local inventory file, verification ANSIBLE-7714. submit ANSIBLE-7714', 20, 2),

  ('mission-atlas-configuration-05-o1-c1', 'orientation', 'Try: cat /repo/infra/ansible/inventory.ini', 10, 1),
  ('mission-atlas-configuration-05-o1-c1', 'solution', 'metrics-collector-01 is not listed, verification INVENTORY-4471. submit INVENTORY-4471', 20, 2),

  ('mission-atlas-configuration-06-o1-c1', 'orientation', 'Try: cat /repo/infra/ansible/playbook-collector.yml', 10, 1),
  ('mission-atlas-configuration-06-o1-c1', 'solution', 'It ensures the package and config template, verification PLAYBOOK-8802. submit PLAYBOOK-8802', 20, 2),

  ('mission-atlas-configuration-07-o1-c1', 'orientation', 'Think about whether the end state changes depending on how many times you run it.', 10, 1),
  ('mission-atlas-configuration-07-o1-c1', 'solution', 'Any number of runs always ends at the same target state.', 20, 2),

  ('mission-atlas-configuration-08-o1-c1', 'orientation', 'Try: cat /repo/infra/ansible/roles/collector/structure.txt', 10, 1),
  ('mission-atlas-configuration-08-o1-c1', 'solution', 'Tasks, templates and defaults are bundled together, verification ROLES-2291. submit ROLES-2291', 20, 2),

  ('mission-atlas-configuration-09-o1-c1', 'orientation', 'Try: cat /repo/infra/ansible/roles/collector/templates/collector.conf.j2', 10, 1),
  ('mission-atlas-configuration-09-o1-c1', 'solution', 'Variables render per-host, verification TEMPLATE-9012. submit TEMPLATE-9012', 20, 2),

  ('mission-atlas-configuration-10-o1-c1', 'orientation', 'Try: cat /repo/infra/ansible/group_vars/vault-notes.txt', 10, 1),
  ('mission-atlas-configuration-10-o1-c1', 'solution', 'Secrets are vault-encrypted, resolved from Act 6''s secrets manager, verification VAULT-3390. submit VAULT-3390', 20, 2),

  ('mission-atlas-configuration-11-o1-c1', 'orientation', 'Try: cat /var/atlas-ansible/check-metrics-collector-01.txt', 10, 1),
  ('mission-atlas-configuration-11-o1-c1', 'solution', '14 additional differences found, verification DRIFTCHECK-4471. submit DRIFTCHECK-4471', 20, 2),

  ('mission-atlas-configuration-12-o1-c1', 'orientation', 'Try: cat /var/atlas-ansible/drift-report-metrics-collector-01.txt', 10, 1),
  ('mission-atlas-configuration-12-o1-c1', 'solution', '17 undocumented changes, verification SNOWFLAKE-9012. submit SNOWFLAKE-9012', 20, 2),
  ('mission-atlas-configuration-12-o2-c1', 'orientation', 'Try: cat /var/atlas-ansible/inventory-history.txt', 10, 1),
  ('mission-atlas-configuration-12-o2-c1', 'solution', 'Never under any automated tooling, verification HISTORY-8814. submit HISTORY-8814', 20, 2),
  ('mission-atlas-configuration-12-o3-c1', 'orientation', 'The idempotency test and the vault-encrypted secrets are both fine and irrelevant to why this one host is a snowflake. Look at the drift and the history together.', 10, 1),
  ('mission-atlas-configuration-12-o3-c1', 'solution', 'e1 and e2: 17 undocumented manual changes on a host that was never brought under any automated management at all.', 20, 2),
  ('mission-atlas-configuration-12-o4-c1', 'orientation', 'Combine the drift, the missing history, and what should happen to the host into one sentence.', 15, 1),
  ('mission-atlas-configuration-12-o4-c1', 'solution', 'metrics-collector-01 was never migrated to immutable, code-managed infrastructure, so years of reasonable manual fixes compounded into a snowflake -- replace it outright rather than trying to force it into compliance.', 25, 2);
