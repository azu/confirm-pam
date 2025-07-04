.PHONY: help build test clean install release-patch release-minor release-major

# Default target
help:
	@echo "Available targets:"
	@echo "  build         - Build the project"
	@echo "  test          - Run tests"
	@echo "  release-patch - Create a patch release (0.1.0 → 0.1.1)"
	@echo "  release-minor - Create a minor release (0.1.0 → 0.2.0)"
	@echo "  release-major - Create a major release (0.1.0 → 1.0.0)"
	@echo "  clean         - Clean build artifacts"
	@echo "  install       - Install binary to /usr/local/bin"
	@echo "  help          - Show this help message"

# Build the project
build:
	cargo build --release

# Run tests
test:
	cargo test
	cargo clippy -- -D warnings
	cargo fmt -- --check

# Clean build artifacts
clean:
	cargo clean

# Install binary to system PATH
install: build
	sudo cp target/release/confirm-pam /usr/local/bin/

# Create a patch release
release-patch: test
	@./scripts/release.sh patch

# Create a minor release  
release-minor: test
	@./scripts/release.sh minor

# Create a major release
release-major: test
	@./scripts/release.sh major


# Quick development commands
dev-test:
	./test_touchid.sh

check: test