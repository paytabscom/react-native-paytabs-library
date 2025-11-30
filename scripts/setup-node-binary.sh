#!/bin/bash
set -e

echo "Setting up Node binary for Xcode..."
cd example/ios
# Update .xcode.env to use the correct node path
echo "export NODE_BINARY=$(which node)" > .xcode.env
cat .xcode.env
echo "✓ Node binary configured"
