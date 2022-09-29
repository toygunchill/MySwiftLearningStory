//
//  Network.swift
//  MovieAppCase
//
//  Created by Toygun Çil on 21.09.2022.
//

import Foundation
import Alamofire

let apiKey = "9c61371b"
let baseUrl = "https://www.omdbapi.com/?"

struct Endpoint {
    static let searchTitle = "s="
    static let detailId = "i="
    static let searchType = "&type=movie"
    static let apiKey = "&apikey="
}



class Network {
    static let sharedNetwork = Network()
    private init() {}
    
    func getSearchData(with movieTitle: String?, completion: @escaping (Result<MovieListResponse, AFError>) -> Void) {
        if let movieTitle = movieTitle{
            let searchUrl = "\(baseUrl)\(Endpoint.searchTitle)\(String(describing: movieTitle ))\(Endpoint.searchType)\(Endpoint.apiKey)\(apiKey)"
            AF.request(searchUrl, method: .get).responseDecodable(of: MovieListResponse.self) {
                movieResponse in completion(movieResponse.result)
            }
        }
    }
    
    func getDetailData(with movieId: String?, completion: @escaping (Result<MovieDetailResponse,AFError>) -> Void) {
        if let movieId = movieId {
            let detailUrl = "\(baseUrl)\(Endpoint.detailId)\(movieId)\(Endpoint.apiKey)\(apiKey)"
            AF.request(detailUrl, method: .get).responseDecodable(of: MovieDetailResponse.self) { detailResponse in
                completion(detailResponse.result)
            }
        }
    }
}
