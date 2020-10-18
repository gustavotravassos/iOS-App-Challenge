//
//  TVShow.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import Foundation

struct TVShow: Codable {
    var title: String?
    var rating: Double?
    var overview: String?
    var posterPath: String?
    var id: Int?
    var Genre: [Genre]?
    
    var imageURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, overview
        case title = "name"
        case posterPath = "poster_path"
        case rating = "vote_average"
    }
}
