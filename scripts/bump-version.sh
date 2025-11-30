#!/bin/bash
set -e

echo "Bumping version..."

CURRENT_VERSION=$CURRENT_VERSION
# Increment patch version (e.g., 2.7.2 -> 2.7.3)
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

echo "Bumping version from $CURRENT_VERSION to $NEW_VERSION"
echo "NEW_VERSION=$NEW_VERSION" >> $CM_ENV

# Update package.json
sed -i.bak "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEW_VERSION\"/" package.json
rm -f package.json.bak

echo "✓ Version bumped to $NEW_VERSION"
