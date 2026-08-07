-- World System: static world reference data + per-player progress.
-- icon values are Lucide icon component names, resolved client-side
-- (apps/web/src/lib/icon-map.ts) since components can't live in Postgres.

create table public.worlds (
  id text primary key,
  index integer not null unique,
  name text not null,
  short text not null,
  icon text not null,
  boss text,
  threat text not null,
  x real not null,
  y real not null
);

alter table public.worlds enable row level security;

create policy "Worlds are viewable by any authenticated user"
  on public.worlds for select
  to authenticated
  using (true);

insert into public.worlds (id, index, name, short, icon, boss, threat, x, y) values
  ('academy', 1, 'Cyber Guardian Academy', 'Academy', 'GraduationCap', null, 'low', 6, 78),
  ('fundamentals', 2, 'Computer Fundamentals', 'Fundamentals', 'Binary', null, 'low', 15, 52),
  ('networking', 3, 'Networking Kingdom', 'Networking', 'Network', 'The Packet Tyrant', 'guarded', 24, 76),
  ('linux', 4, 'Linux Citadel', 'Linux', 'Terminal', null, 'guarded', 32, 44),
  ('windows', 5, 'Windows Fortress', 'Windows', 'Building2', null, 'elevated', 41, 70),
  ('programming', 6, 'Programming', 'Programming', 'Bot', null, 'guarded', 49, 40),
  ('osint', 7, 'Recon & OSINT', 'Recon', 'Search', null, 'guarded', 58, 66),
  ('websec', 8, 'Web Security Metropolis', 'Web Sec', 'Globe', 'SQL Leviathan', 'elevated', 67, 34),
  ('pentest', 9, 'Penetration Testing', 'Pentest', 'Crosshair', null, 'elevated', 76, 62),
  ('privesc', 10, 'Privilege Escalation', 'PrivEsc', 'TrendingUp', null, 'elevated', 85, 30),
  ('ad', 11, 'Active Directory Empire', 'AD Empire', 'Server', 'Domain Overlord', 'severe', 93, 58),
  ('soc', 12, 'SOC Command Center', 'SOC', 'Radar', null, 'elevated', 10, 22),
  ('ir', 13, 'Incident Response', 'IR', 'ShieldAlert', null, 'severe', 21, 12),
  ('forensics', 14, 'Digital Forensics', 'Forensics', 'Fingerprint', null, 'severe', 34, 18),
  ('malware', 15, 'Malware Analysis & RE', 'Malware RE', 'Bug', 'HOLLOW TIDE', 'critical', 46, 10),
  ('cloud', 16, 'Cloud Security & DevSecOps', 'Cloud', 'Cloud', null, 'severe', 58, 18),
  ('crypto', 17, 'Cryptography', 'Crypto', 'KeyRound', null, 'severe', 70, 8),
  ('redteam', 18, 'Advanced Red Team', 'Red Team', 'Skull', 'The Shadow Cell', 'critical', 80, 16),
  ('hunting', 19, 'Threat Hunting', 'Hunting', 'Activity', null, 'critical', 90, 8),
  ('aisec', 20, 'AI Security', 'AI Sec', 'Brain', 'ORACLE-9', 'critical', 97, 22);

create table public.player_world_progress (
  player_id uuid not null references auth.users (id) on delete cascade,
  world_id text not null references public.worlds (id) on delete cascade,
  state text not null default 'locked' check (state in ('locked', 'unlocked', 'active', 'cleared')),
  completion integer not null default 0,
  updated_at timestamptz not null default now(),
  primary key (player_id, world_id)
);

alter table public.player_world_progress enable row level security;

create policy "Progress viewable by owner"
  on public.player_world_progress for select
  using (auth.uid() = player_id);

create policy "Progress insertable by owner"
  on public.player_world_progress for insert
  with check (auth.uid() = player_id);

create policy "Progress updatable by owner"
  on public.player_world_progress for update
  using (auth.uid() = player_id);

-- Extend the signup trigger: every new player starts with the first world
-- (Academy) unlocked. Everything else is implicitly locked (no row yet).
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, display_name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'display_name', split_part(new.email, '@', 1))
  );

  insert into public.player_world_progress (player_id, world_id, state, completion)
  select new.id, id, 'unlocked', 0 from public.worlds where index = 1;

  return new;
end;
$$;
