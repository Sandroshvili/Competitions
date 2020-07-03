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
}

struct Genres: Codable {
    let genres: [Genre]
}
struct Genre: Codable {
    let id: Int
    let name: String
}
