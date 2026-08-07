# infra

Deployment config: Cloudflare Pages (web), the API's container host, Supabase
migrations, Cloudflare R2 buckets, and the dedicated Docker host for isolated
labs (section 29).

## supabase/

A local-first Supabase project (`supabase init`'d here, not at the repo
root). `pnpm db:start` / `db:stop` / `db:status` (run from the repo root)
drive it via the CLI's `--workdir infra` flag. `supabase/migrations/` holds
the SQL migrations — currently just `profiles` (one row per `auth.users` row,
auto-created via trigger on signup). Link this project to a hosted Supabase
project when a real deployment target exists (`supabase link`); no code
changes needed on the app side, just swapping the `.env` values.

Everything else in this folder (Cloudflare Pages/Workers config, R2 buckets,
the isolated-lab Docker host) is not implemented yet.
