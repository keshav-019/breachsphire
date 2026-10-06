-- Backend Engineering ("The Fracture") -- post-game spine. Adds everything
-- from the source doc's Sections 5-12 that wasn't in the core 32-Act
-- campaign, adapted to the existing worlds/campaigns/missions engine
-- (no new schema, no new ChallengeTypes -- decision confirmed with the
-- user's recommended defaults when the clarifying question went
-- unanswered: adapt to the existing engine, Node/TS-only, no new grading
-- infrastructure).
--
-- Four new Arcs, appended after Act 32 in map order (the engine's
-- lock/unlock is strictly linear per pathway index, so doc-stated
-- "unlocks after Act 14 / Act 21" positioning for the specialist tracks
-- is approximated as "available once the whole core campaign is cleared"
-- rather than a mid-campaign branch -- a real simplification, noted here
-- on purpose):
--   act-be-9  "Arc IX -- Mastery"   (doc Sections 8-10: Messaging, GraphQL, Database specializations)
--   act-be-10 "Arc X -- The Arena"  (doc Section 5: 12 System Design Arenas)
--   act-be-11 "Arc XI -- Portfolio" (doc Section 6: 5 practical project campaigns)
--   act-be-12 "Arc XII -- Field Ops" (doc Sections 11-12: On-Call incident library + Interview Arena)
--
-- Out of scope, not built here (flagged to the user): doc Section 7
-- (Java/Python/Go language-specialization replay tracks -- Node/TS only
-- per the recommended default), Section 13 (a Backend-specific RANKS list
-- -- PLAYER_RANKS is currently one global list shared with Cyber
-- Guardians; changing it is a rank-architecture decision, not a content
-- one), Sections 14-16 (design philosophy / MVP release staging / mission
-- statement -- not buildable content, already effectively satisfied by
-- the shipped 32-Act campaign).

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-be-9', 8, 'mastery', 'Arc IX -- Mastery',
   'The core campaign taught every tool once, under real pressure, at the moment its absence hurt. This Arc goes back to three of them -- messaging, GraphQL, and the database itself -- and asks for real depth instead of first contact: not "does this work," but "do you actually know this tool well enough to defend a choice against a better engineer who disagrees with you."',
   'Systems architect -> subject-matter specialist',
   'pathway-backend'),
  ('act-be-10', 9, 'the-arena', 'Arc X -- The Arena',
   'No incident, no mentor, no hint chain shaped around a specific bug. Twelve open system-design problems, the kind asked in a real interview room, each one scored across four rising difficulty modes: a clean beginner architecture, a version that has to hold under real scale, a version with a live production incident injected into it, and a version constrained the way a real interviewer constrains you on purpose.',
   'Subject-matter specialist -> system designer',
   'pathway-backend'),
  ('act-be-11', 10, 'portfolio', 'Arc XI -- Portfolio',
   'Everything up to here proved understanding inside Forge''s systems. This Arc proves it can leave the building: five real, buildable projects, each one a legitimate portfolio piece, each one forcing the same decisions Forge has been making all along with no simulation standing between the player and the actual code.',
   'System designer -> engineer with a portfolio',
   'pathway-backend'),
  ('act-be-12', 11, 'field-ops', 'Arc XII -- Field Ops',
   'The last two rooms in Forge Division are the two a working engineer actually returns to for the rest of their career: the pager, and the interview panel. Neither one is a story. Both of them are the job.',
   'Engineer with a portfolio -> working backend engineer',
   'pathway-backend');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  -- Arc IX -- Mastery (3 worlds)
  ('world-be-messaging-mastery', 'act-be-9', 32, 'messaging-mastery', 'Messaging Mastery', 'Messaging Mastery',
   'A deep specialist pass across BullMQ, RabbitMQ and Kafka -- the same three systems the core campaign already used, now studied for their internals, their failure recovery, and the judgment call of picking the right one instead of the familiar one.',
   'Leadership wants one page that says, for any given messaging need, which of Forge''s four options -- a synchronous API, BullMQ, RabbitMQ, or Kafka -- is actually correct, and why the other three are wrong for that specific case.',
   'The Trial of Twenty Scenarios',
   'Writing the real decision guide surfaces how often the team picked a tool out of familiarity rather than fit -- three past incidents this Arc revisits turn out to have been solvable with a simpler system than the one that was actually deployed.',
   'Depth on messaging is done. GraphQL and the database itself get the same treatment next.',
   'The Trial of Twenty Scenarios', 'Radio', 'elevated', 15, 152, 'pathway-backend'),

  ('world-be-graphql-mastery', 'act-be-9', 33, 'graphql-mastery', 'GraphQL Mastery', 'GraphQL Mastery',
   'Nested resolvers, DataLoader batching, federation and schema stitching concepts, subscriptions, persisted queries, query whitelisting, depth limits, cost analysis, field-level authorization, and gateway concepts -- the parts of GraphQL that only matter at real scale.',
   'A single crafted query, five levels of nested relations deep, brings the GraphQL gateway to its knees -- technically valid, technically answerable, and expensive enough to be indistinguishable from an attack.',
   'THE QUERY OF INFINITE DEPTH',
   'The fix is never "ban nested queries" -- it''s cost analysis and depth limiting applied deliberately, the same instinct as every rate limiter this campaign has ever built, aimed at a shape of abuse GraphQL makes uniquely easy to construct by accident.',
   'GraphQL earns real depth. The database underneath every one of these systems gets the same treatment next.',
   'THE QUERY OF INFINITE DEPTH', 'Share2', 'elevated', 29, 152, 'pathway-backend'),

  ('world-be-database-mastery', 'act-be-9', 34, 'database-mastery', 'Database Mastery', 'Database Mastery',
   'MVCC, WAL concepts, vacuum, logical vs. physical replication, partition pruning, index-only scans, partial indexes, JSONB, advisory locks, when not to use a database as a queue, connection proxies, and zero-downtime migrations.',
   'A "quick" schema migration locks a hot table for four minutes in production, and nobody on the team can explain afterward why a change that looked so small took the whole write path down with it.',
   'The Migration That Didn''t Feel Small',
   'Understanding what a migration actually does under the hood -- locks, rewrites, index builds -- turns "just add a column" from a one-line PR into a real engineering decision with a real blast radius, every time.',
   'Arc IX closes. Every core tool this campaign ever introduced has now been tested for both first contact and real depth. What''s left isn''t a tool. It''s a design problem with no mentor standing next to you.',
   'The Migration That Didn''t Feel Small', 'Database', 'elevated', 43, 152, 'pathway-backend'),

  -- Arc X -- The Arena (12 worlds)
  ('world-be-arena-url-shortener', 'act-be-10', 35, 'arena-url-shortener', 'Arena: URL Shortener', 'Arena: URL Shortener',
   'Design a URL shortener from ambiguous requirements: ID generation, the database, the cache, the redirect path, and what changes once it has to run at real scale.',
   'A product manager hands you one sentence: "we need short links." Everything else -- scale, abuse prevention, custom aliases, analytics -- is a question you have to ask, not a spec you''re given.',
   'The Arena Grades Itself',
   'The arena has no mentor and no incident report -- just a scored architecture, judged the same way a real interview panel judges one.',
   'One arena down, eleven to go. Each one hands you the same kind of silence and expects a real design out of it.',
   null, 'Globe', 'guarded', 8, 172, 'pathway-backend'),

  ('world-be-arena-rate-limiter', 'act-be-10', 36, 'arena-rate-limiter', 'Arena: Rate Limiter', 'Arena: Rate Limiter',
   'Design a rate limiter from ambiguous requirements: token bucket vs. sliding window, and how a single counter becomes a correct one once it has to be distributed across many nodes.',
   'Every service in the building wants "add rate limiting" and none of them can tell you what algorithm they actually need or why.',
   'The Arena Grades Itself',
   'The grading harness cares about one thing: does the design actually hold at the load it claims to handle.',
   'The counter that has to agree across every node is a preview of the next arena''s real problem: state that has to be right everywhere at once.',
   null, 'Gauge', 'guarded', 22, 172, 'pathway-backend'),

  ('world-be-arena-notification-platform', 'act-be-10', 37, 'arena-notification-platform', 'Arena: Notification Platform', 'Arena: Notification Platform',
   'Design a notification platform from ambiguous requirements: queues, fanout to multiple channels, retries, and per-user preference rules that change which channels even apply.',
   'One event needs to become an email, a push notification, and an SMS, for some users but not others, without ever sending the same alert twice.',
   'The Arena Grades Itself',
   'There is no NPC to ask a clarifying question of -- ambiguity itself is part of what''s being graded.',
   'Fanout at notification scale is a small preview of fanout at feed scale -- same shape, much bigger numbers next.',
   null, 'Radio', 'guarded', 36, 172, 'pathway-backend'),

  ('world-be-arena-chat-system', 'act-be-10', 38, 'arena-chat-system', 'Arena: Chat System', 'Arena: Chat System',
   'Design a chat system from ambiguous requirements: WebSockets, presence, message ordering, and where the conversation history actually lives.',
   'Two users on opposite sides of the world need to see each other''s messages in the order they were actually sent, know when the other is online, and never lose a message to a dropped connection.',
   'The Arena Grades Itself',
   'Ordering and presence guarantees are checked against the same kind of adversarial trace a real production chat system would actually see.',
   'Ordering guarantees under real-time constraints is exactly the discipline the next arena needs, just spread across millions of readers instead of two.',
   null, 'Terminal', 'guarded', 50, 172, 'pathway-backend'),

  ('world-be-arena-news-feed', 'act-be-10', 39, 'arena-news-feed', 'Arena: News Feed', 'Arena: News Feed',
   'Design a news feed from ambiguous requirements: fanout-on-write vs. fanout-on-read, caching, ranking, and how feed generation changes for a user who follows a million accounts.',
   'A celebrity account with ten million followers posts once, and every naive fanout strategy either falls over immediately or leaves ten million people staring at a stale feed.',
   'The Arena Grades Itself',
   'The grading harness injects the exact traffic shape naive fanout strategies fail on, on purpose.',
   'Ranking and caching at feed scale sets up file storage''s own scale problem: getting the actual bytes to everyone, fast, cheaply.',
   null, 'TrendingUp', 'guarded', 64, 172, 'pathway-backend'),

  ('world-be-arena-file-storage', 'act-be-10', 40, 'arena-file-storage', 'Arena: File Storage', 'Arena: File Storage',
   'Design a file storage system from ambiguous requirements: object storage, metadata, chunked uploads, and a CDN in front of all of it.',
   'A single service is expected to hold everything from a one-kilobyte thumbnail to an eighty-gigabyte archive, and serve every one of them fast, from everywhere.',
   'The Arena Grades Itself',
   'The design is graded against files at both extremes -- one kilobyte and eighty gigabytes -- in the same run.',
   'Chunking and metadata for arbitrary files is most of what a payment ledger needs too, minus the money -- and money is next.',
   null, 'Boxes', 'guarded', 78, 172, 'pathway-backend'),

  ('world-be-arena-payment-system', 'act-be-10', 41, 'arena-payment-system', 'Arena: Payment System', 'Arena: Payment System',
   'Design a payment system from ambiguous requirements: idempotency, a real ledger, transaction boundaries, and reconciliation when two records disagree.',
   'A retried payment request must never charge a customer twice, and a ledger that can''t prove its own numbers are correct after the fact isn''t a ledger, it''s a guess.',
   'The Arena Grades Itself',
   'The harness replays every request exactly twice, on purpose, and grades whether the ledger ever notices.',
   'Idempotency at payment stakes is the sharpest version of a problem this whole campaign has circled since Act 1 -- can this operation safely happen twice.',
   null, 'KeyRound', 'guarded', 8, 192, 'pathway-backend'),

  ('world-be-arena-search', 'act-be-10', 42, 'arena-search', 'Arena: Search', 'Arena: Search',
   'Design a search system from ambiguous requirements: indexing strategy, async pipelines keeping the index honest, and relevance ranking that actually matches intent.',
   'A search box that returns technically-matching, practically-useless results is worse than no search box -- it teaches users the feature doesn''t work.',
   'The Arena Grades Itself',
   'Relevance is graded against real queries with real, sometimes contradictory intent -- there is no single correct ranking to memorize.',
   'An async indexing pipeline is a small, focused version of what video processing needs next, just with heavier payloads.',
   null, 'Search', 'guarded', 22, 192, 'pathway-backend'),

  ('world-be-arena-video-processing', 'act-be-10', 43, 'arena-video-processing', 'Arena: Video Processing', 'Arena: Video Processing',
   'Design a video processing pipeline from ambiguous requirements: chunked uploads, transcoding queues, worker fleets, object storage, and a CDN for delivery.',
   'A single uploaded video has to become five different resolutions, transcoded reliably, without a slow worker ever blocking the upload path itself.',
   'The Arena Grades Itself',
   'The grading harness intentionally stalls one worker mid-pipeline to see whether the rest of the system notices.',
   'Everything about geography and delivery here scales directly into the next arena''s much harder version: matching people, not files, across a city in real time.',
   null, 'Activity', 'guarded', 36, 192, 'pathway-backend'),

  ('world-be-arena-ride-matching', 'act-be-10', 44, 'arena-ride-matching', 'Arena: Ride Matching', 'Arena: Ride Matching',
   'Design a ride-matching system from ambiguous requirements: geospatial indexing, realtime location events, and regional partitioning so matching stays fast as the city grows.',
   'Ten thousand riders and drivers are all moving at once, and a match has to happen in under a second without scanning every driver in the city for every request.',
   'The Arena Grades Itself',
   'The harness simulates ten thousand simultaneous movements and grades whether a match still resolves in under a second.',
   'The metrics needed to even know this system is healthy are their own design problem -- high-cardinality, high-throughput, and next.',
   null, 'Radar', 'guarded', 50, 192, 'pathway-backend'),

  ('world-be-arena-metrics-platform', 'act-be-10', 45, 'arena-metrics-platform', 'Arena: Metrics Platform', 'Arena: Metrics Platform',
   'Design a metrics platform from ambiguous requirements: high write throughput, aggregation strategy, and retention policy that doesn''t bankrupt the storage budget.',
   'Every service in the building wants to emit metrics at a rate that would, unmanaged, produce more monitoring data than actual application data.',
   'The Arena Grades Itself',
   'The grading harness floods the write path on purpose, the same flood a real launch day would produce.',
   'Every design constraint this Arena has asked for -- scale, consistency, cost, regional failure -- comes back at once in the final arena.',
   null, 'TrendingUp', 'guarded', 64, 192, 'pathway-backend'),

  ('world-be-arena-global-commerce', 'act-be-10', 46, 'arena-global-commerce', 'Arena: Global Commerce', 'Arena: Global Commerce',
   'The Arena''s capstone: design a global commerce platform from ambiguous requirements, combining multi-region architecture, inventory consistency, payments, event-driven fulfillment, and disaster recovery into one coherent system.',
   'One platform, sold in every region Forge operates, has to keep inventory honest, process payments safely, and survive losing an entire region -- all three requirements pulling against each other.',
   'The Final Design Review',
   'Every constraint from every prior arena returns here at once, graded together instead of one at a time.',
   'Arc X closes. Every design constraint in the Arena was a rehearsal for building something real -- which is exactly what Arc XI asks for next.',
   'The Final Design Review', 'Building2', 'critical', 78, 192, 'pathway-backend'),

  -- Arc XI -- Portfolio (5 worlds)
  ('world-be-project-civic-api', 'act-be-11', 47, 'project-civic-api', 'Project: Civic API', 'Project: Civic API',
   'Build a real, working REST API from scratch: proper routing, validation, PostgreSQL persistence, authentication, and a real test suite -- no simulation standing in for the actual code.',
   'The portfolio starts at the beginning on purpose: the same shape of system Act 4 first taught, this time with nothing pre-built and no safety net but your own tests.',
   'Ship the Civic API',
   'There is no simulated backend behind this one -- the tests either pass against real code or they don''t.',
   'One real, working, tested service exists. Nexus Commerce adds everything that makes a service actually production-shaped.',
   'Ship the Civic API', 'Building2', 'guarded', 15, 212, 'pathway-backend'),

  ('world-be-project-nexus-commerce', 'act-be-11', 48, 'project-nexus-commerce', 'Project: Nexus Commerce', 'Project: Nexus Commerce',
   'Extend a real service with Redis caching, a simulated payments flow, background queues, object storage for product assets, and real search -- the layers that turn a CRUD API into a production system.',
   'The Civic API works, but it''s naive: no caching, no async work, no search. Every gap is a real feature to add, not a lesson to read.',
   'Ship Nexus Commerce',
   'Every added layer is graded by whether it actually improves the system, not by whether it''s merely present.',
   'A working commerce platform exists. Transit Realtime adds the layer none of this has needed yet: live, streaming data.',
   'Ship Nexus Commerce', 'Boxes', 'guarded', 29, 212, 'pathway-backend'),

  ('world-be-project-transit-realtime', 'act-be-11', 49, 'project-transit-realtime', 'Project: Transit Realtime', 'Project: Transit Realtime',
   'Build a real-time system from scratch: WebSocket connections, a Kafka event stream, real consumers, and a live dashboard that actually updates as events arrive.',
   'A transit dashboard that refreshes every thirty seconds isn''t real-time -- it''s a page that lies convincingly for twenty-nine of them.',
   'Ship Transit Realtime',
   'The dashboard is graded on latency end-to-end, not on whether the code compiles.',
   'One real-time system exists, alone. Forge Microservices asks whether more than one service can talk to each other honestly.',
   'Ship Transit Realtime', 'Activity', 'guarded', 43, 212, 'pathway-backend'),

  ('world-be-project-forge-microservices', 'act-be-11', 50, 'project-forge-microservices', 'Project: Forge Microservices', 'Project: Forge Microservices',
   'Build a real microservices system from scratch: an API gateway, multiple independent services, RabbitMQ or Kafka between them, a transactional outbox, and distributed tracing across the whole call path.',
   'Every service works alone in a demo. The portfolio needs proof they can work together, honestly, with a trace showing exactly what happened when they don''t.',
   'Ship Forge Microservices',
   'The trace is the grade -- if it doesn''t show the truth of what happened between services, the services don''t actually cooperate.',
   'Multiple services exist and cooperate. Global Nexus asks whether all of it survives being deployed, scaled, and broken on purpose.',
   'Ship Forge Microservices', 'Share2', 'guarded', 57, 212, 'pathway-backend'),

  ('world-be-project-global-nexus', 'act-be-11', 51, 'project-global-nexus', 'Project: Global Nexus', 'Project: Global Nexus',
   'The portfolio capstone: containerize everything built across this Arc, wire up real CI/CD, add real observability, and run a genuine failover simulation to prove it survives losing a piece of itself.',
   'Every prior project works on one machine, one demo, one time. Global Nexus has to work the way real systems actually have to: deployed, observed, and tested against its own failure.',
   'Ship Global Nexus',
   'The failover simulation is graded on whether the system stays up, not on whether the postmortem sounds good afterward.',
   'Arc XI closes. The portfolio is real, built, and battle-tested. What''s left isn''t a build -- it''s the two rooms every working engineer keeps coming back to.',
   'Ship Global Nexus', 'Cloud', 'critical', 71, 212, 'pathway-backend'),

  -- Arc XII -- Field Ops (2 worlds)
  ('world-be-oncall-rotation', 'act-be-12', 52, 'oncall-rotation', 'On-Call Rotation', 'On-Call Rotation',
   'A repeatable library of standalone production incidents -- connection pool exhaustion, cache stampede, poison messages, N+1 queries, bad deploys, clock skew, region outages, and more -- each one a page that starts with an alert and ends with a fix, no ongoing story required.',
   'The pager goes off. It always starts the same way: an alert, a dashboard, and no idea yet what''s actually wrong.',
   'Every Alert, Answered',
   'Every incident in the rotation is drawn from a real failure mode this campaign has already taught, replayed cold, without the mission context that made it easy the first time.',
   'On-call proves you can react. The Interview Arena proves you can explain why, afterward, to someone who wasn''t there.',
   null, 'Bug', 'elevated', 29, 232, 'pathway-backend'),

  ('world-be-interview-arena', 'act-be-12', 53, 'interview-arena', 'The Interview Arena', 'The Interview Arena',
   'A rotating set of interview-style questions -- REST vs. GraphQL, why Redis is fast, what idempotency means, how to design a notification service -- answered using systems this pathway already made you repair firsthand.',
   'The panel asks a question you already know the answer to, in your hands, from an incident you actually lived through. The only new skill left is saying it out loud, clearly, under pressure.',
   'The Last Question',
   'Every question in the rotation maps back to a system this pathway already made you fix -- the arena is grading recall under pressure, not new knowledge.',
   'Forge Division has no incidents left to hand you. Whatever comes next, you build it.',
   'The Last Question', 'GraduationCap', 'elevated', 57, 232, 'pathway-backend');
