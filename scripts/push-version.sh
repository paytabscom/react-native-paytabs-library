#!/bin/bash
set -e

echo "Pushing bumped version to build branch..."

if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is not set or empty."
  exit 1
fi

NEW_VERSION=$NEW_VERSION
BUILD_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current build branch: $BUILD_BRANCH"
echo "Pushing bumped version to $BUILD_BRANCH..."

# Add files if they have changes
git add -A
if git diff --cached --quiet; then
  echo "No changes to commit"
else
  git commit -m "Bump version to $NEW_VERSION and update README"
fi

# Push with proper authentication
REPO_URL=$(git config --get remote.origin.url)
git remote set-url origin "https://${GITHUB_TOKEN}@github.com/${REPO_URL##*github.com/}"
git push origin "$BUILD_BRANCH"
echo "✓ Successfully pushed to $BUILD_BRANCH"
