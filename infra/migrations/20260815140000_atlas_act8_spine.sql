-- Atlas Division pathway ("The Silence"): Act row for World III --
-- "Container Docks" (Acts 8-9 of the doc: Containment, Container
-- Production) -- plus the World row for its first Act, "Containment"
-- (Docker foundations). Content (missions) follows in its own
-- migration, same two-step pattern as every prior World.
--
-- World II closed cleanly at the end of Act 7 -- the v12.1.0 arc is
-- fully resolved. This Act deliberately opens a new, self-contained
-- thread rather than continuing that story: with the collector finally
-- stable, Rook starts containerizing Atlas Division's services so that
-- "an oversized image reaching production" (the root cause all the way
-- back in Act 3) can never happen the same way twice. The first
-- attempt is a naive, bloated Dockerfile; the Act's own arc is fixing
-- it, ending on a genuine technical win rather than another incident.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-3', 2, 'container-docks', 'World III -- Container Docks',
   'With v12.1.0 finally stable in production, Rook starts containerizing Atlas Division''s services outright -- so that a machine image nobody resized in months can never again be the reason something breaks. The player learns Docker from first principles while fixing a genuinely bloated first attempt, then what changes once containers are actually running in production for real.',
   'Understands git, build, CI and CD end to end -> can containerize a real service correctly, from a naive first Dockerfile to a production-ready image',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-containment', 'act-atlas-3', 7, 'docker-foundations', 'Containment', 'Containment',
   'Images versus containers; Dockerfiles; layers; build context; volumes; networks; environment variables; Compose; multi-stage builds; optimization; registries.',
   'Rook''s first attempt at containerizing atlas-metrics-agent builds -- and the resulting image is over a gigabyte, takes 94 seconds to push, and drags a build context stuffed with .git history and node_modules along with it. The exact same gravity that produced Act 3''s undersized machine image is already pulling this container down too.',
   'Container Escape Velocity',
   'None of this was ever really about the image itself. It was every habit carried over from building VM images -- installing a full toolchain nobody strips out afterward, a build context nobody ever bothered to scope, one giant layer instead of a build stage separated cleanly from a runtime stage. Fix all three at once, and the same service drops from 1.1 gigabytes to 31 megabytes -- fast enough, finally, to escape the gravity that shaped every image before it.',
   'One image, built small and clean on purpose, is the proof this can be done right from the very first line of a Dockerfile. The next question is what changes once containers like this one are actually the thing running in production.',
   'Container Escape Velocity', 'Container', 'guarded', 56, 12, 'pathway-atlas');
