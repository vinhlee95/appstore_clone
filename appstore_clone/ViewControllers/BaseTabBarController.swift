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
        viewControllers = [
            setupNavController(viewController: TodayController(), title: "Today", image: #imageLiteral(resourceName: "today_icon")),
            setupNavController(viewController: AppsController(), title: "Apps", image: #imageLiteral(resourceName: "apps")),
            setupNavController(viewController: AppSearchController(), title: "Search", image: #imageLiteral(resourceName: "search"))
        ]
    }
    
    fileprivate func setupNavController(viewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.tabBarItem.title = title
        navViewController.tabBarItem.image = image
        
        if title != "Today" {
            navViewController.navigationBar.prefersLargeTitles = true
        } else {
            navViewController.isNavigationBarHidden = true
        }
        return navViewController
    }
}
