//
//  TextField.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 24.08.2021.
//

import Foundation
import UIKit

extension UITextField {
    func centerStyleTextField (font: UIFont?, text: String) {
        layer.cornerRadius = 10
        backgroundColor = AppColors.white
        textAlignment = .center
        self.text = text
        self.font = font
        textColor = AppColors.black
    }
    
    func leftStyleTextField (font: UIFont?, text: String) {
        layer.cornerRadius = 10
        backgroundColor = AppColors.white
        textAlignment = .left
        self.text = text
        self.font = font
        textColor = AppColors.black
    }
}
