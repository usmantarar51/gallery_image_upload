//
//  ProgressIndicator.swift
//  ImageUploader
//
//  Created by Muhammad Usman Tarar on 6/13/19.
//  Copyright © 2019 Usman Tarar. All rights reserved.
//

import MaterialComponents.MaterialActivityIndicator
import UIKit

@objc class ProgressIndicator: UIView {
    @objc static let shared = ProgressIndicator()
    
    var indicator = MDCActivityIndicator()
    let radius: CGFloat = Constants.ProgressIndicator.radius
    let strokeWidth: CGFloat = Constants.ProgressIndicator.strokeWidth
    var shouldAllowUserInteraction = false
    let bgView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }
    
    private func _commonInit() {
        indicator.sizeToFit()
        indicator.indicatorMode = .indeterminate
        indicator.cycleColors = [UIColor.progressTintColor()]
        indicator.radius = radius
        indicator.strokeWidth = strokeWidth
        backgroundColor = UIColor.clear
    }
    
    func showInLine(shouldAllowUserInteraction: Bool = true) {
        if indicator.isAnimating {
            return
        }
        
        self.shouldAllowUserInteraction = shouldAllowUserInteraction
        indicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        DispatchQueue.main.async {
            if !shouldAllowUserInteraction {
                self._showBackground(bounds: self.frame, inline: true)
            }
            
            self.indicator.startAnimating()
            self.addSubview(self.indicator)
        }
    }
    
    @objc func show(shouldAllowUserInteraction: Bool = false) {
        if indicator.isAnimating {
            return
        }
        
        self.shouldAllowUserInteraction = shouldAllowUserInteraction
        if let center = UIApplication.shared.keyWindow?.rootViewController?.view.center {
            indicator.center = center
        }
        
        DispatchQueue.main.async {
            if !shouldAllowUserInteraction {
                self._showBackground(bounds: UIScreen.main.bounds)
            }
            
            self.indicator.startAnimating()
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        }
    }
    
    @objc func hide() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
            self.bgView.removeFromSuperview()
        }
    }
    
    private func _showBackground(bounds: CGRect, inline: Bool = false) {
        let size = bounds
        
        bgView.backgroundColor = UIColor.progressBackgroundColor()
        
        if inline {
            bgView.frame = frame
            addSubview(bgView)
        } else {
            bgView.frame = CGRect(x: 0, y: 0, width: size.size.width, height: size.size.height)
            UIApplication.shared.keyWindow?.addSubview(bgView)
        }
    }
}
