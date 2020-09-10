//
//  AppReviewRowCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/9/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppReviewRowCell: UICollectionViewCell {
    private let label = UILabel(text: "Reviews & Rating", font: .boldSystemFont(ofSize: 20))
    let reviewHorizontalController = AppReviewHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(label)
        label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 16, paddingLeft: 16)
        addSubview(reviewHorizontalController.view)
        reviewHorizontalController.view.anchor(top: label.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
