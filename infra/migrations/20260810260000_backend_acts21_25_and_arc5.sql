-- Backend Engineering ("The Fracture") -- world/act "spine" for Acts 21-25.
-- Act 21 closes Arc IV (Protect & Prove); Acts 22-25 open AND complete a
-- new Arc V (Scale). Pre-authored in full before any mission content, same
-- pattern as the three earlier spine migrations.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-be-5', 4, 'scale', 'Arc V -- Scale',
   'Every piece Forge builds now survives contact with reality individually. This Arc asks what happens when it all has to work together, under real traffic, as one system that''s outgrown what any single service or single team can hold in their head -- and, for the first time, gives Forge a live, continuous view of exactly how much of that traffic still carries the signature it has been quietly tracking since Act 2.',
   'Production-hardened backend engineer -> systems-scale backend engineer',
   'pathway-backend');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-be-21', 'act-be-4', 20, 'testing-the-system', 'Testing the System', 'Testing the System',
   'The testing pyramid, unit tests, mocks/stubs/fakes, integration tests, database tests, API tests, contract tests, end-to-end tests, test containers, load tests, and stress/soak testing.',
   'After the external-probing discovery, Mira orders a full reliability audit: can anything Forge has built actually be trusted under adversarial testing, not just code review? The first real attempt at a test suite reveals half of what the team believed was "tested" was actually just run once, by hand, months ago.',
   'It Worked on My Machine',
   'A critical service passes every existing test and fails immediately in staging -- the gap is an environment-specific config value nobody wrote a test for, because nobody thought a computer needed to be told the thing that made local and staging look the same. While migrating fixtures across every suite, someone finds one shared fixture file, untouched for over a year, with a "//" typo in a path constant that every downstream test had silently accepted as correct.',
   'Testing proves the pieces work under real conditions. Whether the whole system holds up together, under real traffic, at real scale, is untested and unknown -- that''s where Arc V starts.',
   'It Worked on My Machine', 'Bug', 'critical', 36, 72, 'pathway-backend'),

  ('world-be-22', 'act-be-5', 21, 'performance-and-scale', 'Performance & Scale', 'Performance & Scale',
   'Latency, throughput, percentiles, profiling, CPU vs I/O bottlenecks, vertical and horizontal scaling, stateless services, load balancers, health checks, and capacity planning.',
   'A public event page goes viral overnight, and the service that was fine for a normal Tuesday falls over within four minutes of real traffic -- not a bug, just a system that was never built to scale past what one box could handle.',
   'Flash Crowd',
   'Scaling out horizontally works, but only once the team notices the service was quietly storing per-user state in local memory the whole time -- a change that should have taken an hour takes half a day because nothing was stateless to begin with. Buried in the incident''s capacity-planning spreadsheet, copied from an old template, one row label reads "requests//sec" instead of "requests/sec." Everyone assumed it was a typo. It has been in every capacity template Forge uses since before this Arc began.',
   'Scaling one service is solved. Scaling the whole system means asking whether it should still be one service at all -- and whether the monolith Forge has been quietly growing for twenty Acts is still the right shape.',
   'Flash Crowd', 'Gauge', 'critical', 50, 72, 'pathway-backend'),

  ('world-be-23', 'act-be-5', 22, 'modular-monolith-to-microservices', 'Modular Monolith to Microservices', 'Monolith to Microservices',
   'Why monoliths aren''t bad, the modular monolith, coupling and cohesion, domain-driven design concepts, bounded contexts, service boundaries, extracting a service, database-per-service, synchronous service communication, API gateways, and backend-for-frontend.',
   'Two teams now step on each other constantly inside the same codebase -- a deploy for one feature routinely breaks an unrelated one three folders away. Someone finally asks the question everyone''s been avoiding: should this actually be more than one service?',
   'The Distributed Monolith',
   'The team''s first attempt at splitting services goes badly: several deployables that still share one database and call each other synchronously in a tight, brittle chain -- arguably worse than the monolith it replaced. Doing it properly, with real bounded contexts and a database per service, forces Forge to formally document, for the first time, everywhere a "//" occurrence has ever physically lived. The map that produces is the first time anyone has drawn all of it as one diagram.',
   'Multiple independent services now exist, each with its own failure modes. What happens when one of them fails isn''t a testing question anymore -- it''s an operational one.',
   'The Distributed Monolith', 'Share2', 'critical', 64, 72, 'pathway-backend'),

  ('world-be-24', 'act-be-5', 23, 'resilience-engineering', 'Resilience Engineering', 'Resilience Engineering',
   'Partial failure, timeouts, retry safety, exponential backoff, jitter, retry storms, circuit breakers, bulkheads, load shedding, backpressure, and graceful degradation.',
   'One newly-extracted service goes down for ninety seconds. It should have been a minor blip. Instead, every service that called it synchronously, with no timeout, backs up and falls over too -- ninety seconds of downtime becomes a citywide fifteen-minute outage.',
   'Cascade',
   'No timeouts, no circuit breakers, and a retry storm the moment the failing service came back online made things worse, not better -- every client immediately re-hammered the service that had just recovered. Reviewing the incident timeline for anything that might explain the retry storm''s exact shape, Forge finds a decommissioned internal wiki page, barely indexed, referencing an old reliability-research initiative shut down years ago. Its internal codename is illegible in every surviving record except one field, which still renders as a single unbroken double slash. Nobody currently at Forge has ever heard of it.',
   'The system survives failure now, but surviving isn''t the same as knowing it''s failing -- next is seeing it happen in real time.',
   'Cascade', 'Shield', 'critical', 78, 72, 'pathway-backend'),

  ('world-be-25', 'act-be-5', 24, 'observability-and-production', 'Observability & Production', 'Observability & Production',
   'Structured logging, log levels, correlation IDs, metrics, the RED method, the USE method, distributed tracing, OpenTelemetry concepts, dashboards, alerts, and SLIs/SLOs/error budgets.',
   'Now that Forge''s systems survive failure instead of cascading from it, leadership asks a harder question: how would anyone actually know, in real time, that something started going wrong -- not after a citizen complains, but before?',
   'The Five Percent',
   'Building real dashboards and alerting finally gives Forge a live, aggregate view across every system it runs -- and in its very first week, an SLO dashboard quietly shows one specific class of request, five percent of all traffic pathway-wide, has had an error budget silently burning for months with no alert ever configured for it. Cross-referencing that five percent against everything Forge has logged all campaign gives the obvious, uncomfortable answer: it''s the "//"-tagged traffic. It was never rare. It was just never watched.',
   'For the first time, Forge isn''t discovering the pattern by accident -- it''s watching it, continuously, in a dashboard, and has to decide what to actually do with that. Whatever comes next has to be built for a system this size, running in production, for real -- deployment, cloud infrastructure and containers are where that starts.',
   'The Five Percent', 'Radar', 'critical', 8, 92, 'pathway-backend');
