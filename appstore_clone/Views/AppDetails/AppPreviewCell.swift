//
//  AppPreviewCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/8/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppPreviewCell: UICollectionViewCell {
    private let label = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    let appPreviewHorizontalController = AppPreviewHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        addSubview(label)
        label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingLeft: 16)
        addSubview(appPreviewHorizontalController.view)
        appPreviewHorizontalController.view.anchor(top: label.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
