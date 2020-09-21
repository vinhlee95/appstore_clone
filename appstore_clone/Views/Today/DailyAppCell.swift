//
//  DailyAppCel.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/21/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class DailyAppCell: UICollectionViewCell {
    private let appLogo = UIImageView(cornerRadius: 8)
    private let appNameLabel = UILabel(text: "App name", font: .boldSystemFont(ofSize: 18))
    private let appDeveloperLabel = UILabel(text: "Developer", font: .systemFont(ofSize: 14))
    private let getButton = UIButton(title: "GET")
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    var appData: AppFeedResult! {
        didSet {
            appNameLabel.text = appData.name
            appDeveloperLabel.text = appData.artistName
            appLogo.sd_setImage(with: URL(string: appData.artworkUrl100))
        }
    }
    
    
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
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: labelStackView.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingBottom: -8, size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
