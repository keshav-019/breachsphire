-- Backend Engineering ("The Fracture") -- world/act "spine" for Acts 11-15.
-- Acts 11-13 close Arc II (Data); Acts 14-15 open a new Arc III (Connect).
-- Pre-authored in full before any mission content, same pattern as
-- 20260810045000_backend_acts2_10_and_arc2.sql.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-be-3', 2, 'connect', 'Arc III -- Connect',
   'With data finally trustworthy and fast, Forge turns to what other teams and cities actually consume: APIs that fit real client shapes, and services that talk to each other in real time instead of waiting on request/response. The player learns GraphQL, RPC and realtime protocols while the recurring pattern keeps surfacing in the connections between systems, not just inside them.',
   'Data-literate backend engineer -> integration-literate backend engineer',
   'pathway-backend');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-be-11', 'act-be-2', 10, 'database-performance', 'Database Performance', 'Database Performance',
   'What an index is, B-tree intuition, composite indexes and ordering, covering indexes, query plans, sequential vs index scans, N+1 queries, connection pools, and investigating a slow query.',
   'A routine dashboard query now takes fourteen seconds and times out clients citywide -- discovered, ironically, because the cross-system anomaly-tracking queries Forge just finished in Data Systems put more load on it than ever before.',
   'The 14-Second Query',
   'The query plan shows a full sequential scan: the column it filters on was never indexed. That column is source_tag -- the exact field that let a duplicate slip past a uniqueness check back in the civic registry incident.',
   'Fixing the query buys speed, but exposes something stranger: for a few seconds while it ran, two dashboards showed two different totals for the same report. That''s not an indexing problem.',
   'The 14-Second Query', 'TrendingUp', 'elevated', 64, 32, 'pathway-backend'),

  ('world-be-12', 'act-be-2', 11, 'transactions-and-concurrency', 'Transactions & Concurrency', 'Transactions & Concurrency',
   'ACID, transaction boundaries, atomicity failure, isolation levels, lost updates, dirty reads, non-repeatable reads, phantom reads, locks, deadlocks and optimistic concurrency.',
   'A citizen is charged twice for the same service fee within the same second. Two requests, two transactions, and neither one saw the other coming.',
   'Double Payment',
   'Replaying the timeline shows both transactions read the same "unpaid" balance before either wrote back. A lost update -- not a retry bug, and nothing that looks like an attack.',
   'Transactions solve this, but the team realizes not everything Forge stores even fits a table. Some of what''s being tracked now is semi-structured, and it doesn''t belong in rows and columns at all.',
   'Double Payment', 'Binary', 'elevated', 78, 32, 'pathway-backend'),

  ('world-be-13', 'act-be-2', 12, 'nosql-and-specialized-storage', 'NoSQL & Specialized Storage', 'NoSQL & Specialized Storage',
   'Why NoSQL exists, key-value stores, document databases, MongoDB concepts, data modelling in documents, wide-column and graph concepts, time-series concepts, Redis as a data store, polyglot persistence and choosing the right database.',
   'Someone tried to force every shape of data Forge owns -- session cache, anomaly event logs, sensor telemetry, an identity graph -- into the same relational schema, and the team is drowning in tables that don''t fit their data.',
   'One Database for Everything',
   'Mapping every shape of data onto the right store finally produces something nobody could build before: a clean, queryable timeline of every "//" occurrence ever logged, correlated across every storage engine Forge runs.',
   'The data is finally trustworthy, fast, and correlated. What Forge builds on top of it -- the APIs other teams and other cities actually consume -- is the next problem, starting with why REST alone stopped being enough for the mobile team.',
   'One Database for Everything', 'Cloud', 'severe', 8, 52, 'pathway-backend'),

  ('world-be-14', 'act-be-3', 13, 'graphql-district', 'GraphQL District', 'GraphQL District',
   'Why GraphQL, schema design, object types, queries, mutations, resolvers, variables and fragments, interfaces and unions, GraphQL pagination, the N+1 problem and DataLoader, authentication and query complexity.',
   'Three mobile screens need three different combinations of the same underlying data, and the REST API has grown nineteen slightly-different endpoints trying to serve them. The frontend team is drowning in endpoint variations.',
   'The Infinite Query',
   'A client built entirely from publicly documented schema discovers a self-referencing query that recurses without bound -- no exploit, no malicious intent, just no depth limit on a graph that was always shaped to allow it.',
   'GraphQL solves the shape-of-data problem, but it still assumes a request gets one response. The next incident involves a service that needs to stream continuously, not just answer once.',
   'The Infinite Query', 'Workflow', 'severe', 22, 52, 'pathway-backend'),

  ('world-be-15', 'act-be-3', 14, 'rpc-and-realtime', 'RPC & Realtime', 'RPC & Realtime',
   'RPC fundamentals, Protocol Buffers, gRPC services, unary calls, server streaming, client/bidirectional streaming concepts, deadlines and metadata, REST vs GraphQL vs gRPC, WebSockets, Server-Sent Events, and reconnect/presence.',
   'The city''s transit dashboard needs live vehicle positions, not a page someone refreshes -- and the service feeding it keeps silently dropping connections, showing a bus as "on time" for eleven minutes after it actually went dark.',
   'The Disconnected City',
   'Every dropped connection shares the same reconnect handshake, and that handshake''s log contains a doubled path segment -- consistent with the pattern, still unexplained, and still not the actual bug being fixed today.',
   'Real-time, low-latency communication between services now works city-wide -- which means the next failures won''t stay contained inside one service either. Background work and queues are next.',
   'The Disconnected City', 'Radio', 'severe', 36, 52, 'pathway-backend');
