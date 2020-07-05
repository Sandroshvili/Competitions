//
//  ViewController.swift
//  Competition5
//
//  Created by Vakho on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    let apiService = APIServices()
    
    
    var movie : Movie?
    
    var recommendations: AllRecommendations?
    var recommendationsArr = [Recommendation]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        apiService.fetchRecommendations(completion: { (recs) in
            for recommendation in recs.results {
                self.recommendationsArr.append(recommendation)
                
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, id: movie!.id)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    @IBAction func onBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailController: UITableViewDelegate {
    
}

extension DetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recommendationsArr.isEmpty {
            return 1
        } else {
            return recommendationsArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            
            cell.movieLabel.text = movie!.title
            movie!.posterPath
                .downloadImage { (image) in
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
            }
            cell.movieRatingImageView.image =  UIImage(named: "\(Int( movie!.voteAverage / 2.0))")
            cell.movieRating.text = "\(movie!.voteAverage)"
            cell.recommendationsLabel.text = "Movie Recommendations"
            cell.descriptionLabel.text = movie!.overview
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMovieCell") as! SimilarMovieCell
        let recommendedMovie = recommendationsArr[indexPath.row]
        recommendedMovie.backdropPath
            .downloadImage { (image) in
                DispatchQueue.main.async {
                    cell.imgView.image = image
                }
        }
        cell.movieTitle.text = recommendedMovie.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 645
        }
        return 125
    }
    
    
    
    
}
