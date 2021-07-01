//
//  MoviesContract.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 6/30/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

protocol MoviesView {
    func loadMovies()
    func showLoading()
    func hideLoading()
}

protocol MoviesPresenter {
    func getMovies()
}
