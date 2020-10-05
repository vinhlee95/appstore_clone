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
    
    // Scale animation when the cell is tapped and highlighted
    override var isHighlighted: Bool {
        didSet {
            let transform: CGAffineTransform = isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.transform = transform
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        clipsToBounds = true
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
