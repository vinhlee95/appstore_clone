//
//  AppsController.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/31/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

struct AppCategory {
    let name: String
    let rssUrl: String
}

class AppsController: BaseListController {
    private let cellId = "cellId"
    private let headerId = "headerId"
    private var gameFeed: AppFeed?
    private var appCategories: [AppCategory] = [
        AppCategory(name: "topGames", rssUrl: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/10/explicit.json"),
        AppCategory(name: "topFree", rssUrl: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/10/explicit.json"),
        AppCategory(name: "topGrossing", rssUrl: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/10/explicit.json"),
    ]
    private var appGroups = [AppFeed]()
    private var socialApps = [SocialApp]()
    
    private let spinnerView: UIActivityIndicatorView = {
        let sv = UIActivityIndicatorView(style: .large)
        sv.color = .gray
        sv.startAnimating()
        sv.hidesWhenStopped = true
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        setupLoadingIndicator()
        fetchApps()
    }
    
    fileprivate func setupLoadingIndicator() {
        collectionView.addSubview(spinnerView)
        spinnerView.centerXY()
        spinnerView.fillSuperview()
    }
    
    fileprivate func fetchApps() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkService.shared.fetchSocialApps { (socialApps, error) in
            dispatchGroup.leave()
            guard let socialApps = socialApps else {return}
            self.socialApps = socialApps
        }
        
        appCategories.forEach { (category) in
            dispatchGroup.enter()
            NetworkService.shared.fetchAppsByUrl(urlString: category.rssUrl) { (appFeed, error) in
                dispatchGroup.leave()
                if error != nil {
                    return
                }
                self.appGroups.append(appFeed)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.spinnerView.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppGroupCell
        let sectionData = appGroups[indexPath.item]
        cell.label.text = sectionData.title
        cell.horizontalController.appResults = sectionData.results
        cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! AppSectionHeader
        header.horizontalController.apps = socialApps
        header.horizontalController.collectionView.reloadData()
        return header
    }
}

extension AppsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
