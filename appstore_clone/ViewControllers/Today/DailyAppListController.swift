//
//  DailyAppListController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/21/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class DailyAppListController: BaseListController {
    private let cellId = "cellId"
    private let spacing: CGFloat = 16
    static let shownAppAmount: CGFloat = 4
    private let mode: Mode
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.constrainSize(width: 28, height: 28)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    var appList = [AppFeedResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(DailyAppCell.self, forCellWithReuseIdentifier: cellId)
        if mode == .fullScreen {
            setupCloseButton()
        }
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, paddingTop: 32, paddingRight: 16)
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = appList[indexPath.item].id
        let appDetailsController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailsController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .small {
            return Int(DailyAppListController.self.shownAppAmount)
        }
        
        return appList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DailyAppCell
        cell.appData = appList[indexPath.item]
        return cell
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Mode: String {
        case small, fullScreen
    }
}

extension DailyAppListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let shownAmount = mode == .fullScreen ? CGFloat(appList.count) : DailyAppListController.self.shownAppAmount
        let totalAvailableHeight = view.frame.height - spacing*(shownAmount)
        let width = mode == .fullScreen ? view.frame.width - 48 : view.frame.width
        
        return .init(width: width, height: totalAvailableHeight/shownAmount)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
