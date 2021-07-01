//
//  MovieEndPoint.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public enum MovieApi {
    case popular(page:Int)
    case upcoming(page:Int)
    case topRated(page:Int)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        return "https://api.themoviedb.org/4/discover/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "movie"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .upcoming(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["primary_release_date.gte" : "2021-07-02", "page" : page])
        case .popular(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["sort_by" : "popularity.desc", "page" : page])
        case .topRated(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["sort_by" : "vote_average.desc", "page" : page])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


