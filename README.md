# ARVEN VPS bundle (brand-loader fix 2026-11-04)

Production installer tip is pinned after publish. Prefer the one-liner in `DEPLOY.txt`.

- Bundle sha256: `2f93fc7cc6bf397cd7e9307ac0e4388eebf0f02e4b4dfcba0b1c45e4aed870b9`
- Parts commit: `9f82e7209f1460c291c3f9f771dbc622c35594f8`
- Keeps DB when Admin rows exist (do not set `FORCE_IMPORT=1` unless you intend a TEST re-import).

```bash
curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/<TIP>/i.sh | BUNDLE_BASE=https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/<TIP> bash
```
