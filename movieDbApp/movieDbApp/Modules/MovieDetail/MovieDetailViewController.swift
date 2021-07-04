//
//  MovieDetailViewController.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var webSiteButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detailActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var overlayView: UIView!
    
    var presenter : DetailPresenter?
    var movieId: Int = 0
    var movieWebSite: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieDetailsPresenter(view: self)
        loadMovieDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openVideo(_ sender: UIButton) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "PlayVideoViewController") as! PlayVideoViewController
        controller.movieId = movieId
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    @IBAction func openWebSite(_ sender: UIButton) {
        guard let url = URL(string: movieWebSite!) else { return }
        UIApplication.shared.open(url)
    }
}


extension MovieDetailViewController : DetailView {
    
    /*
     * Load Movie details
     */
    func loadMovieDetails() {
        presenter?.getMovieDetails(id: movieId)
    }
    
    /*
     * Show the retrieved Movie
     */
    func showMovieDetails(_ movie: MovieDetail) {
        titleLabel.text =  movie.title
        overviewLabel.text = movie.overview
        taglineLabel.text = movie.tagline
        releaseDateLabel.text = movie.releaseDate
        revenueLabel.text = "$\(movie.revenue)"
        voteAverageLabel.text = "\(movie.voteAverage*10)%"
        statusLabel.text = movie.status
        webSiteButton.isEnabled = movie.homepage != nil
        movieWebSite = movie.homepage
        posterImageView.loadImage(url: movie.posterPath)
        videoButton.isEnabled = true
    }
    
    /*
     * Show loading spinner
     */
    func showLoading() {
        detailActivityIndicatorView.startAnimating()
        overlayView.isHidden = false
        detailActivityIndicatorView.isHidden = false
    }
    
    /*
     * Hide loading spinner
     */
    func hideLoading() {
        detailActivityIndicatorView.stopAnimating()
        overlayView.isHidden = true
        detailActivityIndicatorView.isHidden = true
    }
    
    /*
     * Show Alert Action with error message
     * Alow user to retry the loading or cancel
     */
    func showErrorMessage() {
        let alert = UIAlertController(title: "Ups", message: "Something happen with the movie detail, please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {[weak self] (action) in
            self?.loadMovieDetails()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
