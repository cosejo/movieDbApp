//
//  TopRatedPresenter.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

class TopRatedPresenter: MoviesAppPresenter {
    
    /*
     * Retrieve movies from source
     */
    override func getMovies() {
        super.getMovies(category: .topRated)
    }
}
