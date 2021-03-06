//
//  SearchResultCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/26/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    var appData: Result! {
        didSet {
            nameLabel.text = appData.trackName
            categoryLabel.text = appData.primaryGenreName
            ratingLabel.text = "\(appData.averageUserRating ?? 0)"
            
            logoImageView.sd_setImage(with: URL(string: appData.artworkUrl100))
            
            if appData.screenshotUrls.count > 0 {
                setupViews(screenshotUrls: appData.screenshotUrls)
            }
        }
    }
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.clipsToBounds = true
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
    
    lazy var screenshotImageView1 = self.createScreenshotImageView()
    lazy var screenshotImageView2 = self.createScreenshotImageView()
    lazy var screenshotImageView3 = self.createScreenshotImageView()
    
    fileprivate func createScreenshotImageView() -> UIImageView {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews(screenshotUrls: [String] = []) {
        let labelStackView = setupLabelStackView()
        let infoStackView = UIStackView(arrangedSubviews: [
            logoImageView,
            labelStackView,
            getButton
        ])
        infoStackView.spacing = 12
        infoStackView.alignment = .top
        
        if screenshotUrls.count == 0 {
            addSubview(infoStackView)
            infoStackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
            return
        }
        
        let screenshotStackView = setupScreenshotStackView(screenshotUrls: screenshotUrls)
        let stackView = VerticalStackView(arrangedSubViews: [
            infoStackView,
            screenshotStackView
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    fileprivate func setupScreenshotStackView(screenshotUrls: [String]) -> UIStackView {
        screenshotImageView1.sd_setImage(with: URL(string: screenshotUrls[0]))
        if screenshotUrls.count > 1 {
            screenshotImageView2.sd_setImage(with: URL(string: screenshotUrls[1]))
        }
        if screenshotUrls.count > 2 {
            screenshotImageView3.sd_setImage(with: URL(string: screenshotUrls[2]))
        }
        
        let screenshotStackView = UIStackView(arrangedSubviews: [
            screenshotImageView1,
            screenshotImageView2,
            screenshotImageView3
        ])
        screenshotStackView.spacing = 8
        screenshotStackView.distribution = .fillEqually
        return screenshotStackView
    }
    
    fileprivate func setupLabelStackView() -> UIStackView {
        let stackView = VerticalStackView(arrangedSubViews: [
            nameLabel,
            categoryLabel,
            ratingLabel
        ], spacing: 4)
        stackView.distribution = .fillEqually
        return stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
