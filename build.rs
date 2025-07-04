#[cfg(target_os = "macos")]
fn main() {
    use std::env;
    use std::process::Command;

    let out_dir = env::var("OUT_DIR").unwrap();

    // Compile Swift code to object file
    let output = Command::new("swiftc")
        .args([
            "-emit-object",
            "-o",
            &format!("{out_dir}/macos_auth_helper.o"),
            "-framework",
            "LocalAuthentication",
            "-enable-library-evolution",
            "-emit-module",
            "-parse-as-library",
            "src/macos_auth_helper.swift",
        ])
        .output()
        .expect("Failed to compile Swift code");

    if !output.status.success() {
        panic!(
            "Swift compilation failed: {}",
            String::from_utf8_lossy(&output.stderr)
        );
    }

    // Create static library
    let output = Command::new("ar")
        .args([
            "rcs",
            &format!("{out_dir}/libmacos_auth_helper.a"),
            &format!("{out_dir}/macos_auth_helper.o"),
        ])
        .output()
        .expect("Failed to create static library");

    if !output.status.success() {
        panic!(
            "Failed to create static library: {}",
            String::from_utf8_lossy(&output.stderr)
        );
    }

    // Tell cargo to link the library
    println!("cargo:rustc-link-search=native={out_dir}");
    println!("cargo:rustc-link-lib=static=macos_auth_helper");
    println!("cargo:rustc-link-lib=framework=LocalAuthentication");
    println!("cargo:rustc-link-lib=framework=Foundation");

    // Rebuild if Swift file changes
    println!("cargo:rerun-if-changed=src/macos_auth_helper.swift");
}

#[cfg(not(target_os = "macos"))]
fn main() {
    // Nothing to do for other platforms
}
