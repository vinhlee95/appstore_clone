//
//  AppSectionHeader.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/2/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppSectionHeader: UICollectionReusableView {
    private let horizontalController = HeaderHorizontalController()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
