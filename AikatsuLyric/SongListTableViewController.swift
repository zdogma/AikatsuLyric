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
    typealias JSONObject = [String: Any]

    var songs: [Song] = []

    // MARK: - Table view data source

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            songs = try loadSongs()
        } catch {
            // 復帰不可のため、ポップアップでアプリ再起動を促す
            SCLAlertView().showError("読み込みエラー", subTitle: "アプリを再起動してください。")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
            as? SongListTableViewCell else {

            abort() // Identifier の定義が誤っている場合に検知のために落とす
        }
        let song = songs[(indexPath as NSIndexPath).row]
        cell.apply(song: song)

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSongPage" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let song = songs[(indexPath as NSIndexPath).row]
                if let nextViewController = segue.destination as? ViewController {
                    nextViewController.song = song
                }
            }
        }
    }

    func loadSongs() throws -> [Song] {
        guard let path = Bundle.main.path(forResource: "aikatsu_songs", ofType: "json"),
              let json_data = FileManager.default.contents(atPath: path),
              let json = try JSONSerialization.jsonObject(
                with: json_data,
                options: JSONSerialization.ReadingOptions.allowFragments
              ) as? [JSONObject]
        else {
            throw JSONError.importFailed
        }
        return try Mapper<Song>().mapArray(JSONArray: json)
    }

    enum JSONError: Error {
        case importFailed
    }
}
