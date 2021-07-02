//
//  MoviesContract.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 6/30/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

public enum MoviesCategory : Int {
    case upcoming
    case popular
    case topRated
}

protocol MoviesView {
    func loadMovies()
    func showMovies(movies: [Movie])
    func showLoading()
    func hideLoading()
    func showErrorMessage()
    func reloadSearchMovies(movies: [Movie])
}

protocol MoviesPresenter {
    func getMovies()
    func getMovies(category: MoviesCategory)
    func getSearchMovies(searchText: String)
}
