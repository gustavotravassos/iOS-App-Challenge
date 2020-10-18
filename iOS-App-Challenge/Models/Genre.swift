//
//  Genre.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import Foundation

struct Genre: Codable {
    var id: Int?
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
