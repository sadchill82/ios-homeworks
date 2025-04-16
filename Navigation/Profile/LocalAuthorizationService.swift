//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Ислам on 16.04.2025.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    static let shared = LocalAuthorizationService()
    
    private init() {}
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let biometryType = context.biometryType == .faceID ? "Face ID" : "Touch ID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Authenticate to access your account") { success, authError in
                DispatchQueue.main.async {
                    if success {
                        print("Biometric authentication successful")
                        authorizationFinished(true)
                    } else {
                        if let authError = authError {
                            print("Authentication error: \(authError.localizedDescription)")
                        }
                        authorizationFinished(false)
                    }
                }
            }
        } else {
            print("Biometric authentication not available: \(error?.localizedDescription ?? "Unknown error")")
            authorizationFinished(false)
        }
    }
}
