//
//  GalleryResponseModel.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Foundation
import ObjectMapper

class GalleryResponseModel: BaseResponseModel {
    // MARK: - Model Keys
    
    enum CodingKeys: String {
        case value1
        case value2
    }
    
    // MARK: - Model Variables
    
    var value1: String?
    var value2: String?
    
    // MARK: - Model mapping
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        value1 <- map[CodingKeys.value1.rawValue]
        value2 <- map[CodingKeys.value2.rawValue]
    }
}
