//
//  PlayVideoPresenter.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/4/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

class PlayVideoPresenter: VideoPresenter {

    var view : VideoView
    var networkManager: NetworkManager?
    
    init(view: VideoView) {
        self.view = view
        networkManager = MoviesNetworkManager()
    }
    
    /*
     * Retrieve movie video id
     */
    func getVideo(movieId: Int) {
        networkManager?.getVideo(movieId: movieId, completion: { [weak self] videoId, error in
            if error == nil {
                DispatchQueue.main.async() {
                    self?.view.showVideo(videoId: videoId ?? "")
                    self?.view.hideLoading()
                }
            }
            else{
                self?.view.showErrorMessage()
            }
        })
    }
}
