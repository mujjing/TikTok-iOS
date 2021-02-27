//
//  PostComment.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/27.
//

import Foundation

struct PostComment {
    let text: String
    let user: User
    let date: Date
    
    static func mockComments() -> [PostComment] {
        let user = User(username: "jjh", profilePictureURL: nil, identifier: UUID().uuidString)
        let text = [
            "this a comment",
            "this a awesome comment",
            "this a good comment",
        ]
        var comments = [PostComment]()
        
        for comment in text {
            comments.append(
            PostComment(text: comment, user: user, date: Date())
            )
        }
        
        return comments
    }
}
