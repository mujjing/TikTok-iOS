//
//  ExploreCell.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/03/02.
//

import Foundation
import UIKit

enum ExploreCell {
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: ExplorePostViewModel)
    case hashtag(viewModel: ExploreHashTagViewModel)
    case user(viewModel: ExploreUserViewModel)
}
