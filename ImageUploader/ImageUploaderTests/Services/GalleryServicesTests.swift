//
//  ServicesTests.swift
//  ImageUploaderTests
//
//  Created by Muhammad Usman Tarar on 6/14/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Firebase
@testable import ImageUploader
import XCTest

class GalleryServicesTests: XCTestCase {
    var storage = Storage.storage()
    var ref = DatabaseReference()
    let testMockImage = UIImage(named: "mock-image")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMockImageSuccess() {
        XCTAssert(testMockImage != nil)
    }
    
    func testDownloadImagesFromFirebase() {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() {
                XCTFail()
            }
            if let result = snapshot.value as? [String: Any] {
                guard let _ = GalleryResultModel(JSON: result[Constants.FirebaseDatabase.name] as! [String: Any]) else {
                    XCTFail()
                    return
                }
                XCTAssert(true)
            } else {
                XCTFail()
            }
        })
    }
    
    func testDownloadImagesFromFirebaseFailed() {
        ref = Database.database().reference(withPath: "WrongPath")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() {
                XCTAssert(true)
            }
            if let result = snapshot.value as? [String: Any] {
                guard let _ = GalleryResultModel(JSON: result[Constants.FirebaseDatabase.name] as! [String: Any]) else {
                    XCTAssert(true)
                    return
                }
                XCTFail()
            } else {
                XCTAssert(true)
            }
        })
    }
    
    func testuploadImagesToFirebase() {
        testMockImageSuccess()
        let excption = expectation(description: "uploading data")
        guard let imageData = testMockImage?.pngData() else {
            XCTFail()
            return
        }
        if [imageData].count > 0 {
            var uploadCount = 0
            let imagesCount = [imageData].count
            var uploadedImageUrlsArray = [String]()
            
            DispatchQueue.main.async {
                for imageData in [imageData] {
                    let imagePath = Auth.auth().currentUser!.uid +
                        "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpeg"
                    let imageName = NSUUID().uuidString // Unique string to reference image
                    let storageRef = self.storage.reference().child("\(imagePath)").child("\(imageName).png")
                    
                    storageRef.putData(imageData, metadata: metadata) { _, error in
                        if let _ = error {
                            XCTFail()
                            excption.fulfill()
                            return
                        }
                        
                        storageRef.downloadURL { url, _ in
                            uploadedImageUrlsArray.append(url?.absoluteString ?? "")
                            uploadCount += 1
                            if uploadCount == imagesCount {
                                XCTAssert(true)
                                excption.fulfill()
                            }
                        }
                    }
                }
            }
            
        } else {
            XCTFail()
        }
        
        wait(for: [excption], timeout: 30)
    }
    
    func testuploadImagesURLToDatabase() {
        let excption = expectation(description: "uploading data")
        let imageUrl = "https://www.dccomics.com/sites/default/files/styles/comics320x485/public/Char_Thumb_Batman_20190116_5c3fc4b40fae42.85141247.jpg?itok=_Or1JrO2"
        if [imageUrl].count > 0 {
            var uploadCount = 0
            let imagesCount = [imageUrl].count
            DispatchQueue.main.async {
                for url in [imageUrl] {
                    var ref = DatabaseReference()
                    ref = Database.database().reference()
                    ref.child(Constants.FirebaseDatabase.name).childByAutoId().setValue(url, withCompletionBlock: { error, _ in
                        if let _ = error {
                            XCTFail()
                            excption.fulfill()
                            return
                        } else {
                            uploadCount += 1
                            if uploadCount == imagesCount {
                                XCTAssert(true)
                                excption.fulfill()
                            }
                        }
                    })
                }
            }
        } else {
            XCTFail()
            excption.fulfill()
        }
        
        wait(for: [excption], timeout: 30)
    }
}
