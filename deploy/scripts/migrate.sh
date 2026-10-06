#!/usr/bin/env bash
# Applies every migration in infra/supabase/migrations that is not yet
# recorded in supabase_migrations.schema_migrations, oldest first. Each file
# runs in its own transaction together with its bookkeeping row, so a
# failing migration leaves nothing behind and stops the deploy.
#
# Usage: deploy/scripts/migrate.sh [--dry-run]
set -euo pipefail
cd "$(dirname "$0")/.."

MIGRATIONS_DIR="${MIGRATIONS_DIR:-../infra/supabase/migrations}"
dry_run=false
[[ "${1:-}" == "--dry-run" ]] && dry_run=true

db_user=$(grep -E '^POSTGRES_USER=' .env | cut -d= -f2-)
psql_db() {
  docker exec -i pg psql -U "$db_user" -d "$db_user" -v ON_ERROR_STOP=1 -q "$@"
}

applied=$(psql_db -Atc "select version from supabase_migrations.schema_migrations")

pending=0
for file in $(find "$MIGRATIONS_DIR" -maxdepth 1 -name '*.sql' | sort); do
  name=$(basename "$file")
  version="${name%%_*}"
  if [[ ! "$version" =~ ^[0-9]+$ ]]; then
    echo "migrate: skipping $name (no numeric version prefix)" >&2
    continue
  fi
  grep -qxF "$version" <<<"$applied" && continue

  pending=$((pending + 1))
  if $dry_run; then
    echo "migrate: would apply $name"
    continue
  fi
  echo "migrate: applying $name"
  {
    echo "begin;"
    cat "$file"
    echo
    printf "insert into supabase_migrations.schema_migrations (version, name) values ('%s', '%s');\n" "$version" "$name"
    echo "commit;"
  } | psql_db
done

if [[ $pending -eq 0 ]]; then
  echo "migrate: database is up to date"
elif $dry_run; then
  echo "migrate: $pending pending (dry run, nothing applied)"
else
  echo "migrate: applied $pending migration(s)"
fi
