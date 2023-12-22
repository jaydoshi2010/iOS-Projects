//
//  FavouriteMovie.swift
//  Movie Info
//
//  Created by Jay Doshi on 2023-12-09.
//

import Foundation
import UIKit


class FavouriteMoviesManager {
    static var favouriteMovies: [FavouriteMovie] = []

    static func addFavouriteMovie(_ movie: FavouriteMovie) {
        favouriteMovies.append(movie)
    }

    static func getFavouriteMovies() -> [FavouriteMovie] {
        return favouriteMovies
    }
}


struct FavouriteMovie {
    var title: String
    //var overview: String
    //var releaseDate: String
    var popularity: Double
    var imagePath: UIImage
}


