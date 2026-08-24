#!/usr/bin/env bash
# ============================================================================
#  个人主页部署脚本
#  用法:  ./scripts/deploy.sh [ "提交信息" ]
#  说明:  从 AGENT_ROOT/secrets/github.token 读取凭据（该文件在仓库之外，
#         并被 .gitignore 永久排除），再推送当前分支到 GitHub。
# ============================================================================
set -euo pipefail

# 仓库根目录（本脚本的上一级）
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# Agent 工作区根目录（仓库的上一级）
AGENT_ROOT="$(cd "${REPO_ROOT}/.." && pwd)"
TOKEN_FILE="${AGENT_ROOT}/secrets/github.token"
REMOTE="https://github.com/LouisChenYiqiao/LouisChenYiqiao.github.io.git"

# 提交信息：可传参，否则使用默认值
COMMIT_MSG="${1:-更新: $(date '+%Y-%m-%d %H:%M')}"

if [ ! -f "$TOKEN_FILE" ]; then
  echo "❌ 未找到凭据文件: $TOKEN_FILE" >&2
  echo "   请先在 ${AGENT_ROOT}/secrets/ 下放置 github.token 文件。" >&2
  exit 1
fi

TOKEN="$(tr -d '[:space:]' < "$TOKEN_FILE")"
if [ -z "$TOKEN" ]; then
  echo "❌ 凭据文件为空: $TOKEN_FILE" >&2
  exit 1
fi

cd "$REPO_ROOT"

echo "==> 拉取远端最新状态"
git fetch "https://x-access-token:${TOKEN}@github.com/LouisChenYiqiao/LouisChenYiqiao.github.io.git" main \
  || { echo "❌ fetch 失败，请检查 token 是否有效"; exit 1; }

echo "==> 暂存并提交"
git add -A
if git diff --cached --quiet; then
  echo "    没有需要提交的改动，跳过 commit。"
else
  git commit -m "$COMMIT_MSG"
fi

echo "==> 推送到 main"
git push "https://x-access-token:${TOKEN}@github.com/LouisChenYiqiao/LouisChenYiqiao.github.io.git" main:main \
  || { echo "❌ push 失败"; exit 1; }

# push 成功后，将本地 origin/main 引用同步到当前 HEAD（即 push 后的远端状态）
git update-ref refs/remotes/origin/main HEAD 2>/dev/null || true

echo "✅ 部署完成 → https://louischenyiqiao.github.io"
