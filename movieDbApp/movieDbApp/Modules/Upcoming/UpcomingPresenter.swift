//
//  UpcomingPresenter.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 6/30/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

class UpcomingPresenter: MoviesAppPresenter {
    
    /*
     * Retrieve movies from source
     */
    override func getMovies() {
        super.getMovies(category: .upcoming)
    }
}
