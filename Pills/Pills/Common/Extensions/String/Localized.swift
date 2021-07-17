//
//  String+Localization.swift
//  Pills
//
//  Created by aprirez on 7/17/21.
//

import Foundation

extension String {
    static var errorNotLocalized: String {
        return "error_not_localized"
    }

    func localized() -> String {
        let result = NSLocalizedString(
            self,
            tableName: nil,
            bundle: Bundle.main,
            value: .errorNotLocalized,
            comment: ""
        )
        if result == .errorNotLocalized {
            debugPrint("Error: String '\(self)' is not localized")
            return .errorNotLocalized
        }
        return result
    }

    func localized(_ lang: String) -> String {

        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)

        let result = NSLocalizedString(self, tableName: nil, bundle: bundle!, value: .errorNotLocalized, comment: "")
        if result == .errorNotLocalized {
            debugPrint("Error: String '\(self)' is not localized")
            return .errorNotLocalized
        }
        return result
    }
}
