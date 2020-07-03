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

    var movie : Movie?
    
    var genres: Genres?
    var genresArr = [Genre]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell

            cell.movieLabel.text = movie!.title
            movie!.backdropPath
                .downloadImage { (image) in
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
            }
            cell.movieRatingImageView.image =  UIImage(named: "\(Int( movie!.voteAverage / 2.0))")
            cell.movieRating.text = "\(movie!.voteAverage)"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMovieCell") as! SimilarMovieCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 622
        }
        return 1300
    }
    
    
    
    
}
