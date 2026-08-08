-- Phase 2.5 housekeeping: the original profiles migration defaulted
-- rank to 'recruit', matching PLAYER_RANKS[0] at the time. Phase 2.2
-- (docs/12-world-story-bible.md §2.1's clearance progression) changed
-- PLAYER_RANKS[0] to 'civilian' but never touched this default, since it
-- predates that migration and wasn't part of that phase's scope. Fixing
-- it now that a new migration in this same session touches `profiles`
-- again, rather than editing the original migration file in place.

alter table public.profiles
  alter column rank set default 'civilian';

update public.profiles set rank = 'civilian' where rank = 'recruit';
