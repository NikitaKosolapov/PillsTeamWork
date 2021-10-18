//
//  RateStackViewFactory.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 18.10.2021.
//

import UIKit

final class RateStackViewFactory {
    static func generate(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.Rate.verticalStackViewSpacing
        return stackView
    }
}
