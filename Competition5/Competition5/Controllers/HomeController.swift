//
//  HomeController.swift
//  Competition5
//
//  Created by Sandroshvili on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class HomeController: UIViewController, MovieDelegate {
    
    

    
    var movie : Movie?
    var selectedMovie : Int?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

        

        // Do any additional setup after loading the view.
    }
    
    func getMovie(movie: Movie) {
        self.movie = movie
        performSegue(withIdentifier: "DetailController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "DetailController"{
            if let detailVC = segue.destination as? DetailController {
                detailVC.movie = self.movie
            }
        }
    }
    
}

extension HomeController: UITableViewDelegate {
    
}

extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell", for: indexPath) as! NormalCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 622
        }
        return 1300
    }
    
    
    
    
}




