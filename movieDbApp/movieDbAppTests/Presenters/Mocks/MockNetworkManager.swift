//
//  MockNetworkManager.swift
//  movieDbAppTests
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation
@testable import movieDbApp

enum MockResponse {
    case success
    case emptySuccess
    case error
}

class MockNetworkManager: NetworkManager {
    
    let movies = [Movie.init(id: 1, voteAverage: 10.5, title: "Titanic", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 2, voteAverage: 80.5, title: "Titanic", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 3, voteAverage: 71.7, title: "Titanic", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 4, voteAverage: 90.3, title: "Titanic", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 5, voteAverage: 87.2, title: "Titanic", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 6, voteAverage: 22.1, title: "Titanic", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 7, voteAverage: 45.9, title: "Titanic", posterPath: "MockposterPath", releaseDate: "2020-07-01")]
    
    var mockResponse: MockResponse = .success
    
    func getMovies(category: MoviesCategory, page: Int, date: String = "", completion: @escaping (_ movie: [Movie]?,_ error: String?)->()) {
        switch mockResponse {
        case .success:
            return completion(movies, nil)
        case .emptySuccess:
            return completion([], nil)
        case .error:
            return completion(nil, "Error")
        }
    }
}
