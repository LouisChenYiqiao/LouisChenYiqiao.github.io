#!/usr/bin/env bash
# ============================================================================
#  Personal homepage deployment helper
#  Usage: ./scripts/deploy.sh [ "Commit message" ]
#  Reads AGENT_ROOT/secrets/github.token outside the repository, then pushes
#  the main branch to the configured GitHub remote.
# ============================================================================
set -euo pipefail

# Repository root, one directory above this script.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# Workspace root, one directory above the repository.
AGENT_ROOT="$(cd "${REPO_ROOT}/.." && pwd)"
TOKEN_FILE="${AGENT_ROOT}/secrets/github.token"
REMOTE="$(git -C "$REPO_ROOT" remote get-url origin)"

# Use the supplied commit message, or a timestamped default.
COMMIT_MSG="${1:-Update: $(date '+%Y-%m-%d %H:%M')}"

if [ ! -f "$TOKEN_FILE" ]; then
  echo "Error: Credential file not found: $TOKEN_FILE" >&2
  echo "   Place github.token in ${AGENT_ROOT}/secrets/ before deploying." >&2
  exit 1
fi

TOKEN="$(tr -d '[:space:]' < "$TOKEN_FILE")"
if [ -z "$TOKEN" ]; then
  echo "Error: Credential file is empty: $TOKEN_FILE" >&2
  exit 1
fi

# Pass the token through a temporary askpass helper, never a Git argument or remote URL.
ASKPASS_FILE="$(mktemp "${TMPDIR:-/tmp}/homepage-git-askpass.XXXXXX")"
trap 'rm -f "$ASKPASS_FILE"' EXIT
cat > "$ASKPASS_FILE" <<'ASKPASS'
#!/usr/bin/env bash
case "$1" in
  *Username*) printf '%s\n' 'x-access-token' ;;
  *) printf '%s\n' "$GITHUB_TOKEN" ;;
esac
ASKPASS
chmod 700 "$ASKPASS_FILE"
export GIT_ASKPASS="$ASKPASS_FILE"
export GIT_TERMINAL_PROMPT=0
export GITHUB_TOKEN="$TOKEN"
unset TOKEN

cd "$REPO_ROOT"

echo "==> Fetching the latest remote state"
git fetch "$REMOTE" main \
  || { echo "Error: Fetch failed. Check the deployment credential."; exit 1; }

# Refuse to overwrite remote commits that have not been synchronized locally.
if ! git merge-base --is-ancestor FETCH_HEAD HEAD; then
  echo "Error: Remote main has unsynchronized commits. Reconcile them before deploying." >&2
  exit 1
fi

echo "==> Staging and committing changes"
git add -A
if git diff --cached --quiet; then
  echo "    No changes to commit. Skipping the commit step."
else
  git commit -m "$COMMIT_MSG"
fi

echo "==> Pushing main"
git push "$REMOTE" main:main \
  || { echo "Error: Push failed."; exit 1; }

# Synchronize the local tracking reference after a successful push.
git update-ref refs/remotes/origin/main HEAD 2>/dev/null || true

echo "Push complete. Check the repository Pages settings for publishing status."
