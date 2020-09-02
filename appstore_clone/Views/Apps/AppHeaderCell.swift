//
//  AppHeaderCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/2/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppHeaderCell: UICollectionViewCell {
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
        appImage.backgroundColor = .purple
        
        let stackView = VerticalStackView(arrangedSubViews: [
            appName,
            appExcerpt,
            appImage
        ])
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
