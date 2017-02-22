//
//  SongListTableViewController.swift
//  AikatsuLyric
//
//  Created by Tomohiro Zoda on 2017/02/14.
//  Copyright © 2017年 Tomohiro Zoda. All rights reserved.
//

import ObjectMapper
import SCLAlertView
import SwiftyJSON
import UIKit

class SongListTableViewController: UITableViewController {

    var songs: [Song] = []

    // MARK: - Table view data source

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            songs = try loadSongs()
        } catch {
            // 復帰不可のため、ポップアップでアプリ再起動を促す
            SCLAlertView().showError("読み込みエラー", subTitle: "アプリを再度立ち上げ直してください。")
        }
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

        let detailText = song.series + " - " + song.scene

        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = detailText

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSongPage" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let song = songs[(indexPath as NSIndexPath).row]
                (segue.destination as! ViewController).song = song
            }
        }
    }

    func loadSongs() throws -> [Song] {
        if let path = Bundle.main.path(forResource: "aikatsu_songs", ofType: "json"),
           let json_data = FileManager.default.contents(atPath: path) {
            let json = try JSONSerialization.jsonObject(
                with: json_data,
                options: JSONSerialization.ReadingOptions.allowFragments
            ) as! [[String: Any]]
            return try Mapper<Song>().mapArray(JSONArray: json)
        } else {
            throw CustomError.jsonImportFailed
        }
    }

    enum CustomError: Error {
        case jsonImportFailed
        case songsImportFailed
    }
}
