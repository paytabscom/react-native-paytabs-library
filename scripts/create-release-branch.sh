#!/bin/bash
set -e

echo "Creating release branch..."

NEW_VERSION=$NEW_VERSION
echo "Creating release branch: release_$NEW_VERSION"

git checkout -b "release_$NEW_VERSION"

# Add files if they have changes
git add -A
if git diff --cached --quiet; then
  echo "No changes to commit"
else
  git commit -m "Bump version to $NEW_VERSION and update README"
fi

# Push with proper authentication
echo "Pushing release branch to GitHub..."
REPO_URL=$(git config --get remote.origin.url)
git remote set-url origin "https://${GIT_CREDENTIALS}@github.com/${REPO_URL##*github.com/}"
git push -u origin "release_$NEW_VERSION"
echo "✓ Successfully pushed release_$NEW_VERSION branch"
