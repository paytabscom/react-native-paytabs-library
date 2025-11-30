#!/bin/bash
set -e

echo "Updating README.md with new version..."

NEW_VERSION=$NEW_VERSION
echo "Updating README.md to version $NEW_VERSION"

# Update the version badge (line 3)
# Replace v2.6.9 with v$NEW_VERSION in the badge
sed -i.bak "s/React%20Native%20Paytabs-v[0-9]*\.[0-9]*\.[0-9]*/React%20Native%20Paytabs-v${NEW_VERSION}/g" README.md

# Update the npm install command
# Replace @paytabs/react-native-paytabs@2.7.0 with @paytabs/react-native-paytabs@$NEW_VERSION
sed -i.bak "s/@paytabs\/react-native-paytabs@[0-9]*\.[0-9]*\.[0-9]*/@paytabs\/react-native-paytabs@${NEW_VERSION}/g" README.md

# Clean up backup file
rm -f README.md.bak

echo "✓ README.md updated successfully with version $NEW_VERSION"
echo "Updated sections:"
echo "1. Version badge: v$NEW_VERSION"
echo "2. npm install command: @paytabs/react-native-paytabs@$NEW_VERSION"
