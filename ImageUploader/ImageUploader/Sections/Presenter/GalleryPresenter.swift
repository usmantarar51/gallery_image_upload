//
//  GalleryPresenter.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Foundation

class GalleryPresenter {

    // MARK: Properties

    weak var view: GalleryView?
    var router: GalleryWireframe?
    var interactor: GalleryUseCase?
}

extension GalleryPresenter: GalleryPresentation {
    // TODO: implement presentation methods
}

extension GalleryPresenter: GalleryUseCaseOutput {
    // TODO: implement interactor output methods
}
