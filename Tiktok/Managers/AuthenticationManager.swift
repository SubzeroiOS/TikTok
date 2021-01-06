//
//  AuthenticationManager.swift
//  Tiktok
//
//  Created by Bhaskar Rajbongshi on 1/4/21.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    public static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private init() {
    }

    enum SignInMethod {
        case email
        case facebook
        case google
    }
    
    // Public
    public func signIn(with method: SignInMethod) {
    }
    
    public func signOut() {
    }
}
