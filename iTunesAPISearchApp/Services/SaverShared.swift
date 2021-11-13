//
//  SaverShared.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 12.11.2021.
//

import Foundation

final class SaverShared {
    
    static let shared = SaverShared()
    private(set) var albums: [ITunesAlbumModel] {
        didSet {
            albumsSaver.saveAlbum(albums: self.albums)
        }
    }
    
    let albumsSaver = AlbumsSaver()
    
    private init() {
        self.albums = albumsSaver.recieveAlbum()
    }
    
    var arrayOfIds = [Int]()
    
    func addIdsToSaver() {
        var indexToCheckIds = 0
        for _ in albums {
            arrayOfIds.append(albums[indexToCheckIds].collectionId)
            indexToCheckIds += 1
        }
    }
        
    func addAlbum(_ album: ITunesAlbumModel) {
        self.albums.append(album)
    }
        
    func clearAlbums() {
        self.albums = []
    }
}
