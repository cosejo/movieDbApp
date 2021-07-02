//
//  MoviesViewController.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    let movieCellIdentifier = "movieCell"
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    
    var presenter : MoviesPresenter?
    var movies: [Movie] = []
    var searchedMovies: [Movie] = []
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesSearchBar.delegate = self
        loadMovies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MoviesViewController: MoviesView{
    
    /*
     * Load Movies
     */
    func loadMovies() {
        presenter?.getMovies()
    }
    
    /*
     * Show the retrieved Movies
     */
    func showMovies(movies: [Movie]) {
        self.movies = movies
        moviesTableView.reloadData()
    }
    
    /*
     * Show loading spinner
     */
    func showLoading() {
        moviesActivityIndicatorView.startAnimating()
        overlayView.isHidden = false
        moviesActivityIndicatorView.isHidden = false
    }
    
    /*
     * Hide loading spinner
     */
    func hideLoading() {
        moviesActivityIndicatorView.stopAnimating()
        overlayView.isHidden = true
        moviesActivityIndicatorView.isHidden = true
    }
    
    /*
     * Show Alert Action with error message
     * Alow user to retry the loading or cancel
     */
    func showErrorMessage() {
        let alert = UIAlertController(title: "Ups", message: "Something happen with the movies, please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {[weak self] (action) in
            self?.loadMovies()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     * Reload movies table view with searched movies
     */
    func reloadSearchMovies(movies: [Movie]) {
        searchedMovies = movies
        moviesTableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId =  searching ? searchedMovies[indexPath.row].id : movies[indexPath.row].id
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        controller.movieId = movieId
        self.navigationController!.pushViewController(controller, animated: true)
    }
}

extension MoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchedMovies.count : movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
        let movie =  searching ? searchedMovies[indexPath.row] : movies[indexPath.row]
        cell.updateCell(title: movie.title, releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, posterPath: movie.posterPath)
        return cell
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        presenter?.getSearchMovies(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        moviesSearchBar.text = ""
        moviesTableView.reloadData()
    }
}
