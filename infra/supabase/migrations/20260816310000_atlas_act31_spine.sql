-- Atlas Division pathway ("The Silence"): World row for Act 31, "The
-- Service Mesh", still under act-atlas-9 ("World IX -- Platform City").
-- Content (missions) follows in its own migration.
--
-- Narrative thread: Act 30's transition_hook named the gap directly --
-- every service still handles its own retries, TLS and traffic policy
-- by hand. Vey introduces a real service mesh to centralize it. The
-- "Proxy Maze" incident proves both the mesh's own retry policy and the
-- collector's existing Act 27 application-level retry policy are each,
-- individually, correctly configured -- and that a retry storm happens
-- anyway, because nobody designed the two layers to coordinate, and
-- their retries multiply instead of adding.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-service-mesh', 'act-atlas-9', 30, 'service-mesh', 'The Service Mesh', 'The Service Mesh',
   'East-west traffic; sidecars; mesh concepts; mTLS; traffic policy; retries; circuit breaking; traffic splitting; mesh observability; Istio concepts; when not to mesh.',
   'Every service on this fleet still handles its own retries, TLS and traffic policy by hand, inconsistently, service by service. Vey proposes a real service mesh -- a dedicated layer for east-west traffic, with those concerns centralized instead of duplicated.',
   'Proxy Maze',
   'The mesh itself works exactly as designed -- mTLS between every service, uniform traffic policy, and a mesh-level retry policy that, tested alone, behaves perfectly. So does the collector''s own Act 27 application-level retry policy, tested alone. Tested together, under real load, they do not add -- they multiply: each application-level retry can trigger its own full set of mesh-level retries underneath it, turning three intended attempts into as many as nine. Two individually correct resilience layers, never designed to coordinate with each other, produced exactly the kind of retry storm both of them existed to prevent.',
   'Every service on this fleet can now reach every other one safely and consistently, and this Act just proved that safety has to be designed across layers, not just within each one. The next question is not how services talk to each other -- it is what actually goes into them before they are ever allowed to run at all.',
   'Proxy Maze', 'Network', 'guarded', 140, 12, 'pathway-atlas');
