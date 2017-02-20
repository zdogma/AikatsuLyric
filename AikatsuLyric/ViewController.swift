//
//  ViewController.swift
//  AikatsuLyric
//
//  Created by Tomohiro Zoda on 2017/02/14.
//  Copyright © 2017年 Tomohiro Zoda. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UIWebViewDelegate {

    var data: (
        title: String,
        text: String,
        thumbnail_url: String,
        series: String,
        scene: String,
        singer: String,
        embed_movie_src: String
    )?

    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var lyricTextView: UITextView!
    @IBOutlet weak var songThumbnailImage: UIImageView!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var sceneLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var youtubeMovieWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false

        activityIndicator.hidesWhenStopped = true
        youtubeMovieWebView.delegate = self

        songTitleLabel.text = data!.title
        lyricTextView.text = data!.text
        seriesLabel.text = data!.series
        sceneLabel.text = data!.scene
        singerLabel.text = data!.singer
        
        // サムネイル画像
        if !data!.thumbnail_url.isEmpty {
            let url = URL(string: data!.thumbnail_url)
            self.songThumbnailImage.kf.setImage(with: url)
        }
        
        // Youtube動画
        if !data!.embed_movie_src.isEmpty {
            let url = NSURL(string: data!.embed_movie_src)
            let request = NSURLRequest(url: url! as URL)
            
            self.youtubeMovieWebView.loadRequest(request as URLRequest)
        }
    }
    private func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        activityIndicator.startAnimating()
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

