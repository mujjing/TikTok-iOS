//
//  ExploreSectionType.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/03/02.
//

import Foundation

enum ExploreSectionType: CaseIterable {
    case banners
    case trendingPosts
    case users
    case trendingHashtags
    case recommended
    case popular
    case new
    
    var title: String {
        switch self {
        case .banners:
            return "Featured"
        case .trendingPosts:
            return "Tending Posts"
        case .trendingHashtags:
            return "Trending HashTag"
        case .recommended:
            return "Recommend"
        case .popular:
            return "Popular"
        case .new:
            return "Recently Posted"
        case .users:
            return "Creators"
        }
    }
}
