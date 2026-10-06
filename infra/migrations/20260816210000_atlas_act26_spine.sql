-- Atlas Division pathway ("The Silence"): Act row for World VIII --
-- "The Failure Zone" -- plus the World row for its first Act, "On
-- Call" (incident response). Content (missions) follows in its own
-- migration, same two-step pattern as every prior World.
--
-- Narrative thread: with real incident-response process finally built
-- -- severity, incident command, blameless postmortems, runbooks --
-- Atlas Division does something it never actually did at the time: a
-- proper, structured postmortem of 03:17, the exact original incident
-- that opened this entire story back in Act 1. Not a new crisis. The
-- first real closure on the one that started everything.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-8', 7, 'the-failure-zone', 'World VIII -- The Failure Zone',
   'Every layer of this infrastructure -- hosts, pipelines, containers, clusters, GitOps, observability -- has been built and hardened, one incident at a time, since Act 1. This World is about what happens the moment something fails anyway: real incident response, real resilience patterns, and finally, a proper blameless postmortem of the very first incident this story ever had.',
   'Can build and observe reliable infrastructure -> can actually respond to, recover from, and learn from its failures, formally and without blame',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-on-call', 'act-atlas-8', 25, 'on-call', 'On Call', 'On Call',
   'The incident lifecycle; severity; detection; triage; incident command; communication; mitigation; recovery; postmortems; blameless analysis; runbooks.',
   'With real incident-response process finally in place, Cross proposes something Atlas Division never actually did at the time -- a proper, structured, blameless postmortem of 03:17, the exact incident that opened this entire story.',
   '03:17',
   'Everything about that night was always going to be findable, in hindsight, by exactly the process this World just built -- three independent, unremarkable causes (an expiring certificate, a filling disk, a killed process) discovered simultaneously because nobody, on any team, was watching every layer at once. Nobody was ever attacked. Nobody was ever careless. The postmortem that should have existed since Act 1 finally does.',
   'The story this entire pathway opened with finally has a real, written ending, twenty-five Acts later. The next question is what happens when failure is not the exception anymore, but something this infrastructure is actually built to expect.',
   '03:17', 'FileClock', 'guarded', 116, 12, 'pathway-atlas');
