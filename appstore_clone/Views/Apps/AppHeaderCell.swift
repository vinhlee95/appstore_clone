//
//  AppHeaderCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/2/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit
import SDWebImage

class AppHeaderCell: UICollectionViewCell {
    var appData: SocialApp! {
        didSet {
            appName.text = appData.name
            appExcerpt.text = appData.tagline
            appImage.sd_setImage(with: URL(string: appData.imageUrl))
        }
    }
    
    
    private let appName = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 16))
    private let appExcerpt = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 20))
    private let appImage = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        appName.textColor = .blue
        appExcerpt.numberOfLines = 2
        
        let stackView = VerticalStackView(arrangedSubViews: [
            appName,
            appExcerpt,
            appImage
        ])
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
