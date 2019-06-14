//
//  GalleryResponseModel.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Foundation
import ObjectMapper

class GalleryResultModel: Mappable {
    
    // MARK: - Model Keys
    
    enum CodingKeys: String {
        case imageUrl = "imageUrl"
        case imageId = "imageId"
    }
    
    // MARK: - Model Variables
    

    typealias Images = (id: String, url: String)
    var imagesArray: [Images] = []
    
    public required init?(map: Map) {
        mapping(map: map)
    }
    
    // MARK: - Model mapping
    
    public func mapping(map: Map) {
        let rawDictionary = map.JSON
        let items = rawDictionary.compactMap { (key, value) -> Images? in
            guard let url = value as? String else { return nil }
            return (key, url)
        }
        imagesArray = items
    }
}
