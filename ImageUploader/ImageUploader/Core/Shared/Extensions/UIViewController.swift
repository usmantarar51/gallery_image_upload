//
//  UIViewController.swift
//  Swyp
//
//  Created by Khawar Shahzad on 27/02/2019.
//  Copyright © 2019 Etisalat. All rights reserved.
//

import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }

    enum AppStoryboard: String {
        case Movies = "Movies"

        var instance: UIStoryboard {
            return UIStoryboard(name: rawValue, bundle: Bundle.main)
        }

        func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
            let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
            return instance.instantiateViewController(withIdentifier: storyboardID) as! T
        }

        func initialViewController() -> UIViewController? {
            return instance.instantiateInitialViewController()
        }
    }
}
