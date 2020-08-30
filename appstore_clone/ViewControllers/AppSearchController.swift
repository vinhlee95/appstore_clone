//
//  AppSearchController.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/25/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppSearchController: UICollectionViewController {
    private let appResultCellId = "appResultCellId"
    private let discoverCellId = "discoverCellId"
    private var appResults = [Result]()
    private var timer: Timer?
    private let defaultSectionAmount = 2
    private let discoverTerms = ["cartoon yourself", "reverse video", "music games", "birthday countdown"]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: appResultCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: discoverCellId)
        setupSearchBar()
        setupDiscoverSection()
    }
    
    fileprivate func debounceFetchApps(searchText: String) {
        // Debounce making API request to fetch apps
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            NetworkService.shared.fetchApps(searchText: searchText) { (results, error) in
                if error != nil {
                    return
                }
                // Just display first 5 items
                let renderedResults = Array(results[0...4])
                self.appResults = renderedResults
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.placeholder = "Games, Apps, Stories, and More"
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appResultCellId, for: indexPath) as! SearchResultCell
            cell.appData = appResults[indexPath.item]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discoverCellId, for: indexPath)
            cell.backgroundColor = .red
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discoverCellId, for: indexPath)
            cell.backgroundColor = .red
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return appResults.count
        }
        return discoverTerms.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension AppSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.appResults = []
            self.collectionView.reloadData()
            return
        }
        self.debounceFetchApps(searchText: searchText)
    }
}

extension AppSearchController {
    fileprivate func setupDiscoverSection() {
        
    }
}
