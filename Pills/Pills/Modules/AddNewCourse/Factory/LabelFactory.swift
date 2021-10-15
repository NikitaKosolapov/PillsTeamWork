//
//  LabelFactory.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 11.10.2021.
//

import UIKit

final class LabelFactory {
    
    static func generateLabelWith(text: String) -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = text
        view.font = AppLayout.Fonts.smallRegular
        view.textAlignment = .left
        return view
    }
    
}
