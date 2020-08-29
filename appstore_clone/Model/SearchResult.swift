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
    let trackName: String?
    let primaryGenreName: String?
    let averageUserRating: Float?
}
