//
//  AlertManager.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/13/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import UIKit

@objc class AlertManager: NSObject {
    @objc open class func showAlert(title: String = "", message: String = "", preferredStyle: UIAlertController.Style = .alert, alertActions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actions = alertActions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(genericAlertAction())
        }
        UIApplication.shared.keyWindow!.rootViewController!.present(alert, animated: true, completion: nil)
    }

    @objc open class func genericAlertAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    }
}
