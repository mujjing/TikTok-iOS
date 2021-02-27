//
//  CommentTableViewCell.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/27.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let identifier = "CommentTableViewCell"
    
    private let avatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let commentLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(avatarImageView)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commentLabel.sizeToFit()
        dateLabel.sizeToFit()
        let imageSize: CGFloat = 44
        
        avatarImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        
        let commentHeight = min(contentView.height - dateLabel.top, commentLabel.height)
        commentLabel.frame = CGRect(x: avatarImageView.right + 10, y: 5, width: contentView.width - avatarImageView.right - 10, height: commentHeight )
        
        dateLabel.frame = CGRect(x: avatarImageView.right + 10, y: commentLabel.bottom, width: dateLabel.width, height: dateLabel.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        commentLabel.text = nil
        dateLabel.text = nil
    }
    
    public func configre(with model: PostComment) {
        commentLabel.text = model.text
        dateLabel.text = .date(with: model.date)
        if let url = model.user.profilePictureURL {
            debugPrint(url)
        } else {
            avatarImageView.image = UIImage(systemName: "person.circle")
        }
    }
}
