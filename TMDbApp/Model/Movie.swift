//
//  Movie.swift
//  TMDbApp
//
//  Created by Colton Swapp on 8/7/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Double?
}
