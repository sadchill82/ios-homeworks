//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Ислам on 16.04.2025.
//

import UIKit

final class PhotosViewModel {
    
    private let photos: [UIImage]
    
    init(photos: [UIImage] = Photos.shared.examples) {
        self.photos = photos
    }
    
    var numberOfPhotos: Int {
        photos.count
    }
    
    func photo(at index: Int) -> UIImage? {
        guard index >= 0 && index < photos.count else { return nil }
        return photos[index]
    }
}
