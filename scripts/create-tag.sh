#!/bin/bash
set -e

echo "Creating and pushing git tag..."

NEW_VERSION=$NEW_VERSION
echo "Creating tag: v$NEW_VERSION"

git tag -a "v$NEW_VERSION" -m "Release version $NEW_VERSION"

# Push tag with authentication
echo "Pushing tag to GitHub..."
REPO_URL=$(git config --get remote.origin.url)
git remote set-url origin "https://${GIT_CREDENTIALS}@github.com/${REPO_URL##*github.com/}"
git push origin "v$NEW_VERSION"
echo "✓ Successfully pushed tag v$NEW_VERSION"
