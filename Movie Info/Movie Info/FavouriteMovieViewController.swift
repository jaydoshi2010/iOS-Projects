//
//  FavouriteMovieViewController.swift
//  Movie Info
//
//  Created by Jay Doshi on 2023-12-08.
//

import UIKit

class FavouriteMovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}




// TableVIew:
extension FavouriteMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return FavouriteMoviesManager.getFavouriteMovies().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomFavCell", for: indexPath) as! FavouriteMovieCell
            
            let favMovie = FavouriteMoviesManager.getFavouriteMovies()[indexPath.row]
            
            // Assuming you have a method to load images asynchronously
            //loadImage(url: movie.imagePath)
        cell.FavouriteMovieImageView.image = favMovie.imagePath
            cell.FavouriteMovieTitle.text = favMovie.title
            cell.FavouriteMoviePopularity.text = "\(String(favMovie.popularity))M watched"
            
            return cell
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
