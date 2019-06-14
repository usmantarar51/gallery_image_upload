//
//  RootRouter.swift
//  Swyp
//
//  Created by Khawar Shahzad on 27/02/2019.
//  Copyright © 2019 Etisalat. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    func presentRootScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        let vc = MoviesListingRouter.setupModule()
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
}
