#!/bin/bash
set -e

echo "Pushing bumped version to build branch..."

NEW_VERSION=$NEW_VERSION
BUILD_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current build branch: $BUILD_BRANCH"
echo "Pushing bumped version to $BUILD_BRANCH..."

git add pubspec.yaml CHANGELOG.md README.md
git commit -m "Bump version to $NEW_VERSION and update CHANGELOG & README"

# Push with proper authentication
REPO_URL=$(git config --get remote.origin.url)
git remote set-url origin "https://${GIT_CREDENTIALS}@github.com/${REPO_URL##*github.com/}"
git push origin "$BUILD_BRANCH"
echo "✓ Successfully pushed to $BUILD_BRANCH"
