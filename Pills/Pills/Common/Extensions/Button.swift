//
//  Button.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 13.08.2021.
//

import Foundation
import UIKit

extension UIButton {
    func rateStyleButton (backgroundColor: UIColor, text: String) {
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 10
        setTitle(text, for: .normal)
        setTitleColor(AppColors.whiteOnly, for: .normal)
        titleLabel?.font = AppLayout.Fonts.verySmallRegular
    }
}
