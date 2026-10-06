-- Atlas Division pathway ("The Silence"): Act row for World IV --
-- "Cloudreach" (Acts 10-13 of the doc: The Cloud Opens, Identity Plane,
-- AWS Sector, Serverless Frontier) -- plus the World row for its first
-- Act, "The Cloud Opens" (cloud foundations). Content (missions)
-- follows in its own migration, same two-step pattern as every prior
-- World.
--
-- World III closed cleanly at the end of Act 9. This Act opens a new,
-- self-contained thread rather than continuing the collector story --
-- a genuine jump in scope from one service to real multi-region
-- infrastructure. Tomas Vey (Cloud Architect, "networking, cloud,
-- Terraform, global architecture") leads this World, his first
-- sustained role since his Act 2 debut and one-mission Act 7 cameo.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-4', 3, 'cloudreach', 'World IV -- Cloudreach',
   'Every host, pipeline and container built so far has lived in one place. Vey leads Atlas Division into real multi-region cloud infrastructure -- a second region provisioned for redundancy, fully built out and seemingly healthy, until it becomes clear nothing is actually reaching it. The player learns cloud foundations end to end while tracing exactly why a region that looks correct in every dashboard is receiving zero real traffic.',
   'Can containerize and run a single service correctly -> understands cloud infrastructure across regions, from provisioning through shared-responsibility boundaries',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-the-cloud-opens', 'act-atlas-4', 9, 'the-cloud-opens', 'The Cloud Opens', 'The Cloud Opens',
   'IaaS, PaaS and SaaS; regions and availability zones; virtual networks; compute; block storage; object storage; managed databases; load balancers; DNS; CDN; the shared responsibility model.',
   'Atlas Division has run entirely out of one region since Act 1. Vey starts provisioning a second one for real redundancy -- a full build-out of network, compute, storage and a managed database, mirroring everything already running. Every resource comes up healthy. Nothing is actually using it.',
   'The Empty Region',
   'The provider held up its side completely -- the region exists, every resource inside it is healthy, and nothing about the infrastructure itself is broken. The gap is on Atlas Division''s own side of the shared responsibility line: nobody ever updated DNS or the load balancer to actually send traffic there. A perfectly healthy region is not the same thing as a reachable one.',
   'One region, fully built and finally reachable, is real multi-region redundancy for the first time. The next question is who -- and what -- is actually allowed to touch any of this.',
   'The Empty Region', 'Globe', 'guarded', 68, 12, 'pathway-atlas');
