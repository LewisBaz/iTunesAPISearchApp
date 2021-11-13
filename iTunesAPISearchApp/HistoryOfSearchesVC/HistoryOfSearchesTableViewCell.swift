//
//  HistoryOfSearchesTableViewCell.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 23.10.2021.
//

import UIKit

final class HistoryOfSearchesTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "HistoryOfSearchesTableViewCell"

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
    func setupCell(albumName: String, artistName: String, image: UIImage) {
        albumNameLabel.text = albumName
        artistNameLabel.text = artistName
        albumImage.image = image
    }
}
