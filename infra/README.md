# infra

## migrations/

The database schema and game content as ordered SQL migrations
(`<YYYYMMDDHHMMSS>_<name>.sql`). `deploy/scripts/migrate.sh` applies the ones
not yet recorded in `migrations.schema_migrations`, each in its own
transaction, as part of every deploy. Run against an empty PostgreSQL they
build the complete database; `20260807000000_auth_baseline.sql` creates the
`auth` schema (accounts, the `authenticated` role, `auth.uid()`) the rest
build on.

Add a change as a new file with a later timestamp. Never edit a migration that
has already been applied: it will not run again.

The VM's Docker Compose stack and deploy scripts live in
[`deploy/`](../deploy/README.md).
