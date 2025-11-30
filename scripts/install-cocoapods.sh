#!/bin/bash
set -e

echo "Installing CocoaPods dependencies..."
cd example/ios
rm -rf Pods Podfile.lock
pod install --repo-update
echo "✓ CocoaPods dependencies installed"
