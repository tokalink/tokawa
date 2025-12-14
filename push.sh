#!/bin/bash
set -euo pipefail

MAIN_BRANCH="main"
CUSTOM_BRANCH="gowa"
UPSTREAM_BRANCH="upstream/main"

# === TANGGAL COMMIT ===
COMMIT_DATE=$(date +"%Y-%m-%d %H:%M")
COMMIT_MSG="update: ${COMMIT_DATE}"

echo "📄 Git status:"
git status --short

# === CEK ADA PERUBAHAN ATAU TIDAK ===
# Ada perubahan kalau:
# - ada modified/added/deleted (tracked)
# - atau ada untracked files
if [[ -n "$(git status --porcelain)" ]]; then
  echo "➕ Git add ."
  git add .

  echo "📝 Git commit"
  git commit -m "$COMMIT_MSG"
else
  echo "ℹ️ Tidak ada perubahan lokal. Lanjut sync upstream saja."
fi

echo "🔄 Fetch upstream..."
git fetch upstream

echo "📌 Checkout $MAIN_BRANCH..."
git checkout "$MAIN_BRANCH"

echo "🔀 Merge $UPSTREAM_BRANCH -> $MAIN_BRANCH..."
git merge "$UPSTREAM_BRANCH"

echo "⬆️ Push $MAIN_BRANCH -> origin..."
git push origin "$MAIN_BRANCH"

echo "📌 Checkout $CUSTOM_BRANCH..."
git checkout "$CUSTOM_BRANCH"

echo "🧩 Rebase $CUSTOM_BRANCH onto $MAIN_BRANCH..."
git rebase "$MAIN_BRANCH"

echo "⬆️ Push (force) $CUSTOM_BRANCH -> origin..."
git push -f origin "$CUSTOM_BRANCH"

echo "✅ DONE: commit + sync upstream + rebase $CUSTOM_BRANCH"