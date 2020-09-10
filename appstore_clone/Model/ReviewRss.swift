//
//  ReviewRss.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/9/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import Foundation

struct ReviewResponse: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [ReviewEntry]
}

struct ReviewEntry: Decodable {
    let author: ReviewAuthor
    let title: ReviewLabel
    let content: ReviewLabel
}

struct ReviewAuthor: Decodable {
    let name: ReviewLabel
}

struct ReviewLabel: Decodable {
    let label: String
}
