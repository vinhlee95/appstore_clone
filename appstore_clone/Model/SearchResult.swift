//
//  SearchResult.swift
//  appstore_clone
//
//  Created by Vinh Le on 8/27/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int?
    let trackName: String?
    let primaryGenreName: String?
    let averageUserRating: Float?
    let artworkUrl100: String
    var screenshotUrls: [String]
    let description: String
    let formattedPrice: String?
    let releaseNotes: String?
    let version: String
}
