//
//  TodayCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/13/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    let categoryLabel = UILabel(text: "CATEGORY LABEL", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Title label", font: .boldSystemFont(ofSize: 28))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let descriptionLabel = UILabel(text: "Hello world. Hello world. Hello world. Hello world", font: .systemFont(ofSize: 18))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
    
        setupViews()
    }
    
    fileprivate func setupViews() {
        // To make the image view fits with the card layout
        let imageContainerView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageContainerView.addSubview(imageView)
        imageView.centerXY()
        imageView.constrainSize(width: 200, height: 200)
        descriptionLabel.numberOfLines = 3
        
        let stackView = VerticalStackView(arrangedSubViews: [
            categoryLabel,
            titleLabel,
            imageContainerView,
            descriptionLabel
        ])
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 24, bottom: 16, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
