//
//  Hex.swift
//  Pills
//
//  Created by aprirez on 7/17/21.
//

import UIKit

extension UIColor {
    convenience init(hex: Int32) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: 1
        )
    }
}
