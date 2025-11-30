#!/bin/bash
set -e

echo "Reading current version..."

CURRENT_VERSION=$(grep "^version:" pubspec.yaml | sed 's/version: //')
echo "Current version: $CURRENT_VERSION"
echo "CURRENT_VERSION=$CURRENT_VERSION" >> $CM_ENV

echo "✓ Version read and exported"
