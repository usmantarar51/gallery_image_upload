//
//  MockImageListEventHandler.swift
//  ImageUploaderTests
//
//  Created by Muhammad Usman Tarar on 6/14/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

@testable import ImageUploader
import XCTest

class MockImageListEventHandler: GalleryPresentation {
    private(set) var onRequestImageListCalled = 0
    
    func fireBaseAnonymouslyLogin() {
        onRequestImageListCalled += 1
    }
    
    func downloadImagesFromFirebase() {
        onRequestImageListCalled += 1
    }

    func uploadImages(imageDataArray: [Data]) {
        onRequestImageListCalled += 1
    }
}
