//
//  JSON.swift
//  Competition5
//
//  Created by Sandroshvili on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import Foundation

struct AllMovies: Codable {
    let results: [Movie]
    enum CodingKeys: String, CodingKey {
        case results
    }
}
struct Movie: Codable {
    let posterPath: String
    let id: Int
    let title: String
    let voteAverage: Double
    let overview : String
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case title
        case voteAverage = "vote_average"
        case overview
    }
}
enum OriginalLanguage: String, Codable {
    case en = "en"
    case ko = "ko"
}
