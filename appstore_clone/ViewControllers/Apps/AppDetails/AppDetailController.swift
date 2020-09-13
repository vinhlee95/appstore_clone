//
//  AppDetailController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/6/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailController: BaseListController {
    private let itunesLookupApi = "https://itunes.apple.com/lookup"
    private let itunesReviewRssApi = "https://itunes.apple.com/us/rss/customerreviews"
    private let itunesReviewJsonSort = "sortby=mostrecent/json"
    private let cellId = "cellId"
    private let previewCellId = "previewCellId"
    private let reviewCellId = "reviewCellId"
    private var app: Result?
    private var responseEntries: [ReviewEntry]?
    private var appId: String
    
    // Dependency injection
    init(appId: String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppPreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(AppReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
        fetchAppData(appId: appId)
    }
    
    private func fetchAppData(appId: String) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkService.shared.fetchGenericJSONData(urlString: "\(itunesLookupApi)?id=\(appId)") { (response: SearchResult?, error) in
            dispatchGroup.leave()
            if error != nil {return}
            self.app = response?.results.first
        }
        
        dispatchGroup.enter()
        NetworkService.shared.fetchGenericJSONData(urlString: "\(itunesReviewRssApi)/id=\(appId)/\(itunesReviewJsonSort)") { (response: ReviewResponse?, error) in
            dispatchGroup.leave()
            if error != nil {return}
            guard let responseEntries = response?.feed.entry else {return}
            self.responseEntries = Array(responseEntries[0...4])
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailCell
            cell.app = app
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! AppPreviewCell
            cell.appPreviewHorizontalController.app = app
            cell.appPreviewHorizontalController.collectionView.reloadData()
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! AppReviewRowCell
            cell.reviewHorizontalController.reviews = responseEntries
            cell.reviewHorizontalController.collectionView.reloadData()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            // Calculate height for the cell
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = self.app
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        case 1:
            return .init(width: view.frame.width, height: 440)
        case 2:
            return .init(width: view.frame.width, height: 250)
        default:
            return .init(width: view.frame.width, height: 200)
        }
    }
}
