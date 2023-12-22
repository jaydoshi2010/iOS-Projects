//
//  SearchResponse.swift
//  Movie Info
//
//  Created by Jay Doshi on 2023-12-02.
//

import Foundation

struct SearchResponse: Codable {
    let results: [MovieResult]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
}

struct MovieResult: Codable {
    let id: Int
    let originalTitle: String?
    let originalTitle2: String?
    let posterPath: String?
    
    let backdropImagePath: String?
    let overview: String?
    let mediaType: String?
    let releaseDate: String?
    let popularity: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "title"
        case originalTitle2 = "name"
        case posterPath = "poster_path"
        
        case backdropImagePath = "backdrop_path"
        case overview = "overview"
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case popularity = "popularity"
    }
}

