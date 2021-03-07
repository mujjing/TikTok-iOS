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
                viewModel: ExploreBannerViewModel(image: UIImage(named: "test"), title: "Foo", handler: {
                    
                })
            )
            cells.append(cell)
        }
        //banners
        sections.append(
            ExploreSection(type: .banners,
                           cells: cells)
        )
        
        var posts = [ExploreCell]()
        for _ in 0...30 {
            posts.append(ExploreCell.post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "this is a good caption", handler: {
                
            })))
        }
        // Trending posts
        sections.append(
            ExploreSection(type: .trendingPosts, cells: posts)
        )
        // users
        sections.append(
            ExploreSection(type: .users, cells: [
                .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "iron man", followerCount: 0, handler: {
                
            })),
                .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "captain america", followerCount: 0, handler: {
                
            })),
                .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "thor", followerCount: 0, handler: {
                
            })),
                .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "hulk", followerCount: 0, handler: {
                
            }))
            ]
            )
        )
        // trending hashtags
        sections.append(
            ExploreSection(type: .trendingHashtags, cells: [
                .hashtag(viewModel: ExploreHashTagViewModel(icon: UIImage(systemName: "camera"), text: "#MacBookPro", count: 1, handler: {
                    
                })),
                .hashtag(viewModel: ExploreHashTagViewModel(icon: UIImage(systemName: "airplane"), text: "#Apple", count: 1, handler: {
                    
                })),
                .hashtag(viewModel: ExploreHashTagViewModel(icon: UIImage(systemName: "house"), text: "#iPad", count: 1, handler: {
                    
                })),
                .hashtag(viewModel: ExploreHashTagViewModel(icon: UIImage(systemName: "bell"), text: "#iPhone", count: 1, handler: {
                    
                })),
            ]
            )
        )
        // recommended
        sections.append(
            ExploreSection(type: .recommended, cells: posts)
        )
        // popular
        sections.append(
            ExploreSection(type: .popular, cells: posts)
        )
        // new/recent
        sections.append(
            ExploreSection(type: .new, cells: posts)
        )
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView (frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ExploreBannerCollectionViewCell.self, forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier)
        collectionView.register(ExplorePostCollectionViewCell.self, forCellWithReuseIdentifier: ExplorePostCollectionViewCell.identifier)
        collectionView.register(ExploreUserCollectionViewCell.self, forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier)
        collectionView.register(ExploreHashtagCollectionViewCell.self, forCellWithReuseIdentifier: ExploreHashtagCollectionViewCell.identifier)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
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
        
        switch model {
        
        case .banner(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreBannerCollectionViewCell.identifier, for: indexPath) as? ExploreBannerCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)}
            cell.configuration(with: viewModel)
            return cell
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePostCollectionViewCell.identifier, for: indexPath) as? ExplorePostCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)}
            cell.configuration(with: viewModel)
            return cell
        case .hashtag(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreHashtagCollectionViewCell.identifier, for: indexPath) as? ExploreHashtagCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)}
            cell.configuration(with: viewModel)
            return cell
        case .user(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreUserCollectionViewCell.identifier, for: indexPath) as? ExploreUserCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)}
            cell.configuration(with: viewModel)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        HapticsManager.shared.vibrateForSelection()
        
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
        
        case .banner(let viewModel):
            break
        case .post(let viewModel):
            break
        case .hashtag(let viewModel):
            break
        case .user(let viewModel):
            break
        }
    }
}

extension ExploreViewController: UISearchBarDelegate {
    
}

//MARK: layout
extension ExploreViewController {
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
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(200)),
                subitems: [item])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
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
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(60)),
                subitems : [item]
            )
  
            let sectionLayout = NSCollectionLayoutSection(group: verticalGroup)
            //return
            return sectionLayout
        case .trendingPosts, .new, .recommended:
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
                    heightDimension: .absolute(300)),
                subitem: item,
                count: 2
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(300)), subitems: [verticalGroup])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
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
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(200)), subitems: [item])
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            //return
            return sectionLayout
        }
    }
}
