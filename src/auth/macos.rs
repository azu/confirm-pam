use super::BiometricAuthenticator;
use anyhow::Result;
use std::ffi::CString;

unsafe extern "C" {
    fn authenticate_with_biometrics(message: *const std::os::raw::c_char) -> i32;
    fn is_biometrics_available() -> bool;
}

pub struct MacOSAuthenticator;

impl MacOSAuthenticator {
    pub fn new() -> Result<Self> {
        Ok(MacOSAuthenticator)
    }
}

impl BiometricAuthenticator for MacOSAuthenticator {
    fn authenticate(&self, message: &str) -> Result<bool> {
        let c_message = CString::new(message)?;
        unsafe {
            match authenticate_with_biometrics(c_message.as_ptr()) {
                0 => Ok(true),  // Success
                1 => Ok(false), // User cancelled
                2 => Err(anyhow::anyhow!("Authentication failed")),
                3 => Err(anyhow::anyhow!("Biometric authentication not available")),
                _ => Err(anyhow::anyhow!("Unknown authentication error")),
            }
        }
    }

    fn is_available(&self) -> Result<bool> {
        unsafe { Ok(is_biometrics_available()) }
    }
}
