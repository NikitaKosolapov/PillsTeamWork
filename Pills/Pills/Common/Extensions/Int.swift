//
//  Int.swift
//  Pills
//
//  Created by aprirez on 8/15/21.
//

import UIKit

extension Int {
    private func daysFormat_Ru() -> String {
        if 11...14 ~= self % 100 {return "дней"}
        let number = self % 10
        if number == 1 {return "день"}
        if 2...3 ~= number {return "дня"}
        return "дней"
    }

    private func daysFormat_En() -> String {
        if self == 1 {return "day"}
        return "days"
    }

    func days() -> String {
        switch Locale.current.languageCode {
        case "ru": return daysFormat_Ru()
        case "en": return daysFormat_En()
        default:
            return daysFormat_En()
        }
    }
}
