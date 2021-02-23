//
//  AuthenticationManager.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/23.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    public static let shared = AuthenticationManager()
    
    private init() {}
    
    enum SignInMethod {
        case email
        case facebook
        case google
    }
    
    //public
    public func signIn(with method: SignInMethod) {
        
    }
    public func signOut() {
        
    }
}
