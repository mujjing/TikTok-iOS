//
//  StorageManager.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/23.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    public static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    private init() {}
    
    //public
    
    public func getVideoURL(with identifire: String ,completion: (URL) -> Void) {
        
    }
    
    public func uploadVideoURL(from url: URL) {
        
    }

}
