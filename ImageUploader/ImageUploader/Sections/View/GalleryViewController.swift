//
//  GalleryViewController.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import Foundation
import UIKit

class GalleryViewController: BaseViewController {

    // MARK: Properties

    var presenter: GalleryPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension GalleryViewController: GalleryView {
    // TODO: implement view output methods
}
