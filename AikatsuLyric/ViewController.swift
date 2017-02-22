//
//  ViewController.swift
//  AikatsuLyric
//
//  Created by Tomohiro Zoda on 2017/02/14.
//  Copyright © 2017年 Tomohiro Zoda. All rights reserved.
//

import Kingfisher
import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    var song: Song!

    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var lyricTextView: UITextView!
    @IBOutlet weak var songThumbnailImage: UIImageView!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var sceneLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var youtubeMovieWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webViewErrorMessageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false

        activityIndicator.hidesWhenStopped = true
        youtubeMovieWebView.delegate = self
        webViewErrorMessageLabel.text = ""

        songTitleLabel.text = song.title
        lyricTextView.text = song.text
        seriesLabel.text = song.series
        sceneLabel.text = song.scene
        singerLabel.text = song.singer

        // サムネイル画像
        if let url = URL(string: song.thumbnailUrl) {
            let placeholderImage = #imageLiteral(resourceName: "NoImage")
            self.songThumbnailImage.kf.setImage(with: url, placeholder: placeholderImage)
        }

        // Youtube動画
        if let srcUrl = URL(string: song.embedMovieSrc) {
            let request = URLRequest(url: srcUrl)
            self.youtubeMovieWebView.loadRequest(request as URLRequest)
        }
    }
    internal func webView(
        _ webView: UIWebView,
        shouldStartLoadWith request: URLRequest,
        navigationType: UIWebViewNavigationType
    ) -> Bool {
        activityIndicator.startAnimating()
        return true
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        webViewErrorMessageLabel.text = error.localizedDescription
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
