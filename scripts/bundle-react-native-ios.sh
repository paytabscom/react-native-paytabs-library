#!/bin/bash
set -e

echo "Pre-bundling React Native for Release (iOS)..."
cd example
npx react-native bundle \
  --platform ios \
  --dev false \
  --entry-file index.js \
  --bundle-output ios/main.jsbundle \
  --assets-dest ios
echo "✓ React Native bundle created"
