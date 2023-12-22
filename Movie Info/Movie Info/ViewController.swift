//
//  ViewController.swift
//  Movie Info
//
//  Created by Jay Doshi on 2023-12-02.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var movieData: [MovieModel] = []
    let networkManager = NetworkingManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        //initiialize activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        // for default search
        networkManager.searchMovies(query: "h")
    }
        
}

// UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        activityIndicator.startAnimating()
        // Trigger the search when the user types
        if searchText.count >= 1{
            // Trigger the search when the user types
            networkManager.searchMovies(query: searchText)
        }
        if searchText.count == 0{
            // Trigger the search when the user types
            networkManager.searchMovies(query: "h")
        }
    }
}

// NetworkingDelegate
extension ViewController: NetworkingDelegate {
    
    func networkingDidFinishWithMovies(movies: [MovieModel]) {
        print("Received data: \(movies)")
        self.movieData = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    func networkingDidFinishWithError() {
        print("Error fetching data")
        self.activityIndicator.stopAnimating()
    }
}

// UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! MovieCell
        
        let movie = movieData[indexPath.row]
        cell.titleLabel.text = movie.originalTitle ?? movie.originalTitle2 ?? "N/A"

        if let posterPath = movie.posterPath {
            // Load and set the image using URLSession
            if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.movieImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        } else {
            // Handle the case where there is no posterPath
            cell.movieImageView.image = nil
        }

        return cell
    }
    
    // data passign for particular row
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieInfo" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedMovie = movieData[indexPath.row]
                if let movieInfoViewController = segue.destination as? MovieInfoViewController {
                    movieInfoViewController.selectedMovie = selectedMovie
                    //set navigation title to the selected movie's name
                    movieInfoViewController.title = selectedMovie.originalTitle ?? selectedMovie.originalTitle2
                }
            }
        }
    }
}


