-- Atlas Division pathway ("The Silence"): World row for Act 27,
-- "Failure Is Normal", still under act-atlas-8 ("World VIII -- The
-- Failure Zone"). Content (missions) follows in its own migration.
--
-- Narrative thread: atlas-metrics-db has one brief, routine slow
-- query -- exactly the kind of partial failure any distributed system
-- should expect. It resolves on its own in under two minutes. But the
-- collector's own database calls have no timeout configured, so
-- threads pile up waiting indefinitely, and within minutes every
-- service depending on the collector is degraded too. Not one big
-- failure -- one small, ordinary one, with nothing built to contain
-- it.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-failure-is-normal', 'act-atlas-8', 26, 'failure-is-normal', 'Failure Is Normal', 'Failure Is Normal',
   'Partial failure; timeouts; retries; backoff; jitter; circuit breakers; bulkheads; load shedding; backpressure; graceful degradation; dependency budgets.',
   'atlas-metrics-db has one brief, routine slow query, resolved on its own in under two minutes. Within that same window, the collector goes unresponsive, then the ingestion API, then everything that calls either of them.',
   'Cascade',
   'The database was never really the incident -- a slow query resolving itself in under two minutes is exactly the kind of partial failure a distributed system is supposed to expect and absorb. What actually happened is that the collector''s own database calls have no timeout configured at all, so every thread waiting on that one slow query simply never came back, until there were no threads left to serve anything else. One small, ordinary failure, with nothing built to contain it, is indistinguishable from a catastrophic one to everything downstream.',
   'Every dependency this fleet calls is now assumed to fail, sometimes, on purpose -- and contained when it does, instead of spreading. The next question is whether that assumption actually holds up on purpose, deliberately, before it is ever tested by accident again.',
   'Cascade', 'Waves', 'critical', 116, 20, 'pathway-atlas');
