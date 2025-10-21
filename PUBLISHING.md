# Publishing Guide

This document describes how to publish new versions of the `@paytabs/react-native-paytabs` package to npm.

## Prerequisites

1. **NPM Account**: Ensure you have an npm account with publish access to `@paytabs/react-native-paytabs`
2. **NPM Login**: Run `npm login` before publishing
3. **Git Access**: Ensure you have push access to the repository
4. **Clean Working Directory**: Commit or stash all changes before publishing

## Manual Publishing

### Using the Publish Script (Recommended)

The repository includes a convenient shell script for version bumping and publishing:

```bash
# Bump patch version (e.g., 2.6.9 -> 2.6.10)
./scripts/publish.sh patch

# Bump minor version (e.g., 2.6.9 -> 2.7.0)
./scripts/publish.sh minor

# Bump major version (e.g., 2.6.9 -> 3.0.0)
./scripts/publish.sh major
```

**What the script does:**
1. Validates that you're on the master/main branch
2. Checks for a clean working directory
3. Pulls the latest changes
4. Installs dependencies
5. Runs linter and tests
6. Builds the library
7. Bumps the version in `package.json`
8. Commits the version bump
9. Creates a git tag
10. Pushes to GitHub
11. Publishes to npm

### Using release-it

Alternatively, you can use the built-in `release-it` configuration:

```bash
yarn release
```

This will:
- Prompt you for the version bump type
- Generate a changelog
- Create a git tag
- Push to GitHub
- Publish to npm
- Create a GitHub release

## Automated Publishing (Codemagic)

The repository is configured with Codemagic CI/CD for automated builds and publishing.

### Setup

1. **Add the repository to Codemagic**
   - Go to [Codemagic](https://codemagic.io)
   - Add the repository

2. **Configure Environment Variables**
   - In Codemagic, create an environment group called `npm_credentials`
   - Add the following variable:
     - `NPM_TOKEN`: Your npm authentication token (get it from npmjs.com → Access Tokens)

3. **Configure Notifications**
   - Update the email recipients in `codemagic.yaml` if needed

### Workflows

#### 1. `react-native-library` (Main Build)
**Triggers:** Push to master/main or tags matching `v*`

**Actions:**
- Installs dependencies
- Runs linter
- Runs tests
- Builds the library
- Builds Android library
- Validates iOS Podspec

#### 2. `publish-npm` (NPM Publishing)
**Triggers:** Git tags matching `v*`

**Actions:**
- Installs dependencies
- Builds the library
- Publishes to npm with public access

**To trigger:**
```bash
# Create and push a version tag
git tag v2.6.10
git push origin v2.6.10
```

#### 3. `android-build` (PR Validation)
**Triggers:** Pull requests to any branch

**Actions:**
- Builds Android library
- Validates the build process

#### 4. `ios-build` (PR Validation)
**Triggers:** Pull requests to any branch

**Actions:**
- Builds iOS example app
- Validates CocoaPods integration

## Version Guidelines

Follow [Semantic Versioning](https://semver.org/):

- **Patch** (2.6.9 → 2.6.10): Bug fixes, minor changes
- **Minor** (2.6.9 → 2.7.0): New features, backward compatible
- **Major** (2.6.9 → 3.0.0): Breaking changes

## Checklist Before Publishing

- [ ] All tests pass locally
- [ ] Linter shows no errors
- [ ] CHANGELOG is updated (if using manual process)
- [ ] Documentation is up to date
- [ ] Example app works correctly
- [ ] iOS and Android builds succeed
- [ ] You're on the master/main branch
- [ ] Working directory is clean

## Troubleshooting

### "You must be logged in to publish packages"
```bash
npm login
```

### "You do not have permission to publish"
Contact the package owner to add you as a maintainer:
```bash
npm owner add <username> @paytabs/react-native-paytabs
```

### "Tag already exists"
```bash
# Delete the local tag
git tag -d v2.6.10

# Delete the remote tag
git push origin :refs/tags/v2.6.10
```

### Build Failures
```bash
# Clean and rebuild
yarn clean
yarn install
yarn prepare
```

## Post-Publishing

After publishing:

1. Verify the package on npm: https://www.npmjs.com/package/@paytabs/react-native-paytabs
2. Check the GitHub release: https://github.com/paytabscom/react-native-paytabs-library/releases
3. Test installation in a fresh project:
   ```bash
   npm install @paytabs/react-native-paytabs@latest
   ```
4. Update any dependent projects
5. Announce the release (if major version)

## Support

For issues with publishing:
- Check the [npm documentation](https://docs.npmjs.com/)
- Contact muhammad.alkady@paytabs.com
- Review Codemagic build logs

