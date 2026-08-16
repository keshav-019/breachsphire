-- Atlas Division pathway ("The Silence"): World row for Act 16,
-- "Configuration", closing act-atlas-5 ("World V -- The Terraform
-- Expanse", Acts 14-16: Infrastructure as Code, State of the World,
-- Configuration). Content (missions) follows in its own migration.
--
-- Narrative thread: with provisioning finally solid (Acts 14-15), the
-- team turns to configuring what actually runs inside these servers
-- with Ansible -- and building the inventory surfaces a host that was
-- never added to it at all: metrics-collector-01, the same host first
-- introduced all the way back in Act 3, still running as a
-- hand-maintained legacy machine that nothing since has ever replaced
-- or brought under automated management.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-configuration', 'act-atlas-5', 15, 'configuration', 'Configuration', 'Configuration',
   'Immutable versus mutable infrastructure; bootstrapping; cloud-init; Ansible; inventory; playbooks; idempotency; roles; templates; secrets; configuration drift.',
   'Rook builds out Ansible inventory for the whole fleet -- and one host is conspicuously missing from it. metrics-collector-01, the same host first met in Act 3, has never once been added to any automated configuration management. Nobody remembers exactly why.',
   'Snowflake Server',
   'metrics-collector-01 has been hand-maintained, directly, over SSH, for every single change since Act 3 -- seventeen undocumented differences from what any playbook would expect, none of them malicious, each one a reasonable fix made in isolation by whoever was on call that day. It was never migrated when everything else moved to immutable, code-managed infrastructure, because nobody ever decided to stop patching it long enough to notice it needed replacing instead.',
   'Every other host in this story is immutable, code-managed, and reproducible on demand. The next question is what happens once these are not single hosts at all, but a whole cluster that has to schedule and coordinate itself.',
   'Snowflake Server', 'Snowflake', 'elevated', 80, 28, 'pathway-atlas');
