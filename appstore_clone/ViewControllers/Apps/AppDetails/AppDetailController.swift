//
//  AppDetailController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/6/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailController: BaseListController {
    private let itunesLookupApi = "https://itunes.apple.com/lookup"
    
    var appData: AppFeedResult! {
        didSet {
            NetworkService.shared.fetchGenericJSONData(urlString: "\(itunesLookupApi)?id=\(appData.id)") { (response: SearchResult?, error) in
                if error != nil {return}
                print(response?.results.first?.trackName)
            }
            
            appName.text = appData.name
            appIconImage.sd_setImage(with: URL(string: appData.artworkUrl100))
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = .init(top: 16, left: 16, bottom: 0, right: 16)
        setupViews()
    }
    
    private func setupViews() {
        let stackView = VerticalStackView(arrangedSubViews: [
            setupAppHeaderStackVIew(),
            whatsNewLabel,
            appVersion,
            releaseNotes
        ], spacing: 12)
        
        collectionView.addSubview(stackView)
        stackView.fillSuperview()
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
}
