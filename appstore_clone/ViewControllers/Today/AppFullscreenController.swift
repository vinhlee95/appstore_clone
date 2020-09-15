//
//  AppFullscreenController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/14/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.register(TodayFullScreenDescriptionCell.self, forCellReuseIdentifier: cellId)
    }
    
    //
    // Header
    //
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TodayCell()
        return header
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
