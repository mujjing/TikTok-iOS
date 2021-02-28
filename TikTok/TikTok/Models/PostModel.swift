//
//  PostModel.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/23.
//

import Foundation

struct PostModel {
    let identifire: String
    
    let user = User(username: "jordy", profilePictureURL: nil, identifier: UUID().uuidString)
    
    var isLikedByCurrentUser = false
    
    static func mokModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(identifire: UUID().uuidString)
            posts.append(post)
        }
        
        return posts
    }
}
