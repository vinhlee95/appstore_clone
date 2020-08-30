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
    private let sectionHeaderId = "sectionHeaderId"
    private var appResults = [Result]()
    private var timer: Timer?
    private let defaultSectionAmount = 2
    private let discoverTerms = ["instagram", "telegram", "cartoon yourself", "reverse video", "music games", "birthday countdown"]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        // Register cell ids
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: appResultCellId)
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: discoverCellId)
        // Register section headers
        collectionView.register(SearchSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discoverCellId, for: indexPath) as! DiscoverCell
            cell.discoverTerm = discoverTerms[indexPath.item]
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId, for: indexPath) as! SearchSectionHeader
        sectionHeader.label.text = "Discover"
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        }
        return .init(width: collectionView.frame.width, height: 50)
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
        if indexPath.section == 0 {
            return .init(width: view.frame.width, height: 350)
        }
        
        return .init(width: view.frame.width, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        
        return 8
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
