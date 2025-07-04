# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.1] - 2025-01-04

### Changed
- Reorganized macOS implementation into platform-specific directory structure
- Simplified Homebrew installation instructions to single command
- Improved test reliability by fixing CLI test execution method

### Fixed
- Fixed test failures in CI environment by allowing error code 2 for Touch ID unavailable
- Fixed CLI tests to use built binary directly instead of cargo run

## [0.1.0] - 2025-01-03

### Added
- Initial implementation of Touch ID authentication for macOS
- Command-line interface with custom message support
- Exit codes: 0 (success), 1 (cancelled), 2 (error)
- Swift FFI integration with LocalAuthentication framework
- Comprehensive test suite (unit tests, integration tests, manual tests)
- GitHub Actions CI/CD pipeline
- Cross-platform architecture for future Linux and Windows support
- Example Git pre-commit hook
- Make commands for development workflow
- Homebrew formula for easy installation