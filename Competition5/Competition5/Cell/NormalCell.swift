//
//  NormalCell.swift
//  Competition5
//
//  Created by Sandroshvili on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class NormalCell: UITableViewCell {
    
    let apiService = APIServices()
    var allmovies : AllMovies?
    var movies = [Movie]()
    var delegate: MovieDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        apiService.fetchMovies { (allMovies) in
            self.allmovies = allMovies
            self.movies.append(contentsOf: allMovies.results)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension NormalCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        delegate?.getMovie(movie: movies[indexPath.row])
    }
}

extension NormalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCell", for: indexPath) as! PopularCell
        let movie = movies[indexPath.row]

        movie.posterPath
            .downloadImage { (image) in
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
        }

        return cell
    }
    



}
