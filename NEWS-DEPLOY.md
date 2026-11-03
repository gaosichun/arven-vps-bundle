ARVEN News module deploy (Asia/Shanghai)

ONE-LINER (run as root on VPS 179.197.251.1):

curl -fsSL https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/6620ab235d6487d3a963c7474a7f7d0b62bbadca/i.sh | BUNDLE_BASE=https://raw.githubusercontent.com/gaosichun/arven-vps-bundle/6620ab235d6487d3a963c7474a7f7d0b62bbadca bash

Notes:
- Keeps DB (skips import when Admin rows exist). Do NOT set FORCE_IMPORT=1.
- Bundle sha256 b5bb3af1291b84586804f634e6232a1f3068a8e52164ffd46e8921cd962ce8ab
- Parts commit: 8531db5eefe8e99fb3ee951599a20cbeb8cff9bd  pin: 6620ab235d6487d3a963c7474a7f7d0b62bbadca
- Build takes several minutes.
- Prefer tmux if console drops: tmux new -s arven-deploy
