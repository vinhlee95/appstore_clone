//
//  TodayItem.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/19/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let description: String
    let title: String
    let image: UIImage?
    let backgroundColor: UIColor
    let cellType: CellType
    let apps: [AppFeedResult]
    
    enum CellType: String {
        case single, multiple
    }
}
