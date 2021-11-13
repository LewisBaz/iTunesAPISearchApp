//
//  AlbumDetailTableViewCell.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 25.10.2021.
//

import UIKit

final class AlbumDetailTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "AlbumDetailTableViewCell"

    @IBOutlet weak var songNumberLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    func setupCell(songNumber: String, songName: String) {
        songNumberLabel.text = songNumber
        songNameLabel.text = songName
        songNameLabel.lineBreakMode = .byTruncatingTail
        songNameLabel.numberOfLines = 1
        songNameLabel.backgroundColor = .white
        songNumberLabel.backgroundColor = .white
    }
}
