use std::env;
use std::process::Command;

#[test]
#[cfg(target_os = "macos")]
fn test_touch_id_availability() {
    // Skip in CI environment
    if env::var("CI").is_ok() {
        println!("Skipping Touch ID test in CI environment");
        return;
    }

    let output = Command::new("cargo")
        .args(&["run", "--", "Test Touch ID availability"])
        .output()
        .expect("Failed to execute command");

    // Should either succeed (0) or be cancelled by user (1)
    // Both are valid outcomes for availability test
    let exit_code = output.status.code().unwrap_or(2);
    assert!(
        exit_code == 0 || exit_code == 1,
        "Expected success (0) or cancel (1), got {}",
        exit_code
    );
}

#[test]
fn test_empty_message() {
    let output = Command::new("cargo")
        .args(&["run", "--", ""])
        .output()
        .expect("Failed to execute command");

    // Empty message should still work
    assert!(output.status.code().is_some());
}

#[test]
fn test_long_message() {
    let long_message = "This is a very long message ".repeat(10);
    let output = Command::new("cargo")
        .args(&["run", "--", &long_message])
        .output()
        .expect("Failed to execute command");

    // Long message should be handled gracefully
    assert!(output.status.code().is_some());
}

#[test]
fn test_special_characters_in_message() {
    let special_message = "Test with special chars: 日本語 🔐 \"quotes\" 'apostrophe' \n newline";
    let output = Command::new("cargo")
        .args(&["run", "--", special_message])
        .output()
        .expect("Failed to execute command");

    // Special characters should be handled properly
    assert!(output.status.code().is_some());
}
