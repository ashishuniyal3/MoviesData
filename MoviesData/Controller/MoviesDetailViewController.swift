//
//  MoviesDetailViewController.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/9/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import UIKit
import CoreData

class MoviesDetailViewController: UIViewController {
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    var movieId = 0
    var selectedMovie : Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Details"
        self.getMovieDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovieDetails() {
        APIClient.getMovieData(id: movieId){result in
            switch result {
            case .success(let movie):
                self.selectedMovie = movie
                self.loadMovieDetails(movie: movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMovieDetails(movie : Movie) {
        self.movieTitle.text = movie.title
        self.releaseDate.text = "Release Date : " + movie.releaseDate
        self.moviePoster.imageFromURL(urlString: API.DevServer.imagesUrl + movie.posterPath, imageName: nil)
        self.movieOverview.text = movie.overview 
    }
    
    @IBAction func saveAsFavorite() {
        var isFavorite = false
        let managedContext =
            CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            for item in fetchedResults {
                if (selectedMovie?.id == Int(item.id)) {
                    isFavorite = true
                    break;
                }
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        if (!isFavorite) {
            let entity =
                NSEntityDescription.entity(forEntityName: "FavoriteMovies",
                                           in: managedContext)!
            
            
            let movie = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
            movie.setValue(selectedMovie?.id, forKeyPath: "id")
            movie.setValue(selectedMovie?.posterPath, forKeyPath: "posterPath")
            movie.setValue(selectedMovie?.overview, forKeyPath: "overview")
            movie.setValue(selectedMovie?.title, forKeyPath: "title")
            movie.setValue(selectedMovie?.releaseDate, forKeyPath: "releaseDate")
            if let image = self.moviePoster.image, let id = self.selectedMovie?.id {
                FileManagerHelper.saveImageToDocuments(fileName: String(id), image: image)
            }
            
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
}
