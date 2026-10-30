# ARVEN production on a VPS (Docker: app + Postgres + Caddy)

One command on the VPS as root:

    curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/main/i.sh | bash

If raw.githubusercontent.com serves a stale `main` cache, use the pinned commit (same installer body; `BUNDLE_BASE` already points here for parts):

    curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/927ba7e5dc821003f1fe6d40735ae218b11eadd6/i.sh | BUNDLE_BASE=https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/927ba7e5dc821003f1fe6d40735ae218b11eadd6 bash

- Installs Docker if missing, unpacks source into /opt/arven-app, generates `deploy/vps/.env`
  (random POSTGRES_PASSWORD / JWT_SECRET, created on the VPS, never committed).
- Builds the Next.js standalone image, `prisma db push` on Postgres, imports `prisma/seeded.db`
  (same snapshot TEST/Vercel serves) only when the DB is empty (`FORCE_IMPORT=1` to overwrite).
- Admins from TEST: admin@demo.com, sales@demo.com, editor@demo.com (password Admin123!). Change them after go-live.
- Caddy: https://arvenoutdoor.com (auto Let's Encrypt), www -> apex 301/308.
- Uploaded media is stored in Postgres (Asset rows), so the db_data volume holds content + uploads.

Re-deploy: run the same command again (keeps .env and DB data).

Installer pin: `BUNDLE_BASE` defaults to commit `927ba7e5dc821003f1fe6d40735ae218b11eadd6` so raw CDN cache on branch `main` cannot mix old/new part blobs. Override with `BUNDLE_BASE=...` if needed. Re-publish updates the pin.

This release: submitter receipt emails for inquiry + dealer apply (and dealer approved → applicant).
