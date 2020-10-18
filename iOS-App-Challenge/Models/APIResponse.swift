//
//  APIResponse.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import Foundation

struct APIResponse: Codable {
    var response: [TVShow]?
    var genres: [Genre]?
    
    private enum CodingKeys: String, CodingKey {
        case response = "results"
        case genres
    }
    
}
