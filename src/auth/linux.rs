use super::BiometricAuthenticator;
use anyhow::Result;

pub struct LinuxAuthenticator;

impl LinuxAuthenticator {
    pub fn new() -> Result<Self> {
        Ok(LinuxAuthenticator)
    }
}

impl BiometricAuthenticator for LinuxAuthenticator {
    fn authenticate(&self, _message: &str) -> Result<bool> {
        // TODO: Implement PAM authentication
        Err(anyhow::anyhow!(
            "Linux PAM authentication not yet implemented"
        ))
    }

    fn is_available(&self) -> Result<bool> {
        // TODO: Check if fprintd is available
        Ok(false)
    }
}
