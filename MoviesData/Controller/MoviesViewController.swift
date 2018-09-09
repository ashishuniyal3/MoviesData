//
//  MoviesViewController.swift
//  MoviesData
//
//  Created by Uniyal, Ashish (US - Mumbai) on 9/5/18.
//  Copyright © 2018 Uniyal, Ashish (US - Mumbai). All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesListView: UITableView!
    var movies : [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMoviesData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMoviesData() {
        APIClient.getPopularMovies{ result in
            switch result {
            case .success(let movies):
                self.movies = movies.results
                self.moviesListView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension MoviesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movies![indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let movieDetailViewController = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailViewController") as! MoviesDetailViewController
        movieDetailViewController.movieId = movie.id
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.movies?.count {
            return count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.movies![indexPath.row]
        
        let cellReuseIdentifier = "MoviesCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MovieListTableViewCell
        cell.setMovieData(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}



