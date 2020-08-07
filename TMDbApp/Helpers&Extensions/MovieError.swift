//
//  MovieError.swift
//  TMDbApp
//
//  Created by Colton Swapp on 8/7/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation

enum MovieError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .invalidURL:
            return "Unable to reach the server."
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
}
