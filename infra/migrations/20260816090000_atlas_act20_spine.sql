-- Atlas Division pathway ("The Silence"): World row for Act 20, "Keep
-- Them Alive", still under act-atlas-6 ("World VI -- The Cluster
-- Sea"). Content (missions) follows in its own migration.
--
-- Narrative thread: HPA scales the collector fleet up for real under
-- real load, and every single new replica OOMKills almost immediately.
-- The memory limit turns out to be 512Mi -- the exact untouched value
-- from Act 3's original test-tier image manifest, before Act 3's own
-- fix resized it to 2048Mi for the original VM. That fix never carried
-- forward into the Kubernetes Deployment when this workload was
-- containerized and orchestrated -- the pathway's oldest bug,
-- resurfacing at cluster scale.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-keep-them-alive', 'act-atlas-6', 19, 'keep-them-alive', 'Keep Them Alive', 'Keep Them Alive',
   'Liveness; readiness; startup probes; requests; limits; CPU throttling; OOMKilled; HPA; PodDisruptionBudgets; rolling updates; termination.',
   'Real load finally hits the collector fleet, and the HorizontalPodAutoscaler does exactly what it is supposed to -- scaling from 2 replicas to 17 within minutes. Every single new replica enters CrashLoopBackOff within seconds of starting.',
   'CrashLoop City',
   'The autoscaler is not the problem -- it is working exactly as designed. Every replica it creates inherits the same memory limit: 512Mi, the identical untouched number from Act 3''s original test-tier image manifest, before Act 3 ever resized it to 2048Mi for the original VM. That fix apparently never carried forward into the Kubernetes Deployment when this workload was containerized -- the pathway''s very first bug, unnoticed for nineteen Acts, now OOMKilling seventeen replicas at once instead of one host.',
   'Every replica this cluster runs is now sized for the load it actually carries, not a number copied forward from a machine that stopped existing Acts ago. The next question is how any of this actually gets operated day to day, not just kept running.',
   'CrashLoop City', 'HeartCrack', 'critical', 92, 36, 'pathway-atlas');
