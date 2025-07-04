#!/bin/bash
set -e

RELEASE_TYPE=$1

if [ -z "$RELEASE_TYPE" ]; then
    echo "Usage: $0 <patch|minor|major>"
    exit 1
fi

# Check if we have semver command
if ! command -v semver &> /dev/null; then
    echo "Installing semver..."
    npm install -g semver
fi

# Get current version from Cargo.toml
CURRENT_VERSION=$(grep '^version = ' Cargo.toml | sed 's/version = "\(.*\)"/\1/')
echo "Current version: $CURRENT_VERSION"

# Calculate new version
NEW_VERSION=$(semver -i $RELEASE_TYPE $CURRENT_VERSION)
echo "New version: $NEW_VERSION"

# Update Cargo.toml
sed -i.bak "s/^version = \".*\"/version = \"$NEW_VERSION\"/" Cargo.toml
rm Cargo.toml.bak

echo "Updated Cargo.toml to version $NEW_VERSION"

# Check if there are any changes
if ! git diff --quiet; then
    echo "Committing version bump..."
    git add Cargo.toml
    git commit -m "chore: release v$NEW_VERSION"
else
    echo "No changes to commit"
fi

# Create and push tag
echo "Creating tag v$NEW_VERSION..."
git tag -a "v$NEW_VERSION" -m "Release v$NEW_VERSION"

echo "Pushing to origin..."
git push origin main
git push origin "v$NEW_VERSION"

# Publish to crates.io
echo "Publishing to crates.io..."
cargo publish

echo "✅ Release v$NEW_VERSION completed successfully!"
echo "🚀 Published to crates.io"
echo "📦 Tagged and pushed to GitHub"
echo ""
echo "Next steps:"
echo "- Create GitHub release manually if needed"
echo "- Update any documentation or announcements"