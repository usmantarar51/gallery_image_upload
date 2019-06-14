//
//  ImageCollectionViewCell.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Methods
    
    func updateCell(model: GalleryResultModel.Images) {
        imageView.kf.setImage(with: URL(string: model.url))
    }
}
