-- Atlas Division pathway ("The Silence"): World row for Act 29,
-- "Disaster", closing act-atlas-8 ("World VIII -- The Failure Zone")
-- entirely (Acts 26-29 done -- confirmed via the doc's own
-- `# WORLD IX -- PLATFORM CITY` heading appearing only after this Act's
-- topics, no new Act row needed). Content (missions) follows in its own
-- migration.
--
-- Narrative thread: Act 28's transition_hook named the exact gap directly
-- -- "no way to survive losing an entire piece of infrastructure
-- outright." This Act builds real business continuity for
-- atlas-metrics-db: cross-region replication, defined RPO/RTO targets, an
-- active-passive failover topology, DNS-based failover, and a written
-- runbook. The region-wide "Black Sky" drill proves the database itself
-- now recovers well within target -- but reveals that the DNS record
-- pointing at it was never given a short enough TTL, so real
-- client-observed recovery still took far longer than the infrastructure
-- actually needed.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-disaster', 'act-atlas-8', 28, 'disaster', 'Disaster', 'Disaster',
   'Failure domains; backups; snapshots; replication; RPO; RTO; active-passive; active-active; DNS failover; recovery; runbooks.',
   'Act 28 proved this fleet''s resilience patterns hold, and exposed the real gap underneath them: atlas-metrics-db has no way to survive losing an entire piece of infrastructure outright. Vey commits to building it real business continuity, on purpose, before the next drill finds the gap by accident instead.',
   'Black Sky',
   'The "Black Sky" drill -- an entire primary region simulated as gone, not just one zone -- proves the database itself now recovers well within target: the cross-region replica promotes cleanly, inside the defined RTO, with replication lag well inside the defined RPO. But real, client-observed recovery still took far longer than that, because the DNS record pointing at the database was left with a one-hour TTL that nobody ever revisited once the failover itself was built. The infrastructure came back on time. Nobody could actually reach it until their own cached DNS answer finally expired.',
   'This fleet can now expect failure, contain it, and recover from losing an entire region on purpose. What it does not have is any way to give that same hard-won discipline to every other team building on top of it, without each of them living through the same twenty-nine Acts first.',
   'Black Sky', 'CloudOff', 'critical', 128, 16, 'pathway-atlas');
