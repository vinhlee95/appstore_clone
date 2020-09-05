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
    private let socialAppApi = "https://api.letsbuildthatapp.com/appstore/social"
    
    static let shared = NetworkService() // Singleton
    
    func fetchApps(searchText: String = "", completion: @escaping ([Result], Error?) -> ()) {
        let searchArr = searchText.split(whereSeparator: {$0 == " "})
        var searchTerm = searchText
        if searchArr.count > 1 {
            searchTerm = searchArr.joined(separator: "+")
        }
        let urlString = "\(iTunesSearchUrl)?term=\(searchTerm)&entity=software"
        
        fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, error: Error?) in
            guard let searchResult = searchResult else {return}
            completion(searchResult.results, error)
        }
    }
        
    func fetchAppsByUrl(urlString: String, completion: @escaping (AppFeed, Error?) -> ()) {
        fetchGenericJSONData(urlString: urlString) { (appFeedData: AppFeedData?, error: Error?) in
            guard let appFeedData = appFeedData else {return}
            completion(appFeedData.feed, error)
        }
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> ()) {
        fetchGenericJSONData(urlString: socialAppApi, completion: completion)
    }
    
    // Generic method for fetching JSON data
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error in fetching apps", error)
                completion(nil, error)
                return
            }
            
            guard let data = data else {return}
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                completion(data, nil)
            } catch {
                print("Error in decoding JSON search result", error)
                completion(nil, error)
            }
        }.resume()
    }
}
