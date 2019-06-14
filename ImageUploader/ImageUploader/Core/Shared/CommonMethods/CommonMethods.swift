//
//  CommonMethods.swift
//  Swyp
//
//  Created by Khawar Shahzad on 26/02/2019.
//  Copyright © 2019 Etisalat. All rights reserved.
//

import UIKit

class CommonMethods: NSObject {
    class func filmRatingStringFrom(rating: FilmRating) -> String {
        switch rating {
        case .G:
            return "G"
        case .NC17:
            return "NC17"
        case .PG:
            return "PG"
        case .PG13:
            return "PG13"
        case .R:
            return "R"
        }
    }
    
    class func dateStringFrom(date: Date) -> String {
        let dateFormat = DateFormatter(withFormat: "MMM dd, yyyy", locale: Locale.current.identifier)
        let strDate = dateFormat.string(from: date)
        return strDate
    }
    
    class func getGenericError() -> NSError {
        return NSError(domain: Constants.Error.genericErrorDomain, code: Constants.Error.genericErrorCode, userInfo: [NSLocalizedDescriptionKey: Constants.Error.genericErrorMessage])
    }    
    
}
