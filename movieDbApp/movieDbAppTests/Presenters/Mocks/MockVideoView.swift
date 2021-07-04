//
//  MockVideoView.swift
//  movieDbAppTests
//
//  Created by Carlos Osejo on 7/4/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation
@testable import movieDbApp

class MockVideoView: VideoView {
    
    var loadVideoCalledTimes = 0
    var showVideoCalledTimes = 0
    var showLoadingCalledTimes = 0
    var hideLoadingCalledTimes = 0
    var showErrorMessageCalledTimes = 0
    var receivedVideoId: String?
    
    func loadVideo() {
        loadVideoCalledTimes += 1
    }
    
    func showVideo(videoId: String) {
        receivedVideoId = videoId
        showVideoCalledTimes += 1
    }
    
    func showLoading() {
        showLoadingCalledTimes += 1
    }
    
    func hideLoading() {
        hideLoadingCalledTimes += 1
    }
    
    func showErrorMessage() {
        showErrorMessageCalledTimes += 1
    }
    
}

extension PlayVideoPresenter {
    convenience init(view: VideoView, mockNetworkManager: NetworkManager) {
        self.init(view: view)
        networkManager = mockNetworkManager
    }
}
