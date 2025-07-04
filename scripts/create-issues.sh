#!/bin/bash

# Script to create GitHub issues for Linux and Windows support

echo "Creating GitHub issues for platform support..."

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed. Please install it first:"
    echo "   brew install gh"
    echo "   or visit: https://cli.github.com/"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ This is not a git repository"
    exit 1
fi

# Create Linux support issue
echo "Creating Linux PAM integration issue..."
gh issue create \
    --title "Add Linux PAM integration for biometric authentication" \
    --body-file .github/ISSUE_TEMPLATE/linux_support.md \
    --label "enhancement,linux,help wanted"

# Create Windows support issue
echo "Creating Windows Hello integration issue..."
gh issue create \
    --title "Add Windows Hello integration for biometric authentication" \
    --body-file .github/ISSUE_TEMPLATE/windows_support.md \
    --label "enhancement,windows,help wanted"

echo "✅ Issues created successfully!"
echo "You can view them at: https://github.com/azu/confirm-pam/issues"