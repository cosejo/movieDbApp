//
//  Movie.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 6/30/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

/*
 * Movie Detail Structure
 */
struct Movie {
    let id: Int
    let voteAverage: Double
    let title: String
    var posterPath: String?
    let releaseDate: String?
}

extension Movie: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case overview
        case video
        case tagline
        case revenue
        case status
        case homepage
    }
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try movieContainer.decode(Int.self, forKey: .id)
        voteAverage = try movieContainer.decode(Double.self, forKey: .voteAverage)
        title = try movieContainer.decode(String.self, forKey: .title)
        posterPath = try? movieContainer.decode(String.self, forKey: .posterPath)
        releaseDate = try? movieContainer.decode(String.self, forKey: .releaseDate)
    }
}

/*
 * Movie Detail Structure
 */
struct MovieDetail {
    let id: Int
    let title: String
    let overview: String
    let tagline: String
    let releaseDate: String?
    let revenue: Double
    let voteAverage: Double
    let posterPath: String?
    let status: String?
    let video: Bool
    let homepage: String?
}

extension MovieDetail: Decodable {
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: Movie.MovieCodingKeys.self)
        
        id = try movieContainer.decode(Int.self, forKey: .id)
        voteAverage = try movieContainer.decode(Double.self, forKey: .voteAverage)
        title = try movieContainer.decode(String.self, forKey: .title)
        posterPath = try? movieContainer.decode(String.self, forKey: .posterPath)
        releaseDate = try? movieContainer.decode(String.self, forKey: .releaseDate)
        overview = try movieContainer.decode(String.self, forKey: .overview)
        tagline = try movieContainer.decode(String.self, forKey: .tagline)
        status = try? movieContainer.decode(String.self, forKey: .status)
        revenue = try movieContainer.decode(Double.self, forKey: .revenue)
        video = try movieContainer.decode(Bool.self, forKey: .video)
        homepage = try? movieContainer.decode(String.self, forKey: .homepage)
    }
}
