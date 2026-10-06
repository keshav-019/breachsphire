-- Second pathway support (Backend Engineering / "The Fracture"). Introduces
-- a top-level `pathways` table and scopes `acts`/`worlds` to a pathway.
-- Deliberately NOT named "campaigns" -- that name is already taken by the
-- sub-grouping inside a World (see 20260808120100_mission_engine.sql).

create table public.pathways (
  id text primary key,
  slug text not null unique,
  title text not null,
  tagline text not null,
  description text not null,
  icon text not null,
  sort_order integer not null
);

alter table public.pathways enable row level security;

create policy "Pathways are viewable by any authenticated user"
  on public.pathways for select
  to authenticated
  using (true);

insert into public.pathways (id, slug, title, tagline, description, icon, sort_order) values
  ('pathway-cyber', 'cyber-guardians', 'Cyber Guardians', 'Defend the grid.',
   'A production-grade cybersecurity campaign: 74 worlds across 11 Acts, from your first phishing recovery to containing an autonomous AI adversary.',
   'ShieldAlert', 1),
  ('pathway-backend', 'backend-engineering', 'The Fracture', 'Keep a civilization online.',
   'A 0-to-1 backend engineering campaign: 32 Acts of building, securing, scaling and operating the systems a living digital city depends on.',
   'Server', 2);

-- Scope acts/worlds to a pathway. Existing rows all belong to Cyber
-- Guardians; the default lets the backfill (next statement) apply cleanly
-- before it's dropped so future inserts must specify pathway_id explicitly.
alter table public.acts add column pathway_id text references public.pathways (id) default 'pathway-cyber';
update public.acts set pathway_id = 'pathway-cyber';
alter table public.acts alter column pathway_id set not null;
alter table public.acts alter column pathway_id drop default;

alter table public.worlds add column pathway_id text references public.pathways (id) default 'pathway-cyber';
update public.worlds set pathway_id = 'pathway-cyber';
alter table public.worlds alter column pathway_id set not null;
alter table public.worlds alter column pathway_id drop default;

-- Both `index` columns were globally unique (Cyber Guardians being the only
-- pathway). Rescope to per-pathway so a second pathway's Act 1 can also be
-- index 0 -- this is also what lets `handle_new_user()`'s existing
-- `where index = 0` seed both pathways' first world with no trigger change.
alter table public.acts drop constraint acts_index_key;
alter table public.acts add constraint acts_pathway_index_key unique (pathway_id, index);

alter table public.worlds drop constraint worlds_index_key;
alter table public.worlds add constraint worlds_pathway_index_key unique (pathway_id, index);
