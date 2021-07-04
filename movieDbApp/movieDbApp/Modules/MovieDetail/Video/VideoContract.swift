//
//  VideoContract.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/4/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

protocol VideoView {
    func loadVideo()
    func showVideo(videoId: String)
    func showLoading()
    func hideLoading()
    func showErrorMessage()
}

protocol VideoPresenter {
    func getVideo(movieId: Int)
}
