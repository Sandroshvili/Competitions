//
//  HeaderCell.swift
//  Competition5
//
//  Created by Sandroshvili on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    let apiService = APIService()
    var allmovies : AllMovies?
    var movies = [Movie]()
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieRatingImageView: UIImageView!
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
            }
            
            
            
        }
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
