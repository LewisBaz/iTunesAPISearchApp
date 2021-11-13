//
//  SongsTableViewFooter.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 12.11.2021.
//

import UIKit

protocol ReturnFooterHeight: class {
    func returnHeight(height: CGFloat)
}

final class SongsTableViewFooter: UITableViewHeaderFooterView {
    
    weak var delegate: ReturnFooterHeight?
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        return label
    }()
    
    let copyrightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(genreLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(copyrightLabel)
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
        genreLabel.frame = CGRect(x: 30,
                                 y: 10,
                                 width: ceil(contentView.frame.width - 60),
                                 height: 20)
        releaseDateLabel.frame = CGRect(x: 30,
                                        y: floor(genreLabel.frame.maxY + indent),
                                        width: ceil(contentView.frame.width - 60),
                                        height: 20)
        copyrightLabel.frame = CGRect(x: 30,
                                      y: floor(releaseDateLabel.frame.maxY + indent),
                                      width: ceil(contentView.frame.width - 60),
                                      height: 20)
        self.delegate?.returnHeight(height: genreLabel.frame.height + releaseDateLabel.frame.height + copyrightLabel.frame.height + genreLabel.frame.minX + genreLabel.frame.minY + indent * 3)
    }
}
 
