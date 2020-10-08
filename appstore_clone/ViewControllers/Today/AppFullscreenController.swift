//
//  AppFullscreenController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/14/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppFullScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dismissHandler: (() ->())?
    private let cellId = "cellId"
    private let headerId = "headerId"
    var todayItem: TodayItem?
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.constrainSize(width: 28, height: 28)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton(title: "GET", cornerRadius: 16)
        button.backgroundColor = .gray
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.constrainSize(width: 60, height: 30)
        return button
    }()
    
    let appLogoView: UIImageView = {
        let appLogoView = UIImageView()
        appLogoView.constrainSize(width: 50, height: 50)
        appLogoView.layer.cornerRadius = 12
        appLogoView.clipsToBounds = true
        return appLogoView
    }()
    
    let floatingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.constrainSize(width: 0, height: 80)
        return view
    }()
    
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        return view
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        setupTableView()
        setupCloseButton()
        setupFloatingView()
    }
    
    fileprivate func setupTableView() {
        // Setup datasource
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(TodayFullScreenDescriptionCell.self, forCellReuseIdentifier: cellId)
        tableView.register(TodayFullscreenHeader.self, forCellReuseIdentifier: headerId)
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, paddingTop: 54, paddingRight: 24)
    }
    
    // When we first launch the application, status bar frame height is 0
    // so we need to update this new value once window changes
    let statusBarHeight: CGFloat = {
        var heightToReturn: CGFloat = 0.0
             for window in UIApplication.shared.windows {
                 if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                     heightToReturn = height
                 }
             }
        return heightToReturn
    }()
    fileprivate func setupFloatingView() {
        view.addSubview(floatingView)
        floatingView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingLeft: 16, paddingBottom: statusBarHeight, paddingRight: 16)
        floatingView.addSubview(blurView)
        blurView.fillSuperview()
        
        // Setup content
        let label = UILabel(text: todayItem?.title ?? "", font: .boldSystemFont(ofSize: 18))
        let description = UILabel(text: todayItem?.description ?? "", font: .systemFont(ofSize: 16))
        appLogoView.image = todayItem?.image
            
        let stackView = UIStackView(arrangedSubviews: [
            appLogoView,
            VerticalStackView(arrangedSubViews: [
                label, description
            ]),
            downloadButton
        ])
        stackView.alignment = .center
        stackView.spacing = 12
        
        floatingView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 16, bottom: 12, right: 16))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
    
    @objc fileprivate func handleDismiss() {
        dismissHandler?()
    }
    
    //
    // Rows
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerId, for: indexPath) as! TodayFullscreenHeader
            cell.todayCell.todayItem = self.todayItem
            cell.todayCell.layer.cornerRadius = 0
            cell.clipsToBounds = true
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodayFullScreenDescriptionCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayController.cellSize
        }
        return UITableView.automaticDimension
    }
}
