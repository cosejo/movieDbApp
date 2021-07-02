//
//  MoviesPresenter.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

class MoviesAppPresenter: MoviesPresenter {
    
    let requestDateFormat = "yyyy-MM-dd"
    
    var view : MoviesView
    var networkManager: NetworkManager?
    private var moviesPageIndex = 1
    private var movies: [Movie] = []
    
    init(view: MoviesView) {
        self.view = view
        networkManager = MoviesNetworkManager()
    }
    
    /*
     * Retrieve movies from source
     */
    func getMovies(category: MoviesCategory) {
        view.showLoading()
        let currentDateAsString = formatDateToString(date: Date(), format: requestDateFormat)
        networkManager?.getMovies(category: category, page: moviesPageIndex, date: currentDateAsString, completion: { [weak self] movies, error in
            if error == nil {
                self?.moviesPageIndex += 1
                DispatchQueue.main.async() {
                    self?.movies = movies!
                    self?.view.showMovies(movies: movies!)
                    self?.view.hideLoading()
                }
            }
            else{
                self?.view.showErrorMessage()
            }
        })
    }
    
    /*
     * Get Movies should be implemented by child classes
     */
    func getMovies() {
        fatalError("getMovies() has not been implemented")
    }
    
    /*
     * Filter Movies according to the search text
     *  - Parameter searchText: the text to filter movies
     */
    func getSearchMovies(searchText: String) {
        let searchMovies = movies.filter { $0.title.lowercased().prefix(searchText.count) == searchText.lowercased() }
        view.reloadSearchMovies(movies: searchMovies)
        
    }
    
    /*
     * Convert Date into String following a format
     *  - Parameter date: the date to convert into String
     *  - Parameter format: the required format
     *  - Returns: String with the date formatted
     */
    func formatDateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
