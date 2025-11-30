#!/bin/bash
set -e

echo "Installing example dependencies..."
cd example
yarn install
echo "✓ Example dependencies installed"
