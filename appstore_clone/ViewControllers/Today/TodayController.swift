//
//  TodayController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/13/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    private let cellId = "cellId"
    private var animatingCellFrame: CGRect!
    private var appFullScreenController: AppFullScreenController!
    private var topConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        appFullScreenController = AppFullScreenController()
        appFullScreenController.dismissHandler = {
            self.handleRemoveAppFullscreenView()
        }
        let appFullScreenView = appFullScreenController.view!
        view.addSubview(appFullScreenView)
        self.addChild(appFullScreenController)
        
        // Absolute coordinate of the cell
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        animatingCellFrame = startingFrame
        
        appFullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = appFullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = appFullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = appFullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = appFullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach {$0.isActive = true}
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.topConstraint.constant = 0
            self.leadingConstraint.constant = 0
            self.widthConstraint.constant = self.view.frame.width
            self.heightConstraint.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.isHidden = true
        }, completion: nil)
    }
    
    @objc func handleRemoveAppFullscreenView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.appFullScreenController.tableView.contentOffset = .zero
            
            self.topConstraint.constant = self.animatingCellFrame.origin.y
            self.leadingConstraint.constant = self.animatingCellFrame.origin.x
            self.widthConstraint.constant = self.animatingCellFrame.width
            self.heightConstraint.constant = self.animatingCellFrame.height
            
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.isHidden = false
        }, completion: { _ in
            self.appFullScreenController.tableView.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        return cell
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
