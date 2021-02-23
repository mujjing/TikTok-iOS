//
//  DatabaseManager.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/23.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    public static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    private init() {}
    
    //public
    
    public func getAllUsers(completion: ([String]) -> Void) {
        
    }
}
