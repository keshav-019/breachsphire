-- Backend Engineering scope expansion.
--
-- The System Design Arena, portfolio campaigns, and language specialization
-- tracks are intentionally separate from campaigns -> operations -> missions.
-- They collect freeform designs, external build evidence, and track-specific
-- module progress respectively, so each receives a purpose-built model.

create table public.system_design_challenges (
  id text primary key,
  slug text not null unique,
  title text not null,
  domain text not null,
  summary text not null,
  prompt text not null,
  context text not null,
  functional_requirements jsonb not null,
  nonfunctional_requirements jsonb not null,
  modes jsonb not null,
  rubric jsonb not null,
  estimated_minutes integer not null check (estimated_minutes > 0),
  sort_order integer not null unique
);

create table public.system_design_submissions (
  id uuid primary key default gen_random_uuid(),
  player_id uuid not null references auth.users (id) on delete cascade,
  challenge_id text not null references public.system_design_challenges (id) on delete cascade,
  mode text not null check (mode in ('foundation', 'scale', 'incident', 'interview')),
  architecture text not null,
  assumptions text not null,
  tradeoffs text not null,
  score integer not null check (score between 0 and 100),
  criterion_scores jsonb not null,
  feedback jsonb not null,
  created_at timestamptz not null default now()
);

create index system_design_submissions_player_challenge_idx
  on public.system_design_submissions (player_id, challenge_id, created_at desc);

create table public.portfolio_campaigns (
  id text primary key,
  slug text not null unique,
  title text not null,
  tagline text not null,
  summary text not null,
  stack_options text[] not null default '{}',
  outcomes jsonb not null,
  sort_order integer not null unique
);

create table public.portfolio_milestones (
  id text primary key,
  campaign_id text not null references public.portfolio_campaigns (id) on delete cascade,
  title text not null,
  description text not null,
  deliverable text not null,
  sort_order integer not null,
  unique (campaign_id, sort_order)
);

create table public.player_portfolio_progress (
  player_id uuid not null references auth.users (id) on delete cascade,
  campaign_id text not null references public.portfolio_campaigns (id) on delete cascade,
  status text not null default 'not_started' check (status in ('not_started', 'in_progress', 'completed')),
  repo_url text not null default '',
  live_url text not null default '',
  reflection text not null default '',
  started_at timestamptz,
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  primary key (player_id, campaign_id)
);

create table public.player_portfolio_milestones (
  player_id uuid not null references auth.users (id) on delete cascade,
  milestone_id text not null references public.portfolio_milestones (id) on delete cascade,
  completed boolean not null default false,
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  primary key (player_id, milestone_id)
);

create table public.language_tracks (
  id text primary key,
  slug text not null unique,
  title text not null,
  language text not null,
  framework text not null,
  description text not null,
  icon text not null,
  estimated_hours integer not null check (estimated_hours > 0),
  capstone text not null,
  sort_order integer not null unique
);

create table public.language_track_modules (
  id text primary key,
  track_id text not null references public.language_tracks (id) on delete cascade,
  title text not null,
  description text not null,
  focus jsonb not null,
  project_step text not null,
  sort_order integer not null,
  unique (track_id, sort_order)
);

create table public.player_language_tracks (
  player_id uuid not null references auth.users (id) on delete cascade,
  track_id text not null references public.language_tracks (id) on delete cascade,
  status text not null default 'in_progress' check (status in ('in_progress', 'completed')),
  started_at timestamptz not null default now(),
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  primary key (player_id, track_id)
);

create table public.player_language_modules (
  player_id uuid not null references auth.users (id) on delete cascade,
  module_id text not null references public.language_track_modules (id) on delete cascade,
  completed boolean not null default false,
  reflection text not null default '',
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  primary key (player_id, module_id)
);

alter table public.system_design_challenges enable row level security;
alter table public.system_design_submissions enable row level security;
alter table public.portfolio_campaigns enable row level security;
alter table public.portfolio_milestones enable row level security;
alter table public.player_portfolio_progress enable row level security;
alter table public.player_portfolio_milestones enable row level security;
alter table public.language_tracks enable row level security;
alter table public.language_track_modules enable row level security;
alter table public.player_language_tracks enable row level security;
alter table public.player_language_modules enable row level security;

create policy "System design challenges are viewable by authenticated users"
  on public.system_design_challenges for select to authenticated using (true);
create policy "System design submissions viewable by owner"
  on public.system_design_submissions for select using (auth.uid() = player_id);
create policy "System design submissions insertable by owner"
  on public.system_design_submissions for insert with check (auth.uid() = player_id);
create policy "Portfolio campaigns are viewable by authenticated users"
  on public.portfolio_campaigns for select to authenticated using (true);
create policy "Portfolio milestones are viewable by authenticated users"
  on public.portfolio_milestones for select to authenticated using (true);
create policy "Portfolio progress viewable by owner"
  on public.player_portfolio_progress for select using (auth.uid() = player_id);
create policy "Portfolio progress insertable by owner"
  on public.player_portfolio_progress for insert with check (auth.uid() = player_id);
create policy "Portfolio progress updatable by owner"
  on public.player_portfolio_progress for update using (auth.uid() = player_id);
create policy "Portfolio milestones viewable by owner"
  on public.player_portfolio_milestones for select using (auth.uid() = player_id);
create policy "Portfolio milestones insertable by owner"
  on public.player_portfolio_milestones for insert with check (auth.uid() = player_id);
create policy "Portfolio milestones updatable by owner"
  on public.player_portfolio_milestones for update using (auth.uid() = player_id);
create policy "Language tracks are viewable by authenticated users"
  on public.language_tracks for select to authenticated using (true);
create policy "Language modules are viewable by authenticated users"
  on public.language_track_modules for select to authenticated using (true);
create policy "Language enrollment viewable by owner"
  on public.player_language_tracks for select using (auth.uid() = player_id);
create policy "Language enrollment insertable by owner"
  on public.player_language_tracks for insert with check (auth.uid() = player_id);
create policy "Language enrollment updatable by owner"
  on public.player_language_tracks for update using (auth.uid() = player_id);
create policy "Language module progress viewable by owner"
  on public.player_language_modules for select using (auth.uid() = player_id);
create policy "Language module progress insertable by owner"
  on public.player_language_modules for insert with check (auth.uid() = player_id);
create policy "Language module progress updatable by owner"
  on public.player_language_modules for update using (auth.uid() = player_id);

-- Replace the earlier placeholder World nodes. Mastery remains mission-based;
-- Arena and Portfolio now live in Forge Lab with their real interaction model.
delete from public.worlds where id like 'world-be-arena-%' or id like 'world-be-project-%';
delete from public.acts where id in ('act-be-10', 'act-be-11');

-- Four progressively harder variants are available for every Arena brief.
-- Challenge-specific requirements remain on the brief; these modes change the
-- operating conditions without changing the core problem.
with arena_modes as (
  select '[
    {"id":"foundation","label":"Foundation","description":"Produce a clear, correct first architecture before optimizing it.","constraints":["Single primary region","10,000 daily active users","Prefer operational simplicity"]},
    {"id":"scale","label":"At Scale","description":"Evolve the design for global traffic and uneven load.","constraints":["10 million daily active users","Multi-region traffic","Identify hot partitions and cost controls"]},
    {"id":"incident","label":"Incident Inject","description":"Defend the design while a critical dependency is failing.","constraints":["Primary datastore is degraded","Backlog is growing","Recovery must not corrupt or duplicate state"]},
    {"id":"interview","label":"Interview","description":"Make and defend the design under time and ambiguity pressure.","constraints":["35-minute design window","State assumptions before components","Interviewer changes one consistency or cost constraint"]}
  ]'::jsonb as value
), arena_rows (
  id, slug, title, domain, summary, prompt, context, functional_requirements,
  nonfunctional_requirements, rubric, estimated_minutes, sort_order
) as (values
  ('arena-url-shortener', 'url-shortener', 'Design a URL Shortener', 'Data & caching',
   'Create short links, resolve them quickly, and keep popular redirects reliable under abuse and scale.',
   'Design a production URL-shortening platform. Begin by stating the product and traffic assumptions you need before drawing components.',
   'A product manager has supplied only one sentence: “we need short links.” You own the questions, boundaries, architecture, and failure story.',
   '["Create random and custom short aliases","Redirect to the original URL","Expire or disable a link","Collect basic click analytics"]'::jsonb,
   '["Redirect p99 below 100 ms","No duplicate aliases","Read-heavy scaling","Abuse and malicious-link controls"]'::jsonb,
   '[{"key":"requirements","label":"Requirements & estimates","description":"Clarifies scope, traffic, and capacity.","weight":20,"keywords":["traffic","read","write","qps","retention","alias"]},{"key":"architecture","label":"Architecture","description":"Presents a coherent request and redirect path.","weight":30,"keywords":["api","service","cache","cdn","load balancer","redirect"]},{"key":"data","label":"Data & consistency","description":"Explains keys, collisions, and persistence.","weight":20,"keywords":["database","hash","id","collision","unique","replica"]},{"key":"reliability","label":"Scale & reliability","description":"Handles hot links and dependency failure.","weight":20,"keywords":["hot","ttl","failover","replication","partition","rate limit"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Defends choices and alternatives.","weight":10,"keywords":["tradeoff","alternative","because","cost","consistency"]}]'::jsonb, 45, 1),

  ('arena-rate-limiter', 'rate-limiter', 'Design a Distributed Rate Limiter', 'Traffic control',
   'Choose an algorithm, enforce quotas across nodes, and define what happens when the limiter itself is unhealthy.',
   'Design a reusable rate-limiting service for APIs with per-user, per-tenant, and global policies.',
   'Every service asks to “add rate limiting,” but their burst tolerance, identity keys, and failure preferences are different.',
   '["Configure multiple quota policies","Return remaining quota and retry time","Support bursts","Apply tenant and endpoint overrides"]'::jsonb,
   '["Sub-10 ms decision overhead","Correct across many API nodes","Resist noisy neighbors","Explicit fail-open or fail-closed behavior"]'::jsonb,
   '[{"key":"requirements","label":"Policy model","description":"Clarifies identities, quotas, and burst semantics.","weight":20,"keywords":["tenant","user","endpoint","quota","burst","window"]},{"key":"architecture","label":"Architecture","description":"Defines the request decision path.","weight":30,"keywords":["gateway","middleware","redis","service","local","lua"]},{"key":"data","label":"Algorithm & atomicity","description":"Defends algorithm and concurrent updates.","weight":20,"keywords":["token bucket","sliding window","atomic","counter","timestamp","clock"]},{"key":"reliability","label":"Distributed reliability","description":"Handles partitions and limiter failure.","weight":20,"keywords":["fail open","fail closed","partition","replica","fallback","latency"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Compares accuracy, memory, and availability.","weight":10,"keywords":["tradeoff","accuracy","memory","availability","cost"]}]'::jsonb, 45, 2),

  ('arena-notifications', 'notification-platform', 'Design a Notification Platform', 'Async messaging',
   'Fan out events to email, push, and SMS while honoring preferences, retries, and deduplication.',
   'Design a multi-channel notification platform used by dozens of product teams.',
   'One business event can produce several messages, but users have channel preferences and repeated delivery can be expensive or harmful.',
   '["Accept templated notification requests","Resolve user preferences","Deliver email, push, and SMS","Track delivery state and retries"]'::jsonb,
   '["Do not send the same logical notification twice","Absorb campaign bursts","Isolate channel-provider failures","Support audit and suppression"]'::jsonb,
   '[{"key":"requirements","label":"Delivery contract","description":"Defines channels, preferences, and guarantees.","weight":20,"keywords":["preference","template","channel","priority","schedule","idempotency"]},{"key":"architecture","label":"Architecture","description":"Builds a decoupled fanout pipeline.","weight":30,"keywords":["api","queue","worker","router","provider","webhook"]},{"key":"data","label":"State & deduplication","description":"Models attempts and logical sends.","weight":20,"keywords":["database","status","dedup","idempotency key","outbox","audit"]},{"key":"reliability","label":"Delivery reliability","description":"Handles retries and poison work.","weight":20,"keywords":["retry","backoff","dead letter","circuit breaker","rate limit","failover"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Explains latency, cost, and guarantees.","weight":10,"keywords":["tradeoff","at least once","cost","latency","exactly once"]}]'::jsonb, 55, 3),

  ('arena-chat', 'chat-system', 'Design a Realtime Chat System', 'Realtime systems',
   'Keep conversations ordered and durable while presence and connections move across a distributed fleet.',
   'Design direct and group messaging for web and mobile clients.',
   'Users on opposite sides of the world expect instant delivery, durable history, unread state, and sensible behavior after reconnecting.',
   '["Direct and group conversations","Send and receive messages in realtime","Presence and typing indicators","History, unread counts, and reconnect sync"]'::jsonb,
   '["Per-conversation ordering","Durable accepted messages","Low global delivery latency","Millions of concurrent connections"]'::jsonb,
   '[{"key":"requirements","label":"Messaging semantics","description":"Clarifies ordering, groups, and offline behavior.","weight":20,"keywords":["ordering","offline","group","unread","ack","presence"]},{"key":"architecture","label":"Realtime architecture","description":"Routes persistent connections and messages.","weight":30,"keywords":["websocket","gateway","connection","pubsub","service","load balancer"]},{"key":"data","label":"History & ordering","description":"Models conversations, messages, and sequence.","weight":20,"keywords":["message id","sequence","database","partition key","history","cursor"]},{"key":"reliability","label":"Scale & recovery","description":"Handles reconnects, duplicates, and node loss.","weight":20,"keywords":["reconnect","dedup","retry","heartbeat","backpressure","replication"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Defends consistency and availability choices.","weight":10,"keywords":["tradeoff","consistency","availability","latency","fanout"]}]'::jsonb, 60, 4),

  ('arena-news-feed', 'news-feed', 'Design a Personalized News Feed', 'Fanout & ranking',
   'Generate ranked feeds for ordinary users and celebrity accounts without collapsing under fanout.',
   'Design the home feed for a large social network.',
   'Most authors have hundreds of followers; a few have tens of millions. Freshness, ranking, and cost all compete.',
   '["Publish posts","Follow and unfollow authors","Read a ranked paginated feed","Hide deleted or blocked content"]'::jsonb,
   '["Fresh posts visible within seconds","Stable cursor pagination","Celebrity fanout protection","Personalized ranking"]'::jsonb,
   '[{"key":"requirements","label":"Feed contract","description":"Clarifies freshness, ranking, and social edges.","weight":20,"keywords":["follow","ranking","freshness","pagination","delete","privacy"]},{"key":"architecture","label":"Feed architecture","description":"Defines publish and read paths.","weight":30,"keywords":["fanout","queue","feed service","cache","ranking service","api"]},{"key":"data","label":"Storage & pagination","description":"Models posts, follows, and feed entries.","weight":20,"keywords":["database","timeline","cursor","partition","post id","graph"]},{"key":"reliability","label":"Hot-key scale","description":"Addresses celebrity traffic and stale work.","weight":20,"keywords":["celebrity","fanout on read","fanout on write","hot","backpressure","cache"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Defends hybrid fanout and freshness choices.","weight":10,"keywords":["tradeoff","hybrid","latency","cost","stale"]}]'::jsonb, 60, 5),

  ('arena-file-storage', 'file-storage', 'Design a Cloud File Storage Service', 'Storage & delivery',
   'Support resumable uploads, metadata, sharing, and efficient global download for tiny and huge files.',
   'Design a Dropbox-like file storage and sharing service.',
   'The same product must handle one-kilobyte thumbnails and eighty-gigabyte archives without routing either through an application server unnecessarily.',
   '["Upload, download, and delete files","Resume interrupted large uploads","Folders, versions, and metadata","Secure sharing links"]'::jsonb,
   '["Durable bytes","Global download performance","Large-file efficiency","Authorization on every object"]'::jsonb,
   '[{"key":"requirements","label":"File lifecycle","description":"Clarifies size, sharing, and version behavior.","weight":20,"keywords":["upload","download","version","share","folder","quota"]},{"key":"architecture","label":"Storage architecture","description":"Separates metadata and byte transfer.","weight":30,"keywords":["object storage","presigned","cdn","metadata service","api","multipart"]},{"key":"data","label":"Metadata & chunks","description":"Models files, versions, and upload sessions.","weight":20,"keywords":["chunk","checksum","database","manifest","upload id","key"]},{"key":"reliability","label":"Durability & recovery","description":"Handles interrupted and corrupted transfers.","weight":20,"keywords":["resume","replication","checksum","retry","garbage collection","encryption"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Explains consistency, cost, and deduplication.","weight":10,"keywords":["tradeoff","cost","dedup","consistency","storage class"]}]'::jsonb, 55, 6),

  ('arena-payments', 'payment-system', 'Design a Payment & Ledger System', 'Transactions',
   'Process retried payment requests safely and keep an auditable ledger that can reconcile with providers.',
   'Design the payment core for an online marketplace.',
   'Networks retry. Providers time out after accepting work. Customers must not be charged twice, and every balance must be explainable later.',
   '["Authorize, capture, refund, and query payments","Idempotent client requests","Double-entry ledger","Provider reconciliation"]'::jsonb,
   '["Never lose accepted money movement","Auditable immutable history","Consistent balances","Safe recovery from unknown provider outcomes"]'::jsonb,
   '[{"key":"requirements","label":"Money movement contract","description":"Defines payment states and idempotency.","weight":20,"keywords":["authorize","capture","refund","idempotency","currency","state machine"]},{"key":"architecture","label":"Payment architecture","description":"Separates workflow, provider, and ledger concerns.","weight":30,"keywords":["payment service","provider","ledger","webhook","queue","orchestrator"]},{"key":"data","label":"Ledger & transactions","description":"Models balanced immutable entries.","weight":20,"keywords":["double entry","debit","credit","transaction","immutable","balance"]},{"key":"reliability","label":"Recovery & reconciliation","description":"Handles duplicates and ambiguous outcomes.","weight":20,"keywords":["reconcile","retry","outbox","saga","dedup","unknown"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Defends consistency and availability boundaries.","weight":10,"keywords":["tradeoff","consistency","availability","isolation","cost"]}]'::jsonb, 65, 7),

  ('arena-search', 'search-platform', 'Design a Search Platform', 'Search & indexing',
   'Build an async indexing pipeline and a query path that balances relevance, freshness, and availability.',
   'Design product search for a large marketplace.',
   'A result that technically matches but ignores user intent teaches customers not to trust search. Inventory and pricing also change constantly.',
   '["Full-text and filtered search","Autocomplete and typo tolerance","Rank by relevance and business signals","Reflect product updates and deletes"]'::jsonb,
   '["Query p99 below 250 ms","Index updates within one minute","No permanently ghosted deletes","Graceful degradation"]'::jsonb,
   '[{"key":"requirements","label":"Search contract","description":"Clarifies filters, relevance, and freshness.","weight":20,"keywords":["query","filter","autocomplete","ranking","freshness","delete"]},{"key":"architecture","label":"Search architecture","description":"Defines indexing and query paths.","weight":30,"keywords":["search engine","indexer","queue","change data capture","query service","cache"]},{"key":"data","label":"Index model","description":"Explains documents, shards, and source of truth.","weight":20,"keywords":["inverted index","document","shard","database","mapping","version"]},{"key":"reliability","label":"Pipeline reliability","description":"Handles lag, replay, and reindexing.","weight":20,"keywords":["reindex","checkpoint","retry","dead letter","lag","alias"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Defends relevance, freshness, and cost.","weight":10,"keywords":["tradeoff","relevance","freshness","cost","eventual"]}]'::jsonb, 60, 8),

  ('arena-video', 'video-processing', 'Design a Video Processing Pipeline', 'Media pipelines',
   'Upload large videos, transcode them asynchronously, and deliver multiple renditions without blocking users.',
   'Design the upload and playback backend for a video platform.',
   'Each upload becomes several resolutions. Workers are expensive, individual jobs are long, and a crash halfway through must not restart the entire product workflow blindly.',
   '["Resumable video upload","Generate multiple renditions and thumbnails","Expose processing progress","Stream through a CDN"]'::jsonb,
   '["Upload path independent of transcoding","Recover stalled work","Control compute cost","Playable output as soon as useful renditions finish"]'::jsonb,
   '[{"key":"requirements","label":"Media workflow","description":"Clarifies formats, progress, and readiness.","weight":20,"keywords":["upload","rendition","thumbnail","progress","codec","resolution"]},{"key":"architecture","label":"Pipeline architecture","description":"Builds a decoupled media workflow.","weight":30,"keywords":["object storage","queue","worker","transcoder","cdn","orchestrator"]},{"key":"data","label":"Jobs & artifacts","description":"Models upload, job, and rendition state.","weight":20,"keywords":["state machine","job","manifest","metadata","idempotency","checksum"]},{"key":"reliability","label":"Worker reliability","description":"Handles stalls, retries, and capacity.","weight":20,"keywords":["lease","heartbeat","retry","dead letter","autoscale","backpressure"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Explains quality, latency, and cost.","weight":10,"keywords":["tradeoff","cost","quality","latency","priority"]}]'::jsonb, 55, 9),

  ('arena-rides', 'ride-matching', 'Design a Ride-Matching System', 'Geospatial realtime',
   'Ingest moving locations and match riders to nearby drivers quickly while regions and ownership change.',
   'Design the realtime dispatch backend for a ride-hailing service.',
   'Thousands of riders and drivers move simultaneously. A match must be fast, exclusive, and resilient to stale coordinates.',
   '["Stream driver locations and availability","Request and accept a ride","Find and reserve a nearby driver","Track trip state"]'::jsonb,
   '["Match within one second","Prevent double assignment","Regional fault isolation","Tolerate stale and out-of-order location updates"]'::jsonb,
   '[{"key":"requirements","label":"Dispatch contract","description":"Clarifies matching, reservation, and trip states.","weight":20,"keywords":["driver","rider","match","accept","cancel","trip"]},{"key":"architecture","label":"Realtime architecture","description":"Routes locations and dispatch decisions.","weight":30,"keywords":["websocket","location service","matching service","stream","gateway","region"]},{"key":"data","label":"Geo data & ownership","description":"Models cells, positions, and reservations.","weight":20,"keywords":["geohash","spatial index","cell","lease","reservation","timestamp"]},{"key":"reliability","label":"Concurrency & scale","description":"Handles races, stale data, and region loss.","weight":20,"keywords":["compare and set","lock","stale","partition","failover","dedup"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Defends match quality versus latency.","weight":10,"keywords":["tradeoff","distance","latency","consistency","availability"]}]'::jsonb, 65, 10),

  ('arena-metrics', 'metrics-platform', 'Design a Metrics Platform', 'Observability data',
   'Ingest high-cardinality time series, aggregate efficiently, and retain useful data without runaway cost.',
   'Design a multi-tenant metrics platform for thousands of services.',
   'Launch traffic can create more monitoring data than application data. The platform must protect itself without hiding the incident it exists to reveal.',
   '["Ingest timestamped metric samples","Query ranges and aggregations","Define recording rules and alerts","Enforce tenant quotas"]'::jsonb,
   '["Millions of samples per second","Bound high-cardinality damage","Fast recent queries","Tiered retention and cost control"]'::jsonb,
   '[{"key":"requirements","label":"Telemetry contract","description":"Clarifies metrics, labels, alerts, and retention.","weight":20,"keywords":["metric","label","cardinality","alert","retention","tenant"]},{"key":"architecture","label":"Metrics architecture","description":"Separates ingestion, storage, and query.","weight":30,"keywords":["ingester","queue","time series","query service","aggregator","object storage"]},{"key":"data","label":"Time-series layout","description":"Explains series identity, chunks, and indexes.","weight":20,"keywords":["timestamp","series","chunk","index","compression","partition"]},{"key":"reliability","label":"Overload handling","description":"Handles bursts and abusive cardinality.","weight":20,"keywords":["backpressure","sampling","quota","replication","buffer","downsample"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Defends accuracy, retention, and cost.","weight":10,"keywords":["tradeoff","cost","accuracy","resolution","retention"]}]'::jsonb, 60, 11),

  ('arena-commerce', 'global-commerce', 'Design a Global Commerce Platform', 'Multi-region capstone',
   'Combine inventory, checkout, payment, fulfillment, and disaster recovery across regions.',
   'Design a global commerce platform that survives losing a full region during peak traffic.',
   'Inventory must stay honest, payments must remain safe, and fulfillment must continue while users expect low latency everywhere. The constraints pull against each other.',
   '["Browse catalog and availability","Create carts and place orders","Reserve inventory and process payment","Drive fulfillment and returns"]'::jsonb,
   '["Multi-region availability","No overselling of scarce stock","Auditable order and payment state","Regional disaster recovery"]'::jsonb,
   '[{"key":"requirements","label":"Commerce boundaries","description":"Clarifies order, stock, payment, and fulfillment semantics.","weight":20,"keywords":["catalog","cart","order","inventory","payment","fulfillment"]},{"key":"architecture","label":"Global architecture","description":"Defines services, regions, and workflows.","weight":30,"keywords":["gateway","region","order service","inventory service","event","orchestrator"]},{"key":"data","label":"Consistency boundaries","description":"Models reservations and cross-service state.","weight":20,"keywords":["reservation","ledger","saga","outbox","idempotency","source of truth"]},{"key":"reliability","label":"Disaster recovery","description":"Handles region loss and dependency failure.","weight":20,"keywords":["failover","rpo","rto","replication","reconcile","circuit breaker"]},{"key":"tradeoffs","label":"Tradeoffs","description":"Defends availability, consistency, latency, and cost.","weight":10,"keywords":["tradeoff","consistency","availability","latency","cost"]}]'::jsonb, 75, 12)
)
insert into public.system_design_challenges (
  id, slug, title, domain, summary, prompt, context, functional_requirements,
  nonfunctional_requirements, modes, rubric, estimated_minutes, sort_order
)
select arena_rows.id, slug, title, domain, summary, prompt, context,
       functional_requirements, nonfunctional_requirements, arena_modes.value,
       rubric, estimated_minutes, sort_order
from arena_rows cross join arena_modes;

-- Portfolio campaigns are intentionally stack-flexible. A learner may use
-- their specialization language, while the deliverables remain comparable.
insert into public.portfolio_campaigns
  (id, slug, title, tagline, summary, stack_options, outcomes, sort_order)
values
  ('portfolio-civic-api', 'civic-api', 'Civic API', 'A production API from a blank repository',
   'Ship a documented, authenticated public-service API with durable data, tests, observability, and a deployable runtime.',
   ARRAY['TypeScript + NestJS', 'Java + Spring Boot', 'Python + FastAPI', 'Go + chi'],
   '["Versioned REST contract with OpenAPI","PostgreSQL schema and zero-downtime migration plan","Authentication, authorization, validation, and rate limits","Unit, integration, and contract tests","Deployed service with health and telemetry"]'::jsonb, 1),
  ('portfolio-nexus-commerce', 'nexus-commerce', 'Nexus Commerce', 'Turn CRUD into a production workflow',
   'Build a commerce backend with catalog, checkout, idempotent payments, caching, async work, search, and operational controls.',
   ARRAY['TypeScript + NestJS', 'Java + Spring Boot', 'Python + FastAPI', 'Go + Gin'],
   '["Catalog and inventory boundaries","Idempotent checkout and simulated payment provider","Redis caching with invalidation strategy","Background jobs and dead-letter handling","Search index synchronized from the source of truth"]'::jsonb, 2),
  ('portfolio-transit-realtime', 'transit-realtime', 'Transit Realtime', 'A live event system users can see',
   'Ingest vehicle events, process them as a stream, and push low-latency updates to a live client with replay and backpressure.',
   ARRAY['TypeScript + NestJS', 'Java + Spring WebFlux', 'Python + FastAPI', 'Go + Fiber'],
   '["Versioned event contract","Kafka or compatible durable event log","Idempotent consumer and replay strategy","WebSocket or SSE delivery gateway","End-to-end latency dashboard"]'::jsonb, 3),
  ('portfolio-forge-microservices', 'forge-microservices', 'Forge Microservices', 'Several services, one honest trace',
   'Create independently deployable services with explicit ownership, reliable messaging, an API gateway, and distributed tracing.',
   ARRAY['Polyglot', 'Java + Spring Cloud', 'Python + FastAPI', 'Go + gRPC'],
   '["Clear service and database ownership","Gateway and service authentication","Transactional outbox with message deduplication","Trace propagation across sync and async boundaries","Failure drill with a written postmortem"]'::jsonb, 4),
  ('portfolio-global-nexus', 'global-nexus', 'Global Nexus', 'Deploy, observe, and break the capstone',
   'Operate the portfolio as a containerized platform with CI/CD, infrastructure definitions, SLOs, and a demonstrated recovery exercise.',
   ARRAY['Docker Compose + cloud target', 'Kubernetes', 'Managed container platform'],
   '["Reproducible infrastructure and secrets strategy","Build, test, scan, and deployment pipeline","Metrics, logs, traces, alerts, and runbooks","Load test tied to an SLO","Failover exercise with measured RTO and RPO"]'::jsonb, 5);

insert into public.portfolio_milestones
  (id, campaign_id, title, description, deliverable, sort_order)
values
  ('civic-contract', 'portfolio-civic-api', 'Contract & boundaries', 'Define users, roles, resources, errors, pagination, and versioning before implementation.', 'OpenAPI document plus a one-page architecture decision record.', 1),
  ('civic-data', 'portfolio-civic-api', 'Durable data', 'Model the PostgreSQL schema, indexes, constraints, migrations, and local seed data.', 'Migration set, entity diagram, and representative query plan.', 2),
  ('civic-security', 'portfolio-civic-api', 'Identity & abuse controls', 'Add authentication, resource authorization, request validation, and rate limiting.', 'Security tests proving both allowed and denied paths.', 3),
  ('civic-quality', 'portfolio-civic-api', 'Test the contract', 'Build unit, integration, and API contract coverage around the highest-risk behaviors.', 'Automated test command and CI result.', 4),
  ('civic-ship', 'portfolio-civic-api', 'Operate the service', 'Containerize, deploy, add health endpoints and baseline logs/metrics.', 'Public API URL, runbook, and repository release tag.', 5),

  ('commerce-domains', 'portfolio-nexus-commerce', 'Commerce boundaries', 'Separate catalog, inventory, cart, order, and payment responsibilities.', 'Domain diagram and versioned API/event contracts.', 1),
  ('commerce-checkout', 'portfolio-nexus-commerce', 'Safe checkout', 'Implement inventory reservation and an idempotent simulated payment workflow.', 'Passing duplicate-request and compensation tests.', 2),
  ('commerce-speed', 'portfolio-nexus-commerce', 'Cache deliberately', 'Add Redis to measured hot paths with invalidation, stampede, and fallback behavior.', 'Before/after load result and cache decision record.', 3),
  ('commerce-async', 'portfolio-nexus-commerce', 'Move work off the request path', 'Queue receipts, fulfillment, and index updates with retry and dead-letter handling.', 'Worker dashboard or trace plus poison-message test.', 4),
  ('commerce-search', 'portfolio-nexus-commerce', 'Search & release', 'Build a synchronized product index and ship a complete, documented release.', 'Search demo, reconciliation job, deployed release, and runbook.', 5),

  ('transit-contract', 'portfolio-transit-realtime', 'Event contract', 'Define vehicle location, route, delay, and service-alert events with compatibility rules.', 'Schema files, compatibility test, and sample event generator.', 1),
  ('transit-stream', 'portfolio-transit-realtime', 'Durable stream', 'Partition events, publish reliably, and define retention and replay.', 'Running broker topology and documented partition-key choice.', 2),
  ('transit-process', 'portfolio-transit-realtime', 'Idempotent processing', 'Build consumers that tolerate duplicates, out-of-order input, and restarts.', 'Replay test with deterministic materialized state.', 3),
  ('transit-live', 'portfolio-transit-realtime', 'Live delivery', 'Push authorized, filtered updates over WebSocket or SSE with reconnect cursors.', 'Browser demo surviving disconnect and reconnect.', 4),
  ('transit-observe', 'portfolio-transit-realtime', 'Measure the pipeline', 'Instrument producer-to-screen latency, lag, error rate, and backpressure.', 'Deployed dashboard, SLO, alert, and load-test result.', 5),

  ('micro-boundaries', 'portfolio-forge-microservices', 'Service ownership', 'Split a coherent domain by responsibility and assign each service its own data.', 'Context map, ownership table, and API/event contracts.', 1),
  ('micro-gateway', 'portfolio-forge-microservices', 'Gateway & identity', 'Route clients through one edge while preserving service-to-service identity.', 'Gateway policies and authentication tests.', 2),
  ('micro-messaging', 'portfolio-forge-microservices', 'Reliable events', 'Implement an outbox, broker delivery, idempotent consumers, and dead letters.', 'Failure test proving database and event consistency.', 3),
  ('micro-tracing', 'portfolio-forge-microservices', 'One trace', 'Propagate context through HTTP/gRPC and the message broker.', 'Trace screenshot or export covering the complete workflow.', 4),
  ('micro-drill', 'portfolio-forge-microservices', 'Break a dependency', 'Inject latency or failure, mitigate it, and document what happened.', 'Failure drill, alert evidence, and blameless postmortem.', 5),

  ('global-containers', 'portfolio-global-nexus', 'Reproducible runtime', 'Containerize services and dependencies with health checks and bounded resources.', 'One-command local environment and production image definitions.', 1),
  ('global-pipeline', 'portfolio-global-nexus', 'Delivery pipeline', 'Automate tests, supply-chain scanning, image publishing, migrations, and deployment.', 'Green CI/CD run with rollback documented.', 2),
  ('global-observe', 'portfolio-global-nexus', 'Telemetry & SLOs', 'Correlate metrics, logs, and traces and alert on user-visible objectives.', 'Service dashboard, SLO, alerts, and two runbooks.', 3),
  ('global-load', 'portfolio-global-nexus', 'Prove capacity', 'Run a representative load profile and remove the first measured bottleneck.', 'Load report with baseline, bottleneck, fix, and rerun.', 4),
  ('global-failover', 'portfolio-global-nexus', 'Recovery game day', 'Remove a critical dependency or region and measure restoration.', 'Game-day record with actual RTO/RPO and follow-up work.', 5);

insert into public.language_tracks
  (id, slug, title, language, framework, description, icon, estimated_hours, capstone, sort_order)
values
  ('track-java-spring', 'java-spring', 'Java / Spring Engineering', 'Java', 'Spring Boot',
   'Replay backend judgment through the JVM: strong domain modeling, Spring’s runtime model, relational transactions, messaging, testing, and production operation.',
   'Coffee', 52, 'Build and operate a Spring Boot order service with PostgreSQL, Kafka, security, observability, and a zero-downtime release.', 1),
  ('track-python-fastapi', 'python-fastapi', 'Python / FastAPI Engineering', 'Python', 'FastAPI',
   'Use Python’s type system and async runtime deliberately while building validated APIs, durable persistence, background work, tests, and production telemetry.',
   'Braces', 42, 'Build and operate an async FastAPI incident service with PostgreSQL, Redis, task processing, authorization, and load-tested telemetry.', 2),
  ('track-go', 'go', 'Go Backend Engineering', 'Go', 'Standard library + chi',
   'Learn Go through explicit concurrency, small interfaces, context propagation, SQL, services, profiling, and failure-aware production design.',
   'Terminal', 46, 'Build and operate a Go event-ingestion service with PostgreSQL, worker pools, graceful shutdown, observability, and measured performance.', 3);

insert into public.language_track_modules
  (id, track_id, title, description, focus, project_step, sort_order)
values
  ('java-language', 'track-java-spring', 'Modern Java for backend systems', 'Use records, sealed types, generics, exceptions, streams, and immutability without hiding control flow.', '["records and sealed types","collections and generics","error modeling","JVM memory basics"]'::jsonb, 'Model the capstone order domain and its error contract.', 1),
  ('java-spring-core', 'track-java-spring', 'Spring runtime & configuration', 'Understand dependency injection, bean lifecycles, configuration binding, profiles, and the request pipeline.', '["IoC container","configuration properties","profiles","filters and interceptors"]'::jsonb, 'Create the application boundary and environment-safe configuration.', 2),
  ('java-web', 'track-java-spring', 'HTTP APIs with Spring MVC', 'Build versioned controllers with validation, problem details, pagination, and OpenAPI.', '["Spring MVC","Jakarta Validation","exception advice","OpenAPI"]'::jsonb, 'Expose the order API with a tested error format.', 3),
  ('java-data', 'track-java-spring', 'JPA, SQL & transactions', 'Use ORM features without losing sight of SQL, locking, fetch plans, and transaction boundaries.', '["JPA mappings","N+1 prevention","transactions","optimistic locking"]'::jsonb, 'Persist orders and inventory reservations safely.', 4),
  ('java-security', 'track-java-spring', 'Spring Security', 'Implement authentication, method/resource authorization, token validation, and security tests.', '["filter chain","OAuth2 resource server","authorization","CSRF and CORS"]'::jsonb, 'Secure operator and customer actions separately.', 5),
  ('java-messaging', 'track-java-spring', 'Kafka & reliable messaging', 'Publish after commit, consume idempotently, retry deliberately, and quarantine poison events.', '["Spring Kafka","transactional outbox","consumer groups","dead letters"]'::jsonb, 'Emit order events and implement an idempotent fulfillment consumer.', 6),
  ('java-testing', 'track-java-spring', 'Testing the real boundaries', 'Combine unit tests, slice tests, Testcontainers, contract tests, and failure injection.', '["JUnit 5","MockMvc","Testcontainers","contract testing"]'::jsonb, 'Prove database, API, and broker behavior in CI.', 7),
  ('java-production', 'track-java-spring', 'Operate the JVM service', 'Tune pools, expose Actuator telemetry, profile, containerize, and release without downtime.', '["Actuator","Micrometer","JVM profiling","graceful shutdown"]'::jsonb, 'Deploy, load test, observe, and perform the capstone release.', 8),

  ('python-language', 'track-python-fastapi', 'Typed Python for services', 'Use typing, dataclasses, protocols, exceptions, and project tooling to keep dynamic code explicit.', '["type hints","dataclasses","protocols","packaging and linting"]'::jsonb, 'Model the capstone incident domain and public errors.', 1),
  ('python-fastapi-core', 'track-python-fastapi', 'FastAPI request lifecycle', 'Build routers and dependencies while understanding validation, middleware, and OpenAPI generation.', '["routers","dependency injection","Pydantic v2","middleware"]'::jsonb, 'Expose validated incident endpoints and generated docs.', 2),
  ('python-async', 'track-python-fastapi', 'Async I/O without event-loop traps', 'Use async/await, structured concurrency, timeouts, and thread offloading intentionally.', '["asyncio","task groups","timeouts","blocking I/O"]'::jsonb, 'Add concurrent enrichment with bounded timeouts.', 3),
  ('python-data', 'track-python-fastapi', 'PostgreSQL & migrations', 'Use SQLAlchemy’s async model, transactions, indexes, and Alembic migrations.', '["SQLAlchemy 2","async sessions","Alembic","query plans"]'::jsonb, 'Persist incidents and timeline entries transactionally.', 4),
  ('python-security', 'track-python-fastapi', 'Identity & authorization', 'Validate tokens, scope access, protect secrets, and test resource ownership.', '["OAuth2","JWT validation","RBAC","resource authorization"]'::jsonb, 'Separate responder, reporter, and administrator permissions.', 5),
  ('python-workers', 'track-python-fastapi', 'Background work & caching', 'Move durable work out of request tasks, use Redis safely, and design retries and idempotency.', '["Celery or Dramatiq","Redis","idempotency","retry and dead letter"]'::jsonb, 'Process notifications and enrichment outside the API process.', 6),
  ('python-testing', 'track-python-fastapi', 'Test async boundaries', 'Exercise APIs, database transactions, workers, and property-level invariants.', '["pytest","httpx","async fixtures","property testing"]'::jsonb, 'Build a deterministic integration suite for the full workflow.', 7),
  ('python-production', 'track-python-fastapi', 'Run FastAPI in production', 'Choose worker topology, tune pools, instrument requests, containerize, and load test.', '["ASGI","Uvicorn workers","OpenTelemetry","profiling"]'::jsonb, 'Deploy, observe, load test, and complete the incident-service capstone.', 8),

  ('go-language', 'track-go', 'Go’s explicit foundations', 'Use packages, structs, interfaces, errors, slices, maps, and composition idiomatically.', '["interfaces","error wrapping","zero values","package design"]'::jsonb, 'Model ingestion events and domain errors with small interfaces.', 1),
  ('go-http', 'track-go', 'Production HTTP services', 'Build handlers and middleware with net/http, routing, validation, and stable error responses.', '["net/http","chi router","middleware","JSON contracts"]'::jsonb, 'Expose versioned ingestion and query endpoints.', 2),
  ('go-concurrency', 'track-go', 'Goroutines with ownership', 'Use channels, mutexes, worker pools, cancellation, and bounded concurrency without leaks.', '["goroutines","channels","worker pools","race detector"]'::jsonb, 'Build a bounded ingestion worker pool.', 3),
  ('go-context', 'track-go', 'Cancellation & graceful lifecycle', 'Propagate context, enforce deadlines, handle signals, and shut down without losing accepted work.', '["context","deadlines","signals","graceful shutdown"]'::jsonb, 'Make API and worker shutdown drain safely.', 4),
  ('go-data', 'track-go', 'SQL without surprises', 'Use database/sql or pgx, explicit transactions, migrations, pool tuning, and query plans.', '["pgx","transactions","migrations","connection pools"]'::jsonb, 'Persist events and checkpoints with explicit transaction boundaries.', 5),
  ('go-messaging', 'track-go', 'Streams & idempotent consumers', 'Integrate a broker, partition work, commit checkpoints, retry, and deduplicate.', '["Kafka client","consumer groups","offsets","idempotency"]'::jsonb, 'Consume an event stream and safely replay it.', 6),
  ('go-testing', 'track-go', 'Tests, fuzzing & contracts', 'Use table tests, httptest, integration containers, fuzzing, and race detection.', '["table-driven tests","httptest","fuzzing","testcontainers"]'::jsonb, 'Prove parser, API, database, and concurrency boundaries.', 7),
  ('go-production', 'track-go', 'Profile and operate Go', 'Instrument with OpenTelemetry, profile CPU and heap, tune the runtime, and ship small containers.', '["pprof","OpenTelemetry","runtime metrics","container builds"]'::jsonb, 'Deploy, profile, load test, and complete the event-ingestion capstone.', 8);
