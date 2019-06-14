//
//  ImageUploaderTests.swift
//  ImageUploaderTests
//
//  Created by Muhammad Usman Tarar on 6/14/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import XCTest
@testable import ImageUploader

class GalleryInteractorTests: XCTestCase {

    var mockOutput: MockImageListIntrectorOutput?
    var interactor: GalleryInteractor?
    var mockInput: MockImageListIntrectorInput?
    let testMockImage = UIImage(named: "mock-image")

    override func setUp() {
        mockInput = MockImageListIntrectorInput()
        mockOutput = MockImageListIntrectorOutput()
        interactor = GalleryInteractor()
        interactor?.output = mockOutput
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMockImageSuccess() {
        XCTAssert(testMockImage != nil)
    }

    func testDownloadImages() {
        let excption = expectation(description: "fetching data")
        interactor?.services.downloadImagesFromFirebase(completionHandler: { (result) in
            self.interactor?.output?.imagesReceivedFromServer(images: [])
            excption.fulfill()
        })
        wait(for: [excption], timeout: 30)
        
        XCTAssert(mockOutput?.onRequestSuccess == 1,
                  "Expect download images called once")
        XCTAssert(mockOutput?.imagesData != nil, "Expect image list to be present")
    }
    
    func testDownloadImagesFailed() {
        let excption = expectation(description: "fetching data")
        interactor?.services.downloadImagesFromFirebase(completionHandler: { (result) in
            if let _ = result?.imagesArray {
                
            } else {
                self.interactor?.output?.errorReceived(error: NSError(domain: Constants.Error.genericErrorDomain, code: Constants.Error.genericErrorCode, userInfo: nil))
                
            }
            excption.fulfill()
        })
        wait(for: [excption], timeout: 30)
        
        XCTAssert(mockOutput?.onRequestSuccess == 0,
                  "Expect download images should Failed")
        XCTAssert(mockOutput?.imagesData == nil, "Expect image list to be present")
    }
    
    func testUploadImagesFirebaseStorage() {
        self.testMockImageSuccess()
        let excption = expectation(description: "fetching data")
        guard let imageData = testMockImage?.pngData() else {
            XCTFail()
            return
        }
        interactor?.services.uploadImagesToFirebase(imageDataArray: [imageData], successHandler: { (imagesUrl) in
            self.interactor?.output?.imagesUploaded()
            excption.fulfill()
        }, errorHandler: { (error) in
            XCTFail()
        })
        wait(for: [excption], timeout: 30)
        
        XCTAssert(mockOutput?.onRequestSuccess == 1,
                  "Expect upload images called once")
    }
    
    func testInputUploadImagesFirebaseStorage() {
        self.testMockImageSuccess()
        guard let imageData = testMockImage?.pngData() else {
            XCTFail()
            return
        }
        mockInput?.uploadImages(imageDataArray: [imageData])
        XCTAssert(mockInput?.inputMethodCalled == 1,
                  "Expect upload images called once")
    }
    
    func testUploadImagesFirebaseStorageFailed() {
        self.testMockImageSuccess()
        let excption = expectation(description: "fetching data")
        interactor?.services.uploadImagesToFirebase(imageDataArray: [], successHandler: { (imagesUrl) in
        }, errorHandler: { (error) in
            self.interactor?.output?.errorReceived(error: error! as NSError)
            excption.fulfill()
        })
        wait(for: [excption], timeout: 30)
        
        XCTAssert(mockOutput?.onRequestSuccess == 0,
                  "Expect upload images failed")
    }
    
    func testUploadImagesUrlFirebaseDatabase() {
        let excption = expectation(description: "fetching data")
        let imageUrl = "https://www.dccomics.com/sites/default/files/styles/comics320x485/public/Char_Thumb_Batman_20190116_5c3fc4b40fae42.85141247.jpg?itok=_Or1JrO2"
        interactor?.services.uploadImagesURLToDatabase(imgUrlArray: [imageUrl], successHandler: {
            self.interactor?.output?.imagesUploaded()
            excption.fulfill()
        }, errorHandler: { (error) in

        })
        wait(for: [excption], timeout: 30)
        
        XCTAssert(mockOutput?.onRequestSuccess == 1,
                  "Expect upload images called once")
    }
    
    func testUploadImagesUrlFirebaseDatabaseFailed() {
        let excption = expectation(description: "fetching data")
        interactor?.services.uploadImagesURLToDatabase(imgUrlArray: [], successHandler: {
        }, errorHandler: { (error) in
            self.interactor?.output?.errorReceived(error: error! as NSError)
            excption.fulfill()
        })
        wait(for: [excption], timeout: 30)
        
        XCTAssert(mockOutput?.onRequestSuccess == 0,
                  "Expect upload images failed")
    }


}
