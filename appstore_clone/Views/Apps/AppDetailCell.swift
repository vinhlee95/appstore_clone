//
//  AppDetailCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/8/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var app: Result! {
        didSet {
            appIconImage.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            appName.text = app?.trackName
            appDescription.text = app?.description
            downloadButton.titleLabel?.text = app?.formattedPrice
            appVersion.text = app?.version
            releaseNotes.text = app?.releaseNotes
        }
    }
    
    //
    // App description
    //
    let appIconImage: UIImageView = {
        let iv = UIImageView(cornerRadius: 8)
        iv.backgroundColor = .red
        iv.constrainSize(width: 120, height: 120)
        return iv
    }()
    let appName = UILabel(text: "App name", font: .boldSystemFont(ofSize: 24))
    let appDescription = UILabel(text: "App description", font: UIFont.systemFont(ofSize: 14, weight: .ultraLight))
    let downloadButton: UIButton = {
        let button = UIButton(title: "Free", cornerRadius: 16)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.constrainSize(width: 64, height: 32)
        return button
    }()
    
    //
    // Release notes
    //
    let whatsNewLabel = UILabel(text: "What's new", font: .boldSystemFont(ofSize: 20))
    let appVersion = UILabel(text: "1.0.0", font: UIFont.systemFont(ofSize: 14, weight: .ultraLight))
    let releaseNotes = UILabel(text: "Release notes", font: .systemFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .gray
    }
    
    private func setupViews() {
        appName.numberOfLines = 2
        releaseNotes.numberOfLines = 0
        
        let stackView = VerticalStackView(arrangedSubViews: [
            setupAppHeaderStackVIew(),
            whatsNewLabel,
            appVersion,
            releaseNotes
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    private func setupAppHeaderStackVIew() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            appIconImage,
            setupDescriptionStackView()
        ])
        stackView.spacing = 12
        return stackView
    }
    
    private func setupDescriptionStackView() -> UIStackView {
        let stackView = VerticalStackView(arrangedSubViews: [
            appName,
            appDescription,
            UIStackView(arrangedSubviews: [
                downloadButton,
                UIView()
            ])
        ], spacing: 8)
        stackView.distribution = .fill
        return stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
