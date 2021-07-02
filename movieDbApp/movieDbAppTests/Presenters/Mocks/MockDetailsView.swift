//
//  MockDetailsView.swift
//  movieDbAppTests
//
//  Created by Carlos Osejo on 7/2/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation
@testable import movieDbApp

class MockDetailsView: DetailView {
    
    var loadMovieDetailsCalledTimes = 0
    var showMovieDetailsCalledTimes = 0
    var showLoadingCalledTimes = 0
    var hideLoadingCalledTimes = 0
    var showErrorMessageCalledTimes = 0
    var receivedMovie: MovieDetail?
    
    func loadMovieDetails() {
        loadMovieDetailsCalledTimes += 1
    }
    
    func showMovieDetails(_ movie: MovieDetail) {
        receivedMovie = movie
        showMovieDetailsCalledTimes += 1
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

extension MovieDetailsPresenter {
    convenience init(view: DetailView, mockNetworkManager: NetworkManager) {
        self.init(view: view)
        networkManager = mockNetworkManager
    }
}
