//
//  Networking.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import Foundation

class APIRequest {
    
    let APIKey = "ca01e6658836c07edbe8b8ce2ac738c1"
    let popularDayURL = "https://api.themoviedb.org/3/trending/tv/day?api_key="
    let popularWeekURL = "https://api.themoviedb.org/3/trending/tv/week?api_key="
    
    
    func fetchMostPopularShowsDay(completionHandler: @escaping ([TVShow], Error?) -> Void) {
        var shows: [TVShow] = []
        
        guard let url = URL(string: "\(popularDayURL)\(APIKey)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(APIResponse.self, from: data)
                shows = response.response!
                completionHandler(shows, error)
            }
            catch let error {
    
                print("Error", error)
                completionHandler([], error)
            }
        }.resume()
        
    }
    
    func fetchMostPopularShowsWeek(completionHandler: @escaping ([TVShow], Error?) -> Void) {
        var shows: [TVShow] = []
        
        guard let url = URL(string: "\(popularWeekURL)\(APIKey)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(APIResponse.self, from: data)
                shows = response.response!
                completionHandler(shows, error)
            }
            catch let error {
                
                print("Error", error)
                completionHandler([], error)
            }
        }.resume()
    }
}
