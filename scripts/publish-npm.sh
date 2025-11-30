#!/bin/bash
set -e

echo "Publishing to npm..."
npm publish --access public
echo "✓ Successfully published to npm"
