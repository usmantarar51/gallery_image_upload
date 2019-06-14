//
//  GalleryServices.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//


import Foundation
import Firebase

class GalleryServices: NSObject {
    var storage = Storage.storage()
    var ref = DatabaseReference.init()
    
    func downloadImagesFromFirebase(completionHandler: @escaping (GalleryResultModel?) -> ()) {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(nil)
                return
            }
            if let result = snapshot.value as? Dictionary<String,Any> {
                guard let galleryResult = GalleryResultModel(JSON: result[Constants.FirebaseDatabase.name] as! Dictionary<String,Any>) else {
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
                    
                    storageRef.downloadURL { url, error in
                        uploadedImageUrlsArray.append(url?.absoluteString ?? "")
                        uploadCount += 1
                        if uploadCount == imagesCount {
                            successHandler(uploadedImageUrlsArray)
                        }
                    }
                }
            }
        }
        
    }
}

// MARK: GalleryServicesMethods

extension GalleryServices {
    func uploadImagesURLToDatabase(imgUrlArray: [String], successHandler: @escaping () -> ()) {
        var uploadCount = 0
        let imagesCount = imgUrlArray.count
        DispatchQueue.main.async {
            for url in imgUrlArray {
                var ref = DatabaseReference.init()
                ref = Database.database().reference()
                ref.child(Constants.FirebaseDatabase.name).childByAutoId().setValue(url)
                uploadCount += 1
                if uploadCount == imagesCount {
                    successHandler()
                }
            }
        }
    }
}
