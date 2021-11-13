//
//  SongModel.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 25.10.2021.
//

import Foundation

final class ITunesSong: Codable {
    var resultCount: Int
    var results: [ITunesSongModel]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results = "results"
    }
}

final class ITunesSongModel: Codable {
    
    var collectionName: String
    var artistName: String
    var trackName: String?
    var trackId: Int?
    var collectionId: Int
    var albumImage: String?
    
    enum CodingKeys: String, CodingKey {
        case collectionName
        case artistName
        case trackName
        case trackId
        case collectionId
        case albumImage = "artworkUrl100"
    }
}
