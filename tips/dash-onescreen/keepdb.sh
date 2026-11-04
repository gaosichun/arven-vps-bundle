#!/usr/bin/env bash
# KEEP-DB dash onescreen overlay — run ON the VPS as root.
set -euo pipefail
SRC=${1:-/tmp/arven-dash-onescreen-tip}
APP=/opt/arven-app
install -D -m 0644 "$SRC/src/components/admin/AnalyticsDashboard.tsx" "$APP/src/components/admin/AnalyticsDashboard.tsx"
install -D -m 0644 "$SRC/src/components/admin/dashboard-premium.css" "$APP/src/components/admin/dashboard-premium.css"
install -D -m 0644 "$SRC/deploy/vps/install.sh" "$APP/deploy/vps/install.sh"
grep -c footerNote "$APP/src/components/admin/AnalyticsDashboard.tsx" | grep -qx 0
grep -q 'max-height: 820' "$APP/src/components/admin/dashboard-premium.css"
grep -q 'DONE. Open https://arvenoutdoor.com' "$APP/deploy/vps/install.sh"
! grep -Eiq 'Admin123|password:' "$APP/deploy/vps/install.sh" || { echo "REFUSE: password-like string in install.sh DONE"; exit 3; }
cd "$APP/deploy/vps"
cnt=$(docker compose exec -T db psql -U arven -d arven -tAc 'SELECT count(*) FROM "Admin"' 2>/dev/null | tr -d '[:space:]' || echo 0)
echo "Admin.count=$cnt"
[ "${cnt:-0}" != "0" ] || { echo "REFUSE: Admin.count=0 — abort KEEP-DB rebuild"; exit 2; }
docker compose build app
docker compose up -d --no-deps app
docker compose ps
echo "DONE KEEP-DB dash onescreen tip"
