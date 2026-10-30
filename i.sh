#!/usr/bin/env bash
# ARVEN production installer for Ubuntu VPS (run as root). Idempotent: safe to re-run.
#   curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/main/i.sh | bash
set -euo pipefail
BUNDLE_BASE="${BUNDLE_BASE:-https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/927ba7e5dc821003f1fe6d40735ae218b11eadd6}"
APP_DIR=/opt/arven-app
DEP=$APP_DIR/deploy/vps
log(){ echo -e "\n\033[1;32m==> $*\033[0m"; }
main(){

log "1/7 Docker"
if ! command -v docker >/dev/null 2>&1; then curl -fsSL https://get.docker.com -o /tmp/get-docker.sh && sh /tmp/get-docker.sh </dev/null; fi
docker compose version >/dev/null 2>&1 || apt-get install -y docker-compose-plugin
systemctl enable --now docker >/dev/null 2>&1 || true

log "2/7 Download source bundle"
TMP=$(mktemp -d)
curl -fsSL "$BUNDLE_BASE/bundle/manifest.txt" -o "$TMP/manifest.txt"
: > "$TMP/b64"
while read -r part sha; do
  [ -z "$part" ] && continue
  curl -fsSL "$BUNDLE_BASE/bundle/$part" >> "$TMP/b64"
done < <(grep -v '^sha256 ' "$TMP/manifest.txt")
base64 -d "$TMP/b64" > "$TMP/src.tgz"
want=$(awk '/^sha256 /{print $2}' "$TMP/manifest.txt")
got=$(sha256sum "$TMP/src.tgz" | cut -d' ' -f1)
[ "$want" = "$got" ] || { echo "checksum mismatch ($got != $want)"; exit 1; }
mkdir -p "$APP_DIR"
# keep generated .env across re-runs
[ -f "$DEP/.env" ] && cp "$DEP/.env" "$TMP/.env.keep"
find "$APP_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
tar -xzf "$TMP/src.tgz" -C "$APP_DIR"
[ -f "$TMP/.env.keep" ] && cp "$TMP/.env.keep" "$DEP/.env"
rm -rf "$TMP"

log "3/7 Secrets (.env)"
if [ ! -f "$DEP/.env" ]; then
  umask 077
  cat > "$DEP/.env" <<ENV
POSTGRES_PASSWORD=$(openssl rand -hex 24)
JWT_SECRET=$(openssl rand -hex 48)
ENV
fi

log "4/7 Stop old /opt/arven stack (frees ports 80/443; its volumes are kept)"
if [ -f /opt/arven/docker-compose.yml ] || [ -f /opt/arven/compose.yml ]; then
  (cd /opt/arven && docker compose down) || true
fi

cd "$DEP"
log "5/7 Build image (several minutes)"
docker compose build app

log "6/7 Start database + schema + data import"
docker compose up -d db
for i in $(seq 1 60); do docker compose exec -T db pg_isready -U arven -d arven >/dev/null 2>&1 && break; sleep 2; done
docker compose run --rm --no-deps -T -u root app node node_modules/prisma/build/index.js db push --skip-generate --schema=prisma/postgres/schema.prisma
cnt=$(docker compose exec -T db psql -U arven -d arven -tAc 'SELECT count(*) FROM "Admin"' 2>/dev/null | tr -d '[:space:]' || echo 0)
if [ "${cnt:-0}" = "0" ] || [ "${FORCE_IMPORT:-0}" = "1" ]; then
  docker compose run --rm --no-deps -T -u root app node scripts/db-import-sqlite.mjs prisma/seeded.db --force
else
  echo "DB already has $cnt admins - skipping import (FORCE_IMPORT=1 to re-import TEST data)"
fi

log "7/7 Start app + Caddy (HTTPS)"
docker compose up -d
sleep 8
docker compose ps
code=$(curl -s -o /dev/null -w '%{http_code}' -H 'Host: arvenoutdoor.com' http://127.0.0.1/ || true)
echo "Local check via Caddy: HTTP $code (308 redirect to https is expected)"
echo
echo "DONE. Open https://arvenoutdoor.com  |  admin: https://arvenoutdoor.com/admin  (admin@demo.com / Admin123!)"
echo "Logs: cd $DEP && docker compose logs -f app caddy"
}
main "$@" </dev/null
