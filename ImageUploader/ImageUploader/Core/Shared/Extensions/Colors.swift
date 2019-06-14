//
//  Color.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/13/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import UIKit

extension UIColor {
    // Progress Indicator
    class func appBrownColor2() -> UIColor { return UIColor(hex: "C1A673") }
    class func progressTintColor() -> UIColor { return appBrownColor2() }
    class func progressBackgroundColor() -> UIColor { return UIColor(hex: "FFFFFF").withAlpha(0.75) }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func withAlpha(_ alpha: Float) -> UIColor {
        guard let components = cgColor.components else {
            return UIColor.black
        }
        
        let r: CGFloat = components[0]
        let g: CGFloat = components[1]
        var b: CGFloat = 1.0
        if components.count > 2 {
            b = components[2]
        }
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}
