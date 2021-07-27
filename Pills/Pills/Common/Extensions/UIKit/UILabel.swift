//
//  UILabel.swift
//  Pills
//
//  Created by Rayen on 27.07.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?,  alignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
    }
}
