//
//  URLExtension.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/9/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import Foundation

extension URL {
    static var documentsDirectory: URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return try! documentsDirectory.asURL()
    }
    
    static func urlInDocumentsDirectory(with filename: String) -> URL? {
        return documentsDirectory.appendingPathComponent(filename)
    }
}
