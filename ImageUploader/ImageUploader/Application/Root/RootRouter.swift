//
//  AppSetup.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    func presentRootScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        let vc = GalleryRouter.setupModule()
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
}
