# FAQ admin — language Tabs + rich-text answers

**SoT:** `/workspace/arven-recovered` commit `20f2c1f` (feat/faq-admin-tabs-richtext).
**Date:** 2026-11-05 (Asia/Shanghai)
**Scope:** KEEP-DB VPS prod only. No Vercel (quota exhausted until ~2026-11-06 00:47 Asia/Shanghai). No passwords.

## What

Admin FAQ manager uses `LocaleTabs` for per-locale Q&A editing and `NewsRichEditor` for HTML answers (YouTube embeds allowed via SafeHtml).

Public FAQ page renders sanitized HTML answers.

## Files (overlay onto `/opt/arven`)

See `FILES.md5`.

## Deploy

```bash
bash /tmp/arven-faq-admin-tabs-tip-keepdb.sh
```

Uses flock on `/tmp/arven-tips/compose-build.lock`, asserts postgres Prisma client, KEEP-DB (no seeded.db import when Admin count > 0).
