//
//  AppPreviewHorizontalController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/8/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit
import SDWebImage

class AppPreviewHorizontalController: HorizontalSnapController {
    private let cellId = "cellId"
    
    var app: Result! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PreviewImageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PreviewImageCell
        guard let screenshotUrlString = app?.screenshotUrls[indexPath.item] else {return cell}
        cell.screenshot.sd_setImage(with: URL(string: screenshotUrlString))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
}

extension AppPreviewHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width * 0.6, height: view.frame.height)
    }
}
