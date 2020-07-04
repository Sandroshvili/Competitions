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
    var filterSet = false
    
    
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
        
//        self.setUpSearchBar()
    }
    
//    func setUpSearchBar() {
//        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
//        textFieldInsideSearchBar?.textColor = .white
//    }
//
//
//    func filterMovies(searchText: String) {
//
//        if self.filterSet {
//            self.filteredMovies.removeAll()
//            for i in self.movies {
//                if i.title.lowercased().contains(searchText.lowercased()) || i.originalTitle.lowercased().contains(searchText.lowercased()) {
//                    self.filteredMovies.append(i)
//                }
//            }
//        }
//        self.collectionView.reloadData()
//    }

}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
//        var cellCount = 0
//        if self.filterSet
//        {
//            cellCount = self.filteredMovies.count
//        }
//        else
//        {
//            cellCount = self.movies.count
//        }
//        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "search_cell", for: indexPath) as! SearchCell
        
        cell.layer.cornerRadius = 10
        let movie = filteredMovies[indexPath.row]
        
        
//        if self.filterSet {
//            cell.layer.cornerRadius = 10
//
//            let tempFilter = filteredMovies[indexPath.row]
            movie.posterPath.downloadImage { (image) in
                DispatchQueue.main.async {
                    cell.posterImageView.image = image
                }
            }
//        }
//        else {
//            cell.layer.cornerRadius = 10
//
//            let tempMovie = movies[indexPath.row]
//            tempMovie.posterPath.downloadImage { (image) in
//                DispatchQueue.main.async {
//                    cell.posterImageView.image = image
//                }
//            }
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Didselect")
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailController") as! DetailController
        detailVC.movie = filteredMovies[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
                self.filteredMovies = self.movies.filter({ $0.title.lowercased().contains(searchText.lowercased()) || $0.originalTitle.lowercased().contains(searchText.lowercased()) })
                self.collectionView.reloadData()
       
        } else {
            filteredMovies = movies
            collectionView.reloadData()
        }
        
//        if searchText.count > 2 {
//            filterSet = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.filterMovies(searchText: searchText)
//            }
//        }
//        else {
//            filterSet = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.filterMovies(searchText: searchText)
//            }
//        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}


//extension SearchViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let itemWidth = collectionView.frame.width / 4
//
//        return CGSize(width: itemWidth - 20 - 20, height: 150)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 30, left: 20, bottom: 0, right: 20)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//}
