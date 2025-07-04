.PHONY: help build test release clean install

# Default target
help:
	@echo "Available targets:"
	@echo "  build    - Build the project"
	@echo "  test     - Run tests"
	@echo "  release  - Create a release build and tag"
	@echo "  clean    - Clean build artifacts"
	@echo "  install  - Install binary to /usr/local/bin"
	@echo "  help     - Show this help message"

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

# Create a release
release: test
	@echo "Creating release..."
	@read -p "Enter version (e.g., 0.1.0): " version; \
	echo "Releasing version $$version"; \
	git add -A; \
	git commit -m "Release v$$version" || true; \
	git tag "v$$version"; \
	cargo build --release; \
	echo "Release v$$version created. Push with: git push origin main --tags"

# Quick development commands
dev-test:
	./test_touchid.sh

check: test