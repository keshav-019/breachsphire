-- Atlas Division pathway ("The Silence"): World row for Act 9,
-- "Container Production", closing act-atlas-3 ("World III -- Container
-- Docks", Acts 8-9: Containment, Container Production). Content
-- (missions) follows in its own migration.
--
-- Narrative thread: Act 8 ended on a genuine win -- a lean, distroless,
-- 31MB image. This Act complicates that win on purpose rather than
-- treating it as unconditionally correct: distroless has no shell, no
-- package manager, and critically no init system, and running a
-- compiled binary directly as PID 1 makes it solely responsible for
-- reaping its own child processes. Nobody added that responsibility
-- deliberately -- and across a whole fleet of replicas, zombie
-- processes have been quietly accumulating ever since.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-container-production', 'act-atlas-3', 8, 'container-production', 'Container Production', 'Container Production',
   'PID 1 and its responsibilities; signals; graceful shutdown; health checks; resource limits; running as non-root; image security; registry workflows; logging; production networking; distroless concepts.',
   'A routine fleet audit finds it almost by accident: every replica of the newly-optimized atlas-metrics-agent has been quietly accumulating zombie processes for days. Health checks are green. Resource usage looks fine. Nothing has crashed. And the process table keeps growing anyway.',
   'The Zombie Fleet',
   'A distroless image has no shell, no package manager -- and no init system either. Running the compiled binary directly as PID 1 made it solely responsible for reaping its own child processes, a responsibility nobody assigned on purpose. Every five minutes, a small health-check helper subprocess spawns, exits, and is never reaped, because nothing in this container was ever built to do that job. Health checks only ever asked whether the HTTP endpoint responded -- never whether the process table itself was healthy.',
   'One lean image, finally running correctly in production, with an init process actually reaping what it spawns. Everything since Act 1 has lived on bare hosts, VMs, and now containers -- the next question is what changes once a whole platform, not just one host, is the thing being trusted.',
   'The Zombie Fleet', 'Skull', 'elevated', 56, 20, 'pathway-atlas');
