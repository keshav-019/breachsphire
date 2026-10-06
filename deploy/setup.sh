#!/usr/bin/env bash
# Creates the .env file (asks for your password), builds the image,
# starts Postgres, and verifies that SSL is on and enforced.
set -euo pipefail

cd "$(dirname "$0")"
DB_USER="breachsphire"
CONTAINER="pg"

# --- Pre-flight checks -------------------------------------------------------
if ! docker info >/dev/null 2>&1; then
  echo "Cannot talk to Docker." >&2
  echo "If you just ran install-docker.sh, log out and SSH back in, then retry." >&2
  exit 1
fi

for f in certs/server.crt certs/server.key certs/ca.crt pg_hba.conf Dockerfile docker-compose.yaml; do
  [[ -f "$f" ]] || { echo "Missing $f. Run ./generate-certs.sh first." >&2; exit 1; }
done
chmod 600 certs/server.key

# --- .env with credentials ---------------------------------------------------
if [[ -f .env ]]; then
  echo "==> .env already exists, keeping it"
else
  echo "==> Set the password for database user '$DB_USER'"
  while true; do
    read -rsp "Password (min 12 chars): " pw1; echo
    read -rsp "Confirm password:        " pw2; echo
    if [[ "$pw1" != "$pw2" ]]; then
      echo "Passwords don't match, try again."
    elif [[ ${#pw1} -lt 12 ]]; then
      echo "Too short, use at least 12 characters."
    elif [[ "$pw1" == *"'"* ]]; then
      echo "Please avoid single quotes (') in the password."
    else
      break
    fi
  done
  (
    umask 077
    printf "POSTGRES_USER=%s\nPOSTGRES_PASSWORD='%s'\n" "$DB_USER" "$pw1" > .env
  )
  unset pw1 pw2
  echo "    .env written (permissions 600)"
fi
chmod 600 .env

# The API signs its access tokens with this; docker-compose.yaml refuses to
# run without it.
if ! grep -q '^JWT_SECRET=' .env; then
  [[ -z "$(tail -c1 .env)" ]] || echo >> .env
  echo "JWT_SECRET=$(openssl rand -hex 48)" >> .env
  echo "    JWT_SECRET generated in .env"
fi

# --- Build and start ---------------------------------------------------------
# Only Postgres: the api image comes from CI (deploy/scripts/deploy.sh).
echo "==> Building image and starting Postgres"
docker compose up -d --build postgres

echo "==> Waiting for Postgres to become healthy"
for i in $(seq 1 30); do
  status=$(docker inspect -f '{{.State.Health.Status}}' "$CONTAINER" 2>/dev/null || echo "starting")
  if [[ "$status" == "healthy" ]]; then
    echo "    healthy"
    break
  fi
  if [[ "$status" == "unhealthy" || $i -eq 30 ]]; then
    echo "Postgres did not become healthy. Recent logs:" >&2
    docker compose logs --tail 40 postgres >&2
    exit 1
  fi
  sleep 3
done

# --- Verify SSL --------------------------------------------------------------
echo "==> Checking SSL is enabled"
docker compose exec -T postgres psql -U "$DB_USER" -d "$DB_USER" -Atc "SHOW ssl;" | grep -qx on \
  && echo "    ssl = on"

echo "==> Checking an SSL connection with full certificate verification"
docker compose exec -T postgres sh -c \
  'PGPASSWORD="$POSTGRES_PASSWORD" psql "host=localhost user=$POSTGRES_USER dbname=$POSTGRES_USER sslmode=verify-full sslrootcert=/etc/postgresql/ssl/ca.crt" -Atc "SELECT version FROM pg_stat_ssl WHERE pid = pg_backend_pid();"' \
  | sed 's/^/    connected using /'

echo "==> Checking that non-SSL connections are rejected"
if docker compose exec -T postgres sh -c \
     'PGPASSWORD="$POSTGRES_PASSWORD" psql "host=localhost user=$POSTGRES_USER dbname=$POSTGRES_USER sslmode=disable" -c "SELECT 1"' >/dev/null 2>&1; then
  echo "    WARNING: a non-SSL connection succeeded. Check pg_hba.conf." >&2
  exit 1
else
  echo "    non-SSL connection rejected (as intended)"
fi

PUBLIC_IP=$(curl -fsS --max-time 5 https://checkip.amazonaws.com 2>/dev/null | tr -d '[:space:]' || echo "<vm-ip>")

cat <<EOF

Postgres 18 is running with SSL enforced.

Connect from your machine (after allowing port 5432 for your IP in the
cloud firewall / security group):

  psql "host=$PUBLIC_IP port=5432 dbname=$DB_USER user=$DB_USER sslmode=verify-full sslrootcert=ca.crt"

Useful commands (run in $(pwd)):
  docker compose ps                 # status
  docker compose logs -f postgres   # logs
  docker compose restart postgres   # restart
  docker compose down               # stop (data is kept)
EOF
