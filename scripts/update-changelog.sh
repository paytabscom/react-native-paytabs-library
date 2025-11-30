#!/bin/bash
set -e

echo "Updating CHANGELOG..."

NEW_VERSION=$NEW_VERSION
echo "Updating CHANGELOG for version $NEW_VERSION"

# Create temporary file with new changelog entry
cat > /tmp/changelog_entry.txt << EOF
## $NEW_VERSION

* Bug Fix

EOF

# Prepend new entry to CHANGELOG.md
cat /tmp/changelog_entry.txt CHANGELOG.md > CHANGELOG.md.new
mv CHANGELOG.md.new CHANGELOG.md
rm /tmp/changelog_entry.txt

echo "✓ CHANGELOG updated successfully"
echo "First 10 lines of CHANGELOG:"
head -10 CHANGELOG.md
