//
//  MovieDetailResponse.swift
//  MovieAppCase
//
//  Created by Toygun Çil on 28.09.2022.
//

import Foundation

struct MovieDetailResponse: Codable {
    let Title: String?
    let Year: String?
    let Rated: String?
    let Released: String?
    let Runtime: String?
    let Genre: String?
    let Director: String?
    let Writer: String?
    let Actors: String?
    let Plot: String?
    let Language: String?
    let Country: String?
    let Awards: String?
    let Poster: String?
    let imdbRating: String?
    let imdbVoting: String?
}
