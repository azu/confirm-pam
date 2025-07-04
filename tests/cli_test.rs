use std::env;
use std::process::Command;

#[test]
fn test_missing_argument() {
    let exe_path = env::current_exe()
        .unwrap()
        .parent()
        .unwrap()
        .parent()
        .unwrap()
        .join("confirm-pam");

    let output = Command::new(&exe_path)
        .output()
        .expect("Failed to execute command");

    assert!(!output.status.success());
    assert_eq!(output.status.code(), Some(2));

    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(stderr.contains("error: the following required arguments were not provided"));
}

#[test]
fn test_help_message() {
    let exe_path = env::current_exe()
        .unwrap()
        .parent()
        .unwrap()
        .parent()
        .unwrap()
        .join("confirm-pam");

    let output = Command::new(&exe_path)
        .args(&["--help"])
        .output()
        .expect("Failed to execute command");

    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(stdout.contains("A CLI tool for biometric authentication confirmation"));
    assert!(stdout.contains("Message to display during authentication"));
}

#[test]
fn test_version() {
    let exe_path = env::current_exe()
        .unwrap()
        .parent()
        .unwrap()
        .parent()
        .unwrap()
        .join("confirm-pam");

    let output = Command::new(&exe_path)
        .args(&["--version"])
        .output()
        .expect("Failed to execute command");

    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(stdout.contains("confirm-pam"));
}
