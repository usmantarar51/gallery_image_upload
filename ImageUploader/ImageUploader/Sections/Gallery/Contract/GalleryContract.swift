//
//  GalleryContract.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Foundation

protocol GalleryView: Loadable {
    // TODO: Declare view methods
    func imagesReceived(images: [GalleryResultModel.Images])
    func firebaseUserLoggedIn()
    func imageUploaded()
    func showError(error: NSError)
}

protocol GalleryPresentation: class {
    // TODO: Declare presentation methods
    func getUploadedImagesFromServer()
    func fireBaseAnonymouslyLogin()
    func uploadImages(imageDataArray: [Data])
}

protocol GalleryUseCase: class {
    // TODO: Declare use case methods
    func getUploadedImagesFromServer()
    func fireBaseAnonymouslyLogin()
    func uploadImages(imageDataArray: [Data])
}

protocol GalleryUseCaseOutput: class {
    // TODO: Declare interactor output methods
    func imagesReceivedFromServer(images: [GalleryResultModel.Images])
    func firebaseUserLoggedIn()
    func imagesUploaded()
    func errorReceived(error: NSError)
}

protocol GalleryWireframe: class {
    // TODO: Declare wireframe methods
}
