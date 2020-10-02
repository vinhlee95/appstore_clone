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
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(TodayFullScreenDescriptionCell.self, forCellReuseIdentifier: cellId)
        tableView.register(TodayFullscreenHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
    
    //
    // Header
    //
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as! TodayFullscreenHeader
        header.todayCell.todayItem = self.todayItem
        header.todayCell.layer.cornerRadius = 0
        header.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        header.clipsToBounds = true
        return header
    }
    
    @objc fileprivate func handleDismiss() {
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 450
    }
    
    //
    // Rows
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodayFullScreenDescriptionCell
        return cell
    }
}
