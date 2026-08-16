-- Atlas Division pathway ("The Silence"): World row for Act 35, "The
-- Control Plane", still under act-atlas-10 ("World X -- Atlas").
-- Content (missions) follows in its own migration.
--
-- Narrative thread: the Act 30 platform's own auto-remediation
-- controller -- built to keep every self-service database's backup
-- schedule in sync with its desired state -- goes wrong in three
-- compounding ways at once: its reconciliation loop compares an
-- unstable field, so it believes real state never converges and keeps
-- reapplying forever; it runs three replicas with no leader election, so
-- all three do this simultaneously; and nothing rate-limits its calls to
-- the management API, so nothing was ever going to stop it from hammering
-- the one system every other controller on this fleet also depends on.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-control-plane', 'act-atlas-10', 34, 'control-plane', 'The Control Plane', 'The Control Plane',
   'Control vs data plane; management APIs; schedulers; controllers; reconciliation; desired state; leader election; coordination; rate limits; safe automation; blast radius.',
   'The Act 30 platform''s own auto-remediation controller -- built to keep every self-service database''s backup schedule reconciled with its desired state -- starts hammering the management API without any real work getting done.',
   'Controller Gone Wild',
   'Three separate, individually plausible gaps compound into one real incident. The controller''s reconciliation loop compares its desired state against a field that changes on every read, so it always sees a difference and always reapplies, forever, even when nothing real has actually changed. It runs three replicas for redundancy, but nothing was ever configured to elect a single leader among them, so all three run this same broken loop at once, tripling the damage. And nothing rate-limits its calls to the shared management API, so nothing in the whole system was ever going to stop it before it started crowding out every other controller that also depends on that same API. No single piece was reckless. Together, unrated-limited, unelected, and comparing the wrong thing, they were enough.',
   'This fleet has now been proven safe under chaos, real disaster, real cost pressure, real global scale, and a runaway controller of its own making. Every layer this pathway ever built is about to be tested together, for the first time, all at once.',
   'Controller Gone Wild', 'GitBranch', 'critical', 164, 24, 'pathway-atlas');
