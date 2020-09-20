//
//  TodayCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/13/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    var topConstraint: NSLayoutConstraint?
    
    var todayItem: TodayItem? {
        didSet {
            categoryLabel.text = todayItem?.category
            titleLabel.text = todayItem?.title
            descriptionLabel.text = todayItem?.description
            imageView.image = todayItem?.image
            backgroundColor = todayItem?.backgroundColor
        }
    }
    
    
    let categoryLabel =  UILabel(text: "CATEGORY LABEL", font: .boldSystemFont(ofSize: 24))
    let titleLabel = UILabel(text: "Title label", font: .boldSystemFont(ofSize: 24))
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
        imageView.constrainSize(width: 180, height: 180)
        descriptionLabel.numberOfLines = 3
        
        let stackView = VerticalStackView(arrangedSubViews: [
            categoryLabel,
            titleLabel,
            imageContainerView,
            descriptionLabel
        ])
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 16, paddingRight: 24)
        
        topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
