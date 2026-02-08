#!/bin/bash
set -e

echo "Creating and pushing git tag..."

if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is not set or empty."
  exit 1
fi

NEW_VERSION=$NEW_VERSION
echo "Creating tag: v$NEW_VERSION"

git tag -a "v$NEW_VERSION" -m "Release version $NEW_VERSION"

# Push tag with authentication
echo "Pushing tag to GitHub..."
REPO_URL=$(git config --get remote.origin.url)
git remote set-url origin "https://${GITHUB_TOKEN}@github.com/${REPO_URL##*github.com/}"
git push origin "v$NEW_VERSION"
echo "✓ Successfully pushed tag v$NEW_VERSION"
