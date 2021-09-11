//
//  Label.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 13.08.2021.
//

import Foundation
import UIKit

extension UILabel {
    func centerStyleLabel (font: UIFont?, text: String) {
        numberOfLines = 1
        textAlignment = .center
        self.text = text
        self.font = font
        textColor = AppColors.blackCenterStyleLabel
    }
    
    func leftStyleLabel (font: UIFont?, text: String) {
        numberOfLines = 1
        textAlignment = .left
        self.text = text
        self.font = font
        textColor = AppColors.blackCenterStyleLabel
    }
}
