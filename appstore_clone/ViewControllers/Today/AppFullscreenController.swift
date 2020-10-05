//
//  AppFullscreenController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/14/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    var dismissHandler: (() ->())?
    private let cellId = "cellId"
    private let headerId = "headerId"
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(TodayFullScreenDescriptionCell.self, forCellReuseIdentifier: cellId)
        tableView.register(TodayFullscreenHeader.self, forCellReuseIdentifier: headerId)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerId, for: indexPath) as! TodayFullscreenHeader
            cell.todayCell.todayItem = self.todayItem
            cell.todayCell.layer.cornerRadius = 0
            cell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            cell.clipsToBounds = true
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodayFullScreenDescriptionCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayController.cellSize
        }
        return UITableView.automaticDimension
    }
}
