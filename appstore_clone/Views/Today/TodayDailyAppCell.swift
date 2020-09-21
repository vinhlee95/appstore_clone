//
//  TodayDailyAppCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/21/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class TodayDailyAppCell: BaseTodayCell {
    private let categoryLabel = UILabel(text: "THE DAILY LIST", font: .boldSystemFont(ofSize: 20))
    private let titleLabel = UILabel(text: "Test-Drive These CarPlay Apps", font: .boldSystemFont(ofSize: 24))
    
    override var todayItem: TodayItem? {
        didSet {
            categoryLabel.text = todayItem?.category
            titleLabel.text = todayItem?.title
        }
    }
    
    let dailyAppListController = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
        setupViews()
    }
    
    fileprivate func setupViews() {
        titleLabel.numberOfLines = 2
        dailyAppListController.view.backgroundColor = .red
        
        let stackView = VerticalStackView(arrangedSubViews: [
            categoryLabel,
            titleLabel,
            dailyAppListController.view
        ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 24, bottom: 16, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
