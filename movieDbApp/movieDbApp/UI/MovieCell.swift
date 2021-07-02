//
//  MovieCell.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/1/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(title: String, releaseDate: String?, voteAverage: Double, posterPath: String?) {
        titleLabel.text = title
        releaseDateLabel.text = releaseDate ?? "TBD"
        voteAverageLabel.text = "\(voteAverage)"
        posterImageView.loadImage(url: posterPath)
    }
    
}

extension UIImageView {
    
    func loadImage(url: String?) {
        guard url != nil && !url!.isEmpty else {
            return
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(url!)")
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            
            guard data != nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
    }
}
