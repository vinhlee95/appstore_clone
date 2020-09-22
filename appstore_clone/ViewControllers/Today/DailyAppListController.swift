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
    private let spacing: CGFloat = 16
    static let shownAppAmount: CGFloat = 4
    
    var appList = [AppFeedResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(DailyAppCell.self, forCellWithReuseIdentifier: cellId)
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
        let totalAvailableHeight = view.frame.height - spacing*(DailyAppListController.self.shownAppAmount - 1)
        return .init(width: view.frame.width, height: totalAvailableHeight/DailyAppListController.shownAppAmount)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
