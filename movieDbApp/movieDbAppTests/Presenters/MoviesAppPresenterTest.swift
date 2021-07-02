//
//  UpcomingPresenterTest.swift
//  movieDbAppTests
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import XCTest
@testable import movieDbApp

class MoviesAppPresenterTest: XCTestCase {
    
    var presenter : MoviesAppPresenter?
    var mockView : MockMoviesView?
    var mockNetworkManager: MockNetworkManager?
    
    override func setUp() {
        super.setUp()
        mockView = MockMoviesView()
        mockNetworkManager = MockNetworkManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /*
     * Test Format Date method
     */
    func testFormatDate(){
        let date = Date(timeIntervalSinceReferenceDate: -123456789.0)
        let expectedDateFormatted = "1997-02-01"
        presenter = MoviesAppPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        
        let dateStringResult = presenter!.formatDateToString(date: date, format: "yyyy-MM-dd")
        
        XCTAssertTrue(expectedDateFormatted.elementsEqual(dateStringResult))
    }
    
    /*
     * Test Format Date method
     */
    func testSearchMoviesWithMatch(){
        presenter = UpcomingPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .success
        let getMoviesExpectation = self.expectation(description: "GetMoviesSuccessfull")
        getMoviesExpectation.isInverted = true
        presenter!.getMovies()
        wait(for: [getMoviesExpectation], timeout: 3)
        
        presenter?.getSearchMovies(searchText: "T")
        
        let searchedMovies = mockView?.searchedMovies
        XCTAssertTrue(searchedMovies?.count == 2)
        XCTAssertTrue(mockView?.reloadSearchMoviesCalledTimes == 1)
        XCTAssertTrue(searchedMovies![0].title == "Titanic")
        XCTAssertTrue(searchedMovies![1].title == "The Incredible Hulk")
    }
    
    func testSearchMoviesWithNoMatch(){
        presenter = UpcomingPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .success
        let getMoviesExpectation = self.expectation(description: "GetMoviesSuccessfull")
        getMoviesExpectation.isInverted = true
        presenter!.getMovies()
        wait(for: [getMoviesExpectation], timeout: 3)
        
        presenter?.getSearchMovies(searchText: "Y")
        
        let searchedMovies = mockView?.searchedMovies
        XCTAssertTrue(mockView?.reloadSearchMoviesCalledTimes == 1)
        XCTAssertTrue(searchedMovies?.count == 0)
    }
    
    /*
     * Test Get Upcoming Movies Method with successful response
     */
    func testUpcomingGetMoviesSuccessful(){
        presenter = UpcomingPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .success
        let getMoviesExpectation = self.expectation(description: "GetMoviesSuccessfull")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()

        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedMovies?.count == 7)
        }
    }
    
    /*
     * Test Get Upcoming Movies Method with successful response but empty array of movies
     */
    func testUpcomingGetMoviesSuccessfulEmpty(){
        presenter = UpcomingPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .emptySuccess
        let getMoviesExpectation = self.expectation(description: "GetMoviesSuccessfullEmpty")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedMovies?.count == 0)
        }
    }
    
    /*
     * Test Get Upcoming Movies Method with Error response
     */
    func testGetUpcomingMoviesError(){
        presenter = UpcomingPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .error
        let getMoviesExpectation = self.expectation(description: "GetMoviesError")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 0)
            XCTAssertNil(self?.mockView?.receivedMovies)
        }
    }
    
    /*
     * Test Get Popular Movies Method with successful response
     */
    func testPopularGetMoviesSuccessful(){
        presenter = PopularPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .success
        let getMoviesExpectation = self.expectation(description: "GetMoviesSuccessfull")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedMovies?.count == 7)
        }
    }
    
    /*
     * Test Get Popular Movies Method with successful response but empty array of movies
     */
    func testPopularGetMoviesSuccessfulEmpty(){
        presenter = PopularPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .emptySuccess
        let getMoviesExpectation = self.expectation(description: "GetMoviesSuccessfullEmpty")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedMovies?.count == 0)
        }
    }
    
    /*
     * Test Get Popular Movies Method with Error response
     */
    func testGetPopularMoviesError(){
        presenter = PopularPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .error
        let getMoviesExpectation = self.expectation(description: "GetMoviesError")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 0)
            XCTAssertNil(self?.mockView?.receivedMovies)
        }
    }
    
    /*
     * Test Get TopRated Movies Method with successful response
     */
    func testTopRatedGetMoviesSuccessful(){
        presenter = TopRatedPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .success
        let getMoviesExpectation = self.expectation(description: "GetMoviesSuccessfull")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedMovies?.count == 7)
        }
    }
    
    /*
     * Test Get TopRated Movies Method with successful response but empty array of movies
     */
    func testTopRatedGetMoviesSuccessfulEmpty(){
        presenter = TopRatedPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .emptySuccess
        let getMoviesExpectation = self.expectation(description: "GetMoviesSuccessfullEmpty")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 1)
            XCTAssertTrue(self?.mockView?.receivedMovies?.count == 0)
        }
    }
    
    /*
     * Test Get TopRated Movies Method with Error response
     */
    func testGetTopRatedMoviesError(){
        presenter = TopRatedPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
        mockNetworkManager!.mockResponse = .error
        let getMoviesExpectation = self.expectation(description: "GetMoviesError")
        getMoviesExpectation.isInverted = true
        
        presenter!.getMovies()
        
        waitForExpectations(timeout: 3) {[weak self] (error) in
            XCTAssertTrue(self?.mockView?.showMoviesCalledTimes == 0)
            XCTAssertNil(self?.mockView?.receivedMovies)
        }
    }
}
