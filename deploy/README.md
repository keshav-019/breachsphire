# Deployment (VM)

Production runs on one VM (`vanisher.projectyourown.com`) with Docker Compose:

| Container | What | Port |
|---|---|---|
| `pg` | PostgreSQL 18, TLS required (`verify-full` capable) | 5432 |
| `api` | NestJS API (`apps/api`), image built by CI | 3001 |

The VM has a checkout of this repo at `~/breachsphire`; everything runs from
its `deploy/` directory. Docker's data lives on the `/data` volume, database
backups in `/data/backups`.

## How a deploy happens

Push to `main` touching the API, shared types, migrations or `deploy/` runs
[`.github/workflows/deploy-api.yml`](../.github/workflows/deploy-api.yml):

1. **check**: typecheck + build the API, shellcheck these scripts.
2. **image**: build `apps/api/Dockerfile`, push
   `ghcr.io/keshav-019/breachsphire-api:<commit-sha>` (and `:main`).
3. **deploy** (environment `vm-production`): SSH to the VM with the deploy key,
   `git reset --hard <commit-sha>` the checkout, log in to GHCR for this job
   only, then run [`scripts/deploy.sh`](scripts/deploy.sh):
   pull image → back up DB → apply pending migrations → swap the `api`
   container → health check → **roll back to the previous image** if it is not
   healthy within 90 s → prune old images.

Pull requests run steps 1–2 without pushing or deploying. A deploy can also be
started by hand: Actions → API CI/CD → Run workflow (on `main`).

Migrations are forward-only: a rollback restores the previous API image but
not the schema. Every deploy takes a backup first (newest 7 kept).

## Files on the VM that are not in git

`deploy/.env` (mode 600):

```
POSTGRES_USER=breachsphire
POSTGRES_PASSWORD=...
JWT_SECRET=...        # openssl rand -hex 48; changing it signs everyone out
```

`deploy/certs/`: `ca.crt`, `server.crt`, `server.key` (from
`generate-certs.sh`). Keep `ca.key` off the server.

## GitHub configuration

Environment **vm-production** (deployments limited to `main`; separate from
the `Production` environment Vercel uses for the web app) holds:

| Secret | Value |
|---|---|
| `VM_HOST` | `vanisher.projectyourown.com` |
| `VM_USER` | `ubuntu` |
| `VM_SSH_KEY` | private half of the deploy key (`github-actions-deploy` in the VM's `~/.ssh/authorized_keys`, no port/agent/X11 forwarding, no pty) |
| `VM_KNOWN_HOSTS` | the VM's SSH host keys, so the runner refuses a different host |

To rotate the deploy key: generate a new ed25519 key, replace its line in
`authorized_keys`, and update `VM_SSH_KEY`.

## Day-to-day commands (on the VM, in `~/breachsphire/deploy`)

```bash
docker compose ps                      # status
docker compose logs -f api             # API logs
scripts/backup.sh                      # manual backup -> /data/backups
scripts/migrate.sh --dry-run           # list pending migrations
docker tag breachsphire-api:previous breachsphire-api:current && docker compose up -d --no-deps api   # manual rollback
```

Changes to the Postgres image (`Dockerfile`, `pg_hba.conf`, certs) are **not**
applied by CI, because rebuilding restarts the database. Apply them by hand:
`docker compose up -d --build postgres`.

## New VM from scratch

1. `./install-docker.sh`, then log out and back in.
2. `./generate-certs.sh <public-ip> <dns-name>` and move `certs/ca.key` off the server.
3. `./setup.sh` (asks for the DB password, generates `JWT_SECRET`, starts Postgres, verifies TLS).
4. Restore data with `pg_restore`, if any, then run the workflow to deploy the API.
