//
//  BaseRowModel.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/12/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import UIKit

class BaseRowModel: NSObject {
    var tag: Int = 0
    var rowId: Int = 0
    var rowTitle: String = ""
    var rowCellIdentifier = ""
    var rowValue: Any?
    var rowHeight: CGFloat = 0.0
    var rowWidth: CGFloat = 0.0
    var delegate: Any?
}
