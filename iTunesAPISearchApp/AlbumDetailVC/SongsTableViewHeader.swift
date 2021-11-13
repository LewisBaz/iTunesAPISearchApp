//
//  SongsTableViewHeader.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 12.11.2021.
//

import UIKit

protocol ReturnHeaderHieght: class {
    func returnHieght(height: CGFloat)
}

final class SongsTableViewHeader: UITableViewHeaderFooterView {
    
    weak var delegate: ReturnHeaderHieght?
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageView)
        contentView.addSubview(albumLabel)
        contentView.addSubview(artistLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    func setupView() {
        let indent: CGFloat = 10
        imageView.frame = CGRect(x: 30,
                                 y: 10,
                                 width: ceil(contentView.frame.width - 60),
                                 height: ceil(contentView.frame.width - 60))
        albumLabel.frame = CGRect(x: 30,
                                  y: floor(imageView.frame.maxY + indent),
                                  width: ceil(contentView.frame.width - 60),
                                  height: 30)
        artistLabel.frame = CGRect(x: 30,
                                   y: floor(albumLabel.frame.maxY + indent),
                                   width: ceil(contentView.frame.width - 60),
                                   height: 20)
        self.delegate?.returnHieght(height: imageView.frame.height + albumLabel.frame.height + artistLabel.frame.height + imageView.frame.minY + indent * 3)
    }
}
 
