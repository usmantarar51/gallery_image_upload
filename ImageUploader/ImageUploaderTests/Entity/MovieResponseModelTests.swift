//
//  ImageUploaderTests.swift
//  ImageUploaderTests
//
//  Created by Muhammad Usman Tarar on 6/14/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import XCTest
@testable import ImageUploader

class GalleryResultModelTests: XCTestCase {

    var jsonString: String!
    override func setUp() {
        jsonString = "{\"-LhJa-lu13KektBNoecA\" : \"https://firebasestorage.googleapis.com/v0/b/imageuploader-fb437.appspot.com/o/Pi1b10T3r4PZpS7t9PoFYHupaXe2%2F582185160567.jpg%2F40683572-E6FA-4C88-8ADD-8FB28A6E96CE.png?alt=media&token=6a618717-d61c-4f3f-b95b-1cc2da56dd60\"}"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJsonParsedSuccess() {
        let images = GalleryResultModel(JSONString: jsonString)
        XCTAssert(images != nil, "Expect image to parsed")
    }
    
    func testJsonParsedFailer() {
        let images = GalleryResultModel(JSONString: "jsonStringfailed")
        XCTAssertNil(images, "Expect image to parsing failed")
    }
    
    func testDataAuthenticity() {
        guard let images = GalleryResultModel(JSONString: jsonString) else {
            XCTFail()
            return
        }
        
        XCTAssert(images.imagesArray.count > 0, "Expect Atleast one image")
    }
}
