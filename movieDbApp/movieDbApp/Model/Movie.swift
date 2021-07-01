//
//  Movie.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 6/30/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let voteAverage: Double
    let title: String
    let posterPath: String
    let backdrop: String?
    let releaseDate: String?
    let overview: String
    let video: Bool
}

extension Movie: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case overview
        case video
    }
    
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try movieContainer.decode(Int.self, forKey: .id)
        voteAverage = try movieContainer.decode(Double.self, forKey: .voteAverage)
        title = try movieContainer.decode(String.self, forKey: .title)
        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
        backdrop = try? movieContainer.decode(String.self, forKey: .backdrop)
        releaseDate = try? movieContainer.decode(String.self, forKey: .releaseDate)
        overview = try movieContainer.decode(String.self, forKey: .overview)
        video = try movieContainer.decode(Bool.self, forKey: .video)
    }
}
