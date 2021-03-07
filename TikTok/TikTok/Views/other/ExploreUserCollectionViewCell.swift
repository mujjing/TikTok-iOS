//
//  ExploreUserCollectionViewCell.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/03/07.
//

import UIKit

class ExploreUserCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreUserCollectionViewCell"
    
    private let profilePictureImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let usernamelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(profilePictureImageView)
        contentView.addSubview(usernamelabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height - 55
        profilePictureImageView.frame = CGRect(x: (contentView.width - imageSize) / 2, y: 0, width: imageSize, height: imageSize)
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.height / 2
        usernamelabel.frame = CGRect(x: 0, y:profilePictureImageView.bottom , width: contentView.width, height: 55)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePictureImageView.image = nil
        usernamelabel.text = nil
    }
    
    public func configuration(with model: ExploreUserViewModel) {
        usernamelabel.text = model.username
        
        if let user = model.profilePictureURL {
            
        } else {
            profilePictureImageView.tintColor = .systemBlue
            profilePictureImageView.image = UIImage(systemName: "person.circle")
        }
    }

}
