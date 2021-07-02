//
//  MovieDetailPresenterTest.swift
//  movieDbAppTests
//
//  Created by Carlos Osejo on 7/2/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import XCTest
@testable import movieDbApp

class MovieDetailPresenterTest: XCTestCase {
    
    var presenter : DetailPresenter?
    var mockView : MockDetailsView?
    var mockNetworkManager: MockNetworkManager?
    
    override func setUp() {
        super.setUp()
        mockView = MockDetailsView()
        mockNetworkManager = MockNetworkManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /*
     * Test Get Movie Detail Method with successful response
     */
    func testGetMovieDetailsSuccessful(){
        presenter = MovieDetailsPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .success
        let getMoviesExpectation = self.expectation(description: "GetMovieDetailsSuccessful")
        getMoviesExpectation.isInverted = true
        let mockId = 1
        
        presenter!.getMovieDetails(id: mockId)
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMovieDetailsCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedMovie!.id == mockId+1)
        }
    }
    
    /*
     * Test Get Movie Detail Method with successful response but empty array of movies
     */
    func testGetMovieDetailsSuccessfulEmpty(){
        presenter = MovieDetailsPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .emptySuccess
        let getMoviesExpectation = self.expectation(description: "GetMovieDetailsSuccessfulEmpty")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovieDetails(id: 1)
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMovieDetailsCalledTimes == 0)
            XCTAssertTrue(self?.mockView?.showErrorMessageCalledTimes == 1)
            XCTAssertNil(self?.mockView?.receivedMovie)
        }
    }
    
    /*
     * Test Get Movie Detail Method with Error response
     */
    func testGetMovieDetailsError(){
        presenter = MovieDetailsPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .error
        let getMoviesExpectation = self.expectation(description: "GetMovieDetailsError")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovieDetails(id: 1)
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMovieDetailsCalledTimes == 0)
            XCTAssertNil(self?.mockView?.receivedMovie)
        }
    }
    
    /*
     * Test Get Movie Detail Method without valid id
     */
    func testGetMovieDetailsWithoutValidId(){
        presenter = MovieDetailsPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .error
        let getMoviesExpectation = self.expectation(description: "GetMovieDetailsError")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovieDetails(id: 0)
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMovieDetailsCalledTimes == 0)
            XCTAssertNil(self?.mockView?.receivedMovie)
        }
    }
}
