#!/bin/bash
set -e

echo "Creating release branch..."

NEW_VERSION=$NEW_VERSION
echo "Creating release branch: release_$NEW_VERSION"

git checkout -b "release_$NEW_VERSION"
git add pubspec.yaml CHANGELOG.md README.md
git commit -m "Bump version to $NEW_VERSION and update CHANGELOG & README"

# Push with proper authentication
echo "Pushing release branch to GitHub..."
REPO_URL=$(git config --get remote.origin.url)
git remote set-url origin "https://${GIT_CREDENTIALS}@github.com/${REPO_URL##*github.com/}"
git push -u origin "release_$NEW_VERSION"
echo "✓ Successfully pushed release_$NEW_VERSION branch"
