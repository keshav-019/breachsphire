-- Phase 2.3: structural tables for the mission content engine
-- (packages/types/src/mission.ts's Campaign -> Operation -> Mission ->
-- Objective -> Challenge hierarchy, plus dialogue/hints) and the
-- per-player progress tables that join against them. Content tables are
-- created empty here -- seeding World 0/1 content is Phase 2.4.

create extension if not exists pgcrypto;

-- ---------------------------------------------------------------------
-- Content hierarchy (read-only to any authenticated user, same as worlds)
-- ---------------------------------------------------------------------

create table public.campaigns (
  id text primary key,
  world_id text not null references public.worlds (id) on delete cascade,
  slug text not null,
  title text not null,
  description text not null,
  sort_order integer not null,
  unique (world_id, slug)
);

create table public.operations (
  id text primary key,
  campaign_id text not null references public.campaigns (id) on delete cascade,
  slug text not null,
  title text not null,
  description text not null,
  sort_order integer not null,
  unique (campaign_id, slug)
);

create table public.missions (
  id text primary key,
  world_id text not null references public.worlds (id) on delete cascade,
  campaign_id text not null references public.campaigns (id) on delete cascade,
  operation_id text not null references public.operations (id) on delete cascade,
  slug text not null,
  title text not null,
  description text not null,
  difficulty text not null check (difficulty in
    ('intro', 'beginner', 'intermediate', 'advanced', 'expert', 'boss')),
  character_ids text[] not null default '{}',
  -- PrerequisiteRule | null
  prerequisites jsonb,
  -- Partial<Record<SkillTrack, number>> | null
  required_skills jsonb,
  -- LabConfig
  lab jsonb not null,
  -- MissionRewards
  rewards jsonb not null,
  is_boss boolean not null default false,
  sort_order integer not null,
  unique (operation_id, slug)
);

create table public.dialogue_lines (
  id uuid primary key default gen_random_uuid(),
  mission_id text not null references public.missions (id) on delete cascade,
  sort_order integer not null,
  character_id text not null check (character_id in
    ('ava', 'zayn', 'luna', 'byte', 'cipher', 'sentinel_x', 'system')),
  text text not null,
  unique (mission_id, sort_order)
);

create table public.objectives (
  id text primary key,
  mission_id text not null references public.missions (id) on delete cascade,
  sort_order integer not null,
  title text not null,
  description text not null,
  unique (mission_id, sort_order)
);

create table public.challenges (
  id text primary key,
  objective_id text not null references public.objectives (id) on delete cascade,
  sort_order integer not null,
  type text not null check (type in (
    'story_dialogue', 'investigation', 'multiple_choice', 'interactive_diagram',
    'drag_and_drop', 'packet_routing', 'phishing_identification', 'log_analysis',
    'terminal_simulation', 'browser_simulation', 'code_debugging', 'sandbox_lab',
    'boss_encounter', 'timed_incident', 'ctf'
  )),
  prompt text not null,
  -- shape depends on `type`
  content jsonb not null,
  completion_conditions jsonb not null,
  unique (objective_id, sort_order)
);

create table public.hints (
  id uuid primary key default gen_random_uuid(),
  challenge_id text not null references public.challenges (id) on delete cascade,
  tier text not null check (tier in
    ('orientation', 'concept', 'tool_direction', 'near_solution', 'solution')),
  text text not null,
  xp_cost integer not null default 0,
  sort_order integer not null,
  unique (challenge_id, tier)
);

alter table public.campaigns enable row level security;
alter table public.operations enable row level security;
alter table public.missions enable row level security;
alter table public.dialogue_lines enable row level security;
alter table public.objectives enable row level security;
alter table public.challenges enable row level security;
alter table public.hints enable row level security;

create policy "Campaigns are viewable by any authenticated user"
  on public.campaigns for select to authenticated using (true);
create policy "Operations are viewable by any authenticated user"
  on public.operations for select to authenticated using (true);
create policy "Missions are viewable by any authenticated user"
  on public.missions for select to authenticated using (true);
create policy "Dialogue lines are viewable by any authenticated user"
  on public.dialogue_lines for select to authenticated using (true);
create policy "Objectives are viewable by any authenticated user"
  on public.objectives for select to authenticated using (true);
create policy "Challenges are viewable by any authenticated user"
  on public.challenges for select to authenticated using (true);
create policy "Hints are viewable by any authenticated user"
  on public.hints for select to authenticated using (true);

-- ---------------------------------------------------------------------
-- Player progress (owner-only, same pattern as player_world_progress)
-- ---------------------------------------------------------------------

create table public.player_mission_progress (
  player_id uuid not null references auth.users (id) on delete cascade,
  mission_id text not null references public.missions (id) on delete cascade,
  status text not null default 'locked' check (status in
    ('locked', 'available', 'in_progress', 'completed')),
  started_at timestamptz,
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  primary key (player_id, mission_id)
);

create table public.player_objective_progress (
  player_id uuid not null references auth.users (id) on delete cascade,
  objective_id text not null references public.objectives (id) on delete cascade,
  status text not null default 'locked' check (status in
    ('locked', 'available', 'in_progress', 'completed')),
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  primary key (player_id, objective_id)
);

-- Append-only attempt log (not "current state" -- that's
-- player_objective_progress). Lets the API layer compute hint costs
-- spent, retry counts, etc. without losing history.
create table public.player_challenge_attempts (
  id uuid primary key default gen_random_uuid(),
  player_id uuid not null references auth.users (id) on delete cascade,
  challenge_id text not null references public.challenges (id) on delete cascade,
  is_correct boolean not null,
  hints_revealed text[] not null default '{}',
  submitted_at timestamptz not null default now()
);

create index player_challenge_attempts_player_challenge_idx
  on public.player_challenge_attempts (player_id, challenge_id);

alter table public.player_mission_progress enable row level security;
alter table public.player_objective_progress enable row level security;
alter table public.player_challenge_attempts enable row level security;

create policy "Mission progress viewable by owner"
  on public.player_mission_progress for select using (auth.uid() = player_id);
create policy "Mission progress insertable by owner"
  on public.player_mission_progress for insert with check (auth.uid() = player_id);
create policy "Mission progress updatable by owner"
  on public.player_mission_progress for update using (auth.uid() = player_id);

create policy "Objective progress viewable by owner"
  on public.player_objective_progress for select using (auth.uid() = player_id);
create policy "Objective progress insertable by owner"
  on public.player_objective_progress for insert with check (auth.uid() = player_id);
create policy "Objective progress updatable by owner"
  on public.player_objective_progress for update using (auth.uid() = player_id);

create policy "Challenge attempts viewable by owner"
  on public.player_challenge_attempts for select using (auth.uid() = player_id);
create policy "Challenge attempts insertable by owner"
  on public.player_challenge_attempts for insert with check (auth.uid() = player_id);
