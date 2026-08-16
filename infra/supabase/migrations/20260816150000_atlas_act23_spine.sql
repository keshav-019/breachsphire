-- Atlas Division pathway ("The Silence"): World row for Act 23, "The
-- Signal", still under act-atlas-7 ("World VII -- The Signal Tower").
-- Content (missions) follows in its own migration.
--
-- Narrative thread: Act 22's transition_hook asked directly "whether
-- anyone would even notice if it stopped working... since nobody is
-- watching it by hand anymore." Cross builds the fleet's first real
-- observability stack -- Prometheus, Grafana, actual alerts -- and the
-- very first dashboard reveals something nobody caught in two weeks: a
-- steady ~8% error rate, invisible because the liveness probe only
-- ever confirmed the process was running, never that requests were
-- actually succeeding.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-the-signal', 'act-atlas-7', 22, 'the-signal', 'The Signal', 'The Signal',
   'Observability versus monitoring; logs; structured logs; metrics; metric types; Prometheus; scraping; labels; Grafana; dashboards; alerts.',
   'Cross builds the fleet''s first real observability stack -- Prometheus scraping, Grafana dashboards, actual alerting -- and the very first dashboard ever rendered shows an error rate that has clearly been there far longer than the dashboard has.',
   'Invisible Failure',
   'A legacy client integration has been sending requests missing a required field for at least two weeks straight, failing roughly 8% of all traffic the entire time. Nothing caught it, because nothing was ever built to check for it -- the liveness probe only ever confirmed the process was running, and no error-rate alert existed until today. The collector was never actually silent. Nobody had ever built anything capable of hearing it.',
   'For the first time, this fleet can actually be asked new questions about its own behavior, not just checked against ones anyone thought to ask in advance. The next question is what happens once a single request has to be followed across every one of these services it actually touches.',
   'Invisible Failure', 'Radio', 'guarded', 104, 20, 'pathway-atlas');
