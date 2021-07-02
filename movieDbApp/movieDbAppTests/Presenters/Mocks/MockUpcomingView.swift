//
//  UpcomingViewFake.swift
//  movieDbAppTests
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation
@testable import movieDbApp

class MockMoviesView: MoviesView {
    
    var loadMoviesCalledTimes = 0
    var showMoviesCalledTimes = 0
    var showLoadingCalledTimes = 0
    var hideLoadingCalledTimes = 0
    var showErrorMessageCalledTimes = 0
    var receivedMovies: [Movie]?
    
    func loadMovies() {
        loadMoviesCalledTimes += 1
    }
    
    func showMovies(movies: [Movie]) {
        receivedMovies = movies
        showMoviesCalledTimes += 1
    }
    
    func showLoading() {
        showLoadingCalledTimes += 1
    }
    
    func hideLoading() {
        hideLoadingCalledTimes += 1
    }
    
    func showErrorMessage() {
        showErrorMessageCalledTimes += 1
    }
}

extension MoviesAppPresenter {
    convenience init(view: MoviesView, mockNetworkManager: NetworkManager) {
        self.init(view: view)
        networkManager = mockNetworkManager
    }
}
