//
//  HistoryOfSearchesTableViewController.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 23.10.2021.
//

import UIKit

final class HistoryOfSearchesTableViewController: UITableViewController {
    
    private var albums = SaverShared.shared.albums
    private var songs = [ITunesSongModel]()
    private var networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        albums = albums.reversed()
        
        if albums.count > 30 {
            albums.removeLast(albums.count - 30)
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryOfSearchesTableViewCell.reuseIdentifier, for: indexPath) as! HistoryOfSearchesTableViewCell

        guard let url = URL(string: albums[indexPath.row].albumImage ) else { return UITableViewCell() }
        let data = (try? Data(contentsOf: url)) ?? Data()
        cell.setupCell(albumName: albums[indexPath.row].collectionName,
                       artistName: albums[indexPath.row].artistName,
                       image: (UIImage(data: data) ?? UIImage()))

        return cell
    }
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationController = storyBoard.instantiateViewController(withIdentifier: "AlbumDetailTableViewController") as? AlbumDetailTableViewController else { return }
        
        destinationController.album = albums[indexPath.row]
        networkService.getSongsForAlbum(albumId: albums[indexPath.row].collectionId, completion: { [weak self] songs in
            guard let self = self else { return }
            self.songs = songs
            self.songs.removeFirst()
            destinationController.songs = self.songs
            destinationController.tableView.reloadData()
        })
        navigationController?.pushViewController(destinationController, animated: true)
    }
}
