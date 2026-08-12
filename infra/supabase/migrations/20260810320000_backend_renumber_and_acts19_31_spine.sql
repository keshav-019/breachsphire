-- Backend Engineering ("The Fracture") -- structural fix + spine for the
-- backfilled/continuation Acts.
--
-- CONTEXT: Acts 19-25 were originally authored using a mis-recalled Act
-- list that skipped 4 real Acts from the source doc (Kafka & Event
-- Streaming, Event-Driven Architecture, Advanced Event Systems, Search
-- Systems). This migration is metadata-only -- it does NOT rename any
-- mission/campaign/objective/challenge id (those stay exactly as shipped,
-- e.g. 'mission-be19-*' still belongs to "Backend Security" forever; ids
-- are opaque identifiers, not position markers) -- it only corrects each
-- affected world's `index` (map position / unlock order) and `act_id`
-- (which Arc it belongs to), and relabels the two Arc rows whose content
-- membership changes.
--
-- The source doc's own Arc summary (section 3) turns out to be internally
-- inconsistent from Arc IV onward: each Arc's one-line topic blurb
-- actually matches the *next* Arc's literal "Acts N-M" range almost
-- exactly (e.g. Arc IV "Protect & Prove: security, testing, files,
-- storage" describes real Acts 22-25, not the stated 19-21). Resolution
-- used here: keep the doc's Arc flavor names/blurbs, but attach each one
-- to the real Acts it actually describes, so every Arc ends up non-empty
-- and thematically correct. Going forward, new world ids use a
-- slug-based scheme (`world-be-<slug>`) instead of `world-be-<N>`,
-- specifically so number 32 is never accidentally minted for anything
-- other than the real Act 32 finale.

-- Step 1: bump the 7 affected worlds' index out of the way to avoid
-- transiently violating unique(pathway_id, index) against each other.
update public.worlds set index = index + 1000
where id in ('world-be-19', 'world-be-20', 'world-be-21', 'world-be-22', 'world-be-23', 'world-be-24', 'world-be-25');

-- Step 2: relabel act-be-4 (was "Arc IV -- Protect & Prove", now the real
-- Kafka/Event-Driven/Advanced-Events cluster) and act-be-5 (was
-- "Arc V -- Scale", now the real Backend Security/Files/Search/Testing
-- cluster, which is what the doc's "Protect & Prove" blurb actually
-- describes).
update public.acts set
  slug = 'stream',
  title = 'Arc IV -- Stream',
  purpose = 'Every message Forge sends now assumes someone is listening right now. This Arc asks what happens when that assumption breaks -- when order matters, when delivery can''t be guaranteed exactly-once, when a consumer group falls silent mid-rebalance. The player learns event streaming and event-driven architecture while the recurring pattern keeps surfacing in exactly the kind of place these systems are worst at noticing: a partition key, a schema field, an offset nobody double-checked.',
  player_transformation = 'Messaging-literate backend engineer -> event-systems backend engineer'
where id = 'act-be-4';

update public.acts set
  slug = 'protect-and-prove',
  title = 'Arc V -- Protect & Prove',
  purpose = 'Every system Forge has built now talks to every other system. This Arc asks whether any of it survives contact with something adversarial or simply large: a real security review, a file too big for any buffer, a search index across a billion records, and the discipline of actually testing all of it before finding out the hard way.',
  player_transformation = 'Event-systems backend engineer -> production-hardened backend engineer'
where id = 'act-be-5';

-- Step 3: new Arc rows for the two remaining real clusters.
insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-be-6', 5, 'scale', 'Arc VI -- Scale',
   'Every piece Forge builds now survives contact with reality individually. This Arc asks what happens when it all has to work together, under real traffic, as one system that''s outgrown what any single service or single team can hold in their head -- and, for the first time, gives Forge a live, continuous view of exactly how much of that traffic still carries the signature it has been quietly tracking since Act 2.',
   'Production-hardened backend engineer -> systems-scale backend engineer',
   'pathway-backend'),
  ('act-be-7', 6, 'operate', 'Arc VII -- Operate',
   'Every service Forge runs now has to actually run somewhere, deployed by a real process, on real infrastructure, orchestrated at a scale no engineer manually babysits one host at a time. This Arc asks whether Forge can ship changes safely, and keep dozens of moving parts alive, without the discipline this whole campaign has built collapsing the moment it meets a deploy pipeline and a container scheduler.',
   'Systems-scale backend engineer -> platform-operations backend engineer',
   'pathway-backend');

-- Step 4: set the 7 renumbered worlds down to their final correct index,
-- act_id and map position.
update public.worlds set index = 21, act_id = 'act-be-5', x = 50, y = 72 where id = 'world-be-19'; -- Backend Security -> real Act 22
update public.worlds set index = 22, act_id = 'act-be-5', x = 64, y = 72 where id = 'world-be-20'; -- Files, Media & Object Storage -> real Act 23
update public.worlds set index = 24, act_id = 'act-be-5', x =  8, y = 92 where id = 'world-be-21'; -- Testing the System -> real Act 25
update public.worlds set index = 25, act_id = 'act-be-6', x = 22, y = 92 where id = 'world-be-22'; -- Performance & Scale -> real Act 26
update public.worlds set index = 26, act_id = 'act-be-6', x = 36, y = 92 where id = 'world-be-23'; -- Modular Monolith to Microservices -> real Act 27
update public.worlds set index = 27, act_id = 'act-be-6', x = 50, y = 92 where id = 'world-be-24'; -- Resilience Engineering -> real Act 28
update public.worlds set index = 28, act_id = 'act-be-7', x = 64, y = 92 where id = 'world-be-25'; -- Observability & Production -> real Act 29

-- Step 5: spine rows for the 6 backfilled/continuation worlds. New ids
-- are slug-based (see header note) -- content migrations for each
-- reference these ids and use a matching `mission-be-<slug>-NN` /
-- `campaign-be-<slug>` / `operation-be-<slug>-N` id prefix.
insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-be-kafka', 'act-be-4', 18, 'kafka-and-event-streaming', 'Kafka & Event Streaming', 'Kafka & Event Streaming',
   'Queue vs event log, Kafka architecture, brokers and topics, partitions, offsets, producers, consumer groups, partition keys and ordering, retention and replay, commits and rebalances, and delivery semantics.',
   'RabbitMQ solved the immediate fanout crisis, but the auditors reviewing the outage response want something RabbitMQ was never built for: a full, replayable, append-only record of every event Forge has ever emitted, for as long as compliance requires it.',
   'The Rebalance Storm',
   'Migrating the audit stream to Kafka goes fine until a routine deploy triggers a consumer-group rebalance during peak load, and for eleven seconds every partition is briefly owned by nobody -- events pile up, and when ownership settles, one partition''s offset commit is a few events behind where it should be. Tracing the exact events reprocessed twice, one message key is a citizen record id with a doubled slash appended, sitting in a partition that has silently reprocessed more often than any other partition Forge has ever measured.',
   'A log you can replay is only as trustworthy as the ordering guarantees around it. The team''s response to one partition''s messages needs to know about every other service''s response to the same event -- which means the events themselves need to carry more than data. They need to carry intent.',
   'The Rebalance Storm', 'Radio', 'critical', 8, 72, 'pathway-backend'),

  ('world-be-event-driven', 'act-be-4', 19, 'event-driven-architecture', 'Event-Driven Architecture', 'Event-Driven Architecture',
   'Events vs commands, pub/sub, choreography, orchestration, eventual consistency, dual-write failure, transactional outbox, inbox pattern, change data capture concepts, saga pattern, and compensating transactions.',
   'A dispatch order is marked "confirmed" in the orders service and "never received" in fulfillment -- both true, from what each service actually saw, and nobody can agree which one lied.',
   'The Lost Order',
   'The orders service wrote to its own database, then tried to publish a confirmation event -- and the publish failed silently after the database commit already succeeded. A classic dual-write: the two operations were never atomic, so a real order now exists that no other service will ever learn about unless someone hand-fixes it. Building a proper outbox finally lets the team query every event ever meant to be published but wasn''t, and one row, from months ago, has a destination topic name with a "//" where a single slash belongs.',
   'Making one dual-write safe with an outbox is done. But now that every service reacts to events instead of waiting to be asked, nobody can point to a single place that shows what actually happened, in order, across the whole system -- some of these operations are complex enough that they need more than a fire-and-forget event.',
   'The Lost Order', 'Workflow', 'critical', 22, 72, 'pathway-backend'),

  ('world-be-advanced-events', 'act-be-4', 20, 'advanced-event-systems', 'Advanced Event Systems', 'Advanced Event Systems',
   'Event schema evolution, schema registry concepts, event versioning, event sourcing, CQRS, materialized views, stream processing, windowing concepts, deduplication, exactly-once (myth vs effect), and Kafka vs RabbitMQ vs BullMQ.',
   'A schema change to the citizen-registration event -- adding one optional field -- breaks four consumers that were never told the change was coming, three of which silently drop every event instead of erroring loudly.',
   'The Event That Never Happened',
   'A stream-processing job meant to deduplicate registration events, built on the (technically false) assumption that "exactly-once" delivery means an event physically arrives exactly once, quietly drops a legitimate second registration attempt that looked like a duplicate but wasn''t -- a real citizen''s real event, treated as if it never happened. Auditing the deduplication window''s key-generation logic, the field it hashes on for identity has, in a small percentage of records, the same doubled-slash tag Forge has been tracking since Act 2 -- and those records are exactly the ones the dedup logic gets wrong.',
   'The event layer is now versioned, replayable and honestly deduplicated. Every core building block Forge set out to build in this Arc now exists. Whether any of it survives an attacker, a file too large for memory, or a genuinely adversarial security review is what the next Arc actually tests.',
   'The Event That Never Happened', 'Layers', 'critical', 36, 72, 'pathway-backend'),

  ('world-be-search', 'act-be-5', 23, 'search-systems', 'Search Systems', 'Search Systems',
   'Database search vs a real search engine, inverted indexes, Elasticsearch/OpenSearch concepts, documents and mappings, analyzers, tokenization, full-text search, relevance, filters, autocomplete, and search index synchronization.',
   'A caseworker searching for a citizen by a partial, misspelled name gets zero results from a database LIKE query that took four seconds to fail -- while the same citizen''s record has sat in the registry the entire time.',
   'Find One Citizen in a Billion Records',
   'A real search engine solves relevance and typo-tolerance, but the index quietly drifts from the source database the moment someone forgets that a search index is a copy, not a source of truth -- a citizen record updated in Postgres doesn''t exist in Elasticsearch until something re-indexes it. Backfilling the index for the first time surfaces records that exist in the database but had never once been searchable, and a disproportionate share of them carry the "//" tag -- as if whatever writes them has been deliberately avoiding the one code path that would make them findable.',
   'Search finally works, and search is honest about what it does and doesn''t know. Whether Forge''s systems hold up against someone actively trying to break them, rather than just against normal wear, is the next and much less comfortable question.',
   'Find One Citizen in a Billion Records', 'Search', 'critical', 78, 72, 'pathway-backend'),

  ('world-be-deploy-cloud', 'act-be-7', 29, 'deployment-cloud-and-containers', 'Deployment, Cloud & Containers', 'Deployment, Cloud & Containers',
   'Linux production runtime, reverse proxy and Nginx concepts, Docker, Docker Compose, CI/CD, environment promotion, rolling deployment, blue/green, canary deployment, feature flags, and cloud backend building blocks.',
   'A routine Friday deploy takes down the whole platform for six minutes because there was never a real rollout strategy -- just stop the old process, start the new one, and hope nothing in between matters.',
   'Deployment Friday',
   'Building a real rolling deployment with health checks finally makes deploys boring -- until the team notices the deploy pipeline itself has a step, untouched for over a year, that stamps every build artifact with a build-tag template, and that template contains a literal "//" nobody has ever explained, silently present in every single production artifact Forge has ever shipped.',
   'Deploys are safe now. But safe deploys onto a handful of manually-managed boxes doesn''t scale to what Forge actually runs today -- dozens of services, none of which anyone wants to babysit by hand anymore.',
   'Deployment Friday', 'Cloud', 'critical', 78, 92, 'pathway-backend'),

  ('world-be-kubernetes', 'act-be-7', 30, 'kubernetes-and-platform-backends', 'Kubernetes & Platform Backends', 'Kubernetes & Platform Backends',
   'The Kubernetes mental model, pods, deployments, services, ConfigMaps and secrets, ingress, liveness and readiness, resource requests and limits, horizontal pod autoscaling, jobs and CronJobs, and rolling updates and debugging.',
   'A service that never had memory limits set gets scheduled next to three others on the same node, gets OOM-killed under load, restarts, gets OOM-killed again -- a crash loop nobody can stop without understanding what Kubernetes actually promises and what it doesn''t.',
   'CrashLoop City',
   'Fixing the resource limits stops the crash loop, but reading through every deployment manifest in the cluster for the first time -- something nobody had ever done in one sitting -- turns up a CronJob, scheduled every day at 2:00 AM, running a container image nobody currently at Forge remembers deploying, whose only argument is a single string: a path containing "//". It has apparently been running successfully, silently, every night, for longer than anyone has been checking.',
   'Every core piece of what Forge builds, secures, connects, scales and now operates is real, running, and -- as far as anyone can prove -- healthy. What''s left isn''t a new skill. It''s the question underneath all of them: what happens when the whole thing has to survive something bigger than any single failure this campaign has simulated. That question doesn''t have an easy answer yet.',
   'CrashLoop City', 'Boxes', 'critical', 8, 112, 'pathway-backend');
