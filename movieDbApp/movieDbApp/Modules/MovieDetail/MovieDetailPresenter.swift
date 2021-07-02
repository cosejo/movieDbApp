//
//  MovieDetailPresenter.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

class MovieDetailsPresenter: DetailPresenter {
    
    var view : DetailView
    var networkManager: NetworkManager?
    
    init(view: DetailView) {
        self.view = view
        networkManager = MoviesNetworkManager()
    }
    
    /*
     * Retrieve movie details from source
     */
    func getMovieDetails(id: Int) {
        view.showLoading()
        guard id > 0 else {
            view.hideLoading()
            view.showErrorMessage()
            return
        }
        
        networkManager?.getMovieDetail(id: id, completion: { [weak self] (movieDetails, error) in
            if error == nil && movieDetails != nil {
                DispatchQueue.main.async() {
                    self?.view.showMovieDetails(movieDetails!)
                    self?.view.hideLoading()
                }
            }
            else{
                self?.view.showErrorMessage()
            }
        })
    }
}
