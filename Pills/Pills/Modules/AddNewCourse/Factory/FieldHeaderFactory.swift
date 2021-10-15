//
//  FieldHeaderFactory.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 11.10.2021.
//

import UIKit

final class FieldHeaderFactory {
    
    static func generate(header: String = "") -> UILabel {
        let view = UILabel()
        view.text = header
        view.font = AppLayout.Fonts.smallRegular
        view.textAlignment = .left
        return view
    }
    
}
