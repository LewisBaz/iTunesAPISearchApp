//
//  AlbumModel.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 24.10.2021.
//

import Foundation

final class ITunesAlbum: Codable {
    var resultCount: Int
    var results: [ITunesAlbumModel]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results = "results" 
    }
}

final class ITunesAlbumModel: Codable {

    var albumImage: String
    var country: String
    var releaseDate: String
    var artistName: String
    var collectionName: String
    var primaryGenreName: String
    var trackCount: Int
    var copyright: String
    var collectionId: Int
    
    init(albumImage: String, country: String, releaseDate: String, artistName: String, collectionName: String, primaryGenreName: String, trackCount: Int, copyright: String, collectionId: Int) {
        self.albumImage = albumImage
        self.country = country
        self.releaseDate = releaseDate
        self.artistName = artistName
        self.collectionName = collectionName
        self.primaryGenreName = primaryGenreName
        self.trackCount = trackCount
        self.copyright = copyright
        self.collectionId = collectionId
    }
    
    enum CodingKeys: String, CodingKey {
        case albumImage = "artworkUrl100"
        case country
        case releaseDate
        case artistName
        case collectionName
        case primaryGenreName
        case trackCount
        case copyright
        case collectionId
    }
}
