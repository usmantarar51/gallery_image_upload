//
//  GalleryViewControllerTests.swift
//  ImageUploaderTests
//
//  Created by Muhammad Usman Tarar on 6/14/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import XCTest
import YPImagePicker
@testable import ImageUploader

class GalleryViewControllerTests: XCTestCase {

    var mockPresenter: MockImageListEventHandler?
    var picker: YPImagePicker?
    var configuration: YPImagePickerConfiguration?
    var view: GalleryViewController?
    let testMockImage = UIImage(named: "mock-image")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard.init(name: "Gallery", bundle: nil)
        view = storyBoard.instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
        mockPresenter = MockImageListEventHandler()
        view?.presenter = mockPresenter
        picker = YPImagePicker()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMockImageSuccess() {
        XCTAssert(testMockImage != nil)
    }

    
    func testypPickerConfig() {
        guard let config = view?.ypPickerConfig() else {
            XCTFail()
            return
        }
        configuration = config
        XCTAssert(true)
    }
    
    func testshowPicker() {
        testypPickerConfig()
        view?.showPicker()
        XCTAssert(view?.picker?.isViewLoaded ?? false)
    }
    
    func testShowPickerImageSelection() {
        testshowPicker()
        guard let picker = picker else {
            XCTFail()
            return
        }
        picker.didFinishPicking { (items, cancelled) in
            if items.count > 0 && !cancelled {
                XCTAssert(true)
            }
        }
    }
    
    func testShowPickerImageSelectionFailed() {
        testshowPicker()
        guard let picker = picker else {
            XCTFail()
            return
        }
        picker.didFinishPicking { (items, cancelled) in
            if items.count == 0 && cancelled {
                XCTAssert(true)
            }
        }
    }
    
    func testfireBaseAnonymouslyLogin() {
        view?.presenter?.fireBaseAnonymouslyLogin()
        XCTAssert(mockPresenter?.onRequestImageListCalled == 1,
                  "Expect loggin called once")
    }
    
    func testdownloadImagesFromFirebase() {
        view?.presenter?.downloadImagesFromFirebase()
        XCTAssert(mockPresenter?.onRequestImageListCalled == 1,
                  "Expect download images called once")
    }
    
    func testuploadImages() {
        self.testMockImageSuccess()
        guard let imageData = testMockImage?.pngData() else {
            XCTFail()
            return
        }
        view?.presenter?.uploadImages(imageDataArray: [imageData])
        XCTAssert(mockPresenter?.onRequestImageListCalled == 1,
                  "Expect download images called once")
    }
    
    func testrefetchImages() {
        testdownloadImagesFromFirebase()
    }

}
