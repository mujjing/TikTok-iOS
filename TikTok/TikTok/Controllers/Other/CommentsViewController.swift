//
//  CommentsViewController.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/26.
//

import UIKit

protocol CommentsViewControllerDelegate: AnyObject {
    func didTapCloseForComment(with viewController: CommentsViewController)
}

class CommentsViewController: UIViewController {
    
    private let post: PostModel
    private var comment = [PostComment]()
    
    weak var delegate: CommentsViewControllerDelegate?
    
    private let closeButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        return tableView
    }()
    
    init(post: PostModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(closeButton)
        view.addSubview(tableView)
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        view.backgroundColor = .white
        fetchPostComments()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.width - 45, y: 10, width: 35, height: 35)
        tableView.frame = CGRect(x: 0, y: closeButton.bottom, width: view.width, height: view.width - closeButton.bottom)
    }

    func fetchPostComments() {
        //DataManager.shared.comment
        self.comment = PostComment.mockComments()
    }
    
    @objc func didTapClose() {
        delegate?.didTapCloseForComment(with: self)
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        let comments = comment[indexPath.row]
        cell.configre(with: comments)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
