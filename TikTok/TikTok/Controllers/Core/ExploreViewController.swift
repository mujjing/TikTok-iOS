//
//  ExploreViewController.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/22.
//

import UIKit

class ExploreViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
       let bar = UISearchBar()
        bar.placeholder = "search..."
        bar.layer.cornerRadius = 8
        bar.layer.masksToBounds = true
        return bar
    }()
    private var sections = [ExploreSection]()
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSearchBar()
        configureModel()
        setUpCollectionView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    func setUpSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func configureModel() {
        var cells = [ExploreCell]()
        for ＿ in 0...100 {
            let cell = ExploreCell.banner(
                viewModel: ExploreBannerViewModel(image: nil, title: "Foo", handler: {
                    
                })
            )
            cells.append(cell)
        }
        //banners
        sections.append(
            ExploreSection(type: .banners,
                           cells: cells)
        )
        
        // Trending posts
        sections.append(
            ExploreSection(type: .trendingPosts, cells: [
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                }))
            ]
            )
        )
        // users
        sections.append(
            ExploreSection(type: .users, cells: [
                .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                
            })),
                .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                
            })),
                .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                
            })),
                .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                
            }))
            ]
            )
        )
        // trending hashtags
        sections.append(
            ExploreSection(type: .trendingHashtags, cells: [
                .hashtag(viewModel: ExploreHashTagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                    
                })),
                .hashtag(viewModel: ExploreHashTagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                    
                })),
                .hashtag(viewModel: ExploreHashTagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                    
                })),
                .hashtag(viewModel: ExploreHashTagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                    
                })),
            ]
            )
        )
        // recommended
        sections.append(
            ExploreSection(type: .recommended, cells: [
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                }))
            ])
        )
        // popular
        sections.append(
            ExploreSection(type: .popular, cells: [
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                }))
            ])
        )
        // new/recent
        sections.append(
            ExploreSection(type: .new, cells: [
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                })),
                .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                    
                }))
            ])
        )
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView (frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func layout(for section: Int) -> NSCollectionLayoutSection {
        let sectionType = sections[section].type
        
        switch sectionType {
        case .banners:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            //group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)),
                subitems: [item])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            //return
            return sectionLayout
        case .trendingPosts:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            //group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(240)),
                subitem: item,
                count: 2
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(240)), subitems: [verticalGroup])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            //return
            return sectionLayout
        case .users:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            //group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)),
                subitems: [item])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            //return
            return sectionLayout
        case .trendingHashtags:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            //group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)),
                subitems: [item])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            //return
            return sectionLayout
        case .recommended:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            //group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)),
                subitems: [item])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            //return
            return sectionLayout
        case .popular:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            //group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)),
                subitems: [item])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            //return
            return sectionLayout
        case .new:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            //group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)),
                subitems: [item])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            //return
            return sectionLayout
        }
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

extension ExploreViewController: UISearchBarDelegate {
    
}
