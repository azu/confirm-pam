use super::BiometricAuthenticator;
use anyhow::Result;

pub struct WindowsAuthenticator;

impl WindowsAuthenticator {
    pub fn new() -> Result<Self> {
        Ok(WindowsAuthenticator)
    }
}

impl BiometricAuthenticator for WindowsAuthenticator {
    fn authenticate(&self, _message: &str) -> Result<bool> {
        // TODO: Implement Windows Hello authentication
        Err(anyhow::anyhow!(
            "Windows Hello authentication not yet implemented"
        ))
    }

    fn is_available(&self) -> Result<bool> {
        // TODO: Check if Windows Hello is available
        Ok(false)
    }
}
