//
//  GalleryPresenter.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Firebase
import Foundation

class GalleryPresenter {
    // MARK: Properties

    weak var view: GalleryView?
    var router: GalleryWireframe?
    var interactor: GalleryUseCase?
}

extension GalleryPresenter: GalleryPresentation {
    func uploadImages(imageDataArray: [Data]) {
        showIndicator()
        if imageDataArray.count > 0 {
            interactor?.uploadImages(imageDataArray: imageDataArray)
        } else {
            view?.showError(error: NSError(domain: Constants.Error.genericErrorDomain, code: Constants.Error.genericErrorCode, userInfo: nil))
        }
    }
    
    func fireBaseAnonymouslyLogin() {
        view?.showLoading()
        showIndicator()
        interactor?.fireBaseAnonymouslyLogin()
    }

    func getUploadedImagesFromServer() {
        view?.showLoading()
        showIndicator()
        interactor?.getUploadedImagesFromServer()
    }
}

extension GalleryPresenter: GalleryUseCaseOutput {
    func imagesUploaded() {
        view?.hideLoading()
        hideIndicator()
        view?.imageUploaded()
    }
    
    func firebaseUserLoggedIn() {
        view?.hideLoading()
        hideIndicator()
        view?.firebaseUserLoggedIn()
    }

    func imagesReceivedFromServer(images: [GalleryResultModel.Images]) {
        view?.hideLoading()
        hideIndicator()
        view?.imagesReceived(images: images)
    }

    func errorReceived(error: NSError) {
        view?.hideLoading()
        hideIndicator()
        view?.showError(error: error)
    }
}

extension GalleryPresenter {
    func showIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
