-- Backend Engineering ("The Fracture") -- world/act "spine" for Acts 2-10.
-- Pre-authored in full (narrative metadata, map coordinates, icons) before
-- any mission content, exactly like the original 74-world Cyber Guardians
-- seed (20260808120000_acts_and_worlds.sql) predated its world-content
-- migrations. Content migrations (campaigns/operations/missions/...) for
-- each Act reference these `worlds` rows by id and are applied afterward.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-be-2', 1, 'data', 'Arc II -- Data',
   'Every failure Forge chases eventually lands on the same floor: a database that disagrees with itself. The player learns relational modelling, SQL and the discipline of correctness under load -- normalization, transactions, indexes, migrations -- while the recurring "//" signature keeps surfacing in places a schema should never allow it to.',
   'Backend developer -> data-literate backend engineer',
   'pathway-backend');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-be-2', 'act-be-1', 1, 'the-server', 'The Server', 'The Server',
   'Runtime and process basics, Node.js, npm, TypeScript, and standing up a real HTTP server: routing, parameters, request bodies, environment variables and configuration.',
   'The hand-rolled fix from The Request holds, but only barely. Forge Division decides the emergency dispatch service needs a real runtime under it instead of patched-together scripts, and the first attempt to bring the new service online won''t even bind to its port.',
   'Port 8080',
   'Buried in the new server''s startup log, once, is a route registered as "//health" instead of "/health". Nobody typed it. The service still starts. Forge flags it and moves on -- for now.',
   'The server runs, but the code inside it grows unruly within a day. Understanding why requires understanding what the runtime is actually doing between requests.',
   'Port 8080', 'Server', 'low', 22, 12, 'pathway-backend'),

  ('world-be-3', 'act-be-1', 2, 'asynchronous-city', 'Asynchronous City', 'Asynchronous City',
   'Synchronous vs asynchronous execution, callbacks, promises, async/await, the event loop, microtasks, blocking work, worker threads, streams and buffers -- learned by finding out exactly what freezes a server and why.',
   'Mira asks for a resilience report generated from a full day of incident logs. The report handler is synchronous and CPU-heavy. The moment it runs, every other request on the service stops responding -- not crashes, just silently stops.',
   'Event Loop Lockdown',
   'The frozen server''s last accepted connection, timestamped to the millisecond it locked, came from a path containing "//". Forge starts a private log just for these.',
   'Understanding the event loop explains the freeze but not how to build real functionality on top of it -- the player needs actual API design next.',
   'Event Loop Lockdown', 'Activity', 'low', 36, 12, 'pathway-backend'),

  ('world-be-4', 'act-be-1', 3, 'api-engineering', 'API Engineering', 'API Engineering',
   'Resources, REST principles, CRUD, route design, controllers, services, the repository pattern, DTOs, validation, error handling and consistent error contracts.',
   'Forge Division starts building real endpoints for city services, and three different engineers ship three incompatible shapes for what should be the same kind of error response.',
   'The Broken Contract',
   'A client integration breaks not because a field was renamed, but because nobody had agreed what the contract even was. One of the offending routes, added in a hurry, is registered twice under paths differing only by a doubled slash.',
   'A consistent contract for one API isn''t enough once dozens of clients depend on it evolving safely -- the next problem is designing APIs meant to last.',
   'The Broken Contract', 'Network', 'low', 50, 12, 'pathway-backend'),

  ('world-be-5', 'act-be-1', 4, 'professional-rest-apis', 'Professional REST APIs', 'Professional REST APIs',
   'Pagination (offset and cursor), filtering, sorting, search parameters, partial updates, API versioning, backward compatibility, and documenting an API with OpenAPI/Swagger.',
   'A city-services partner integrated directly against undocumented, unversioned endpoints. The first schema change Forge ships without a version boundary takes every one of that partner''s clients down at once.',
   'Version Zero',
   'The incident report is filed under a ticket number ending in the same "//" fragment Forge has now seen four times.',
   'A well-versioned, well-documented API is only trustworthy if the people using it actually are who they claim to be -- identity is next.',
   'Version Zero', 'Globe', 'guarded', 64, 12, 'pathway-backend'),

  ('world-be-6', 'act-be-1', 5, 'identity', 'Identity', 'Identity',
   'Authentication vs authorization, password hashing, sessions, cookies, JWTs, access/refresh tokens, token rotation, logout/revocation, OAuth 2.0, OpenID Connect and social login architecture.',
   'A city resident''s account is used to file a report they never made. Nothing was "hacked" in the traditional sense -- a session that should have died weeks ago never actually died.',
   'The Stolen Identity',
   'The zombie session''s token was minted by a login path with a "//" in its route definition -- and no expiry the team can find a reason for.',
   'Proving who someone is doesn''t yet say what they''re allowed to do once they''re in -- permissions come next.',
   'The Stolen Identity', 'KeyRound', 'guarded', 78, 12, 'pathway-backend'),

  ('world-be-7', 'act-be-1', 6, 'permissions', 'Permissions', 'Permissions',
   'Users, roles and permissions, RBAC, ABAC concepts, resource ownership, multi-tenant authorization, API keys, service accounts, service-to-service auth, secrets, authorization middleware/guards and audit trails.',
   'A second city''s data appears inside the first city''s dashboard for exactly four seconds before someone notices. Authentication worked perfectly. Authorization never asked the right question.',
   'The Forbidden Record',
   'The audit trail shows the request came through a service account whose route pattern -- again -- contains an unexplained "//".',
   'Every permission check this Act relied on a codebase that was never designed to make that check easy to get right -- codebase design is next.',
   'The Forbidden Record', 'ShieldAlert', 'elevated', 8, 32, 'pathway-backend'),

  ('world-be-8', 'act-be-1', 7, 'backend-codebase-design', 'Backend Codebase Design', 'Backend Codebase Design',
   'Layered architecture, dependency injection and inversion, clean and hexagonal architecture concepts, modules, domain models, application services, infrastructure layers, configuration and error boundaries.',
   'Every incident this Arc traces back to the same root cause: a codebase with no boundaries, where a config change in one place breaks a validation rule in another nobody remembers writing.',
   'The Spaghetti Service',
   'Refactoring the service into layers finally surfaces it directly: a routing table with a literal, uncommented "//" prefix hardcoded eight months ago by no engineer currently at Forge Division.',
   'The service finally has boundaries strong enough to trust. What it stores behind those boundaries is the next question -- and it lives in a database nobody has audited in years.',
   'The Spaghetti Service', 'Building2', 'elevated', 22, 32, 'pathway-backend'),

  ('world-be-9', 'act-be-2', 8, 'relational-data', 'Relational Data', 'Relational Data',
   'Why databases exist, PostgreSQL, tables and schemas, primary and foreign keys, constraints, and SELECT/INSERT/UPDATE/DELETE/JOIN.',
   'Mira reassigns the player to Data Systems: the city''s civic registry database has been quietly diverging from reality for months, and nobody can agree which row is the truth.',
   'The Civic Registry',
   'Two duplicate citizen records differ in exactly one field: a stray "//" appended to one record''s source-system tag, silently defeating a uniqueness check that should have caught it.',
   'Reading and writing single rows correctly doesn''t explain how to answer real questions about the data at scale -- SQL mastery is next.',
   'The Civic Registry', 'Database', 'elevated', 36, 32, 'pathway-backend'),

  ('world-be-10', 'act-be-2', 9, 'sql-mastery', 'SQL Mastery', 'SQL Mastery',
   'Aggregation, GROUP BY, HAVING, subqueries, CTEs, window function concepts, views, normalization, denormalization, database migrations and ORMs/query builders.',
   'Leadership wants one report: how many "//"-tagged anomalies have touched Forge-managed systems, ever, across every table that could contain one. No existing query can answer it.',
   'The Impossible Report',
   'The finished report is the first time anyone has seen the full scope in one place: dozens of systems, months apart, all carrying the same fragment. It is not a bug. It has never once caused a crash. It is being tracked.',
   'The pattern is now undeniably deliberate and undeniably distributed. Arc III begins connecting these systems to each other -- which means the next failures will not stay contained to one service.',
   'The Impossible Report', 'Search', 'elevated', 50, 32, 'pathway-backend');
