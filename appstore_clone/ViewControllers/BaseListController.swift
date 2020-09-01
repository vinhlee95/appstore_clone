//
//  BaseListController.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/31/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
