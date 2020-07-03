//
//  JSON.swift
//  Competition5
//
//  Created by Sandroshvili on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import Foundation

struct AllMovies: Codable {
  let page, totalResults, totalPages: Int
  let results: [Movie]
  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case results
  }
}
struct Movie: Codable {
  let popularity: Double
  let voteCount: Int
  let video: Bool
  let posterPath: String
  let id: Int
  let adult: Bool
  let backdropPath: String
  let originalLanguage: OriginalLanguage
  let originalTitle: String
  let genreIDS: [Int]
  let title: String
  let voteAverage: Double
  let overview, releaseDate: String
  enum CodingKeys: String, CodingKey {
    case popularity
    case voteCount = "vote_count"
    case video
    case posterPath = "poster_path"
    case id, adult
    case backdropPath = "backdrop_path"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case genreIDS = "genre_ids"
    case title
    case voteAverage = "vote_average"
    case overview
    case releaseDate = "release_date"
  }
}
enum OriginalLanguage: String, Codable {
  case en = "en"
  case ko = "ko"
}

class APIService {
  typealias completion = (AllMovies) -> ()
  func fetchCharacters(completion: @escaping (AllMovies) -> ()) {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=0fa79c85c4bd0a683eb77d3ada60eca1&page=1") else {return}
    URLSession.shared.dataTask(with: url) { (data, res, err) in
      guard let data = data else {return}
      do {
        let decoder = JSONDecoder()
        let movies = try decoder.decode(AllMovies.self, from: data)
        completion(movies)
      } catch {
        print(error.localizedDescription)
      }
    }.resume()
  }
}
