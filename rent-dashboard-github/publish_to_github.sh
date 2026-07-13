#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./publish_to_github.sh https://github.com/YOUR_USER/YOUR_REPO.git

REMOTE_URL="${1:-}"
if [ -z "$REMOTE_URL" ]; then
  echo "Usage: ./publish_to_github.sh https://github.com/YOUR_USER/YOUR_REPO.git"
  exit 1
fi

git init
git add .
git commit -m "Initial rent dashboard"
git branch -M main
git remote add origin "$REMOTE_URL"
git push -u origin main
