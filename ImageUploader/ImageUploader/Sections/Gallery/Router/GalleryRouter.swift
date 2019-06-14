//
//  GalleryRouter.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Foundation
import UIKit

class GalleryRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> GalleryViewController {
        let viewController = GalleryViewController.instantiate(fromAppStoryboard: .Gallery)
        let presenter = GalleryPresenter()
        let router = GalleryRouter()
        let interactor = GalleryInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension GalleryRouter: GalleryWireframe {
    // TODO: Implement wireframe methods
}
