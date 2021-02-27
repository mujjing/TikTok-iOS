//
//  HomeViewController.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let forYouPagingController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    let followingPagingController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    let control: UISegmentedControl = {
        let titles = ["Following", "For You"]
        let control = UISegmentedControl(items: titles)
        control.backgroundColor = nil
        control.selectedSegmentTintColor = .white
        control.selectedSegmentIndex = 1
        return control
    }()
    
    private var forYouPosts = PostModel.mokModels()
    private var followingPosts = PostModel.mokModels()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizontalScrollView.frame = view.bounds
    }
}

extension HomeViewController {
    
    private func initView() {
        view.backgroundColor = .systemBackground
        horizontalScrollView.delegate = self
        setUpFeed()
        addSubView()
        setUpHeaderButton()
    }
    
    private func addSubView() {
        view.addSubview(horizontalScrollView)
    }
    
    private func setUpFeed() {
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        setUpFollowingFeed()
        setUpForYouFeed()
    }
    
    func setUpHeaderButton() {
        control.addTarget(self, action: #selector(didChangeSelectedControl(_:)), for: .valueChanged)
        navigationItem.titleView = control
    }
    
    @objc func didChangeSelectedControl(_ sender: UISegmentedControl) {
        let content = CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex), y: 0)
        horizontalScrollView.setContentOffset(content, animated: true)
    }
    
    func setUpFollowingFeed() {
        guard let model = followingPosts.first else { return }
        
        followingPagingController.setViewControllers(
            [PostViewController(model: model)],
            direction: .forward,
            animated: false,
            completion: nil
        )
        followingPagingController.dataSource = self
        horizontalScrollView.addSubview(followingPagingController.view)
        followingPagingController.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(followingPagingController)
        followingPagingController.didMove(toParent: self)
    }
    
    func setUpForYouFeed() {
        guard let model = forYouPosts.first else { return }
        
        forYouPagingController.setViewControllers(
            [PostViewController(model: model)],
            direction: .forward,
            animated: false,
            completion: nil
        )
        forYouPagingController.dataSource = self
        horizontalScrollView.addSubview(forYouPagingController.view)
        forYouPagingController.view.frame = CGRect(x: view.width,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(forYouPagingController)
        forYouPagingController.didMove(toParent: self)
    }
}

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {return nil}
        guard let index = currentPost.firstIndex(where: {
            $0.identifire == fromPost.identifire
        }) else {return nil}
        
        if index == 0 {
            return nil
        }
        let priorIndex = index - 1
        let model = currentPost[priorIndex]
        let vc = PostViewController(model: model)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {return nil}
        guard let index = currentPost.firstIndex(where: {
            $0.identifire == fromPost.identifire
        }) else {return nil}
        
        guard index < (currentPost.count - 1) else {
            return nil
        }
        let nextIndex = index + 1
        let model = currentPost[nextIndex]
        let vc = PostViewController(model: model)
        return vc
    }
    
    var currentPost : [PostModel] {
        if horizontalScrollView.contentOffset.x == 0 {
            //folling
            return followingPosts
        } else {
            //forYou
            return forYouPosts
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width / 2) {
            control.selectedSegmentIndex = 0
        }
        else if scrollView.contentOffset.x > (view.width / 2) {
            control.selectedSegmentIndex = 1
        }
    }
}
