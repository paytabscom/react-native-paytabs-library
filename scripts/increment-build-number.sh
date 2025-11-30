#!/bin/bash
set -e

echo "Incrementing build number..."
cd example/ios
echo "Current PROJECT_BUILD_NUMBER is $PROJECT_BUILD_NUMBER"
agvtool new-version -all "$PROJECT_BUILD_NUMBER"
echo "✓ Build number incremented"
