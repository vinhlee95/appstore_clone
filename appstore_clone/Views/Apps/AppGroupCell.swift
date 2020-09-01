//
//  AppGroupCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/31/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppGroupCell: UICollectionViewCell {
    let label = UILabel(text: "App section", font: .boldSystemFont(ofSize: 24))
    
    let horizontalController = AppHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingLeft: 16)
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .blue
        horizontalController.view.anchor(top: label.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
