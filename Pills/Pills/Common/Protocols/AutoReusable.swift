//
//  AutoReusable.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import Foundation

// MARK: - AutoReusable

protocol AutoReusable {
    static var autoReuseIdentifier: String { get }
}

extension AutoReusable {
    static var autoReuseIdentifier: String {
        String(describing: self)
    }
}
