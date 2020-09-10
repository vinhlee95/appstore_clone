//
//  AppReviewCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/9/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppReviewCell: UICollectionViewCell {
    var review: ReviewEntry! {
        didSet {
            reviewTitle.text = review.title.label
            reviewAuthor.text = review.author.name.label
            reviewBody.text = review.content.label
        }
    }
    
    private let reviewTitle = UILabel(text: "Review title", font: .boldSystemFont(ofSize: 18))
    private let reviewAuthor = UILabel(text: "Review author", font: UIFont.systemFont(ofSize: 18, weight: .light))
    private let reviewBody = UILabel(text: "Review body", font: UIFont.systemFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        setupViews()
    }
    
    private func setupViews() {
        reviewBody.numberOfLines = 0
        let headerStackView = UIStackView(arrangedSubviews: [reviewTitle, UIView(), reviewAuthor])
        let stackView = VerticalStackView(arrangedSubViews: [
            headerStackView,
            reviewBody
        ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
