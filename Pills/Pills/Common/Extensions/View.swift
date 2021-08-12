//
//  View.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import Foundation
import UIKit

protocol Separator: AnyObject {
    func makeTranslucent() -> UIView
    func makeTranslucent(height: CGFloat) -> UIView
    func makeTranslucent(width: CGFloat) -> UIView
}

extension UIView: Separator {
    func makeTranslucent() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }
    
    func makeTranslucent(height: CGFloat) -> UIView {
        let view = makeTranslucent()
        configure(view: view, withHeight: height)
        return view
    }
    
    func makeTranslucent(width: CGFloat) -> UIView {
        let view = makeTranslucent()
        configure(view: view, withWidth: width)
        return view
    }
    
    func configure(view: UIView, withHeight height: CGFloat) {
        NSLayoutConstraint.activate([view.heightAnchor.constraint(equalToConstant: height)])
    }
    
    func configure(view: UIView, withWidth width: CGFloat) {
        NSLayoutConstraint.activate([view.widthAnchor.constraint(equalToConstant: width)])
    }
}
