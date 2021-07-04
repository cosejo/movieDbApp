//
//  PlayVideoPresenterTest.swift
//  movieDbAppTests
//
//  Created by Carlos Osejo on 7/4/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import XCTest
@testable import movieDbApp

class PlayVideoPresenterTest: XCTestCase {
    
    var presenter : VideoPresenter?
    var mockView : MockVideoView?
    var mockNetworkManager: MockNetworkManager?
    
    override func setUp() {
        super.setUp()
        mockView = MockVideoView()
        mockNetworkManager = MockNetworkManager()
        presenter = PlayVideoPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /*
     * Test Get Movie Video Method with successful response
     */
    func testGetVideoSuccessful(){
        mockNetworkManager!.mockResponse = .success
        let getMoviesExpectation = self.expectation(description: "GetMovieDetailsSuccessful")
        getMoviesExpectation.isInverted = true
        let expectedMovieId = "1ASadaada121432sA"
        
        presenter!.getVideo(movieId: 1)
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showVideoCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedVideoId == expectedMovieId)
        }
    }
    
    /*
     * Test Get Movie Video Method with successful response but empty String
     */
    func testGetVideoSuccessfulEmpty(){
        mockNetworkManager!.mockResponse = .emptySuccess
        let getMoviesExpectation = self.expectation(description: "GetVideoSuccessfulEmpty")
        getMoviesExpectation.isInverted = true
        
        presenter!.getVideo(movieId: 1)
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showVideoCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedVideoId == "")
        }
    }
    
    /*
     * Test Get Movie Video Method with Error response
     */
    func testGetVideoError(){
        mockNetworkManager!.mockResponse = .error
        let getMoviesExpectation = self.expectation(description: "GetVideoError")
        getMoviesExpectation.isInverted = true
        
        presenter!.getVideo(movieId: 1)
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showVideoCalledTimes == 0)
            XCTAssertNil(self?.mockView?.receivedVideoId)
        }
    }
}
