use anyhow::Result;
use clap::Parser;
use std::process;

mod auth;
use auth::{BiometricAuthenticator, PlatformAuthenticator};

#[derive(Parser, Debug)]
#[command(
    name = "confirm-pam",
    about = "A CLI tool for biometric authentication confirmation",
    version
)]
struct Args {
    /// Message to display during authentication
    message: String,
}

fn main() {
    let args = Args::parse();

    match run(&args.message) {
        Ok(authenticated) => {
            if authenticated {
                process::exit(0);
            } else {
                eprintln!("Authentication failed");
                process::exit(1);
            }
        }
        Err(e) => {
            eprintln!("Error: {e}");
            process::exit(2);
        }
    }
}

fn run(message: &str) -> Result<bool> {
    let authenticator = PlatformAuthenticator::new()?;

    if !authenticator.is_available()? {
        return Err(anyhow::anyhow!(
            "Biometric authentication is not available on this device"
        ));
    }

    authenticator.authenticate(message)
}
