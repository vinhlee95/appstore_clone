//
//  AppSearchController.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/25/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class AppSearchController: UICollectionViewController {
    private let cellId = "cellId"
    private let iTunesSearchUrl = "https://itunes.apple.com/search"
    private var appResults = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        fetchApps()
    }
    
    fileprivate func fetchApps() {
        let urlString = "\(iTunesSearchUrl)?term=instagram&entity=software"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error in fetching iTunes apps", error)
                return
            }
            
            guard let data = data else {return}
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                self.appResults = searchResult.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error in decoding JSON search result", error)
            }
            
        }.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        let appData = appResults[indexPath.item]
        cell.nameLabel.text = appData.trackName
        cell.categoryLabel.text = appData.primaryGenreName
        cell.ratingLabel.text = "\(appData.averageUserRating ?? 0)"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
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
}
