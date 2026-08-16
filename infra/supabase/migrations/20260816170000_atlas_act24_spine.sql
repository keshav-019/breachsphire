-- Atlas Division pathway ("The Silence"): World row for Act 24, "The
-- Trace", still under act-atlas-7 ("World VII -- The Signal Tower").
-- Content (missions) follows in its own migration.
--
-- Narrative thread: Act 23's transition_hook asked directly "what
-- happens once a single request has to be followed across every one
-- of these services it actually touches." Cross builds distributed
-- tracing to finally see *why* the legacy client's requests are
-- failing, not just that they are -- and discovers the fleet's random
-- 5% sampling rate has been quietly discarding almost all of the
-- actual evidence, because head-based sampling has no idea which
-- requests are about to fail before it decides whether to keep them.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-the-trace', 'act-atlas-7', 23, 'the-trace', 'The Trace', 'The Trace',
   'Tracing; spans; trace context; OpenTelemetry; instrumentation; sampling; correlation IDs; telemetry correlation; cardinality; pipelines; cost.',
   'Cross instruments the fleet for distributed tracing to finally see exactly why the legacy client''s requests keep failing -- and asks for every error trace from the last 24 hours. Of roughly 1,400 requests that should have failed, only 71 traces actually exist.',
   'The Five Percent',
   'The pipeline is not broken, and nothing was lost by accident. Every trace was sampled at a flat, random 5% -- head-based, decided the instant a request starts, with no way to know yet whether it is about to fail. The vast majority of the exact evidence this investigation actually needed was never kept in the first place, not because it was too expensive to keep, but because nothing about this sampling strategy was ever built to prioritize the requests that matter most.',
   'Errors are no longer just visible -- they are actually traceable, every single time, without anyone having to get lucky with a coin flip first. The next question is what this fleet actually promises anyone about how reliable it is, in numbers real enough to hold it to.',
   'The Five Percent', 'Route', 'guarded', 104, 28, 'pathway-atlas');
