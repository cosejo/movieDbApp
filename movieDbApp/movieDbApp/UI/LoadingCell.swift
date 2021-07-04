//
//  LoadingCell.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/4/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
}
