use anyhow::Result;

#[cfg(target_os = "linux")]
mod linux;
#[cfg(target_os = "macos")]
mod macos;
#[cfg(target_os = "windows")]
mod windows;

#[cfg(target_os = "linux")]
pub use linux::LinuxAuthenticator as PlatformAuthenticator;
#[cfg(target_os = "macos")]
pub use macos::MacOSAuthenticator as PlatformAuthenticator;
#[cfg(target_os = "windows")]
pub use windows::WindowsAuthenticator as PlatformAuthenticator;

pub trait BiometricAuthenticator {
    fn authenticate(&self, message: &str) -> Result<bool>;
    fn is_available(&self) -> Result<bool>;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_platform_authenticator_creation() {
        let result = PlatformAuthenticator::new();
        assert!(result.is_ok());
    }

    #[test]
    #[cfg(target_os = "macos")]
    fn test_macos_authenticator_is_available() {
        let authenticator = PlatformAuthenticator::new().unwrap();
        let result = authenticator.is_available();
        assert!(result.is_ok());
    }
}
