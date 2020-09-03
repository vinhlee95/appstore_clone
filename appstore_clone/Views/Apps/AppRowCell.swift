//
//  AppRowCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/1/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit
import SDWebImage

class AppRowCell: UICollectionViewCell {
    var appData: GameFeedResult! {
        didSet {
            appNameLabel.text = appData.name
            appDeveloperLabel.text = appData.artistName
            appLogo.sd_setImage(with: URL(string: appData.artworkUrl100))
        }
    }
    
    private let appLogo = UIImageView(cornerRadius: 8)
    private let appNameLabel = UILabel(text: "App name", font: .boldSystemFont(ofSize: 18))
    private let appDeveloperLabel = UILabel(text: "Developer", font: .systemFont(ofSize: 14))
    private let getButton = UIButton(title: "GET")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        let labelStackView = VerticalStackView(arrangedSubViews: [appNameLabel, appDeveloperLabel], spacing: 8)
        appLogo.constrainSize(width: 64, height: 64)
        getButton.constrainSize(width: 64, height: 32)
        getButton.layer.cornerRadius = 32/2
        getButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        let stackView = UIStackView(arrangedSubviews: [
            appLogo,
            labelStackView,
            getButton
        ])
        stackView.alignment = .center
        stackView.spacing = 12
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
