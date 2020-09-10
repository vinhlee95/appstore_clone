//
//  AppReviewHorizontalController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/9/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppReviewHorizontalController: HorizontalSnapController {
    private let cellId = "cellId"
    
    var reviews: [ReviewEntry]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppReviewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppReviewCell
        guard let review = reviews?[indexPath.item] else {return cell}
        cell.review = review
        return cell
    }
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }
}

extension AppReviewHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 42, height: view.frame.height)
    }
}
