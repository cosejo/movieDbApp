//
//  UpcomingPresenterTest.swift
//  movieDbAppTests
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import XCTest
@testable import movieDbApp

class UpcomingPresenterTest: XCTestCase {
    
    var presenter : UpcomingPresenter?
    var mockView : MockUpcomingView?
    var mockNetworkManager: MockNetworkManager?
    
    override func setUp() {
        super.setUp()
        mockView = MockUpcomingView()
        mockNetworkManager = MockNetworkManager()
        presenter = UpcomingPresenter(view: mockView!, mockNetworkManager: mockNetworkManager!)
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
        
        let dateStringResult = presenter!.formatDateToString(date: date, format: "yyyy-MM-dd")
        
        XCTAssertTrue(expectedDateFormatted.elementsEqual(dateStringResult))
    }
    
    /*
     * Test Get Movies Method with successful response
     */
    func testGetMoviesSuccessful(){
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
     * Test Get Movies Method with successful response but empty array of movies
     */
    func testGetMoviesSuccessfulEmpty(){
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
     * Test Get Movies Method with Error response
     */
    func testGetMoviesError(){
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
