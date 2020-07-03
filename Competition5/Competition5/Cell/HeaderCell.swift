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
    
    @IBOutlet weak var imgView: UIImageView! {
        didSet {
            imgView.layer.cornerRadius = 30
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        apiService.fetchCharacters { (allMovies) in
            self.allmovies = allMovies
            self.movies.append(contentsOf: allMovies.results)
            
            self.movies[0].backdropPath
                .downloadImage { (image) in
                    DispatchQueue.main.async {
                        self.imgView.image = image
                    }
            }
            
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
