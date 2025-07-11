# confirm-pam

A CLI tool for biometric authentication confirmation.

## Overview

`confirm-pam` is a command-line tool that provides biometric authentication (fingerprint/Touch ID) confirmation prompts. It's designed to prevent automated tools (including AI agents) from bypassing security checks like `git commit --no-verify`.

```
$ confirm-pam "Allow commit with --no-verify?";
```

shows following dialog:

![`confirm-pam "Allow commit with --no-verify?";`](./docs/dialog.png)

## Features

- ✅ Touch ID authentication on macOS
- 🔐 Custom message display during authentication prompt
- 🚦 Simple exit codes: 0 for success, 1 for failure/cancel, 2 for errors
- 🪶 Lightweight binary with minimal dependencies
- 🚀 Fast native performance

## Installation

### From crates.io (Recommended)

```bash
cargo install confirm-pam
```

### From Source

```bash
# Clone and build
git clone https://github.com/azu/confirm-pam
cd confirm-pam
cargo build --release

# Copy to PATH
sudo cp target/release/confirm-pam /usr/local/bin/
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

Override `git` command to include confirmation prompts.

![git commit --no-verify example](./docs/no-verify.png)

zsh example:

```zsh
# Override git push -f and commit --no-verify
git() {
  if [[ $@ == *'push'* && $@ == *'-f'* ]]; then
    echo "Use git push --force-with-lease --force-if-includes instead"
  elif [[ $@ == *'commit'* && $@ == *'--no-verify'* ]]; then
    if confirm-pam "Allow commit with --no-verify?"; then
      command git "$@"
    else
      echo "Authenticated Failed - Disallow the commit by human. Please wait and follow the instructions."
      return 1
    fi
  else
    command git "$@"
  fi
}
```

## Platform Support

| Platform | Status       | Authentication Method | Issue                                             |
| -------- | ------------ | --------------------- | ------------------------------------------------- |
| macOS    | ✅ Supported | Touch ID              | -                                                 |
| Linux    | 🚧 Planned   | PAM + fprintd         | [#1](https://github.com/azu/confirm-pam/issues/1) |
| Windows  | 🚧 Planned   | Windows Hello         | [#2](https://github.com/azu/confirm-pam/issues/2) |

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

# Create releases with specific version bump
make release-patch   # patch version
make release-minor   # minor version
make release-major   # major version
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

This project uses **local manual releases** with make commands:

### Release Commands

```bash
# Patch release (0.1.0 → 0.1.1): Bug fixes, small improvements
make release-patch

# Minor release (0.1.0 → 0.2.0): New features, enhancements
make release-minor

# Major release (0.1.0 → 1.0.0): Breaking changes, major releases
make release-major
```

### What happens automatically

1. ✅ Version bumped in `Cargo.toml` using semver
2. ✅ Git tag created and pushed
3. ✅ Published to crates.io
4. ⚠️ GitHub release needs to be created manually

## Contributing

Contributions are welcome! Please see the [open issues](https://github.com/azu/confirm-pam/issues) for planned features and improvements.

## License

MIT License - See [LICENSE](LICENSE) file for details
