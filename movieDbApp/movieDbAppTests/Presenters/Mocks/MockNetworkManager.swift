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
                  Movie.init(id: 2, voteAverage: 80.5, title: "Fast 5", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 3, voteAverage: 71.7, title: "Inception", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 4, voteAverage: 90.3, title: "The Incredible Hulk", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 5, voteAverage: 87.2, title: "Avengers", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 6, voteAverage: 22.1, title: "Jumanji", posterPath: "MockposterPath", releaseDate: "2020-07-01"),
                  Movie.init(id: 7, voteAverage: 45.9, title: "Goal", posterPath: "MockposterPath", releaseDate: "2020-07-01")]
    
    let details = [MovieDetail.init(id: 1, title: "Titanic", overview: "", tagline: "", releaseDate: "", revenue: 0, voteAverage: 0.0, posterPath: "", status: "", video: false, homepage: ""),
        MovieDetail.init(id: 2, title: "Fast 5", overview: "", tagline: "", releaseDate: "", revenue: 0, voteAverage: 0.0, posterPath: "", status: "", video: false, homepage: ""),
        MovieDetail.init(id: 3, title: "Incpetion", overview: "", tagline: "", releaseDate: "", revenue: 0, voteAverage: 0.0, posterPath: "", status: "", video: false, homepage: ""),
        MovieDetail.init(id: 4, title: "The Incredible Hulk", overview: "", tagline: "", releaseDate: "", revenue: 0, voteAverage: 0.0, posterPath: "", status: "", video: false, homepage: ""),
        MovieDetail.init(id: 5, title: "Avengers", overview: "", tagline: "", releaseDate: "", revenue: 0, voteAverage: 0.0, posterPath: "", status: "", video: false, homepage: ""),
        MovieDetail.init(id: 6, title: "Jumanji", overview: "", tagline: "", releaseDate: "", revenue: 0, voteAverage: 0.0, posterPath: "", status: "", video: false, homepage: ""),
        MovieDetail.init(id: 7, title: "Goal", overview: "", tagline: "", releaseDate: "", revenue: 0, voteAverage: 0.0, posterPath: "", status: "", video: false, homepage: "")]
    
    let videoId = "1ASadaada121432sA"
    
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
    
    func getMovieDetail(id: Int, completion: @escaping (MovieDetail?, String?) -> ()) {
        switch mockResponse {
        case .success:
            return completion(details[id], nil)
        case .emptySuccess:
            return completion(nil, nil)
        case .error:
            return completion(nil, "Error")
        }
    }
    
    func getVideo(movieId: Int, completion: @escaping (String?, String?) -> ()) {
        switch mockResponse {
        case .success:
            return completion(videoId, nil)
        case .emptySuccess:
            return completion(nil, nil)
        case .error:
            return completion(nil, "Error")
        }
    }
}
