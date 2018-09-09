//
//  MoviesResponse.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/7/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import Foundation

struct MovieApiResponse: Decodable{
    let page: Int
    let results: [Movie]
}

