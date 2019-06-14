//
//  AppDelegate.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }

    func setupAppearance() {}
}

// MARK: - Loadable

extension BaseViewController: Loadable {
    @objc func showLoading() {
        DispatchQueue.main.async {
            ProgressIndicator.shared.show()
        }
    }

    @objc func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        ProgressIndicator.shared.hide()
    }
}
