//
//  GalleryServices.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Firebase
import Foundation

class GalleryServices: NSObject {
    var storage = Storage.storage()
    var ref = DatabaseReference()
    
    func downloadImagesFromFirebase(completionHandler: @escaping (GalleryResultModel?) -> ()) {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() {
                completionHandler(nil)
                return
            }
            if let result = snapshot.value as? [String: Any] {
                guard let galleryResult = GalleryResultModel(JSON: result[Constants.FirebaseDatabase.name] as! [String: Any]) else {
                    completionHandler(nil)
                    return
                }
                completionHandler(galleryResult)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func uploadImagesToFirebase(imageDataArray: [Data], successHandler: @escaping ([String]?) -> (), errorHandler: @escaping (Error?) -> ()) {
        if imageDataArray.count > 0 {
            var uploadCount = 0
            let imagesCount = imageDataArray.count
            var uploadedImageUrlsArray = [String]()
            
            DispatchQueue.main.async {
                for imageData in imageDataArray {
                    let imagePath = Auth.auth().currentUser!.uid +
                        "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpeg"
                    let imageName = NSUUID().uuidString // Unique string to reference image
                    let storageRef = self.storage.reference().child("\(imagePath)").child("\(imageName).png")
                    
                    storageRef.putData(imageData, metadata: metadata) { _, error in
                        if let error = error {
                            errorHandler(error)
                            return
                        }
                        
                        storageRef.downloadURL { url, _ in
                            uploadedImageUrlsArray.append(url?.absoluteString ?? "")
                            uploadCount += 1
                            if uploadCount == imagesCount {
                                successHandler(uploadedImageUrlsArray)
                            }
                        }
                    }
                }
            }
        } else {
            errorHandler(NSError(domain: Constants.Error.genericErrorDomain, code: Constants.Error.genericErrorCode, userInfo: nil))
        }
    }
    
    func uploadImagesURLToDatabase(imgUrlArray: [String], successHandler: @escaping () -> (), errorHandler: @escaping (Error?) -> ()) {
        if imgUrlArray.count > 0 {
            var uploadCount = 0
            let imagesCount = imgUrlArray.count
            DispatchQueue.main.async {
                for url in imgUrlArray {
                    var ref = DatabaseReference()
                    ref = Database.database().reference()
                    ref.child(Constants.FirebaseDatabase.name).childByAutoId().setValue(url, withCompletionBlock: { error, _ in
                        if let error = error {
                            errorHandler(error)
                            return
                        } else {
                            uploadCount += 1
                            if uploadCount == imagesCount {
                                successHandler()
                            }
                        }
                    })
                }
            }
        } else {
            errorHandler(NSError(domain: Constants.Error.genericErrorDomain, code: Constants.Error.genericErrorCode, userInfo: nil))
        }
    }
}
