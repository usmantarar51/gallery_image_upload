//
//  BaseCollectionViewCell.swift
//  AbuDhabiSmart
//
//  Created by Khawar Shahzad on 11/03/2019.
//  Copyright © 2019 Techvista. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    func updateCell(model: Any, indexPath : IndexPath) {
        setupFonts()
    }
    func setupFonts() {
        log.warning("========================================")
        log.warning("Coming from \(self). Override in child class")
        log.warning("========================================")
    }
}
