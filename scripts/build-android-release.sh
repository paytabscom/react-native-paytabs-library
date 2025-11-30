#!/bin/bash
set -e

echo "Building Android release..."
cd example/android
./gradlew assembleRelease
echo "✓ Android release build completed"
