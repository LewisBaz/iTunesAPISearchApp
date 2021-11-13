//
//  SearchResultsCollectionViewCell.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 23.10.2021.
//

import UIKit

final class SearchResultsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SearchResultsCollectionViewCell"
    
    let albumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.backgroundColor = .white
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.backgroundColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(albumImage)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setFrameForRecievedAlbums()
    }
    
    func setupCell(image: UIImage, albumName: String, artistName: String) {
        albumImage.image = image
        albumNameLabel.text = albumName
        artistNameLabel.text = artistName
    }
    
    func setFrameForRecievedAlbums() {
        albumImage.frame = CGRect(x: 0,
                                  y: 0,
                                  width: contentView.frame.width,
                                  height: contentView.frame.width)
        albumNameLabel.frame = CGRect(x: 0,
                                      y: floor(albumImage.frame.maxY + 3),
                                      width: ceil(contentView.frame.width),
                                      height: 17)
        artistNameLabel.frame = CGRect(x: 0,
                                       y: floor(albumNameLabel.frame.maxY + 3),
                                       width: ceil(contentView.frame.width),
                                       height: 17)
    }
}
