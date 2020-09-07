//
//  GamesFeed.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/3/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import Foundation

struct AppFeedData: Decodable {
    let feed: AppFeed
}

struct AppFeed: Decodable {
    let title: String
    let results: [AppFeedResult]
}

struct AppFeedResult: Decodable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
}
