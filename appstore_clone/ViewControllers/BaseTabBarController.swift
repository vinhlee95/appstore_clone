//
//  BaseTabBarController.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/25/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .white
        redViewController.navigationItem.title = "Apps"
        
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = .white
        blueViewController.navigationItem.title = "Search"
        
        // Setup navigation controller for each view
        let redNavController = UINavigationController(rootViewController: redViewController)
        let blueNavController = UINavigationController(rootViewController: blueViewController)
        redNavController.navigationBar.prefersLargeTitles = true
        blueNavController.navigationBar.prefersLargeTitles = true
        // Setup tabBarItem
        redNavController.tabBarItem.title = "Apps"
        redNavController.tabBarItem.image = #imageLiteral(resourceName: "today_icon")
        blueNavController.tabBarItem.title = "Search"
        blueNavController.tabBarItem.image = #imageLiteral(resourceName: "search")
        
        viewControllers = [
            redNavController,
            blueNavController
        ]
    }
}
