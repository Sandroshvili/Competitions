//
//  HeaderCell.swift
//  Competition5
//
//  Created by Sandroshvili on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    let apiService = APIServices()
    var allmovies : AllMovies?
    var genres: Genres?
    var genresArr = [Genre]()
    var movies = [Movie]()
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieRatingImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var recommendationsLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        apiService.fetchCharacters { (allMovies) in
            self.allmovies = allMovies
            self.movies.append(contentsOf: allMovies.results)
            
            DispatchQueue.main.async {
                let movie = self.movies[2]
                self.movieLabel.text = movie.title
                movie.backdropPath
                    .downloadImage { (image) in
                        DispatchQueue.main.async {
                            self.imgView.image = image
                        }
                }
                self.movieRatingImageView.image =  UIImage(named: "\(Int( movie.voteAverage / 2.0))")
                self.movieRating.text = "\(movie.voteAverage)"
                self.descriptionLabel.text = "Action | Drama | Fantasy"

//                self.recommendationsLabel.text = "Popular"
            }
            
            
            
        }
        

        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
