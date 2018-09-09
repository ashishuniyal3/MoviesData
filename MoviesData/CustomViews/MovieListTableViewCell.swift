//
//  MovieListTableViewCell.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/8/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMovieData(movie : Movie){
        let imageUrl = API.DevServer.imagesUrl + movie.posterPath
        self.movieTitle.text = movie.title
        self.movieDesc.text = movie.overview
        self.moviePoster.imageFromURL(urlString: imageUrl, imageName: String(movie.id) + API.imageName)
    }

}
