//
//  AppHorizontalController.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/31/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppHorizontalController: HorizontalSnapController {
    private let cellId = "cellId"
    private let lineSpacing: CGFloat = 10
    private let topBottomPadding: CGFloat = 12
    private let leftRightPadding: CGFloat = 16
    var appResults = [AppFeedResult]()
    
    var didSelectApp: ((AppFeedResult) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.contentInset = .init(top: topBottomPadding, left: leftRightPadding, bottom: topBottomPadding, right: leftRightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        cell.appData = appResults[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedApp = appResults[indexPath.item]
        didSelectApp?(selectedApp)
    }
}

extension AppHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalCellHeight = view.frame.height - lineSpacing*2 - topBottomPadding*2
        return .init(width: view.frame.width - 48, height: totalCellHeight/3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
}
