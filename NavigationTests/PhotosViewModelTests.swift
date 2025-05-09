//
//  PhotosViewModelTests.swift
//  NavigationTests
//
//  Created by Ислам on 16.04.2025.
//

import XCTest
import UIKit
@testable import Navigation

class PhotosViewModelTests: XCTestCase {
    
    private var testPhotos: [UIImage] = {
        var images = [UIImage]()
        for _ in 0..<3 {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
            let image = renderer.image { ctx in
                UIColor.red.setFill()
                ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            }
            images.append(image)
        }
        return images
    }()
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test numberOfPhotos property
    
    func testNumberOfPhotos() {
        // Arrange
        let viewModel = PhotosViewModel(photos: testPhotos)
        
        // Act
        let count = viewModel.numberOfPhotos
        
        // Assert
        XCTAssertEqual(count, testPhotos.count, "numberOfPhotos should return the count of photos array")
    }
    
    // MARK: - Test photo(at:) method
    
    func testPhotoAtValidIndex() {
        // Arrange
        let viewModel = PhotosViewModel(photos: testPhotos)
        
        // Act
        let photo = viewModel.photo(at: 1)
        
        // Assert
        XCTAssertNotNil(photo, "Should return a photo for valid index")
    }
    
    func testPhotoAtInvalidIndex() {
        // Arrange
        let viewModel = PhotosViewModel(photos: testPhotos)
        
        // Act & Assert - Test negative index
        XCTAssertNil(viewModel.photo(at: -1), "Should return nil for negative index")
        
        // Act & Assert - Test out of bounds index
        XCTAssertNil(viewModel.photo(at: testPhotos.count), "Should return nil for out of bounds index")
    }
    
    func testPhotoAtEmptyArray() {
        // Arrange
        let viewModel = PhotosViewModel(photos: [])
        
        // Act
        let photo = viewModel.photo(at: 0)
        
        // Assert
        XCTAssertNil(photo, "Should return nil when photos array is empty")
    }
}

class Photos {
    static let shared = Photos()
    let examples: [UIImage] = []
}
