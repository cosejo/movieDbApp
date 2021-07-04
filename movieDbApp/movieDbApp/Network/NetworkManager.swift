//
//  MoviesNetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

protocol NetworkManager {
    func getMovies(category: MoviesCategory, page: Int, date: String, completion: @escaping (_ movie: [Movie]?,_ error: String?)->())
    func getMovieDetail(id: Int, completion: @escaping (_ movieDetail: MovieDetail?,_ error: String?)->())
    func getVideo(movieId: Int, completion: @escaping (_ videoId: String?,_ error: String?)->())
}

struct MoviesNetworkManager : NetworkManager {
    
    let router = Router<MovieApi>()
    
    func getMovies(category: MoviesCategory, page: Int, date: String = "", completion: @escaping (_ movie: [Movie]?,_ error: String?)->()){
        let requestCategory: MovieApi
        switch category {
        case .upcoming:
            requestCategory = MovieApi.upcoming(page: page, date: date)
            break
        case .popular:
            requestCategory = MovieApi.popular(page: page)
            break
        case .topRated:
            requestCategory = MovieApi.topRated(page: page)
            break
        }
        router.request(requestCategory) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                        completion(apiResponse.movies,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getMovieDetail(id: Int, completion: @escaping (_ movieDetail: MovieDetail?,_ error: String?)->()){
        router.request(.movieDetails(id: id)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: responseData)
                        completion(movieDetail, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getVideo(movieId: Int, completion: @escaping (String?, String?) -> ()) {
        router.request(.movieVideo(id: movieId)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let videoResponse = try JSONDecoder().decode(VideoApiResponse.self, from: responseData)
                        completion(videoResponse.videos.first?.key, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
