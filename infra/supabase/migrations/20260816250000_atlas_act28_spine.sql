-- Atlas Division pathway ("The Silence"): World row for Act 28, "Chaos",
-- still under act-atlas-8 ("World VIII -- The Failure Zone"). Content
-- (missions) follows in its own migration.
--
-- Narrative thread: every resilience pattern built in Act 27 -- timeouts,
-- retries, backoff, circuit breakers, bulkheads, load shedding,
-- degradation, dependency budgets -- exists only on paper until it has
-- survived real, deliberately injected failure. A region-wide game day
-- (killing an entire availability zone on purpose) proves those patterns
-- work exactly as designed for the collector fleet -- but discovers that
-- atlas-metrics-db itself was never made highly available at all. The
-- fleet survives; the database does not, for the whole ninety minutes.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-chaos', 'act-atlas-8', 27, 'chaos', 'Chaos', 'Chaos',
   'Chaos principles; hypotheses; failure injection; kill instances; latency; packet loss; dependency failure; zone failure; backup tests; restore drills; game days.',
   'Cross proposes the fleet''s first formal chaos experiments -- not because anything is currently broken, but because every resilience pattern built in Act 27 has only ever been tested on paper, never against a real, deliberately injected failure.',
   'Burn the Region',
   'The region-wide game day -- an entire availability zone terminated on purpose -- proves every pattern from Act 27 works exactly as built. The collector''s circuit breaker trips cleanly, its bulkheads hold, it serves stale-but-honest cached data for the full ninety minutes, and nothing cascades. But atlas-metrics-db itself goes fully unreachable for that entire window and stays unreachable even after the zone comes back, because it was never deployed anywhere but that one zone in the first place. Resilient application code was never going to be enough on its own -- the database underneath it needed to survive too, and nothing had ever made sure it could.',
   'Every pattern this fleet built to survive failure gracefully just proved itself under real fire. What it does not yet have is any way to survive losing an entire piece of infrastructure outright -- that has to be designed on purpose next, not discovered by accident during the next drill.',
   'Burn the Region', 'Flame', 'critical', 122, 18, 'pathway-atlas');
