//
//  SearchSectionHeader.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/30/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class SearchSectionHeader: UICollectionReusableView {
     var label: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
         label.sizeToFit()
         return label
     }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
