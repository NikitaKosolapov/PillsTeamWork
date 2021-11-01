//
//  Date.swift
//  Pills
//
//  Created by aprirez on 7/23/21.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while CustomTextField.dateFormatter.string(from: date) != CustomTextField.dateFormatter.string(from: toDate) {
            dates.append(date)
            guard  let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        dates.append(date)
        return dates
    }
}
