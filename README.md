# ARVEN production on a VPS (Docker: app + Postgres + Caddy)

One command on the VPS as root:

    curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/main/i.sh | bash

- Installs Docker if missing, unpacks source into /opt/arven-app, generates `deploy/vps/.env`
  (random POSTGRES_PASSWORD / JWT_SECRET, created on the VPS, never committed).
- Builds the Next.js standalone image, `prisma db push` on Postgres, imports `prisma/seeded.db`
  (same snapshot TEST/Vercel serves) only when the DB is empty (`FORCE_IMPORT=1` to overwrite).
- Admins from TEST: admin@demo.com, sales@demo.com, editor@demo.com (password Admin123!). Change them after go-live.
- Caddy: https://arvenoutdoor.com (auto Let's Encrypt), www -> apex 301/308.
- Uploaded media is stored in Postgres (Asset rows), so the db_data volume holds content + uploads.

Re-deploy: run the same command again (keeps .env and DB data).
