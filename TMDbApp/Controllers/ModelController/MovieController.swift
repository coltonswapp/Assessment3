//
//  MovieController.swift
//  TMDbApp
//
//  Created by Colton Swapp on 8/7/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import UIKit

class MovieController {
    
    // MARK: - Properties
    static private let baseURL = URL(string: "https://api.themoviedb.org/3")
    static private let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
    static private let movieSearchComponent = "search/movie"
    static private let apiKeyKey = "api_key"
    static private let apiKey = "e8369f0c787da6ec0da2dd3a8efd0c3c"
    static private let queryKey = "query"
    
    static func fetchMovie(for searchTerm: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let searchURL = baseURL.appendingPathComponent(movieSearchComponent)
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        let apiQuery = URLQueryItem(name: apiKeyKey, value: apiKey)
        let searchQuery = URLQueryItem(name: queryKey, value: searchTerm)
        components?.queryItems = [apiQuery, searchQuery]
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                var moviesArray = topLevelObject.results
                for movie in moviesArray {
                    moviesArray.append(movie)
                }
                return completion(.success(moviesArray))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
    }
    
    static func fetchMoviePoster(for movie: Movie, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        
        
        guard let imageBaseURL = imageBaseURL else { return completion(.failure(.invalidURL))}
        guard let posterImagePath = movie.poster_path else { return completion(.failure(.invalidURL))}
        
        let finalURL = imageBaseURL.appendingPathComponent(posterImagePath)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            return completion(.success(image))
            
        }.resume()
    }
    
} // End of MovieController Class

