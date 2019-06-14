//
//  AppDelegate.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import UIKit
import SVProgressHUD

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
            SVProgressHUD.show()
        }
    }

    @objc func hideLoading() {
        SVProgressHUD.dismiss()
    }
}
