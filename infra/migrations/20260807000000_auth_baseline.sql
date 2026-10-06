-- Baseline for the `auth` schema the rest of the migrations build on.
--
-- Accounts live in auth.users (the API's AuthService reads and writes it,
-- player tables reference it, and profiles are created by a trigger on it),
-- and row-level policies are granted to the `authenticated` role and call
-- auth.uid(). This creates all three on a fresh database. Every statement
-- is guarded, so on an existing database it changes nothing.

create schema if not exists auth;

create table if not exists auth.users (
  id uuid primary key,
  aud varchar(255),
  role varchar(255),
  email varchar(255),
  encrypted_password varchar(255),
  email_confirmed_at timestamptz,
  last_sign_in_at timestamptz,
  raw_app_meta_data jsonb,
  raw_user_meta_data jsonb,
  created_at timestamptz,
  updated_at timestamptz,
  banned_until timestamptz,
  deleted_at timestamptz,
  is_sso_user boolean not null default false,
  is_anonymous boolean not null default false
);

-- Row-level policies are granted "to authenticated".
do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'authenticated') then
    create role authenticated nologin;
  end if;
end
$$;

-- The signed-in user's id for row-level policies, taken from the
-- request.jwt.claim.sub setting. The API connects as the table owner and
-- filters by user itself, so these policies are a second line of defence
-- for any other client.
do $$
begin
  if to_regprocedure('auth.uid()') is null then
    create function auth.uid() returns uuid
      language sql stable
      as $fn$ select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $fn$;
  end if;
end
$$;
