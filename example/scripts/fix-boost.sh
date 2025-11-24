#!/bin/bash

# Fix boost.podspec checksum issue for React Native 0.70.6
# This script updates the boost source URL to use archives.boost.io instead of jfrog

BOOST_PODSPEC="node_modules/react-native/third-party-podspecs/boost.podspec"

if [ -f "$BOOST_PODSPEC" ]; then
  echo "Fixing boost.podspec checksum..."

  # Replace jfrog URL with archives.boost.io URL
  sed -i.bak "s|https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.bz2|https://archives.boost.io/release/1.76.0/source/boost_1_76_0.tar.bz2|g" "$BOOST_PODSPEC"

  # Remove backup file
  rm -f "${BOOST_PODSPEC}.bak"

  echo "boost.podspec fixed successfully"
else
  echo "Warning: boost.podspec not found at $BOOST_PODSPEC"
fi