# Issues to Create

## 1. Linux PAM Integration Support

**Title:** Add Linux PAM integration for biometric authentication

**Description:**
Currently, confirm-pam only supports macOS Touch ID. This issue tracks the implementation of Linux support using PAM (Pluggable Authentication Modules) and fprintd for fingerprint authentication.

### Requirements:
- Integrate with PAM for authentication
- Support fprintd for fingerprint readers
- Handle cases where biometric hardware is not available
- Maintain the same CLI interface as macOS version

### Implementation Notes:
- Use the `pam` crate (already added to Cargo.toml)
- Create a PAM service configuration for confirm-pam
- Handle PAM conversation functions for custom messages
- Test with common Linux distributions (Ubuntu, Fedora, etc.)

### Tasks:
- [ ] Implement `LinuxAuthenticator` in `src/auth/linux.rs`
- [ ] Create PAM service configuration file
- [ ] Add installation instructions for Linux
- [ ] Test on multiple Linux distributions
- [ ] Update documentation

**Labels:** enhancement, linux, help wanted

---

## 2. Windows Hello Integration Support

**Title:** Add Windows Hello integration for biometric authentication

**Description:**
This issue tracks the implementation of Windows Hello support for biometric authentication on Windows platforms.

### Requirements:
- Integrate with Windows Hello API
- Support fingerprint and facial recognition where available
- Handle cases where Windows Hello is not configured
- Maintain the same CLI interface as macOS version

### Implementation Notes:
- Use Windows Runtime (WinRT) APIs
- Implement using the `windows` crate (already added to Cargo.toml)
- Handle custom prompt messages in Windows Hello dialogs
- Consider TPM integration for enhanced security

### Tasks:
- [ ] Implement `WindowsAuthenticator` in `src/auth/windows.rs`
- [ ] Integrate with Windows Hello APIs
- [ ] Handle various Windows Hello authentication methods
- [ ] Test on Windows 10 and Windows 11
- [ ] Update documentation

**Labels:** enhancement, windows, help wanted

---

## 3. Cross-platform Testing Infrastructure

**Title:** Set up cross-platform CI/CD for Linux and Windows

**Description:**
Once Linux and Windows support are implemented, we need to extend our CI/CD pipeline to test on all supported platforms.

### Requirements:
- GitHub Actions workflows for Linux and Windows
- Platform-specific test suites
- Cross-compilation support
- Automated release builds for all platforms

**Labels:** testing, ci/cd, infrastructure