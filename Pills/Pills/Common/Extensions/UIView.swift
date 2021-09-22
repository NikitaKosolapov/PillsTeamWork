//
//  UIView.swift
//  Pills
//
//  Created by Rayen on 11.08.2021.
//

import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}

// MARK: - BlurEffect

extension UIView {
    func addBlur(
        style: UIBlurEffect.Style,
        alpha: CGFloat,
        cornerRadius: CGFloat,
        zPosition: CGFloat
    ) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.alpha = alpha
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.layer.zPosition = zPosition
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
