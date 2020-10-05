//
//  TodayFullscreenHeader.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/20/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class TodayFullscreenHeader: UITableViewCell {
    let todayCell = TodayCell()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.constrainSize(width: 28, height: 28)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todayCell)
        todayCell.fillSuperview()
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, paddingTop: 54, paddingRight: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

