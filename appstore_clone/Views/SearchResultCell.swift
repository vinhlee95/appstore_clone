//
//  SearchResultCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/26/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
