-- Backend Engineering ("The Fracture") -- Act 32 spine: Arc VIII (the
-- campaign's final Arc, one Act only, per the source doc's own structure)
-- and the world row for "Distributed Systems & The Fracture". Written
-- before any mission content, per this pathway's established pattern, so
-- content authoring never touches acts/worlds.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-be-8', 7, 'survive', 'Arc VIII -- Survive',
   'Every Arc before this one taught Forge to build one more layer that survives one more category of failure -- alone. This final Arc asks whether any of it survives together, all at once, when nothing about the failure is polite enough to happen one piece at a time. There is no passing grade for perfect uptime. There is only whether the city stays alive while everything underneath it breaks.',
   'Platform-operations backend engineer -> systems architect',
   'pathway-backend');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-be-distributed-systems', 'act-be-8', 31, 'distributed-systems-and-the-fracture', 'Distributed Systems & The Fracture', 'Distributed Systems & The Fracture',
   'Replication, replication lag, failover and split-brain, partitioning and sharding, consistency models, CAP and PACELC intuition, unreliable networks and partial failure, distributed locks/leases/fencing, leader election and consensus intuition, multi-region architecture, and disaster recovery -- the last skill layer, and the one every prior Arc has been quietly assuming away.',
   'The 2 AM CronJob from the Kubernetes cluster has a name now, half-recovered from a decommissioned artifact registry: a chaos-engineering harness nobody currently at Forge remembers authorizing, still running, still tagging every synthetic failure it injects with the same doubled slash Forge has been finding for thirty-one Acts.',
   'THE FRACTURE',
   'It was never an intruder. It was never automated malice, either. Years ago, before anyone on the current team joined, a reliability research group built a harness to continuously inject correlated, realistic failure into production and prove the platform could survive it -- the honest ancestor of everything this Arc teaches on purpose. The team that owned it was dissolved. The harness was never told to stop, and it was built resilient enough that nothing since has managed to kill it by accident. Every "//" tag across two years of incidents was never a signature of intent. It was a synthetic-failure marker, from a system built to fail things on purpose, that nobody has been watching for over two years -- until now.',
   'Quantified. Identified. Neither one was ever the hard part. The hard part was always this: something built to break things safely, running unsupervised for two years, is still a live, armed, escalating system -- and it just noticed someone is finally watching it back.',
   'THE FRACTURE', 'Network', 'critical', 43, 132, 'pathway-backend');
