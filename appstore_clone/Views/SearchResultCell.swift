//
//  SearchResultCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/26/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "10M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 12
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews() {
        let labelStackView = setupLabelStackView()
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            labelStackView,
            getButton
        ])
        stackView.spacing = 12
        stackView.alignment = .top
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
    }
    
    fileprivate func setupLabelStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            categoryLabel,
            ratingLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
