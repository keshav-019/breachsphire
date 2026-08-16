-- Atlas Division pathway ("The Silence"): World row for Act 34,
-- "Multi-Region", still under act-atlas-10 ("World X -- Atlas").
-- Content (missions) follows in its own migration.
--
-- Narrative thread: Act 33 closed by naming the next problem plainly --
-- this fleet still runs from a single home region, on a single
-- continent. Vey stands up a genuine third region, in the EU, for real
-- latency and redundancy reasons. "Two Continents" finds that Act 29's
-- own disaster-recovery replication pipeline, working exactly as it was
-- built to, has been quietly copying EU customer data into the US
-- region the whole time -- because nobody ever scoped a DR system,
-- designed purely for resilience, against a data-residency requirement
-- it was never built to know about.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-multi-region', 'act-atlas-10', 33, 'multi-region', 'Multi-Region', 'Multi-Region',
   'Global DNS; CDN/edge; regional isolation; multi-region apps; global DB concepts; traffic steering; failover; data residency; latency; consistency; capacity.',
   'This fleet still runs from a single home region, on a single continent. Vey stands up a genuine third region, in the EU, for real latency and redundancy -- and to finally serve EU customers data that is supposed to stay in the EU.',
   'Two Continents',
   'The new EU region works exactly as designed -- lower latency for EU customers, real regional isolation, clean traffic steering. But a routine data-residency audit finds EU customer records present in the us-west-2 replica, and they have been there since Act 29. Act 29''s own disaster-recovery replication pipeline is not malfunctioning -- it is doing precisely what it was built to do, replicating every customer record uniformly for resilience, with no region-aware exception ever added, because nobody building a DR system for availability was ever asked to think about where data is legally allowed to live.',
   'This fleet finally runs across two real continents, correctly, with data staying where it is required to. Every layer built across this entire pathway -- compute, containers, cloud, Terraform, Kubernetes, GitOps, observability, resilience, disaster recovery, a real platform, a service mesh, a supply chain, real cost discipline, real global reach -- has never actually been tested all at once. It is about to be.',
   'Two Continents', 'Globe', 'critical', 158, 22, 'pathway-atlas');
