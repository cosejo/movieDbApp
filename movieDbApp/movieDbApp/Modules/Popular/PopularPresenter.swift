//
//  PopularPresenter.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import Foundation

class PopularPresenter: MoviesAppPresenter {
    
    /*
     * Retrieve movies from source
     */
    override func getMovies() {
        super.getMovies(category: .popular)
    }
}
