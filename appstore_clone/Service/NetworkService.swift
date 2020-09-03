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
    private let gameFeedUrl = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/10/explicit.json"
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
    
    func fetchGames(completion: @escaping (GameFeed?, Error?) -> ()) {
        guard let url = URL(string: gameFeedUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error in fetching games feed", error)
                completion(nil, error)
                return
            }
            guard let data = data else {return}
            do {
                let gameFeedData = try JSONDecoder().decode(GameFeedData.self, from: data)
                completion(gameFeedData.feed, nil)
            } catch {
                print("Error in decoding JSON search result", error)
                completion(nil, error)
            }
        }.resume()
    }
}
