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
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        setupTableView()
        setupCloseButton()
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
