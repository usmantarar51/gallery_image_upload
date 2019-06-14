//
//  GalleryServices.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Alamofire
import Foundation

class GalleryServices: BaseService {
    // MARK: Endpoints

    enum apiEndPoints: String {
        case endpoint = "endpoint/"
    }

    func executePostGalleryRequest(value1: String, value2: String, completionHandler: @escaping (DataResponse<GalleryResponseModel>) -> ()) {
        let action = "\(apiEndPoints.endpoint.rawValue)"
        parameters = ["key1": value1, "key2": value2] as [String: AnyObject]

        executePost(action: action) { (handler: DataResponse<GalleryResponseModel>) in
            completionHandler(handler)
        }
    }
}
