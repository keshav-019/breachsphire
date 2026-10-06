# Deployment

Everything server-side runs on one VM, `vanisher.projectyourown.com`:
PostgreSQL 18 and the NestJS API as Docker Compose services. The web app is a
static Vite/React SPA served by Vercel, which forwards API calls to the VM.

```
browser ──HTTPS──> Vercel (static SPA, /api/* rewrite) ──HTTP──> VM :3001  api ──TLS──> pg :5432
desktop app ───────────────────────────────────────────HTTP──> VM :3001
```

Operational detail (scripts, secrets, rollback, rebuilding the VM) lives in
[deploy/README.md](../deploy/README.md); this page is the overview.

## How it's wired

- **`apps/api`** runs as the `api` container from
  `ghcr.io/keshav-019/breachsphire-api:<commit>`, built from
  `apps/api/Dockerfile` by CI. It listens on port 3001 and talks to Postgres
  over the compose network with `sslmode=verify-full`.
- **Postgres** runs as the `pg` container (`deploy/Dockerfile`): TLS
  required for every network connection, SCRAM passwords, data on the VM's
  `/data` volume.
- **Auth** is part of the API (`apps/api/src/auth`): accounts in
  `auth.users` (bcrypt), 15-minute HS256 access tokens signed with
  `JWT_SECRET`, 30-day rotating refresh tokens stored hashed in
  `auth.api_refresh_tokens`.
- **Schema** comes from `infra/migrations/*.sql`, applied in order by
  `deploy/scripts/migrate.sh` and recorded in `migrations.schema_migrations`.
  The full set builds a working database from an empty Postgres.
- **`apps/web`** builds on Vercel (`vercel.json`). Nest's routes have no
  `/api` prefix, so `vercel.json` rewrites `/api/:path*` to
  `http://vanisher.projectyourown.com:3001/:path*`, the same as the local
  Vite proxy (`apps/web/vite.config.ts`). The browser only ever talks to the
  site's own HTTPS origin. A second rewrite sends every other path to
  `/index.html` for client-side routing.
- **`apps/desktop`** loads the renderer from `file:` and calls the VM
  directly (`apps/web/src/lib/api-base.ts`).

## Configuration

| Variable | Where | Notes |
|---|---|---|
| `POSTGRES_USER`, `POSTGRES_PASSWORD` | VM, `deploy/.env` | Database account; the API gets the password as `PGPASSWORD`. |
| `JWT_SECRET` | VM, `deploy/.env` | Signs access tokens. Changing it signs everyone out. |
| `VITE_API_BASE_URL` | Local `apps/web/.env` only | Leave unset on Vercel so the site uses its `/api` proxy (an `http://` API URL would be blocked as mixed content). |

## Deploying

- **API + database:** push to `main`. `.github/workflows/deploy-api.yml`
  typechecks, builds and pushes the image, then deploys it to the VM over
  SSH: back up the database, apply pending migrations, swap the container,
  health-check, and roll back automatically if the new image is unhealthy.
- **Web:** Vercel builds and publishes `main` on its own.

## Known limitations

- The API is served over plain HTTP on port 3001. Browsers reach it through
  Vercel over HTTPS, but the hop from Vercel to the VM, and the desktop app's
  calls, are unencrypted until a TLS-terminating proxy (e.g. Caddy with a
  domain) is put in front of it.
- One VM, no replica: a VM outage takes the API and database down. Database
  backups are taken on every deploy (`/data/backups`, newest 7 kept) but stay
  on the same machine.
- Migrations are forward-only; an automatic rollback restores the previous
  API image, not the previous schema.
