//
//  FavoriteMoviesViewController.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/9/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import UIKit
import CoreData

class FavoriteMoviesViewController: UIViewController {
    
    var movies : [Movie] = []
    @IBOutlet weak var moviesListView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.movies.removeAll()
        self.loadFavoriteMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFavoriteMovies() {
        let managedContext =
            CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            for item in fetchedResults {
                if let title = item.title, let overview = item.overview, let posterPath = item.posterPath, let releaseDate = item.releaseDate {
                    self.movies.append(Movie(id: Int(item.id), posterPath: posterPath, title: title, releaseDate: releaseDate, overview: overview))
                }
            }
            self.moviesListView.reloadData()
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
    }

}

extension FavoriteMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.movies[indexPath.row]
        let cellReuseIdentifier = "MoviesCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MovieListTableViewCell
        cell.setMovieData(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
