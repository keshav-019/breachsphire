-- Backend Engineering ("The Fracture") -- world/act "spine" for Acts 16-20.
-- Acts 16-18 close Arc III (Connect); Acts 19-20 open a new Arc IV
-- (Protect & Prove). Pre-authored in full before any mission content, same
-- pattern as 20260810045000_... and 20260810140000_....

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-be-4', 3, 'protect-and-prove', 'Arc IV -- Protect & Prove',
   'Every piece Forge has built now works in isolation. This Arc asks whether it survives contact with real conditions: real attackers, real file sizes, real production load. For the first time, evidence surfaces that something outside Forge''s own systems is looking for the same pattern the team has been quietly tracking for an Arc and a half.',
   'Integration-literate backend engineer -> production-hardened backend engineer',
   'pathway-backend');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-be-16', 'act-be-3', 15, 'caching', 'Caching', 'Caching',
   'Why cache, local vs distributed caches, Redis fundamentals, cache-aside, read-through, write-through, TTL and eviction, cache invalidation, stale data, and cache stampede / hot keys.',
   'With realtime service links live, the transit dashboard now hammers the same "next three arrivals" query thousands of times a second. The database survives -- barely -- and Forge finally has to justify a cache instead of just scaling the database harder.',
   'The Stampede',
   'A popular cache key expires at the exact same instant across every replica, and all of them hit the database at once the moment it does. Digging into why the timing lined up that precisely turns up a shared deploy-time TTL seed -- and, again, an unexplained "//" prefix sitting inside the cache key namespace itself.',
   'Caching absorbs read load, but a new problem shows up: expensive work -- sending notifications, generating reports -- is now happening inside the request path, and it shouldn''t be. Forge needs an actual background job system.',
   'The Stampede', 'Zap', 'severe', 50, 52, 'pathway-backend'),

  ('world-be-17', 'act-be-3', 16, 'jobs-and-message-queues', 'Jobs & Message Queues', 'Jobs & Message Queues',
   'Request work vs background work, job queues, producers and consumers, BullMQ fundamentals, delayed/scheduled jobs, priorities, retries, exponential backoff, jitter, dead-letter jobs and idempotent workers.',
   'A city-wide outage advisory, submitted as a single API call, tries to synchronously message one million residents inline. The request times out with the batch half-sent.',
   'The Million Jobs',
   'The retry logic behind it has no backoff and no idempotency key -- every timeout triggers a full resubmission, so some residents got the alert zero times and others got it forty. The dead-letter path that should have caught the failures was never wired up, and its queue name, when Forge finally finds it, is prefixed with "//".',
   'A job queue is enough for one service. City-wide messaging has to fan reliably out to inventory, billing, notifications and audit -- systems that don''t share a codebase, a language, or a deploy schedule. That needs a real message broker.',
   'The Million Jobs', 'Layers', 'severe', 64, 52, 'pathway-backend'),

  ('world-be-18', 'act-be-3', 17, 'rabbitmq-and-brokered-messaging', 'RabbitMQ & Brokered Messaging', 'RabbitMQ & Brokered Messaging',
   'Message broker fundamentals, RabbitMQ architecture, exchanges, queues, bindings, routing keys, direct/topic/fanout exchanges, acknowledgements and prefetch, and dead-letter exchanges.',
   'Forge stands up RabbitMQ to fan the outage-advisory event out to four independent teams'' services at once. On day one, a single malformed message crashes every consumer that touches it -- and keeps crashing them, forever.',
   'The Poison Message',
   'The message is never acknowledged, because the consumer crashes before it can ack -- so RabbitMQ redelivers it endlessly, with no dead-letter exchange configured to catch it. Fixing it means auditing every exchange and binding in the broker for the first time, which turns up a topic-exchange routing key, buried in infrastructure config, literally named forge.events//audit.',
   'The pattern has now been found in application code, inside the database layer, and inside the message layer connecting every service together. Forge can no longer treat it as noise confined to any one part of the stack. Whether any of what''s been built survives a real attacker, real scale, and real production conditions is the next, harder question.',
   'The Poison Message', 'Boxes', 'critical', 78, 52, 'pathway-backend'),

  ('world-be-19', 'act-be-4', 18, 'backend-security', 'Backend Security', 'Backend Security',
   'Threat modelling, input validation, SQL and NoSQL injection, CORS, CSRF, SSRF awareness, secure headers, rate limiting, brute-force protection, and dependency/secret security.',
   'With every layer now connected, a routine external security review of one public API turns up findings Forge assumed were impossible in code they''d already shipped: unvalidated input reaching a query, a CORS policy that trusts everything, no rate limiting at all.',
   'The Exposed API',
   'None of the individual findings are the pattern -- this is ordinary security debt, the kind every team accumulates. But fixing the CORS misconfiguration surfaces server logs showing months of automated probing from outside Forge''s network, aimed specifically at endpoints containing a doubled slash -- as if something out there has been testing for the exact shape of what Forge keeps finding internally.',
   'The findings are patched. The probing traffic is what won''t leave Mira alone: for the first time, there''s evidence something outside Forge is looking for this too. Before chasing that, the team needs to know their systems can survive real failure conditions at the file and infrastructure level, not just a security review.',
   'The Exposed API', 'ShieldAlert', 'critical', 8, 72, 'pathway-backend'),

  ('world-be-20', 'act-be-4', 19, 'files-media-and-object-storage', 'Files, Media & Object Storage', 'Files, Media & Object Storage',
   'Multipart forms, streaming uploads, large-file handling, object storage, S3 concepts, signed URLs, file metadata, CDN delivery, image processing pipelines, malware-scanning architecture and resumable upload concepts.',
   'A city resident tries to upload a 20-gigabyte encrypted case archive to a public records portal. The upload fails at 94% every time, silently, with no way to resume and no clear error.',
   'The 20-Gigabyte Upload',
   'The root cause is mundane: no support for chunked or resumable uploads, and a memory buffer sized for files a hundredth this size. But building proper resumable upload support finally gives Forge visibility into every large object stored across the city''s systems -- and a metadata audit turns up a handful of objects, uploaded over several years, all carrying the familiar doubled-slash tag, none of them ever downloaded by a human account.',
   'Every core building block Forge has now exists and holds up under real conditions. Whether it holds up as a whole system, under real production load, deployed the way real production actually deploys, is a different question -- performance, scale and architecture at a level bigger than any one service, next.',
   'The 20-Gigabyte Upload', 'Image', 'critical', 22, 72, 'pathway-backend');
