//
//  AlbumsSaver.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 12.11.2021.
//

import Foundation

final class AlbumsSaver {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "records"
    
    func saveAlbum(albums: [ITunesAlbumModel]) {
        do {
            let data = try self.encoder.encode(albums)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func recieveAlbum() -> [ITunesAlbumModel] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try self.decoder.decode([ITunesAlbumModel].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
