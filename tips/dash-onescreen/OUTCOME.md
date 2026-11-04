# Dash-onescreen tip — OUTCOME (Asia/Shanghai 2026-11-05)

## Status: HOLD on VPS
Production reported DOWN (Application error). All further VPS deploy/compose/docker to `179.197.251.1` stopped per parent HOLD. Tip code remains local+GitHub docs only until recovery finishes.

## Tip (local OK)
- SoT commits: `e8bb4c5` (remove footerNote/seed notice) + `eec432f` (max-height:820; install.sh DONE no passwords)
- AnalyticsDashboard.tsx sha1 `4deb1029f7d218ac6e90ad067e197579cd1e19a8` — footerNote count `0`
- dashboard-premium.css sha1 `894f5a1a81be80f6c07c8f8b75ea75bd72d7984d` — `max-height: 820` present
- Tip dir: `/workspace/arven-dash-onescreen-tip-20261105`
- overlay.tgz sha256 `2bb6da48f2a12e5767a1667e5364882ccca06ce6c2f1bef5d1d4bca96df8d053`
- src.tgz sha256 `8f88368bca5ec2959e1a78baae661470b53864445e621740acba17bbd30ef0d6`
- Tip pin i.sh `7d169a0da574ed63b11b9b2b7da30b80bccf2ca6` / BUNDLE_BASE `d473ae69aa287136c42450df7ca1c520ca624560`
- GitHub docs: `tips/dash-onescreen/` on `gaosichun/arven-vps-bundle`
- SoT README pin line: Dash-onescreen tip (deploy/vps/README.md)
- No passwords in tip / install.sh DONE
- No Vercel creates

## Last VPS observations before HOLD (not re-verified after HOLD)
- KEEP-DB Admin count was `5` (volumes intact; no FORCE_IMPORT)
- Live image briefly showed FN=0 MH=1 with admin login HTTP 200
- Concurrent tip stampede caused incomplete tree / canceled builds; app later dropped → 502
- Deploy/compose activity stopped; recovery is owned elsewhere

## After recovery
Re-apply KEEP-DB overlay only (`keepdb.sh` / tip overlay.tgz), assert Admin>0, FN=0, MH=1, smoke `/admin/login` — do not wipe postgres volumes.
