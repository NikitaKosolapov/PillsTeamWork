//
//  HorizontalStackViewFabric.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 11.10.2021.
//

import UIKit

final class HorizontalStackViewFabric {
    
    static func generate(
        _ views: [UIView],
        _ distribution: UIStackView.Distribution = .fillEqually,
        spacing: CGFloat = AppLayout.AddCourse.horizontalSpacing
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = spacing
        return stackView
    }
    
}
