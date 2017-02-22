//
//  SongListTableViewCell.swift
//  AikatsuLyric
//
//  Created by Tomohiro Zoda on 2017/02/22.
//  Copyright © 2017年 Tomohiro Zoda. All rights reserved.
//

import UIKit

class SongListTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func apply(song: Song) {
        titleLabel.text = song.title
        subTitleLabel.text = song.series + " - " + song.scene

        if let url = URL(string: song.thumbnailUrl) {
            let placeholderImage = #imageLiteral(resourceName: "NoImage")
            thumbnailImageView.kf.setImage(with: url, placeholder: placeholderImage)
        } else {
            thumbnailImageView.image = #imageLiteral(resourceName: "NoImage")
        }
    }
}
