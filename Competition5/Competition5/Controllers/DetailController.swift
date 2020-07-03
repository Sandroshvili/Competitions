//
//  ViewController.swift
//  Competition5
//
//  Created by Sandroshvili on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    let apiservice = APIServices()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    var movie : Movie?
    
    var genres: Genres?
    var genresArr = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movie!.backdropPath
            .downloadImage { (image) in
                DispatchQueue.main.async {
                    self.imgView.image = image
                }
        }
        self.movieLabel.text = movie?.title
//        self.textView.text = movie?.overview
        ratingLabel.text = "\(movie!.voteAverage)"
        ratingImageView.image = UIImage(named: "\(Int( movie!.voteAverage / 2.0))")
        // Do any additional setup after loading the view.
        
        apiservice.fetchGenres { (genres) in
            
            for genre in genres.genres {
                self.genresArr.append(genre)
                
            }
            
            //print(self.genresArr)
            
            DispatchQueue.main.async {
               // self.collectionView.reloadData()
            }
        }
        

    }


}

