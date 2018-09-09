//
//  APIRouter.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/5/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible {
    
    case movies
    case movie(id: Int)
    case imageDownload(path: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .movies, .movie, .imageDownload:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .movies:
            return "/movie/popular"
        case .movie(let id):
            return "/movie/\(id)"
        case .imageDownload(let path):
            return "\(path)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .movies, .movie, .imageDownload:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }

    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var url:URL
        switch self {
        case .imageDownload:
            url = try API.DevServer.imagesUrl.asURL()
        default:
            url = try API.DevServer.baseURL.asURL()
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        urlRequest = try URLEncoding.default.encode(urlRequest, with: ["api_key":API.APIParameterKey])
        return urlRequest
        
    }
}
