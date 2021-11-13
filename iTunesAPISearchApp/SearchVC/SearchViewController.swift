//
//  SearchViewController.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 23.10.2021.
//

import UIKit

final class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    private let searchController = UISearchController(searchResultsController: SearchResultsViewController())
    private let networkService = NetworkService()
    private var recievedAlbums = [ITunesAlbumModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let vc = searchController.searchResultsController as? SearchResultsViewController else { return }
        guard let text = searchController.searchBar.text else { return }
        let fixedText = text.replacingOccurrences(of: " ", with: "+")
        
            networkService.getAlbums(albumName: fixedText, completion: { [weak self] recievedAlbums in
            guard let self = self else { return }
            self.recievedAlbums = recievedAlbums.sorted(by: { $0.collectionName > $1.collectionName })
            vc.albums = self.recievedAlbums
            vc.collectionView?.reloadData()
        })
    }
}
