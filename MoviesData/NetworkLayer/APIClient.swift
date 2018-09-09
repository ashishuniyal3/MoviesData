//
//  NetworkManager.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/5/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import UIKit
import Alamofire

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        
        return Alamofire.request(route)
            .responseJSONDecodable (decoder: decoder){(response: DataResponse<T>) in
                completion(response.result)
        }
    }
    
    static func getPopularMovies(completion:@escaping (Result<MovieApiResponse>)->Void) {
        performRequest(route: APIRouter.movies, completion: completion)
    }
    
    static func getMovieData(id: Int,completion:@escaping (Result<Movie>)->Void) {
        performRequest(route: APIRouter.movie(id: id), completion: completion)
    }
    
    static func markMovieFavorite(id: Int,completion:@escaping (Result<Movie>)->Void) {
        performRequest(route: APIRouter.movie(id: id), completion: completion)
    }
}
