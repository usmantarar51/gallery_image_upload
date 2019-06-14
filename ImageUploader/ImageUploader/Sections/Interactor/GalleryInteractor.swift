//
//  GalleryInteractor.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Foundation

class GalleryInteractor {
    // MARK: Properties

    weak var output: GalleryUseCaseOutput?
    let services = GalleryServices()
}

extension GalleryInteractor: GalleryUseCase {
    // TODO: Implement use case methods
}
