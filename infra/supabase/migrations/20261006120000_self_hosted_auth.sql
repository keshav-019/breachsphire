-- Self-hosted auth: the API now issues its own sessions instead of Supabase
-- Auth. auth.users stays the account table (existing bcrypt hashes keep
-- working, and every player_* foreign key plus the on_auth_user_created
-- profile trigger still point at it). This table holds the API's refresh
-- tokens; only a SHA-256 hash of each token is stored.
create table if not exists auth.api_refresh_tokens (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  token_hash text not null unique,
  expires_at timestamptz not null,
  revoked_at timestamptz,
  replaced_by uuid references auth.api_refresh_tokens (id) on delete set null,
  created_at timestamptz not null default now()
);

create index if not exists api_refresh_tokens_user_id_idx
  on auth.api_refresh_tokens (user_id);

-- Emails are compared case-insensitively at sign-in and sign-up.
create unique index if not exists users_email_lower_key
  on auth.users (lower(email))
  where email is not null and is_sso_user = false;

-- Two pre-existing accounts never got a profile row; backfill so
-- /players/me works for everyone.
insert into public.profiles (id, display_name)
select u.id, coalesce(u.raw_user_meta_data ->> 'display_name', split_part(u.email, '@', 1))
from auth.users u
left join public.profiles p on p.id = u.id
where p.id is null and u.email is not null
on conflict (id) do nothing;
