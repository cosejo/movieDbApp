//
//  VideoResponse.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/4/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

struct VideoApiResponse {
    let id: Int
    let videos: [Video]
}

extension VideoApiResponse: Decodable {
    
    private enum VideoApiResponseCodingKeys: String, CodingKey {
        case id
        case videos = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VideoApiResponseCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        videos = try container.decode([Video].self, forKey: .videos)
    }
}
