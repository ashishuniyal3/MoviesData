//
//  Constants.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/5/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import Foundation

struct API {
    
    struct DevServer {
        static let baseURL = "https://api.themoviedb.org/3"
        static let imagesUrl = "https://image.tmdb.org/t/p/w185"
    }
    
    static let APIParameterKey = "b66ffea8276ce576d60df52600822c88"
    static let imageName = "image.jpg"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "application/x-www-form-urlencoded"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
