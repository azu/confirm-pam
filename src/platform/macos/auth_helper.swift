import LocalAuthentication
import Foundation

// Return codes: 0 = success, 1 = user cancelled, 2 = failed, 3 = not available
@_cdecl("authenticate_with_biometrics")
public func authenticateWithBiometrics(_ messagePtr: UnsafePointer<CChar>) -> Int32 {
    let message = String(cString: messagePtr)
    let context = LAContext()
    var error: NSError?
    
    // Check if biometric authentication is available
    guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
        print("Biometrics not available: \(error?.localizedDescription ?? "Unknown error")")
        return 3 // Not available
    }
    
    var authResult: Int32 = 2 // Default to failed
    let semaphore = DispatchSemaphore(value: 0)
    
    // Perform authentication
    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, 
                          localizedReason: message) { success, authError in
        if success {
            authResult = 0 // Success
        } else if let error = authError as NSError? {
            if error.code == LAError.userCancel.rawValue {
                authResult = 1 // User cancelled
            } else {
                print("Authentication error: \(error.localizedDescription)")
                authResult = 2 // Failed
            }
        }
        semaphore.signal()
    }
    
    // Wait for authentication to complete
    semaphore.wait()
    return authResult
}

@_cdecl("is_biometrics_available")
public func isBiometricsAvailable() -> Bool {
    let context = LAContext()
    var error: NSError?
    return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
}