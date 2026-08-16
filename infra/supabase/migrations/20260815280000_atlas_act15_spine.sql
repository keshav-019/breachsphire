-- Atlas Division pathway ("The Silence"): World row for Act 15,
-- "State of the World", still under act-atlas-5 ("World V -- The
-- Terraform Expanse"). Content (missions) follows in its own
-- migration.
--
-- Correction versus the prior round's memory note: re-reading the
-- source doc directly confirms World V actually spans Acts 14-16
-- (Infrastructure as Code, State of the World, Configuration) -- the
-- next "# WORLD" heading in the doc does not appear until after Act
-- 16's boss ("WORLD VI -- THE CLUSTER SEA"), not after Act 15. No new
-- Act row here; Act 16 is the one that will actually close this World.
--
-- Narrative thread: Act 14's transition_hook set this up directly --
-- "what happens once state itself has to be shared safely across more
-- than one person changing it at once." Rook migrates state to a
-- remote backend with locking -- but the newest module (the Act 12/13
-- serverless pieces) had not been migrated yet when the one laptop
-- holding its only local state file died.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-state-of-the-world', 'act-atlas-5', 14, 'state-of-the-world', 'State of the World', 'State of the World',
   'Remote state; state locking; modules; module interfaces; workspaces; data sources; import; lifecycle; for_each and count; secrets in state; module versioning.',
   'Rook starts migrating every workspace to a shared, locked remote backend, module by module -- the core region first. Before the newest module, the one covering the Act 12/13 serverless pieces, gets its turn, the one laptop holding its only local state file dies.',
   'The Lost State',
   'Every resource region_guard_remediate depends on is still running perfectly in AWS -- nothing about the infrastructure itself was ever at risk. Terraform''s own record of it is simply gone, because that one module had not been migrated to the remote backend yet when the laptop that held its local state was lost. The infrastructure was never lost. Only Terraform''s memory of managing it was.',
   'Every workspace now lives in one shared, locked, remote backend -- no local laptop is a single point of failure for infrastructure state again. The next question is what happens to everything running inside these servers, not just the servers themselves.',
   'The Lost State', 'FileWarning', 'elevated', 80, 20, 'pathway-atlas');
