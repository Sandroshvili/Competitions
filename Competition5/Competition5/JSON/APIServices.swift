//
//  APIServices.swift
//  Competition5
//
//  Created by Kato on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import Foundation


class APIServices {
    
    //typealias completion = (Genres) -> ()
    
    func fetchGenres(completion: @escaping (Genres) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=0fa79c85c4bd0a683eb77d3ada60eca1&language=en-US") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let genres = try decoder.decode(Genres.self, from: data)
                
                completion(genres)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchRecommendations(completion: @escaping (AllRecommendations) -> (), id: Int) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=0fa79c85c4bd0a683eb77d3ada60eca1&language=en-US&page=1") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let recommendations = try decoder.decode(AllRecommendations.self, from: data)

                completion(recommendations)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    typealias completion = (AllMovies) -> ()
    func fetchMovies(completion: @escaping (AllMovies) -> ()) {
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

struct Genres: Codable {
    let genres: [Genre]
}
struct Genre: Codable {
    let id: Int
    let name: String
}
