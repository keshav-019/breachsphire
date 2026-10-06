#!/usr/bin/env bash
# Dumps the database to $BACKUP_DIR (custom format, restore with
# pg_restore) and keeps the newest $KEEP dumps with the same prefix.
#
# Usage: deploy/scripts/backup.sh [prefix]     (default prefix: manual)
set -euo pipefail
cd "$(dirname "$0")/.."

BACKUP_DIR="${BACKUP_DIR:-/data/backups}"
KEEP="${KEEP:-7}"
prefix="${1:-manual}"
db_user=$(grep -E '^POSTGRES_USER=' .env | cut -d= -f2-)

mkdir -p "$BACKUP_DIR"
file="$BACKUP_DIR/breachsphire-$prefix-$(date -u +%Y%m%dT%H%M%SZ).dump"

# Write to a temp name first so a failed dump never looks like a good one.
docker exec pg pg_dump -U "$db_user" -d "$db_user" -Fc > "$file.partial"
mv "$file.partial" "$file"
echo "backup: $file ($(du -h "$file" | cut -f1))"

ls -1t "$BACKUP_DIR"/breachsphire-"$prefix"-*.dump 2>/dev/null | tail -n +"$((KEEP + 1))" | while read -r old; do
  rm -f "$old"
  echo "backup: pruned $old"
done
