#!/bin/bash
set -e

echo "Setting up git credentials..."

git config --global user.email "$Git_Mail"
git config --global user.name "$Git_User"

echo "✓ Git credentials configured"
