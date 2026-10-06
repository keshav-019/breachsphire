-- Backend Engineering ("The Fracture") pathway: Arc I (BUILD) and its first
-- Act, "The Request". Later sessions append more `acts`/`worlds` rows the
-- same way -- the map/lock UI needs no further changes to pick them up.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-be-1', 0, 'build', 'Arc I -- Build',
   'Nexus begins suffering failures that do not resemble attacks: duplicate payments, vanished requests, databases reporting two different truths. The player joins Forge Division and learns how backend applications actually work, from a single HTTP request through to a real running server.',
   'Absolute beginner -> backend developer who can trace a request end to end',
   'pathway-backend');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-be-1', 'act-be-1', 0, 'the-request', 'The Request', 'The Request',
   'How a backend works: the client/server model, IP/ports, DNS, TCP, TLS and the anatomy of an HTTP request and response, learned by tracing one request end to end.',
   'A city emergency endpoint responds incorrectly under load and clients cannot tell success from failure. Chief Architect Mira Voss pulls the player into Forge Division to find out why.',
   'The Silent Endpoint',
   'Every failure Forge investigates carries the same signature: a stray `//` buried in a URL, a log line, a header -- too small to be a bug, too consistent to be chance.',
   'The endpoint that failed was hand-rolled with no framework underneath it. To fix it properly, the player needs a real runtime.',
   'The Silent Endpoint', 'Globe', 'low', 8, 12, 'pathway-backend');

-- Existing players never ran handle_new_user() against a world that didn't
-- exist yet -- unlock Act 1 of the new pathway for everyone already signed
-- up (new signups get this for free via the existing `where index = 0`
-- trigger, now that index is scoped per-pathway).
insert into public.player_world_progress (player_id, world_id, state, completion)
select id, 'world-be-1', 'unlocked', 0 from public.profiles
on conflict (player_id, world_id) do nothing;
