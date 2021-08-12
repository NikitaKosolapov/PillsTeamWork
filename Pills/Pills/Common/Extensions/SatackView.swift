//
//  SatackView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }
}
