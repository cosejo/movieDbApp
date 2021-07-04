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
    let loadingCellIdentifier = "LoadingCell"
    let movieDetailViewControllerIdentifier = "MovieDetailViewController"
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    
    var presenter : MoviesPresenter?
    var movies: [Movie] = []
    var searchedMovies: [Movie] = []
    var searching = false
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesSearchBar.delegate = self
        let tableViewLoadingCellNib = UINib(nibName: loadingCellIdentifier, bundle: nil)
        moviesTableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: loadingCellIdentifier)
        showLoading()
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
        if !isLoading {
            isLoading = true
            presenter?.getMovies()
        }
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
        isLoading = false
        moviesActivityIndicatorView.stopAnimating()
        overlayView.isHidden = true
        moviesActivityIndicatorView.isHidden = true
    }
    
    /*
     * Show Alert Action with error message
     * Alow user to retry the loading or cancel
     */
    func showErrorMessage() {
        isLoading = false
        let alert = UIAlertController(title: "Ups", message: "Something happen with the movies, please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {[weak self] (action) in
            self?.showLoading()
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
        let controller = self.storyboard!.instantiateViewController(withIdentifier: movieDetailViewControllerIdentifier) as! MovieDetailViewController
        controller.movieId = movieId
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.size.height) && !isLoading {
            loadMovies()
        }
    }
}

extension MoviesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else {
            return 44
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return searching ? searchedMovies.count : movies.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
            let movie =  searching ? searchedMovies[indexPath.row] : movies[indexPath.row]
            cell.updateCell(title: movie.title, releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, posterPath: movie.posterPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellIdentifier, for: indexPath) as! LoadingCell
            cell.startLoading()
            return cell
        }
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
