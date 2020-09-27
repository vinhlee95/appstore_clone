//
//  BaseTodayCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/21/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    var todayItem: TodayItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
