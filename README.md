# ARVEN production on a VPS (Docker: app + Postgres + Caddy)

One command on the VPS as root:

    curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/main/i.sh | bash

If raw.githubusercontent.com serves a stale `main` cache, use the pinned commit:

    curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/866047ac955c09d646922adbd247e75ebeae849e/i.sh | BUNDLE_BASE=https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/866047ac955c09d646922adbd247e75ebeae849e bash

Preferred one-liner matching the client-approved live deploy (tip pin — updated after tip commit):

    curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/addbac8f88c79c1b9546732bb470d34caed6a203/i.sh | BUNDLE_BASE=https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/addbac8f88c79c1b9546732bb470d34caed6a203 bash

- Installs Docker if missing, unpacks source into /opt/arven-app, generates `deploy/vps/.env`
  (random POSTGRES_PASSWORD / JWT_SECRET, created on the VPS, never committed).
- Builds the Next.js standalone image, `prisma db push` on Postgres, imports `prisma/seeded.db`
  (same snapshot TEST/Vercel serves) only when the DB is empty (`FORCE_IMPORT=1` to overwrite).
- Admins from TEST: admin@demo.com, sales@demo.com, editor@demo.com (password Admin123!). Change them after go-live.
- Caddy: https://arvenoutdoor.com (auto Let's Encrypt), www -> apex 301/308.
- Uploaded media is stored in Postgres (Asset rows), so the db_data volume holds content + uploads.

Re-deploy: run the same command again (keeps .env and DB data).

Installer pin: `BUNDLE_BASE` defaults to commit `866047ac955c09d646922adbd247e75ebeae849e` so raw CDN cache on branch `main` cannot mix old/new part blobs. Override with `BUNDLE_BASE=...` if needed. Re-publish updates the pin.

Live production installer tip (CDN-safe one-liner SHA): `addbac8f88c79c1b9546732bb470d34caed6a203` (BUNDLE_BASE → 866047ac955c09d646922adbd247e75ebeae849e; src.tgz sha256 `6f2734fdbace88a22fff40deea2ed36d74fdd8a73bc38ae1245b038a401bbaf9`).

This release: public responsive fixes (EN inquiry product picker clip on 375/390; WhatsApp FAB no longer covers form controls / product CTAs).
