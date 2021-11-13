//
//  ImageCache.swift
//  iTunesAPISearchApp
//
//  Created by Lewis on 12.11.2021.
//

import UIKit

final class ImageCache {

    private init() {}

    static let shared = NSCache<NSString, UIImage>()
}
