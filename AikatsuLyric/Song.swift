//
//  Song.swift
//  AikatsuLyric
//
//  Created by Tomohiro Zoda on 2017/02/21.
//  Copyright © 2017年 Tomohiro Zoda. All rights reserved.
//

//import Foundation
import ObjectMapper

struct Song: ImmutableMappable {
    let title: String
    let text: String
    let thumbnailUrl: String
    let scene: String
    let series: String
    let singer: String
    let embedMovieSrc: String

    init(map: Map) throws {
        title = try map.value("title")
        text = try map.value("text")
        thumbnailUrl = try map.value("thumbnail_url")
        series = try map.value("series")
        scene = try map.value("scene")
        singer = try map.value("singer")
        embedMovieSrc = try map.value("embed_movie_src")
    }
}
