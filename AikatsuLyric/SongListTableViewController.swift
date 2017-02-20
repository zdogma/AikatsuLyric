//
//  SongListTableViewController.swift
//  AikatsuLyric
//
//  Created by Tomohiro Zoda on 2017/02/14.
//  Copyright © 2017年 Tomohiro Zoda. All rights reserved.
//

import UIKit
import SwiftyJSON

class SongListTableViewController: UITableViewController {

    var songs: JSON = []
    
    // MARK: - Table view data source

    override func viewDidLoad() {
        super.viewDidLoad()

        songs = loadSongsJSON()!
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let song = songs[(indexPath as NSIndexPath).row]

        let url = URL(string: String(describing: song["thumbnail_url"]))
        let placeholderImage = UIImage(named: "NoImage")

        tableView.rowHeight = 60

        cell.textLabel?.text = String(describing: song["title"])
        cell.detailTextLabel?.text = String(describing: song["series"]) + " - " + String(describing: song["scene"])
        cell.imageView?.kf.setImage(with: url, placeholder: placeholderImage)
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSongPage" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let song = songs[(indexPath as NSIndexPath).row]
                (segue.destination as! ViewController).data = (
                    title: String(describing: song["title"]),
                    text: String(describing: song["text"]),
                    thumbnail_url: String(describing: song["thumbnail_url"]),
                    series: String(describing: song["series"]),
                    scene: String(describing: song["scene"]),
                    singer: String(describing: song["singer"]),
                    embed_movie_src: String(describing: song["embed_movie_src"])
                )
            }
        }
    }

    func loadSongsJSON() -> JSON? {
        let path = Bundle.main.path(forResource: "aikatsu_songs", ofType: "json")
        do {
            let jsonStr = try String(contentsOfFile: path!)
            return JSON.parse(jsonStr)
        } catch {
            return nil
        }
    }
}
