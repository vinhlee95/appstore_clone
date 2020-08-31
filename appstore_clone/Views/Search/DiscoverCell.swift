//
//  DiscoverCell.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/30/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class DiscoverCell: UICollectionViewCell {
    var discoverTerm: String! {
        didSet {
            label.text = discoverTerm
        }
    }
        
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.2941176471, green: 0.5607843137, blue: 0.968627451, alpha: 1)
        label.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
