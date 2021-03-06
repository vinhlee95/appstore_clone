//
//  Extensions.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/26/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, size: CGSize = .zero) -> AnchoredConstraints {
        var anchoredConstraints = AnchoredConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            anchoredConstraints.top = self.topAnchor.constraint(equalTo: top, constant: paddingTop)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = self.widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = self.heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach {$0?.isActive = true}
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerXY() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewXAnchor = superview?.centerXAnchor {
            self.centerXAnchor.constraint(equalTo: superViewXAnchor).isActive = true
        }
        
        if let superViewYAnchor = superview?.safeAreaLayoutGuide.centerYAnchor {
            self.centerYAnchor.constraint(equalTo: superViewYAnchor).isActive = true
        }
    }
    
    func constrainSize(width: CGFloat, height: CGFloat = 0) {
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

class AttributedText {
    var text: String
    var fontSize: CGFloat
    var fontWeight: UIFont.Weight
    var color: UIColor
    
    init(text: String, fontSize: CGFloat, fontWeight: UIFont.Weight, color: UIColor) {
        self.text = text
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.color = color
    }
}

extension UILabel {
    func addAttributeText(primaryText: String, secondaryText: String) {
        let attributedText = NSMutableAttributedString(string: primaryText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        attributedText.append(NSAttributedString(string: secondaryText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        self.attributedText = attributedText
    }

    //
    // This should be used over the previous method
    //
    func appendAttributedText(firstText: AttributedText, secondText: AttributedText) {
        let attributedText = NSMutableAttributedString(string: firstText.text, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: firstText.fontSize, weight: firstText.fontWeight),
            NSAttributedString.Key.foregroundColor: firstText.color
        ])
        attributedText.append(NSAttributedString(string: secondText.text, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: secondText.fontSize, weight: secondText.fontWeight),
            NSAttributedString.Key.foregroundColor: secondText.color
        ]))
        self.attributedText = attributedText
    }
    
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.bounds.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }

}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init()
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}

extension UIButton {
    convenience init(title: String, cornerRadius: CGFloat = 0) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(.blue, for: .normal)
        
        if cornerRadius != 0 {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
