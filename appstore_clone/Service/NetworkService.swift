//
//  NetworkService.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/29/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import Foundation

class NetworkService {
    private let iTunesSearchUrl = "https://itunes.apple.com/search"
    static let shared = NetworkService() // Singleton
    
    func fetchApps(searchText: String = "", completion: @escaping ([Result], Error?) -> ()) {
        let searchArr = searchText.split(whereSeparator: {$0 == " "})
        var searchTerm = searchText
        if searchArr.count > 1 {
            searchTerm = searchArr.joined(separator: "+")
        }
        let urlString = "\(iTunesSearchUrl)?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error in fetching iTunes apps", error)
                completion([], error)
                return
            }
            guard let data = data else {return}
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
            } catch {
                print("Error in decoding JSON search result", error)
                completion([], error)
            }

        }.resume()
    }
}
