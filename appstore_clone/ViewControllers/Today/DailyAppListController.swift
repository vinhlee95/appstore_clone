//
//  DailyAppListController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/21/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class DailyAppListController: BaseListController {
    private let cellId = "cellId"
    private let api = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/10/explicit.json"
    private let spacing: CGFloat = 16
    private let shownAppAmount: CGFloat = 4
    
    var appList = [AppFeedResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(DailyAppCell.self, forCellWithReuseIdentifier: cellId)
        fetchApps()
    }
    
    fileprivate func fetchApps() {
        NetworkService.shared.fetchAppsByUrl(urlString: api) { (appFeed, error) in
            if error != nil {
                return
            }
            
            self.appList = Array(appFeed.results[0...Int(self.shownAppAmount)-1])
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DailyAppCell
        cell.appData = appList[indexPath.item]
        return cell
    }
}

extension DailyAppListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalAvailableHeight = view.frame.height - spacing*(shownAppAmount - 1)
        return .init(width: view.frame.width, height: totalAvailableHeight/shownAppAmount)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
