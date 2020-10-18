//
//  Networking.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import Foundation

class APIRequest {
    
    // MARK: - URL Parts
    private let APIKey = "?api_key=ca01e6658836c07edbe8b8ce2ac738c1"
    private let popularDayURL = "https://api.themoviedb.org/3/trending/tv/day"
    private let popularWeekURL = "https://api.themoviedb.org/3/trending/tv/week"
    private let genreURL = "https://api.themoviedb.org/3/tv/"
    private let languagePortuguese = "&language=pt-BR"
    private let languageEnglish = "&language=en-US"
    
    // MARK: - Fetch Functions
    /// Returns the daily most popular TV Shows arrays if succeded or the Error if failed
    func fetchMostPopularShowsDay(completionHandler: @escaping ([TVShow], Error?) -> Void) {
        var shows: [TVShow] = []
        
        guard let url = URL(string: "\(popularDayURL)\(APIKey)\(languagePortuguese)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(APIResponse.self, from: data)
                shows = response.response ?? []
                completionHandler(shows, error)
            }
            catch let error {
    
                print("Error", error)
                completionHandler([], error)
            }
        }.resume()
    }
    
    /// Returns the weekly most popular TV Shows arrays if succeded or the Error if failed
    func fetchMostPopularShowsWeek(completionHandler: @escaping ([TVShow], Error?) -> Void) {
        var shows: [TVShow] = []
        
        guard let url = URL(string: "\(popularWeekURL)\(APIKey)\(languagePortuguese)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(APIResponse.self, from: data)
                shows = response.response ?? []
                completionHandler(shows, error)
            }
            catch let error {
                print("Error", error)
                completionHandler([], error)
            }
        }.resume()
    }
    
    /// Returns the genre for the requested TV Shows ID if succeded or the Error if failed
    /// - Parameter id: TV Show Id that comes with the TV Show already fetched
    func fetchGenres(id: Int, completionHandler: @escaping ([Genre], Error?) -> Void) {
        var genres: [Genre] = []
        
        guard let url = URL(string: "\(genreURL)\("\(id)")\(APIKey)\(languagePortuguese)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(APIResponse.self, from: data)
                genres = response.genres ?? []
                completionHandler(genres, error)
            }
            catch let error {
                print("Error", error)
                completionHandler([], error)
            }
        }.resume()
    }
}
