//
//  AppDelegate.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import UIKit

class Constants: NSObject {
    struct Error {
        static let genericErrorDomain = ""
        static let genericErrorCode = 111111
        static let genericErrorMessage = "Something went wrong"
        
        static let networkErrorDomain = ""
        static let networkErrorCode = 222222
        static let networkErrorMessage = "Networking is not working. Please try again."
        static let networkErrorTitle = "Network not found"
        static let networkErrorSubTitle = "Please try again"
    }
    
    struct URLS {
        static let baseURL = ""
    }
    
    struct EndPoints {
        static let firebaseStorageBucket = "gs://imageuploader-fb437.appspot.com"
        static let image = "images"
    }
    
    struct FirebaseDatabase {
        static let name = "result"
    }
    
    struct ProgressIndicator {
        static let radius: CGFloat = 18
        static let strokeWidth: CGFloat = 3
    }
}
