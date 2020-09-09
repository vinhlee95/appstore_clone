//
//  PreviewImageCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/8/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit
import SDWebImage

class PreviewImageCell: UICollectionViewCell {
    let screenshot = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(screenshot)
        screenshot.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
