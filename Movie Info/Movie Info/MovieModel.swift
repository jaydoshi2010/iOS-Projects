//
//  MovieModel.swift
//  Movie Info
//
//  Created by Jay Doshi on 2023-12-02.
//

import Foundation


struct MovieModel: Codable {
    
    // This is for main VIew Controller
    let id: Int
    let originalTitle: String?
    let originalTitle2: String?
    let posterPath: String?
    
    
    // this if forr MovieInfoViewCOntroller
    let backdropImagePath: String?
    let overview: String?
    let mediaType: String?
    let releaseDate: String?
    let popularity: Double?
}




