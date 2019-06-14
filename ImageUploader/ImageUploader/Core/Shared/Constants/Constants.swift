//
//  Constants.swift
//  MovieWebService
//
//  Created by Afroz on 26/04/2019.
//  Copyright © 2019 Afroz. All rights reserved.
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
}
