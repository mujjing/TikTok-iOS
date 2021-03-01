//
//  PostViewController.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/23.
//

import UIKit
import AVFoundation

protocol PostViewControllerDelegate:AnyObject {
    func postViewController(_ vc: PostViewController, didTapCommentButtonFor post: PostModel)
    func postViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel)
}

class PostViewController: UIViewController {
    
    weak var delegate: PostViewControllerDelegate?
    var model: PostModel
    
    private let likeButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    private let commentButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    private let sharedButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    private let profileButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        return button
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Check out this video! Check out this video! Check out this video! Check out this video! Check out this video!"
        label.font = .systemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    var player: AVPlayer?
    private var playerDidFinishObserver:NSObjectProtocol?
    
    let color: [UIColor] = [.red, .orange, .green, .blue, .purple]
    
    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color.randomElement()
        configureVideo()
        setUpButtons()
        setUpDoubleTapToLike()
        view.addSubview(captionLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size: CGFloat = 40
        let tabBarHeight = (tabBarController?.tabBar.height ?? 0 )
        let yStart: CGFloat = view.height - (size * 4) - 30 - view.safeAreaInsets.bottom - tabBarHeight
        for (index, button) in [likeButton, commentButton, sharedButton].enumerated() {
            button.frame = CGRect(x: view.width-size-10, y: yStart + (CGFloat(index) * 10) + (CGFloat(index) * size), width: size, height: size)
        }
        captionLabel.sizeToFit()
        let labelSize = captionLabel.sizeThatFits(CGSize(width: view.width - size - 12, height: view.height))
        captionLabel.frame = CGRect(x: 5, y: view.height - 10 - view.safeAreaInsets.bottom - labelSize.height - (tabBarController?.tabBar.height ?? 0), width: view.width - size - 12, height: labelSize.height)
        
        profileButton.frame = CGRect(x: likeButton.left, y: likeButton.top - 10 - size, width: size, height: size)
        
        profileButton.layer.cornerRadius = size / 2
    }
    
    func configureVideo() {
        guard let path = Bundle.main.path(forResource: "video", ofType: "MP4") else {return}
        
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        player?.volume = 0.0
        player?.play()
        
        guard let player = player else { return }
        
        playerDidFinishObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { _ in
            player.seek(to: .zero)
            player.play()
        }
    }

    func setUpButtons() {
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(sharedButton)
        view.addSubview(profileButton)
        
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        sharedButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
    }
    
    @objc func didTapLike() {
        model.isLikedByCurrentUser = !model.isLikedByCurrentUser
        likeButton.tintColor = model.isLikedByCurrentUser ? .systemRed : .white
    }
    @objc func didTapComment() {
        // Present comment tray
        delegate?.postViewController(self, didTapCommentButtonFor: model)
    }
    @objc func didTapShare() {
        guard let url = URL(string: "https://www.tiktok.com") else {return}
        let vc = UIActivityViewController(
            activityItems: [url], applicationActivities: []
            )
        present(vc, animated: true, completion: nil)
    }
    @objc func didTapProfile() {
        delegate?.postViewController(self, didTapProfileButtonFor: model)
    }
    func setUpDoubleTapToLike() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    @objc func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        if !model.isLikedByCurrentUser {
            model.isLikedByCurrentUser = true
        }
        let touchPoint = gesture.location(in: view)
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = .systemRed
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.center = touchPoint
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 0.2) {
            imageView.alpha = 1
        } completion: { (done) in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    UIView.animate(withDuration: 0.2) {
                        imageView.alpha = 0
                    } completion: { (done) in
                        if done {
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
        }

    }
}

