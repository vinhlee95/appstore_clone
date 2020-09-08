//
//  AppPreviewCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/8/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppPreviewCell: UICollectionViewCell {
    private let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    private let previewImage1 = UIImageView(cornerRadius: 8)
    private let previewImage2 = UIImageView(cornerRadius: 8)
    private let previewImage3 = UIImageView(cornerRadius: 8)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .yellow
    }
    
    private func setupViews() {
        let stackView = VerticalStackView(arrangedSubViews: [
            previewLabel,
            setupPreviewStackView()
        ], spacing: 8)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    private func setupPreviewStackView() -> UIStackView {
        previewImage1.backgroundColor = .green
        previewImage2.backgroundColor = .green
        previewImage3.backgroundColor = .green

        let stackView = UIStackView(arrangedSubviews: [
            previewImage1,
            previewImage2,
            previewImage3
        ])
        return stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
