//
//  PlayVideoViewController.swift
//  movieDbApp
//
//  Created by Carlos Osejo on 7/2/21.
//  Copyright © 2021 Carlos Osejo. All rights reserved.
//

import UIKit
import WebKit

class PlayVideoViewController: UIViewController {
    
    @IBOutlet weak var videoWebVIew: WKWebView!
    @IBOutlet weak var videoActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var overlayView: UIView!
    
    var presenter : VideoPresenter?
    var videoURL: String?
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PlayVideoPresenter(view: self)
        loadVideo()
    }
}

extension PlayVideoViewController: VideoView{
    
    /*
     * Load Video
     */
    func loadVideo() {
        presenter?.getVideo(movieId: movieId!)
    }
    
    /*
     * Show the retrieved Movies
     */
    func showVideo(videoId: String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else {
            showErrorMessage()
            return
        }
        videoWebVIew.load(URLRequest(url: youtubeURL))
    }
    
    /*
     * Show loading spinner
     */
    func showLoading() {
        videoActivityIndicatorView.startAnimating()
        overlayView.isHidden = false
        videoActivityIndicatorView.isHidden = false
    }
    
    /*
     * Hide loading spinner
     */
    func hideLoading() {
        videoActivityIndicatorView.stopAnimating()
        overlayView.isHidden = true
        videoActivityIndicatorView.isHidden = true
    }
    
    /*
     * Show Alert Action with error message
     * Alow user to retry the loading or cancel
     */
    func showErrorMessage() {
        let alert = UIAlertController(title: "Ups", message: "Something happen with the video, please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {[weak self] (action) in
            self?.showLoading()
            self?.loadVideo()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {[weak self] (action) in
            self?.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
