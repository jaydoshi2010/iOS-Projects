//
//  MovieInfoViewController.swift
//  Movie Info
//
//  Created by Jay Doshi on 2023-12-02.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UITextView!
    @IBOutlet weak var mediaTypeLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    // object of MovieModel
    var selectedMovie: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("It's call")
        print(selectedMovie?.mediaType ?? "N/A")
        print(selectedMovie?.originalTitle ?? selectedMovie?.originalTitle2 ?? "N/A")
        // Do any additional setup after loading the view.
        
        if let movie = selectedMovie {
            overviewLabel.text = "Overview:\n \(movie.overview ?? "N/A")"
            mediaTypeLabel.text = "Media Type: \(movie.mediaType ?? "N/A")"
            releaseDateLabel.text = "Release Date: \(movie.releaseDate ?? "N/A")"
            
            if let popularity = movie.popularity {
                popularityLabel.text = "\(String(popularity))M watched"
            } else {
                popularityLabel.text = "N/A"
            }
            
            if let backdropPath = movie.backdropImagePath ?? movie.posterPath {
                let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
                URLSession.shared.dataTask(with: imageUrl!) { data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.backdropImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
        
    }
    
    @IBAction func addToFavoritesButtonTapped(_ sender: Any) {
        guard let selectedMovie = selectedMovie else { return }
        
        let favouriteMovie = FavouriteMovie(
            title: selectedMovie.originalTitle ?? selectedMovie.originalTitle2 ?? "N/A",
            popularity: selectedMovie.popularity ?? 0.0,
            imagePath: backdropImageView.image!
        )
        
        // Add the favouriteMovie to array of favourite movies
        FavouriteMoviesManager.addFavouriteMovie(favouriteMovie)
        
        // alert for movie added in favorites
        let alert = UIAlertController(
            title: "Movie Added",
            message: "The movie has been added to My Favourites",
            preferredStyle: .alert
        )
            
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        print("moovie added ")
        print(FavouriteMoviesManager.getFavouriteMovies())
        
    }
    
}



