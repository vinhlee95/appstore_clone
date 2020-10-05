//
//  TodayFullscreenHeader.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/20/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class TodayFullscreenHeader: UITableViewCell {
    let todayCell = TodayCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todayCell)
        todayCell.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

