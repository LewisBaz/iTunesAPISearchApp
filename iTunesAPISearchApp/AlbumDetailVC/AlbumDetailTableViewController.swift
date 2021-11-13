//
//  AlbumDetailTableViewController.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 12.11.2021.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, ReturnHeaderHieght, ReturnFooterHeight {
    
    var album = ITunesAlbumModel(albumImage: "", country: "", releaseDate: "", artistName: "", collectionName: "", primaryGenreName: "", trackCount: 0, copyright: "", collectionId: 0)
    var songs = [ITunesSongModel]()
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy 'at' HH:mm"
        return df
    }()
    var header = SongsTableViewHeader()
    var footer = SongsTableViewFooter()
    var tableViewHeaderHeight: CGFloat = 1
    var tableViewFooterHeight: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SongsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "SongsViewHeader")
        tableView.register(SongsTableViewFooter.self, forHeaderFooterViewReuseIdentifier: "SongsViewFooter")
        
        SaverShared.shared.addIdsToSaver()
        if !SaverShared.shared.arrayOfIds.contains(album.collectionId) {
            SaverShared.shared.addAlbum(album)
            SaverShared.shared.arrayOfIds.append(album.collectionId)
        }
    }

    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumDetailTableViewCell.reuseIdentifier, for: indexPath) as! AlbumDetailTableViewCell
        
        cell.selectionStyle = .none
        cell.setupCell(songNumber: "\(indexPath.row + 1).", songName: "\(songs[indexPath.row].trackName ?? "")")
        
        return cell
    }
    
    // MARK: - UITableView Header & Footer
    
    func returnHieght(height: CGFloat) {
        self.tableViewHeaderHeight = height
    }
    func returnHeight(height: CGFloat) {
        self.tableViewFooterHeight = height
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SongsViewHeader") as! SongsTableViewHeader
        header.delegate = self
        
        if let cachedImage = ImageCache.shared.object(forKey: "\(self.album.albumImage)" as NSString) {
            header.imageView.image = cachedImage
        } else {
            if let url = URL(string: album.albumImage) {
                let data = (try? Data(contentsOf: url)) ?? Data()
                header.imageView.image = UIImage(data: data)
                ImageCache.shared.setObject(header.imageView.image ?? UIImage(), forKey: "\(self.album.albumImage)" as NSString)
            }
        }
        header.albumLabel.text = album.collectionName
        header.artistLabel.text = album.artistName
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SongsViewFooter") as! SongsTableViewFooter
        footer.delegate = self
        
        footer.genreLabel.text = album.primaryGenreName
        let date = dateFormatter.date(from: self.album.releaseDate) ?? Date()
        let dateString = dateFormatter.string(from: date)
        footer.releaseDateLabel.text = dateString
        footer.copyrightLabel.text = album.copyright
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableViewHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.tableViewFooterHeight
    }
}
