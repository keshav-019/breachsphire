-- Atlas Division pathway ("The Silence"): World row for Act 25,
-- "Reliability", closing act-atlas-7 ("World VII -- The Signal
-- Tower", Acts 22-25, confirmed via the doc's own "# WORLD VIII"
-- heading appearing only after this Act's boss). Content (missions)
-- follows in its own migration.
--
-- Narrative thread: with observability and tracing both real now,
-- Atlas Division leadership, chasing a new enterprise customer, wants
-- to commit to "four nines" (99.99%) availability. Cross does the
-- actual math against this pathway's own real incident history --
-- Acts 9, 17, 18, 19, 20, 21 and 23 -- and finds measured reliability
-- nowhere close, closing this World on the difference between an
-- aspirational number and an evidence-based one.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-reliability', 'act-atlas-7', 24, 'reliability', 'Reliability', 'Reliability',
   'What SRE actually is; SLIs; SLOs; SLAs; error budgets; availability; latency objectives; burn rates; toil; automation; velocity versus reliability.',
   'Chasing a new enterprise customer, Atlas Division leadership wants to commit to "four nines" -- 99.99% availability -- starting next quarter. Cross is asked to confirm the fleet can actually deliver it.',
   'Four Nines',
   'Four nines allows roughly 52 minutes of downtime across an entire year. Measured honestly against this fleet''s actual incident history -- Acts 9, 17, 18, 19, 20, 21 and 23, real hours, not minutes -- current availability sits closer to 99.2%. Reaching four nines for real would take an order of investment nobody has funded yet: multi-region failover, far more automation, toil driven close to zero. None of that makes the target dishonest to want. It makes committing to it today, in writing, to a paying customer, a promise nobody could actually keep.',
   'Every promise this fleet makes about its own reliability is finally backed by a real number, not a hopeful one. Everything since Act 1 has been about keeping systems running -- the next question is what actually happens the moment one of them does not.',
   'Four Nines', 'Gauge', 'guarded', 104, 36, 'pathway-atlas');
