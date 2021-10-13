//
//  VerticalStackViewFabric.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 11.10.2021.
//

import UIKit

final class VerticalStackViewFabric {
    
    static func generate(
        spacing: CGFloat = AppLayout.AddCourse.vStackViewSpacing,
        _ views: [UIView]
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = spacing
        return stackView
    }
    
}
