# ARVEN tip: admin analytics dashboard onescreen (no seed notice)

- Date: 2026-11-05 Asia/Shanghai
- SoT: `/workspace/arven-recovered` @ `eec432f` (also `e8bb4c5`)
- Files:
  - `src/components/admin/AnalyticsDashboard.tsx` (remove footerNote / seed-demo notice + refresh)
  - `src/components/admin/dashboard-premium.css` (`max-height: 820` media query for ~1280×800)
  - `deploy/vps/install.sh` (DONE echo: no demo credentials / passwords)
- KEEP-DB VPS only (`179.197.251.1`): overlay + `docker compose build/up --no-deps app` (no volume wipe, no FORCE_IMPORT)
- No Vercel creates (quota)
- No passwords in tip
- Tip pin (i.sh): `7d169a0da574ed63b11b9b2b7da30b80bccf2ca6`
- BUNDLE_BASE: `d473ae69aa287136c42450df7ca1c520ca624560`
- overlay.tgz sha256: `2bb6da48f2a12e5767a1667e5364882ccca06ce6c2f1bef5d1d4bca96df8d053`
- src.tgz sha256: `8f88368bca5ec2959e1a78baae661470b53864445e621740acba17bbd30ef0d6`
- Tip dir: `/workspace/arven-dash-onescreen-tip-20261105`
- Install helper: `keepdb.sh` (run on VPS as root after unpacking overlay)
