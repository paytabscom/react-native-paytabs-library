#!/bin/bash

# Script to bump version and publish to npm
# Usage: ./scripts/publish.sh [patch|minor|major]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_error() {
    echo -e "${RED}ERROR: $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}→ $1${NC}"
}

# Check if version bump type is provided
VERSION_BUMP=${1:-patch}

# Validate version bump type
if [[ ! "$VERSION_BUMP" =~ ^(patch|minor|major)$ ]]; then
    print_error "Invalid version bump type. Use: patch, minor, or major"
    echo "Usage: ./scripts/publish.sh [patch|minor|major]"
    exit 1
fi

# Check if git working directory is clean
if [[ -n $(git status -s) ]]; then
    print_error "Working directory is not clean. Please commit or stash your changes first."
    git status -s
    exit 1
fi

print_info "Starting publish process with version bump: $VERSION_BUMP"

# Get current version
CURRENT_VERSION=$(node -p "require('./package.json').version")
print_info "Current version: $CURRENT_VERSION"

# Make sure we're on the latest master/main branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$CURRENT_BRANCH" != "master" && "$CURRENT_BRANCH" != "main" ]]; then
    print_error "You must be on master or main branch to publish"
    exit 1
fi

print_info "Pulling latest changes..."
git pull origin $CURRENT_BRANCH

# Install dependencies
print_info "Installing dependencies..."
yarn install

# Run linter
print_info "Running linter..."
if ! yarn lint; then
    print_error "Linting failed. Please fix the errors and try again."
    exit 1
fi
print_success "Linting passed"

# Run tests
print_info "Running tests..."
if ! yarn test; then
    print_error "Tests failed. Please fix the tests and try again."
    exit 1
fi
print_success "Tests passed"

# Build the library
print_info "Building library..."
if ! yarn prepare; then
    print_error "Build failed. Please fix the errors and try again."
    exit 1
fi
print_success "Build completed"

# Bump version using npm version
print_info "Bumping version ($VERSION_BUMP)..."
NEW_VERSION=$(npm version $VERSION_BUMP --no-git-tag-version)
print_success "Version bumped to: $NEW_VERSION"

# Update git
print_info "Committing version bump..."
git add package.json
git commit -m "chore: release $NEW_VERSION"

# Create git tag
print_info "Creating git tag..."
git tag -a "$NEW_VERSION" -m "Release $NEW_VERSION"

# Push to remote
print_info "Pushing to remote repository..."
git push origin $CURRENT_BRANCH
git push origin "$NEW_VERSION"
print_success "Pushed to remote"

# Publish to npm
print_info "Publishing to npm..."
if ! npm publish --access public; then
    print_error "Publishing to npm failed"
    print_error "You may need to:"
    print_error "1. Login to npm: npm login"
    print_error "2. Check your npm credentials"
    print_error "3. Verify package name is available"
    exit 1
fi

print_success "Successfully published $NEW_VERSION to npm!"

# Summary
echo ""
echo "======================================"
print_success "Publication Complete!"
echo "======================================"
echo "Package: @paytabs/react-native-paytabs"
echo "Version: $NEW_VERSION"
echo "Branch: $CURRENT_BRANCH"
echo "======================================"
echo ""
print_info "Next steps:"
echo "  - Verify on npm: https://www.npmjs.com/package/@paytabs/react-native-paytabs"
echo "  - Check GitHub release: https://github.com/paytabscom/react-native-paytabs-library/releases"
echo ""

