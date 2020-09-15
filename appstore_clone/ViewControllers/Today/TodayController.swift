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
    private var animatingCellFrame: CGRect?
    private var appFullScreenController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        appFullScreenController = AppFullScreenController()
        let appFullScreenView = appFullScreenController.view!
        appFullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveAppFullscreenView)))
        view.addSubview(appFullScreenView)
        self.addChild(appFullScreenController)
        
        // Absolute coordinate of the cell
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        animatingCellFrame = startingFrame
        appFullScreenView.frame = startingFrame
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            appFullScreenView.frame = self.view.frame
            self.tabBarController?.tabBar.isHidden = true
        }, completion: nil)
    }
    
    @objc func handleRemoveAppFullscreenView(gesture: UITapGestureRecognizer) {
        guard let originalFrame = self.animatingCellFrame else {return}
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            gesture.view?.frame = originalFrame
            self.tabBarController?.tabBar.isHidden = false
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
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
