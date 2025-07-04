#!/bin/bash

# Example usage of confirm-pam

# Build the project
cargo build --release

# Example 1: Git commit hook simulation
echo "Example 1: Git commit hook with --no-verify protection"
echo "Please authenticate with Touch ID when prompted..."
if ./target/release/confirm-pam "Allow git commit --no-verify?"; then
    echo "✅ Touch ID authenticated - proceeding with git commit --no-verify"
else
    echo "❌ Touch ID authentication failed or cancelled - blocking git commit --no-verify"
fi

# Example 2: Sensitive operation confirmation
echo -e "\nExample 2: Sensitive operation confirmation"
echo "Please authenticate with Touch ID when prompted (or cancel to test rejection)..."
if ./target/release/confirm-pam "Delete production database?"; then
    echo "⚠️  User confirmed dangerous operation with Touch ID"
else
    echo "✅ Operation cancelled by user or Touch ID failed"
fi

# Example 3: Check if Touch ID is available
echo -e "\nExample 3: Checking Touch ID availability"
./target/release/confirm-pam "Test availability" 2>/dev/null
case $? in
    0) echo "✅ Touch ID is available and authentication succeeded" ;;
    1) echo "❌ Touch ID is available but user cancelled" ;;
    2) echo "❌ Touch ID authentication error occurred" ;;
    *) echo "❌ Unknown error" ;;
esac