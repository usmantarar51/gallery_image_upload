//
//  AppSetup.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    internal func setupApp(window: UIWindow) {
        boot(window: window)
    }
    
    internal func boot(window: UIWindow) {
        RootRouter().presentRootScreen(in: window)
    }
    
}
