//
//  NetworkService.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 23.10.2021.
//

import UIKit

final class NetworkService {

    private let queue = DispatchQueue(label: "networkQueue", qos: .userInteractive)
    private let cache = NSCache<NSString, UIImage>()
    
    func getAlbums(albumName: String, completion: @escaping ([ITunesAlbumModel]) -> ()) {
            
        queue.async {
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(albumName)&entity=album&limit=20") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data else { return }
//                      let json = try? JSONSerialization.jsonObject(with: data) else { return }
//                      print(json)
                
                do {
                    let results = try JSONDecoder().decode(ITunesAlbum.self, from: data)
                    let albums: [ITunesAlbumModel] = results.results.map({$0})
                    DispatchQueue.main.async {
                        completion(albums)
                    }
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
    
    func getSongsForAlbum(albumId: Int, completion: @escaping ([ITunesSongModel]) -> ()) {
        
        queue.async {
            guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(albumId)&entity=song") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data else { return }
//                      let json = try? JSONSerialization.jsonObject(with: data) else { return }
//                      print(json)
                
                do {
                    let results = try JSONDecoder().decode(ITunesSong.self, from: data)
                    let songs: [ITunesSongModel] = results.results.map({$0})
                    DispatchQueue.main.async {
                        completion(songs)
                    }
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
}

