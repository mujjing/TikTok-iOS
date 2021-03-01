//
//  ExploreUserViewModel.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/03/02.
//

import UIKit

struct ExploreUserViewModel {
    let profilePictureURL: URL?
    let username: String
    let followerCount: Int
    let handler: (()->Void)
}
