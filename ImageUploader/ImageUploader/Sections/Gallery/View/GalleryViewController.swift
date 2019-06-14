//
//  GalleryViewController.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import AppImageViewer
import Firebase
import FirebaseStorage
import Foundation
import Kingfisher
import UIKit
import YPImagePicker

class GalleryViewController: BaseViewController {
    // MARK: Properties
    
    @IBOutlet var imageCollectionView: UICollectionView!
    
    var presenter: GalleryPresentation?
    var selectedItems: [YPMediaItem] = []
    var downloadedImages: [GalleryResultModel.Images] = []
    var picker: YPImagePicker?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery"
    }
    
    // MARK: Methods
    
    override func setupAppearance() {
        addBarButton()
        fireBaseAnonymouslyLogin()
    }
    
    fileprivate func addBarButton() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showPicker))
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(title: "Refetch", style: .plain, target: self, action: #selector(refetchImages))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    fileprivate func fireBaseAnonymouslyLogin() {
        presenter?.fireBaseAnonymouslyLogin()
    }
    
    @objc fileprivate func refetchImages() {
        presenter?.fireBaseAnonymouslyLogin()
    }
    
    func ypPickerConfig() -> YPImagePickerConfiguration? {
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.usesFrontCamera = true
        config.showsPhotoFilters = false
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.wordings.libraryTitle = "Gallery"
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.library.maxNumberOfItems = 5
        
        return config
    }
    
    @objc func showPicker() {
        guard let config = ypPickerConfig() else {
            return
        }
        picker = YPImagePicker(configuration: config)
        if let picker = self.picker {
            picker.didFinishPicking { [unowned picker] items, cancelled in
                
                if cancelled {
                    AlertManager.showAlert(title: "Cancelled", message: "User canceled to selected images")
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                _ = items.map { print("🧀 \($0)") }
                
                self.selectedItems = items
                var imageDataArray: [Data] = []
                for item in items {
                    switch item {
                    case .photo(let image):
                        let imageV = image.image
                        guard let imageData = imageV.jpegData(compressionQuality: 0.8) else { return }
                        imageDataArray.append(imageData)
                    default:
                        print("Default Case")
                    }
                }
                
                picker.dismiss(animated: true, completion: {
                    self.presenter?.uploadImages(imageDataArray: imageDataArray)
                })
            }
            present(picker, animated: true, completion: nil)
        }
    }
}

// MARK: GalleryView

extension GalleryViewController: GalleryView {
    func imageUploaded() {
        presenter?.downloadImagesFromFirebase()
    }
    
    func firebaseUserLoggedIn() {
        presenter?.downloadImagesFromFirebase()
    }
    
    func imagesReceived(images: [GalleryResultModel.Images]) {
        downloadedImages.removeAll()
        downloadedImages.append(contentsOf: images)
        imageCollectionView.reloadData()
    }
    
    func showError(error: NSError) {
        AlertManager.showAlert(title: "Error", message: error.localizedDescription)
    }
}

// MARK: UICollectionViewDelegate && UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.updateCell(model: downloadedImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            let selectedImage = ViewerImage.appImage(forImage: cell.imageView.image ?? UIImage())
            let viewer = AppImageViewer(originImage: cell.imageView.image ?? UIImage(), photos: [selectedImage], animatedFromView: cell)
            present(viewer, animated: true, completion: nil)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 10 - 10
        return CGSize(width: width / 3, height: width / 3)
    }
}
