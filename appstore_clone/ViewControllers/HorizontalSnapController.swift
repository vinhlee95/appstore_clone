//
//  HorizontalSnapController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/5/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class HorizontalSnapController: UICollectionViewController {
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
