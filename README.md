# confirm-pam

A CLI tool for biometric authentication confirmation.

## Overview

`confirm-pam` is a command-line tool that provides biometric authentication (fingerprint/Touch ID) confirmation prompts. It's designed to prevent automated tools (including AI agents) from bypassing security checks like `git commit --no-verify`.

## Features

- ✅ Touch ID authentication on macOS
- 🔐 Custom message display during authentication prompt
- 🚦 Simple exit codes: 0 for success, 1 for failure/cancel, 2 for errors
- 🪶 Lightweight binary with minimal dependencies
- 🚀 Fast native performance

## Installation

### From Source

```bash
# Clone and build
git clone https://github.com/azu/confirm-pam
cd confirm-pam
cargo build --release

# Copy to PATH
sudo cp target/release/confirm-pam /usr/local/bin/
```

### Homebrew

```bash
brew install azu/confirm-pam/confirm-pam
```

## Usage

### Basic Usage

```bash
confirm-pam "Your authentication message here"
```

### Exit Codes

- `0` - Authentication successful
- `1` - User cancelled authentication
- `2` - Error occurred (biometrics unavailable, etc.)

### Shell Script Integration

```bash
if confirm-pam "Allow sensitive operation?"; then
    echo "Authenticated - proceeding"
else
    echo "Authentication failed or cancelled"
    exit 1
fi
```

### Git Hook Example

Create `.git/hooks/pre-commit`:

```bash
#!/bin/bash
# Prevent --no-verify without biometric confirmation
if [[ "$GIT_PARAMS" == *"--no-verify"* ]]; then
    if ! confirm-pam "Allow bypassing git hooks with --no-verify?"; then
        echo "❌ Touch ID authentication required to use --no-verify"
        exit 1
    fi
fi
```

## Platform Support

| Platform | Status | Authentication Method | Issue |
|----------|--------|---------------------|-------|
| macOS    | ✅ Supported | Touch ID | - |
| Linux    | 🚧 Planned | PAM + fprintd | [#1](https://github.com/azu/confirm-pam/issues/1) |
| Windows  | 🚧 Planned | Windows Hello | [#2](https://github.com/azu/confirm-pam/issues/2) |

## Requirements

### macOS
- macOS 10.12.2 or later
- Touch ID capable device
- Touch ID must be configured in System Preferences

## Development

### Using Make Commands

```bash
# Show available commands
make help

# Build the project
make build

# Run all tests (unit + lint + format check)
make test

# Run Touch ID integration tests (requires user interaction)
make dev-test

# Clean build artifacts
make clean

# Install to system PATH
make install

# Create a release (tag + build)
make release
```

### Using Cargo Directly

```bash
# Run tests
cargo test

# Run integration tests (requires user interaction)
./test_touchid.sh

# Build for release
cargo build --release

# Format code
cargo fmt

# Run linter
cargo clippy
```

## Release Process

This project uses **fully automated releases** via GitHub Actions:

### Automated Release (Recommended)

1. **Trigger Release Workflow**:
   - Go to [Actions → Create Release](https://github.com/azu/confirm-pam/actions/workflows/release-workflow.yml)
   - Click "Run workflow"
   - Select release type: `patch`, `minor`, or `major`
   - Click "Run workflow"

2. **What happens automatically**:
   - ✅ Version bumped in `Cargo.toml`
   - ✅ Git tag created and pushed
   - ✅ GitHub release with binaries created
   - ✅ Homebrew formula update triggered

3. **Final manual step**:
   - Review and merge the auto-generated Homebrew formula PR

### Manual Release (Legacy)

<details>
<summary>For manual control over release process</summary>

1. **Manual Steps**:
   ```bash
   # Update version and changelog manually
   git tag v0.x.x
   git push origin v0.x.x
   ```

2. **Homebrew Update**:
   - Go to [Actions → Update Homebrew Formula](https://github.com/azu/confirm-pam/actions/workflows/update-homebrew.yml)
   - Enter release tag and run workflow
   - Create PR from generated branch: `gh pr create --base main --head update-homebrew-X.X.X`

</details>

### Release Types

- **patch** (0.1.0 → 0.1.1): Bug fixes, small improvements
- **minor** (0.1.0 → 0.2.0): New features, enhancements  
- **major** (0.1.0 → 1.0.0): Breaking changes, major releases

## Contributing

Contributions are welcome! Please see the [open issues](https://github.com/azu/confirm-pam/issues) for planned features and improvements.

## License

MIT License - See [LICENSE](LICENSE) file for details

## Acknowledgments

This project was inspired by the need to add human verification to automated development workflows, particularly to prevent AI tools from bypassing security measures.