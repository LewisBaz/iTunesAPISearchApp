//
//  SearchResultsViewController.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 23.10.2021.
//

import UIKit

final class SearchResultsViewController: UIViewController {
   
    var collectionView: UICollectionView?
    private let networkService = NetworkService()
    var albums = [ITunesAlbumModel]()
    var recievedSongs = [ITunesSongModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let widthIndent = 20
        let heigthIndent = 40
        layout.sectionInset = UIEdgeInsets(top: CGFloat(heigthIndent*2/3), left: CGFloat(widthIndent/2), bottom: CGFloat(heigthIndent*1/3), right: CGFloat(widthIndent/2))
        layout.itemSize = CGSize(width: Int(self.view.frame.width) / 2 - widthIndent, height: Int(self.view.frame.width) / 2 - widthIndent + heigthIndent)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultsCollectionViewCell.reuseIdentifier)
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
 
        view.addSubview(collectionView ?? UICollectionView())
        
        self.view = view
    }
}

// MARK: UICollectionViewDataSource

extension SearchResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchResultsCollectionViewCell
        
        let url = URL(string: self.albums[indexPath.row].albumImage)
        guard let data = (try? Data(contentsOf: url ?? URL(fileURLWithPath: ""))) else { return UICollectionViewCell()}
        let image = UIImage(data: data)
        let artistName = self.albums[indexPath.row].artistName
        let albumName = self.albums[indexPath.row].collectionName

        cell.setupCell(image: image ?? UIImage(),
                       albumName: albumName,
                       artistName: artistName)
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension SearchResultsViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationController = storyBoard.instantiateViewController(withIdentifier: "AlbumDetailTableViewController") as? AlbumDetailTableViewController else { return }
        
        destinationController.album = self.albums[indexPath.item]
        self.presentingViewController?.navigationController?.pushViewController(destinationController, animated: true)
        let albumId = self.albums[indexPath.item].collectionId
        
        networkService.getSongsForAlbum(albumId: albumId, completion: { [weak self] recievedSongs in
            guard let self = self else { return }
            self.recievedSongs = recievedSongs
            self.recievedSongs.removeFirst()
            destinationController.songs = self.recievedSongs
            destinationController.tableView.reloadData()
        })
    }
}
