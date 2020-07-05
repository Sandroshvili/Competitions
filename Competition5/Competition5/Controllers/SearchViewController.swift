//
//  SearchViewController.swift
//  Competition5
//
//  Created by Kato on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let apiService = APIServices()
    
    var allmovies : AllMovies?
    var movies = [Movie]()
    
    var filteredMovies = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        apiService.fetchMovies { (allMovies) in
            for movie in allMovies.results {
                self.movies.append(movie)
                self.filteredMovies.append(movie)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "search_cell", for: indexPath) as! SearchCell
        
        cell.layer.cornerRadius = 10
        let movie = filteredMovies[indexPath.row]
        
        movie.posterPath.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.posterImageView.image = image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailController") as! DetailController
        detailVC.movie = filteredMovies[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            self.filteredMovies = self.movies.filter({ $0.title.lowercased().contains(searchText.lowercased()) || $0.title.lowercased().contains(searchText.lowercased()) })
            self.collectionView.reloadData()
            
        } else {
            filteredMovies = movies
            collectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

