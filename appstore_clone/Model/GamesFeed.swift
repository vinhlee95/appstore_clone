//
//  GamesFeed.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/3/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import Foundation

struct GameFeedData: Decodable {
    let feed: GameFeed
}

struct GameFeed: Decodable {
    let title: String
    let results: [GameFeedResult]
}

struct GameFeedResult: Decodable {
    let name: String
    let artistName: String
    let artworkUrl100: String
}
