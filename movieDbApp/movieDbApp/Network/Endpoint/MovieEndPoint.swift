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
    case upcoming(page:Int, date: String)
    case topRated(page:Int)
    case movieDetails(id:Int)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        let baseURLV3 = "https://api.themoviedb.org/3/"
        let baseURLV4 = "https://api.themoviedb.org/4/"
        switch self {
        case .movieDetails(_):
            return baseURLV3
        default:
            return baseURLV4
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .movieDetails(let id):
            return "movie/\(id)"
        default:
            return "discover/movie"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .upcoming(let page, let date):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["primary_release_date.gte" : date, "page" : page])
        case .popular(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["sort_by" : "popularity.desc", "page" : page])
        case .topRated(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["sort_by" : "vote_average.desc", "page" : page])
        case .movieDetails(_):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [:])
        }
    }
    
    var headers: HTTPHeaders? {
        let MovieAPIKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYzFjNDI2NmU3OGJlMzExNzBhMzc4MDNjN2NmNjA5ZSIsInN1YiI6IjYwZGQxZDFhMmQzNzIxMDA3ZTc0MmNiYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lAk6zAi0ykEDUh39HJbqtGNCWgejaCYDWoYyPWnSlg8"
        
        return ["authorization" : "Bearer " + MovieAPIKey]
    }
}


