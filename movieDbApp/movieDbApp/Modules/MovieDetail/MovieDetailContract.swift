//
//  MovieDetailContract.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

protocol DetailView {
    func loadMovieDetails()
    func showMovieDetails(_ movie: MovieDetail)
    func showLoading()
    func hideLoading()
    func showErrorMessage()
}

protocol DetailPresenter {
    func getMovieDetails(id: Int)
}
