//
//  MovieListResponse.swift
//  MovieAppCase
//
//  Created by Toygun Çil on 22.09.2022.
//

import Foundation

struct MovieListResponse: Codable {
    let Search: [Movie]?
    let totalResults: String?
    let Response: String?
}
