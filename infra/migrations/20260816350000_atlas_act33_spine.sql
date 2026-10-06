-- Atlas Division pathway ("The Silence"): Act row for World X --
-- "Atlas" -- the pathway's final World -- plus the World row for its
-- first Act, "FinOps" (cloud economics). Content (missions) follows in
-- its own migration, same two-step pattern as every prior World.
--
-- Narrative thread: Act 32 closed by naming the last uncomfortable gap
-- directly -- every hard-won discipline in this pathway has lived inside
-- one team's infrastructure, and none of it has ever accounted for what
-- happens when the cost of running that infrastructure stops being
-- anyone's problem. "Infinite Bill" finds a real cost spike that is not
-- one runaway mistake, but two ordinary, easy-to-miss ones stacked
-- together: years of quietly forgotten idle resources, and one
-- autoscaling group stuck scaled up by a metric nobody ever reset.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-10', 9, 'atlas', 'World X -- Atlas',
   'Every layer this pathway has built -- compute, containers, cloud, Terraform, Kubernetes, GitOps, observability, SRE, resilience, disaster recovery, a real internal platform, a service mesh, and a full software supply chain -- has been built and hardened, one hard-earned lesson at a time. This final World is about what it costs to run all of it, at true global scale, and what happens the one time everything this pathway ever built is tested at once.',
   'Can build, operate, secure and platform-ize infrastructure expertly -> can run it responsibly at true global scale, and hold it together when everything fails at once',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-finops', 'act-atlas-10', 32, 'finops', 'FinOps', 'FinOps',
   'Cloud cost model; compute; storage; egress; idle resources; rightsizing; autoscaling economics; reserved capacity; spot; allocation; FinOps culture.',
   'Thirty-two Acts of building resilient, secure, well-platformed infrastructure, and nobody has been watching what any of it actually costs. Leadership flags a cloud bill that has quietly grown far faster than usage. Vey and Leena are asked to explain it, line by line.',
   'Infinite Bill',
   'The bill spike is not one runaway mistake. Deliberately investigated and ruled out first: the cross-region replication built in Act 29 for disaster recovery, which is real, expected, budgeted cost, working exactly as designed. The actual cause is two ordinary things stacked together -- a genuine idle-resources report finds several forgotten instances and volumes dating as far back as Act 10, never decommissioned once their original purpose ended, and a single autoscaling group stuck permanently scaled up because the metric that should have scaled it back down was never actually reset after an old incident. Nothing here was reckless. Nothing here was watched, either.',
   'This fleet now knows exactly what it costs to run, and why. It still runs from a single home region, on a single continent -- and the very next request on the table is standing it up somewhere else entirely.',
   'Infinite Bill', 'DollarSign', 'guarded', 152, 20, 'pathway-atlas');
