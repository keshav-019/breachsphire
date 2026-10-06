-- Atlas Division pathway ("The Silence"): World row for Act 7,
-- "Continuous Delivery", closing act-atlas-2 ("World II -- The
-- Factory", Acts 4-7: Git, Build, CI, CD) and the entire v12.1.0 arc
-- that has run since Act 4. Content (missions) follows in its own
-- migration.
--
-- Narrative thread: the leaked token from Act 6 is revoked and rotated,
-- the pipeline reruns clean, and for the first time this arc actually
-- produces a real, signed, checksummed artifact. This Act is not about
-- proving the fix anymore -- that was settled three Acts ago. It is
-- about safely getting one specific artifact through every environment
-- into production, on the day everyone is most afraid to do it.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-continuous-delivery', 'act-atlas-2', 6, 'continuous-delivery', 'Continuous Delivery', 'Continuous Delivery',
   'Delivery versus deployment; environments; approvals; rolling, blue-green and canary releases; feature flags; migration safety; rollback; progressive delivery; release metrics.',
   'The token is revoked. The pipeline reruns clean for the first time in this whole story -- build, lint, test and security all pass, and a real signed artifact for v12.1.0 finally exists. It is also Friday afternoon, and nobody on the team has stopped flinching at that fact yet.',
   'Friday Deployment',
   'Nothing about Friday itself was ever the danger. A canary release, a tested rollback runbook, and metrics watched in real time make any day interchangeable -- the fear was never really about the calendar, it was about deploying without any of those things in place. With all of them in place, v12.1.0 finally reaches metrics-collector-01: the exact resize that was supposed to happen in Act 3, real at last.',
   'One artifact, proven correct, built reproducibly, and delivered safely, closes the loop this entire World started with a dying host. The next question is what happens once everything Atlas Division runs lives inside containers instead of bare hosts and VMs.',
   'Friday Deployment', 'Rocket', 'guarded', 44, 36, 'pathway-atlas');
