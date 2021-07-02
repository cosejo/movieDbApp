//
//  UpcomingViewController.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 6/30/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import UIKit

class UpcomingViewController: MoviesViewController {

    override func viewDidLoad() {
        presenter = UpcomingPresenter(view: self)
        super.viewDidLoad()
    }
}

