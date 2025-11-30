#!/bin/bash
set -e

echo "Reading current version..."

CURRENT_VERSION=$(grep -o '"version": "[^"]*"' package.json | head -1 | cut -d'"' -f4)
echo "Current version: $CURRENT_VERSION"
echo "CURRENT_VERSION=$CURRENT_VERSION" >> $CM_ENV

echo "✓ Version read and exported"
