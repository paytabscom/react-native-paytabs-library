#!/bin/bash
set -e

echo "Configuring npm authentication..."
echo "//registry.npmjs.org/:_authToken=${NPM_TOKEN}" > ~/.npmrc
echo "✓ NPM credentials configured"
