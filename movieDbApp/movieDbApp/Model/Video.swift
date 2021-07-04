//
//  Video.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/4/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

/*
 * Movie Video Structure
 */
struct Video {
    let key: String
}

extension Video: Decodable {
    
    enum VideoCodingKeys: String, CodingKey {
        case key
    }
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: VideoCodingKeys.self)
        
        key = try movieContainer.decode(String.self, forKey: .key)
    }
}
