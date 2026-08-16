-- Atlas Division pathway ("The Silence"): Act row for World V -- "The
-- Terraform Expanse" (Acts 14-15 of the doc: Infrastructure as Code,
-- State of the World) -- plus the World row for its first Act,
-- "Infrastructure as Code" (Terraform foundations). Content (missions)
-- follows in its own migration, same two-step pattern as every prior
-- World.
--
-- Narrative payoff: every "resource" block seen since Act 10 has
-- actually been prose written to look like Terraform HCL, never once
-- run through real tooling -- a deliberate in-fiction gap this Act
-- finally closes. Rook (Platform Engineer, "developer platforms,
-- golden paths, GitOps") returns to a leading role for the first time
-- since Act 7, since real infrastructure-as-code is squarely their
-- domain, with Vey supporting since it is his own cloud resources being
-- formalized. Running `terraform plan` for the very first time against
-- everything built across World IV immediately surfaces drift -- the
-- accumulated residue of legitimate emergency console fixes made
-- during real incidents (Acts 9, 12 and 13) that were never written
-- back into any configuration, because until now nothing was actually
-- enforcing that reconciliation.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-5', 4, 'the-terraform-expanse', 'World V -- The Terraform Expanse',
   'Every resource built across Region One has existed only as prose written to look like infrastructure code, never once applied by real tooling. Rook formalizes it into real Terraform -- and the very first `terraform plan` run against it all reveals drift everywhere: quiet, justified, undocumented console fixes made during real incidents, none of them ever written back into configuration. The player learns Terraform end to end while reconciling code and reality for the first time.',
   'Understands cloud infrastructure across regions and services -> can manage that same infrastructure safely as real, version-controlled, drift-aware code',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-infrastructure-as-code', 'act-atlas-5', 13, 'infrastructure-as-code', 'Infrastructure as Code', 'Infrastructure as Code',
   'Why IaC; HCL; providers; resources; variables; outputs; plan; apply; destroy; state; the dependency graph.',
   'Rook starts converting Region One''s hand-written "pretend Terraform" into real HCL, wired to a real provider, tracked in real state. The very first `terraform plan` ever run against it does not come back clean.',
   'Drift',
   'None of it was an attack, and none of it was carelessness in the moment. During Act 9''s zombie investigation, during Act 12''s Region One launch, during Act 13''s invocation storm, someone made a fast, correct, necessary fix directly against live infrastructure to resolve a real incident -- and every single one of those fixes was made through a console, not through code, because until this Act, there was no real Terraform actually enforcing that changes go through it at all. The infrastructure was always going to drift from a config that nothing was ever really applying.',
   'Region One is finally in sync with the code that is supposed to describe it, for the first time since it existed. The next question is what happens once that state itself -- the record of what is real -- has to be shared safely across more than one person changing it at once.',
   'Drift', 'GitCompare', 'elevated', 80, 12, 'pathway-atlas');
