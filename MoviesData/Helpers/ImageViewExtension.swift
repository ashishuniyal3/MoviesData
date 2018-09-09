//
//  ImageViewExtension.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/9/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromURL(urlString: String, imageName : String?) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                if let _ = imageName, let path = URL.urlInDocumentsDirectory(with: imageName!)?.path {
                    let image1 = UIImage(contentsOfFile: path)
                    self.image = image1
                }
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}
