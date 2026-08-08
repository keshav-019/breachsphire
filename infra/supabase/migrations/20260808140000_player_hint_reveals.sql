-- Phase 2.5: tracks which hint tiers a player has already paid for on a
-- given challenge, independent of whether they've submitted an attempt
-- yet. player_challenge_attempts.hints_revealed (Phase 2.3) only captures
-- hints at the moment of a submitted attempt -- this covers "revealed a
-- hint but hasn't answered yet."

create table public.player_hint_reveals (
  player_id uuid not null references auth.users (id) on delete cascade,
  challenge_id text not null references public.challenges (id) on delete cascade,
  tier text not null check (tier in
    ('orientation', 'concept', 'tool_direction', 'near_solution', 'solution')),
  xp_cost integer not null,
  revealed_at timestamptz not null default now(),
  primary key (player_id, challenge_id, tier)
);

alter table public.player_hint_reveals enable row level security;

create policy "Hint reveals viewable by owner"
  on public.player_hint_reveals for select
  using (auth.uid() = player_id);

create policy "Hint reveals insertable by owner"
  on public.player_hint_reveals for insert
  with check (auth.uid() = player_id);
