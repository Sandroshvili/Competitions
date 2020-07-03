//
//  API.swift
//  Competition5
//
//  Created by Kato on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import Foundation

struct AllRecommendations: Codable {
    let page: Int
    let results: [Recommendation]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Recommendation: Codable {
    let id: Int
    let video: Bool
    let voteCount: Int
    let voteAverage: Double
    let title, releaseDate: String
    let originalLanguage: OriginalLanguage
    let originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String
    let adult: Bool
    let overview, posterPath: String
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
        case popularity
    }
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case ko = "ko"
//}

