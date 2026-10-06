#!/usr/bin/env bash
# Deploys one API image on the VM: backup -> migrations -> swap the api
# container -> health check, rolling back to the previous image if the new
# one does not come up healthy.
#
# Usage: deploy/scripts/deploy.sh <image>
#   e.g. deploy/scripts/deploy.sh ghcr.io/keshav-019/breachsphire-api:<commit-sha>
# The caller must already be logged in to the registry if it is private.
set -euo pipefail
cd "$(dirname "$0")/.."

image="${1:?usage: deploy.sh <image>}"
HEALTH_TIMEOUT="${HEALTH_TIMEOUT:-90}"

log() { echo "[deploy $(date -u +%H:%M:%S)] $*"; }

wait_healthy() {
  local status
  for ((i = 0; i < HEALTH_TIMEOUT; i += 3)); do
    status=$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}no-healthcheck{{end}}' api 2>/dev/null || echo missing)
    [[ "$status" == healthy ]] && return 0
    sleep 3
  done
  log "api is '$status' after ${HEALTH_TIMEOUT}s"
  return 1
}

# --- preflight ---------------------------------------------------------------
for f in .env certs/ca.crt certs/server.crt certs/server.key; do
  [[ -f "$f" ]] || { log "missing deploy/$f on this VM (see deploy/README.md)"; exit 1; }
done
if [[ "$(docker inspect -f '{{.State.Health.Status}}' pg 2>/dev/null)" != healthy ]]; then
  log "postgres container 'pg' is not healthy, refusing to deploy"
  exit 1
fi

# --- 1. pull first: nothing changes if the image is unavailable --------------
log "pulling $image"
docker pull -q "$image"

# --- 2. backup, then migrations ----------------------------------------------
log "backing up database"
./scripts/backup.sh deploy
log "running migrations"
./scripts/migrate.sh

# --- 3. swap the api container -----------------------------------------------
previous=$(docker image inspect -f '{{.Id}}' breachsphire-api:current 2>/dev/null || true)
if [[ -n "$previous" ]]; then
  docker tag "$previous" breachsphire-api:previous
fi
docker tag "$image" breachsphire-api:current
log "starting api from $image"
docker compose up -d --no-deps api

# --- 4. health check, rollback on failure ------------------------------------
if ! wait_healthy || ! docker exec api node -e "fetch('http://127.0.0.1:3001/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"; then
  log "new api is unhealthy; last log lines:"
  docker logs --tail 30 api 2>&1 || true
  if [[ -n "$previous" ]]; then
    log "rolling back to previous image ${previous:7:12}"
    docker tag "$previous" breachsphire-api:current
    docker compose up -d --no-deps api
    if wait_healthy; then
      log "rollback healthy"
    else
      log "ROLLBACK ALSO UNHEALTHY, check the api container"
    fi
  fi
  log "note: migrations already applied are not reverted (backup is in /data/backups)"
  exit 1
fi
log "api healthy on $image"

# --- 5. cleanup: keep current + previous, drop older registry tags -----------
keep_ids="$(docker image inspect -f '{{.Id}}' breachsphire-api:current breachsphire-api:previous 2>/dev/null | sort -u)"
docker images --format '{{.Repository}}:{{.Tag}} {{.ID}}' "ghcr.io/keshav-019/breachsphire-api" | while read -r ref id; do
  full=$(docker image inspect -f '{{.Id}}' "$id")
  grep -qxF "$full" <<<"$keep_ids" || docker rmi "$ref" >/dev/null 2>&1 || true
done
docker image prune -f >/dev/null
log "done"
